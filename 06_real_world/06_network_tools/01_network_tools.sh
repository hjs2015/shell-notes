#!/bin/bash
# ============================================================================
# 脚本名称：01_network_tools.sh
# 功能描述：网络工具集 - 网络诊断、端口扫描、带宽测试、连接监控
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：网络诊断、端口扫描、带宽测试、连接监控
# 使用方法：bash 01_network_tools.sh
# 依赖命令：ping, netstat, ss, ip, curl, wget, nmap
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }

print_header "🌐 网络工具集"

# 菜单
show_menu() {
    echo ""
    echo "请选择工具："
    echo "1. Ping 测试（延迟检测）"
    echo "2. 端口扫描"
    echo "3. 网络连接监控"
    echo "4. 带宽速度测试"
    echo "5. DNS 查询"
    echo "6. 路由跟踪"
    echo "7. 网络接口信息"
    echo "8. 防火墙规则查看"
    echo "0. 退出"
    echo ""
}

# Ping 测试
ping_test() {
    print_header "Ping 测试"
    
    read -p "请输入目标主机（默认 www.baidu.com）： " host
    host=${host:-www.baidu.com}
    
    read -p "请输入 Ping 次数（默认 4）： " count
    count=${count:-4}
    
    echo ""
    echo "正在测试到 $host 的连接..."
    echo ""
    
    ping -c "$count" "$host"
    
    if [ $? -eq 0 ]; then
        print_success "连接正常"
    else
        print_error "连接失败"
    fi
}

# 端口扫描
port_scan() {
    print_header "端口扫描"
    
    read -p "请输入目标主机： " host
    read -p "请输入端口范围（如 1-1000，默认 1-100）： " port_range
    port_range=${port_range:-1-100}
    
    echo ""
    echo "正在扫描 $host 的端口 $port_range..."
    echo ""
    
    if command -v nmap &>/dev/null; then
        nmap -p "$port_range" "$host"
    else
        print_warning "nmap 未安装，使用基础扫描"
        
        IFS='-' read -r start_port end_port <<< "$port_range"
        for port in $(seq "$start_port" "$end_port"); do
            if timeout 1 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
                echo "  端口 $port: 开放"
            fi
        done
    fi
}

# 网络连接监控
connection_monitor() {
    print_header "网络连接监控"
    
    echo "=== 当前网络连接 ==="
    echo ""
    
    if command -v ss &>/dev/null; then
        echo "使用 ss 命令："
        ss -tuln
    elif command -v netstat &>/dev/null; then
        echo "使用 netstat 命令："
        netstat -tuln
    else
        print_error "未找到 ss 或 netstat 命令"
        return 1
    fi
    
    echo ""
    echo "=== 连接统计 ==="
    local total=$(ss -tuln 2>/dev/null | wc -l)
    local tcp=$(ss -tuln 2>/dev/null | grep tcp | wc -l)
    local udp=$(ss -tuln 2>/dev/null | grep udp | wc -l)
    
    echo "总连接数：$total"
    echo "TCP 连接：$tcp"
    echo "UDP 连接：$udp"
}

# 带宽速度测试
bandwidth_test() {
    print_header "带宽速度测试"
    
    echo "请选择测试方式："
    echo "1. 下载速度测试（使用 speedtest-cli）"
    echo "2. 简单下载测试（使用 curl）"
    echo "3. 上传速度测试"
    read -p "请选择（1-3）： " choice
    
    case $choice in
        1)
            if command -v speedtest-cli &>/dev/null; then
                speedtest-cli
            else
                print_warning "speedtest-cli 未安装"
                echo "安装方法：pip install speedtest-cli"
            fi
            ;;
        2)
            echo "测试下载速度（10MB 文件）..."
            local start_time=$(date +%s.%N)
            curl -o /dev/null -s https://speed.hetzner.com/100MB.bin
            local end_time=$(date +%s.%N)
            local duration=$(echo "$end_time - $start_time" | bc)
            local speed=$(echo "scale=2; 10 / $duration" | bc)
            echo "下载速度：${speed} MB/s"
            ;;
        3)
            print_warning "上传测试需要目标服务器支持"
            echo "建议使用 speedtest-cli 进行完整测试"
            ;;
    esac
}

# DNS 查询
dns_lookup() {
    print_header "DNS 查询"
    
    read -p "请输入域名： " domain
    
    echo ""
    echo "=== A 记录 ==="
    dig "$domain" A +short 2>/dev/null || nslookup "$domain" 2>/dev/null || host "$domain" 2>/dev/null
    
    echo ""
    echo "=== MX 记录 ==="
    dig "$domain" MX +short 2>/dev/null || nslookup -query=mx "$domain" 2>/dev/null
    
    echo ""
    echo "=== NS 记录 ==="
    dig "$domain" NS +short 2>/dev/null || nslookup -query=ns "$domain" 2>/dev/null
}

# 路由跟踪
traceroute_test() {
    print_header "路由跟踪"
    
    read -p "请输入目标主机： " host
    
    echo ""
    echo "正在跟踪到 $host 的路由..."
    echo ""
    
    if command -v traceroute &>/dev/null; then
        traceroute "$host"
    elif command -v tracepath &>/dev/null; then
        tracepath "$host"
    else
        print_warning "traceroute 未安装，使用 ping TTL 测试"
        for ttl in 1 2 3 4 5 6 7 8 9 10; do
            echo "TTL=$ttl:"
            ping -c 1 -t "$ttl" "$host" 2>&1 | grep "From\|from"
        done
    fi
}

# 网络接口信息
interface_info() {
    print_header "网络接口信息"
    
    echo "=== 所有网络接口 ==="
    ip -br addr show 2>/dev/null || ifconfig -a 2>/dev/null
    
    echo ""
    echo "=== 默认路由 ==="
    ip route show default 2>/dev/null || route -n 2>/dev/null | grep "^0.0.0.0"
    
    echo ""
    echo "=== DNS 服务器 ==="
    cat /etc/resolv.conf 2>/dev/null | grep "nameserver"
    
    echo ""
    echo "=== 网络统计 ==="
    ip -s link 2>/dev/null | head -20
}

# 防火墙规则
firewall_rules() {
    print_header "防火墙规则"
    
    echo "=== iptables 规则 ==="
    if command -v iptables &>/dev/null; then
        iptables -L -n -v 2>/dev/null || print_warning "需要 root 权限"
    else
        print_warning "iptables 未安装"
    fi
    
    echo ""
    echo "=== firewalld 状态 ==="
    if command -v firewall-cmd &>/dev/null; then
        firewall-cmd --state 2>/dev/null || print_warning "firewalld 未运行"
        echo ""
        echo "开放的服务："
        firewall-cmd --list-services 2>/dev/null
    else
        print_warning "firewalld 未安装"
    fi
    
    echo ""
    echo "=== ufw 状态 ==="
    if command -v ufw &>/dev/null; then
        ufw status 2>/dev/null || print_warning "ufw 未运行"
    else
        print_warning "ufw 未安装"
    fi
}

# 主循环
while true; do
    show_menu
    read -p "请选择工具（0-8）： " choice
    
    case $choice in
        1) ping_test ;;
        2) port_scan ;;
        3) connection_monitor ;;
        4) bandwidth_test ;;
        5) dns_lookup ;;
        6) traceroute_test ;;
        7) interface_info ;;
        8) firewall_rules ;;
        0)
            print_success "退出工具集"
            exit 0
            ;;
        *)
            print_error "无效选择，请重新输入"
            ;;
    esac
    
    echo ""
    read -p "按回车键继续..."
done

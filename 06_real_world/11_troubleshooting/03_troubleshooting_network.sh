#!/bin/bash
# ============================================================================
# 脚本名称：03_troubleshooting_network.sh
# 功能描述：网络故障排查 - 连接问题、DNS 问题、防火墙问题、性能问题
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：网络诊断、故障排查、性能分析
# 使用方法：bash 03_troubleshooting_network.sh
# 依赖命令：ping, curl, dig, netstat, ss, ip, tcpdump
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

print_header "🔍 网络故障排查工具"

# 菜单
show_menu() {
    echo ""
    echo "请选择排查场景："
    echo "1. 无法访问外部网站"
    echo "2. DNS 解析问题"
    echo "3. 端口无法连接"
    echo "4. 网络速度慢"
    echo "5. 连接频繁断开"
    echo "6. 防火墙问题"
    echo "7. 全面网络诊断"
    echo "0. 退出"
    echo ""
}

# 场景 1：无法访问外部网站
check_internet_access() {
    print_header "排查：无法访问外部网站"
    
    echo "步骤 1: 检查本地网络接口"
    ip addr show | grep -E "inet |state" | head -10
    echo ""
    
    echo "步骤 2: Ping 网关"
    local gateway=$(ip route | grep default | awk '{print $3}')
    if [ -n "$gateway" ]; then
        echo "网关：$gateway"
        ping -c 3 "$gateway"
    else
        print_warning "未找到默认网关"
    fi
    echo ""
    
    echo "步骤 3: Ping 公共 DNS"
    ping -c 3 8.8.8.8
    echo ""
    
    echo "步骤 4: Ping 域名"
    ping -c 3 www.baidu.com
    echo ""
    
    echo "步骤 5: 检查 DNS 配置"
    cat /etc/resolv.conf
    echo ""
    
    echo "步骤 6: HTTP 测试"
    curl -I --connect-timeout 5 https://www.baidu.com 2>&1 | head -5
    echo ""
    
    # 诊断结论
    print_header "诊断结论"
    if ping -c 1 8.8.8.8 &>/dev/null; then
        if ping -c 1 www.baidu.com &>/dev/null; then
            print_success "网络连接正常"
        else
            print_warning "DNS 解析问题 - 检查 /etc/resolv.conf"
        fi
    else
        print_error "网络连接中断 - 检查网关和路由"
    fi
}

# 场景 2：DNS 解析问题
check_dns_issue() {
    print_header "排查：DNS 解析问题"
    
    read -p "请输入要测试的域名： " domain
    domain=${domain:-www.baidu.com}
    
    echo "步骤 1: 检查 DNS 配置"
    cat /etc/resolv.conf
    echo ""
    
    echo "步骤 2: 测试 DNS 解析（dig）"
    dig "$domain" +short 2>/dev/null || echo "dig 未安装"
    echo ""
    
    echo "步骤 3: 测试 DNS 解析（nslookup）"
    nslookup "$domain" 2>/dev/null || echo "nslookup 未安装"
    echo ""
    
    echo "步骤 4: 测试多个 DNS 服务器"
    for dns in 8.8.8.8 1.1.1.1 114.114.114.114; do
        echo "DNS $dns:"
        dig @"$dns" "$domain" +short +time=2 2>/dev/null || echo "  超时"
    done
    echo ""
    
    echo "步骤 5: 检查本地 hosts 文件"
    grep "$domain" /etc/hosts 2>/dev/null || echo "hosts 文件中无此域名"
    echo ""
    
    # 解决方案
    print_header "解决方案"
    echo "1. 修改 DNS 服务器："
    echo "   sudo nano /etc/resolv.conf"
    echo "   nameserver 8.8.8.8"
    echo "   nameserver 114.114.114.114"
    echo ""
    echo "2. 清除 DNS 缓存（systemd-resolved）："
    echo "   sudo systemd-resolve --flush-caches"
    echo ""
    echo "3. 检查 NetworkManager："
    echo "   nmcli dev show | grep DNS"
}

# 场景 3：端口无法连接
check_port_connection() {
    print_header "排查：端口无法连接"
    
    read -p "请输入目标主机： " host
    read -p "请输入端口号： " port
    
    echo "步骤 1: 检查本地端口监听"
    ss -tuln | grep ":$port" || netstat -tuln | grep ":$port" || echo "本地未监听此端口"
    echo ""
    
    echo "步骤 2: 测试端口连接"
    timeout 3 bash -c "echo > /dev/tcp/$host/$port" 2>&1 && echo "端口开放" || echo "端口关闭或防火墙阻止"
    echo ""
    
    echo "步骤 3: Telnet 测试"
    if command -v telnet &>/dev/null; then
        echo "telnet $host $port"
        timeout 3 telnet "$host" "$port" 2>&1 | head -5
    else
        print_warning "telnet 未安装"
    fi
    echo ""
    
    echo "步骤 4: 检查防火墙规则"
    echo "iptables 规则："
    iptables -L -n 2>/dev/null | grep -E "ACCEPT|DROP|REJECT" | head -10 || echo "需要 root 权限"
    echo ""
    
    echo "步骤 5: 检查服务状态"
    systemctl list-units --type=service --state=running | grep -E "nginx|apache|mysql|redis|docker" | head -10
    echo ""
    
    # 解决方案
    print_header "解决方案"
    echo "1. 开放防火墙端口："
    echo "   sudo iptables -A INPUT -p tcp --dport $port -j ACCEPT"
    echo ""
    echo "2. 检查服务是否运行："
    echo "   sudo systemctl status <service_name>"
    echo ""
    echo "3. 检查服务监听地址："
    echo "   sudo ss -tuln | grep :$port"
}

# 场景 4：网络速度慢
check_network_speed() {
    print_header "排查：网络速度慢"
    
    echo "步骤 1: 测试延迟"
    echo "到网关的延迟："
    local gateway=$(ip route | grep default | awk '{print $3}')
    ping -c 10 "$gateway" 2>&1 | tail -1
    echo ""
    
    echo "到公共 DNS 的延迟："
    ping -c 10 8.8.8.8 2>&1 | tail -1
    echo ""
    
    echo "步骤 2: 测试下载速度"
    echo "使用 speedtest-cli（如果安装）："
    if command -v speedtest-cli &>/dev/null; then
        speedtest-cli --simple
    else
        print_warning "speedtest-cli 未安装"
        echo "安装：pip install speedtest-cli"
    fi
    echo ""
    
    echo "步骤 3: 检查带宽使用"
    echo "实时带宽监控（iftop，如果安装）："
    if command -v iftop &>/dev/null; then
        print_warning "iftop 需要交互式运行"
    else
        print_warning "iftop 未安装"
    fi
    echo ""
    
    echo "步骤 4: 检查网络接口统计"
    ip -s link show | head -20
    echo ""
    
    echo "步骤 5: 检查丢包"
    ping -c 100 8.8.8.8 2>&1 | tail -3
    echo ""
    
    # 解决方案
    print_header "解决方案"
    echo "1. 高延迟："
    echo "   - 检查网络拥塞"
    echo "   - 更换 DNS 服务器"
    echo "   - 检查路由路径（traceroute）"
    echo ""
    echo "2. 低带宽："
    echo "   - 检查带宽限制"
    echo "   - 关闭占用带宽的应用"
    echo "   - 联系 ISP 升级带宽"
    echo ""
    echo "3. 高丢包："
    echo "   - 检查物理连接"
    echo "   - 更换网线/路由器"
    echo "   - 检查网络干扰"
}

# 场景 5：连接频繁断开
check_connection_drop() {
    print_header "排查：连接频繁断开"
    
    echo "步骤 1: 监控连接状态"
    echo "持续 Ping 测试（按 Ctrl+C 停止）："
    timeout 30 ping -i 1 8.8.8.8 2>&1 | tail -20 || true
    echo ""
    
    echo "步骤 2: 检查 DHCP 租约"
    if [ -f /var/lib/dhcp/dhclient.leases ]; then
        echo "DHCP 租约信息："
        tail -20 /var/lib/dhcp/dhclient.leases
    else
        print_warning "未找到 DHCP 租约文件"
    fi
    echo ""
    
    echo "步骤 3: 检查网络接口错误"
    ip -s link show | grep -E "errors|dropped"
    echo ""
    
    echo "步骤 4: 查看系统日志"
    echo "最近的网络相关日志："
    journalctl -u NetworkManager --no-pager -n 20 2>/dev/null || \
    dmesg | grep -i "network\|eth\|wifi" | tail -20
    echo ""
    
    # 解决方案
    print_header "解决方案"
    echo "1. WiFi 断开："
    echo "   - 检查信号强度"
    echo "   - 更换 WiFi 频道"
    echo "   - 更新无线网卡驱动"
    echo ""
    echo "2. 有线断开："
    echo "   - 检查网线连接"
    echo "   - 更换网线/端口"
    echo "   - 检查交换机/路由器"
    echo ""
    echo "3. DHCP 问题："
    echo "   - 延长 DHCP 租约时间"
    echo "   - 使用静态 IP"
}

# 场景 6：防火墙问题
check_firewall_issue() {
    print_header "排查：防火墙问题"
    
    echo "步骤 1: 检查 iptables 规则"
    iptables -L -n -v 2>/dev/null | head -30 || print_warning "需要 root 权限"
    echo ""
    
    echo "步骤 2: 检查 firewalld"
    if command -v firewall-cmd &>/dev/null; then
        echo "状态：$(firewall-cmd --state 2>/dev/null)"
        echo "开放服务：$(firewall-cmd --list-services 2>/dev/null)"
        echo "开放端口：$(firewall-cmd --list-ports 2>/dev/null)"
    else
        print_warning "firewalld 未安装"
    fi
    echo ""
    
    echo "步骤 3: 检查 ufw"
    if command -v ufw &>/dev/null; then
        ufw status 2>/dev/null
    else
        print_warning "ufw 未安装"
    fi
    echo ""
    
    echo "步骤 4: 测试端口连通性"
    read -p "输入要测试的端口： " port
    echo "监听测试："
    ss -tuln | grep ":$port" || echo "端口未监听"
    echo ""
    
    # 解决方案
    print_header "解决方案"
    echo "1. 临时关闭防火墙（测试用）："
    echo "   sudo systemctl stop firewalld"
    echo "   sudo ufw disable"
    echo ""
    echo "2. 开放特定端口："
    echo "   sudo firewall-cmd --permanent --add-port=$port/tcp"
    echo "   sudo firewall-cmd --reload"
    echo ""
    echo "3. 查看被拒绝的连接："
    echo "   sudo journalctl -u firewalld -n 50"
}

# 场景 7：全面网络诊断
full_network_diagnostic() {
    print_header "全面网络诊断"
    
    echo "=== 1. 网络接口信息 ==="
    ip -br addr show
    echo ""
    
    echo "=== 2. 路由表 ==="
    ip route show
    echo ""
    
    echo "=== 3. DNS 配置 ==="
    cat /etc/resolv.conf
    echo ""
    
    echo "=== 4. 网络连接 ==="
    ss -tuln | head -20
    echo ""
    
    echo "=== 5. Ping 测试 ==="
    echo "网关："
    ping -c 3 $(ip route | grep default | awk '{print $3}') 2>&1 | tail -2
    echo ""
    echo "公共 DNS："
    ping -c 3 8.8.8.8 2>&1 | tail -2
    echo ""
    echo "域名："
    ping -c 3 www.baidu.com 2>&1 | tail -2
    echo ""
    
    echo "=== 6. HTTP 测试 ==="
    curl -I --connect-timeout 5 https://www.baidu.com 2>&1 | head -5
    echo ""
    
    echo "=== 7. 防火墙状态 ==="
    iptables -L -n 2>/dev/null | head -10 || echo "需要 root 权限"
    echo ""
    
    echo "=== 8. 系统日志 ==="
    journalctl -u NetworkManager --no-pager -n 10 2>/dev/null || echo "无日志"
    echo ""
    
    # 生成报告
    print_header "诊断报告"
    local issues=0
    
    if ! ping -c 1 8.8.8.8 &>/dev/null; then
        echo "❌ 问题：无法访问外网"
        ((issues++))
    fi
    
    if ! ping -c 1 www.baidu.com &>/dev/null; then
        echo "❌ 问题：DNS 解析失败"
        ((issues++))
    fi
    
    if [ $issues -eq 0 ]; then
        print_success "未发现网络问题"
    else
        print_warning "发现 $issues 个问题，请参考上述排查步骤"
    fi
}

# 主循环
while true; do
    show_menu
    read -p "请选择排查场景（0-7）： " choice
    
    case $choice in
        1) check_internet_access ;;
        2) check_dns_issue ;;
        3) check_port_connection ;;
        4) check_network_speed ;;
        5) check_connection_drop ;;
        6) check_firewall_issue ;;
        7) full_network_diagnostic ;;
        0)
            print_success "退出"
            exit 0
            ;;
        *)
            print_error "无效选择"
            ;;
    esac
    
    echo ""
    read -p "按回车键继续..."
done

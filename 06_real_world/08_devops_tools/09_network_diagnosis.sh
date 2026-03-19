#!/bin/bash
# =============================================================================
# 脚本名称：09_network_diagnosis.sh
# 功能描述：网络诊断脚本（连通性、延迟、路由、DNS 检测）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 网络工具使用（ping, traceroute, dig, nslookup）
#   - 网络性能测试
#   - 带宽测试
#   - 端口扫描
#   - 故障诊断
# 使用方法：
#   chmod +x 09_network_diagnosis.sh
#   sudo ./09_network_diagnosis.sh [目标主机]
#   sudo ./09_network_diagnosis.sh 8.8.8.8
#   sudo ./09_network_diagnosis.sh www.google.com
# 代码说明：
#   - 支持自定义目标主机
#   - 综合网络诊断
#   - 生成诊断报告
#   - 需要 root 权限进行某些测试
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 默认目标
DEFAULT_TARGET="8.8.8.8"
DEFAULT_DNS="8.8.8.8"
DEFAULT_PORT=80

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "------------------------------------"
}

# 打印测试结果
print_result() {
    local status=$1
    local message=$2
    
    case $status in
        "OK")
            echo -e "${GREEN}✓${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}⚠${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}✗${NC} $message"
            ;;
        "INFO")
            echo -e "${CYAN}ℹ${NC} $message"
            ;;
    esac
}

# 打印表格
print_table_row() {
    printf "%-20s %-15s %-15s %-15s\n" "$1" "$2" "$3" "$4"
}

# =============================================================================
# 检查 root 权限
# =============================================================================
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${YELLOW}警告：某些测试需要 root 权限${NC}"
        echo "建议使用：sudo $0"
        echo ""
    fi
}

# =============================================================================
# 网络接口信息
# =============================================================================
network_interfaces() {
    print_header "网络接口信息"
    
    print_table_row "接口" "IP 地址" "状态" "MAC 地址"
    echo "--------------------------------------------------"
    
    # 获取所有网络接口
    ip -o link show | awk -F': ' '{print $2}' | while read -r iface; do
        # 跳过 loopback
        [[ "$iface" == "lo" ]] && continue
        
        # 获取状态
        local state=$(ip link show "$iface" 2>/dev/null | grep -oP 'state \K\w+')
        [[ -z "$state" ]] && state="UNKNOWN"
        
        # 获取 IP 地址
        local ip_addr=$(ip -4 addr show "$iface" 2>/dev/null | grep -oP 'inet \K[\d.]+' | head -1)
        [[ -z "$ip_addr" ]] && ip_addr="无"
        
        # 获取 MAC 地址
        local mac=$(ip link show "$iface" 2>/dev/null | grep -oP 'link/ether \K[0-9a-f:]+' | head -1)
        [[ -z "$mac" ]] && mac="无"
        
        # 根据状态显示颜色
        if [[ "$state" == "UP" ]]; then
            echo -e "${GREEN}"
        else
            echo -e "${YELLOW}"
        fi
        
        print_table_row "$iface" "$ip_addr" "$state" "$mac"
        echo -e "${NC}"
    done
}

# =============================================================================
# 网关和路由
# =============================================================================
gateway_and_routing() {
    print_header "网关和路由"
    
    # 默认网关
    echo "默认网关:"
    local gateway=$(ip route | grep default | awk '{print $3}' | head -1)
    if [[ -n "$gateway" ]]; then
        print_result "OK" "默认网关：$gateway"
    else
        print_result "ERROR" "未找到默认网关"
    fi
    echo ""
    
    # 路由表
    echo "路由表:"
    ip route show | while read -r line; do
        echo "  $line"
    done
    echo ""
    
    # ARP 缓存
    echo "ARP 缓存:"
    ip neigh show | head -10 | while read -r line; do
        echo "  $line"
    done
    
    local arp_count=$(ip neigh show | wc -l)
    [[ $arp_count -gt 10 ]] && echo "  ... 共 $arp_count 条记录"
}

# =============================================================================
# DNS 配置
# =============================================================================
dns_configuration() {
    print_header "DNS 配置"
    
    # 检查 /etc/resolv.conf
    echo "DNS 服务器配置:"
    if [[ -f /etc/resolv.conf ]]; then
        grep -v "^#" /etc/resolv.conf | grep -v "^$" | while read -r line; do
            echo "  $line"
        done
    else
        print_result "WARN" "未找到 /etc/resolv.conf"
    fi
    echo ""
    
    # DNS 解析测试
    echo "DNS 解析测试:"
    local dns_servers=$(grep -v "^#" /etc/resolv.conf | grep nameserver | awk '{print $2}')
    
    for dns in $dns_servers; do
        local start_time=$(date +%s%N)
        local result=$(dig @"$dns" www.baidu.com +short 2>/dev/null | head -1)
        local end_time=$(date +%s%N)
        local duration=$(( (end_time - start_time) / 1000000 ))
        
        if [[ -n "$result" ]]; then
            print_result "OK" "$dns - 解析成功 (${duration}ms)"
        else
            print_result "ERROR" "$dns - 解析失败"
        fi
    done
    echo ""
    
    # nslookup 测试
    if command -v nslookup &> /dev/null; then
        echo "nslookup 测试:"
        nslookup www.baidu.com 2>/dev/null | grep -A1 "Name:" | while read -r line; do
            echo "  $line"
        done
    fi
}

# =============================================================================
# 连通性测试
# =============================================================================
connectivity_test() {
    local target=${1:-$DEFAULT_TARGET}
    
    print_header "连通性测试 - $target"
    
    # Ping 测试
    echo "Ping 测试 (10 次):"
    if command -v ping &> /dev/null; then
        local ping_result=$(ping -c 10 -W 1 "$target" 2>/dev/null)
        
        if [[ $? -eq 0 ]]; then
            local packet_loss=$(echo "$ping_result" | grep -oP '\d+(?=% packet loss)')
            local avg_rtt=$(echo "$ping_result" | grep -oP 'rtt min/avg/max/mdev = [\d.]+/[\d.]+/[\d.]+/[\d.]+' | cut -d'/' -f2)
            
            if [[ "$packet_loss" -eq 0 ]]; then
                print_result "OK" "连通性正常，丢包率：0%，平均延迟：${avg_rtt}ms"
            elif [[ "$packet_loss" -lt 10 ]]; then
                print_result "WARN" "连通性一般，丢包率：${packet_loss}%"
            else
                print_result "ERROR" "连通性差，丢包率：${packet_loss}%"
            fi
            
            echo ""
            echo "详细统计:"
            echo "$ping_result" | tail -3
        else
            print_result "ERROR" "无法 ping 通目标"
        fi
    else
        print_result "WARN" "未安装 ping 工具"
    fi
}

# =============================================================================
# 延迟测试
# =============================================================================
latency_test() {
    print_header "延迟测试"
    
    echo "到常用网站的延迟:"
    print_table_row "目标" "平均延迟" "丢包率" "状态"
    echo "--------------------------------------------------"
    
    local targets=(
        "114.114.114.114"
        "8.8.8.8"
        "www.baidu.com"
        "www.taobao.com"
        "www.qq.com"
    )
    
    for target in "${targets[@]}"; do
        local ping_result=$(ping -c 5 -W 1 "$target" 2>/dev/null)
        
        if [[ $? -eq 0 ]]; then
            local packet_loss=$(echo "$ping_result" | grep -oP '\d+(?=% packet loss)')
            local avg_rtt=$(echo "$ping_result" | grep -oP 'rtt min/avg/max/mdev = [\d.]+/([\d.]+)/[\d.]+/[\d.]+' | cut -d'/' -f2)
            
            if [[ "$packet_loss" -eq 0 ]]; then
                local status="${GREEN}正常${NC}"
            elif [[ "$packet_loss" -lt 10 ]]; then
                local status="${YELLOW}一般${NC}"
            else
                local status="${RED}差${NC}"
            fi
            
            print_table_row "$target" "${avg_rtt:-N/A}ms" "${packet_loss:-N/A}%" "$status"
        else
            print_table_row "$target" "N/A" "100%" "${RED}失败${NC}"
        fi
    done
}

# =============================================================================
# 路由追踪
# =============================================================================
traceroute_test() {
    local target=${1:-$DEFAULT_TARGET}
    
    print_header "路由追踪 - $target"
    
    if command -v traceroute &> /dev/null; then
        echo "路由跳数:"
        traceroute -m 15 -w 1 "$target" 2>/dev/null | while read -r line; do
            echo "  $line"
        done
        
        local hop_count=$(traceroute -m 15 -w 1 "$target" 2>/dev/null | grep -c "^[[:space:]]*[0-9]")
        echo ""
        print_result "INFO" "总跳数：$hop_count"
    elif command -v tracepath &> /dev/null; then
        echo "使用 tracepath:"
        tracepath -m 15 "$target" 2>/dev/null | head -20
    else
        print_result "WARN" "未安装 traceroute 或 tracepath"
    fi
}

# =============================================================================
# 端口扫描
# =============================================================================
port_scan() {
    local target=${1:-localhost}
    
    print_header "端口扫描 - $target"
    
    echo "常用服务端口:"
    print_table_row "端口" "服务" "状态" "进程"
    echo "--------------------------------------------------"
    
    local common_ports=(
        "21:FTP"
        "22:SSH"
        "23:Telnet"
        "25:SMTP"
        "53:DNS"
        "80:HTTP"
        "110:POP3"
        "143:IMAP"
        "443:HTTPS"
        "993:IMAPS"
        "995:POP3S"
        "3306:MySQL"
        "5432:PostgreSQL"
        "6379:Redis"
        "8080:HTTP-Alt"
        "27017:MongoDB"
    )
    
    for port_info in "${common_ports[@]}"; do
        local port=$(echo "$port_info" | cut -d':' -f1)
        local service=$(echo "$port_info" | cut -d':' -f2)
        
        # 检查端口是否监听
        if netstat -tlnp 2>/dev/null | grep -q ":$port "; then
            local process=$(netstat -tlnp 2>/dev/null | grep ":$port " | awk '{print $7}' | cut -d'/' -f2)
            [[ -z "$process" ]] && process="unknown"
            echo -e "${GREEN}"
            print_table_row "$port" "$service" "LISTEN" "$process"
            echo -e "${NC}"
        elif ss -tlnp 2>/dev/null | grep -q ":$port "; then
            local process=$(ss -tlnp 2>/dev/null | grep ":$port " | awk '{print $6}' | cut -d'"' -f2)
            [[ -z "$process" ]] && process="unknown"
            echo -e "${GREEN}"
            print_table_row "$port" "$service" "LISTEN" "$process"
            echo -e "${NC}"
        else
            print_table_row "$port" "$service" "CLOSED" "-"
        fi
    done
}

# =============================================================================
# 带宽测试
# =============================================================================
bandwidth_test() {
    print_header "带宽测试"
    
    echo "网络接口速度:"
    ip -o link show | awk -F': ' '{print $2}' | while read -r iface; do
        [[ "$iface" == "lo" ]] && continue
        
        local speed=$(ethtool "$iface" 2>/dev/null | grep "Speed:" | awk '{print $2}')
        [[ -z "$speed" || "$speed" == "Unknown" ]] && speed="N/A"
        
        local duplex=$(ethtool "$iface" 2>/dev/null | grep "Duplex:" | awk '{print $2}')
        [[ -z "$duplex" ]] && duplex="N/A"
        
        print_result "INFO" "$iface: $speed $duplex"
    done
    echo ""
    
    # 简单的下载速度测试
    echo "下载速度测试 (到常用 CDN):"
    
    # 测试文件 URL（阿里云 CDN）
    local test_url="http://mirrors.aliyun.com/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso"
    
    if command -v curl &> /dev/null; then
        echo "测试中..."
        local speed=$(curl -o /dev/null -s -w "%{speed_download}" "$test_url" 2>/dev/null)
        
        if [[ -n "$speed" && "$speed" != "0" ]]; then
            local speed_kbps=$(echo "scale=2; $speed / 1024" | bc 2>/dev/null)
            print_result "OK" "下载速度：${speed_kbps} KB/s"
        else
            print_result "WARN" "无法测试下载速度"
        fi
    else
        print_result "WARN" "未安装 curl"
    fi
}

# =============================================================================
# 网络连接统计
# =============================================================================
connection_stats() {
    print_header "网络连接统计"
    
    # TCP 连接统计
    echo "TCP 连接状态:"
    print_table_row "状态" "数量" "百分比" "说明"
    echo "--------------------------------------------------"
    
    local total=$(ss -t 2>/dev/null | grep -v "State" | wc -l)
    [[ $total -eq 0 ]] && total=1
    
    ss -t 2>/dev/null | grep -v "State" | awk '{print $1}' | sort | uniq -c | sort -rn | while read -r count state; do
        local percent=$(echo "scale=1; $count * 100 / $total" | bc 2>/dev/null)
        local desc=""
        
        case $state in
            "ESTAB")
                desc="已建立连接"
                ;;
            "TIME-WAIT")
                desc="等待关闭"
                ;;
            "CLOSE-WAIT")
                desc="等待关闭（应用层）"
                ;;
            "SYN-SENT")
                desc="请求连接"
                ;;
            "SYN-RECV")
                desc="接受连接"
                ;;
            "FIN-WAIT-1"|"FIN-WAIT-2")
                desc="等待关闭"
                ;;
            "LISTEN")
                desc="监听中"
                ;;
            *)
                desc="其他状态"
                ;;
        esac
        
        print_table_row "$state" "$count" "${percent}%" "$desc"
    done
    echo ""
    
    # 连接最多的 IP
    echo "连接最多的远程 IP (TOP10):"
    ss -tn 2>/dev/null | grep ESTAB | awk '{print $5}' | cut -d':' -f1 | sort | uniq -c | sort -rn | head -10 | while read -r count ip; do
        print_result "INFO" "$ip: $count 个连接"
    done
}

# =============================================================================
# 网络故障诊断
# =============================================================================
network_troubleshoot() {
    print_header "网络故障诊断"
    
    local issues=0
    
    # 检查网络接口
    echo "检查网络接口:"
    local up_ifaces=$(ip link show | grep -c "state UP")
    if [[ $up_ifaces -gt 0 ]]; then
        print_result "OK" "$up_ifaces 个接口处于 UP 状态"
    else
        print_result "ERROR" "没有接口处于 UP 状态"
        ((issues++))
    fi
    
    # 检查默认路由
    echo ""
    echo "检查默认路由:"
    if ip route | grep -q default; then
        print_result "OK" "默认路由存在"
    else
        print_result "ERROR" "缺少默认路由"
        ((issues++))
    fi
    
    # 检查 DNS
    echo ""
    echo "检查 DNS 配置:"
    if grep -q "nameserver" /etc/resolv.conf 2>/dev/null; then
        print_result "OK" "DNS 服务器已配置"
    else
        print_result "ERROR" "未配置 DNS 服务器"
        ((issues++))
    fi
    
    # 检查外网连通性
    echo ""
    echo "检查外网连通性:"
    if ping -c 3 -W 1 114.114.114.114 &>/dev/null; then
        print_result "OK" "外网连通正常"
    else
        print_result "ERROR" "无法访问外网"
        ((issues++))
    fi
    
    # 检查 DNS 解析
    echo ""
    echo "检查 DNS 解析:"
    if dig www.baidu.com +short &>/dev/null || nslookup www.baidu.com &>/dev/null; then
        print_result "OK" "DNS 解析正常"
    else
        print_result "ERROR" "DNS 解析失败"
        ((issues++))
    fi
    
    echo ""
    if [[ $issues -eq 0 ]]; then
        print_result "OK" "未发现网络问题"
    else
        print_result "WARN" "发现 $issues 个潜在问题"
    fi
}

# =============================================================================
# 生成诊断报告
# =============================================================================
generate_report() {
    print_header "诊断报告"
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local report_file="/tmp/network_diagnosis_$(date +%Y%m%d_%H%M%S).txt"
    
    echo "诊断时间：$timestamp"
    echo "主机名：$(hostname)"
    echo "报告文件：$report_file"
    echo ""
    
    # 保存报告
    {
        echo "========================================"
        echo "       网络诊断报告"
        echo "========================================"
        echo "诊断时间：$timestamp"
        echo "主机名：$(hostname)"
        echo "========================================"
    } > "$report_file"
    
    echo -e "${GREEN}✓${NC} 诊断报告已生成：$report_file"
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [目标主机]"
    echo ""
    echo "参数:"
    echo "  目标主机    要测试的目标（默认：$DEFAULT_TARGET）"
    echo ""
    echo "示例:"
    echo "  $0                    # 使用默认目标"
    echo "  $0 8.8.8.8           # 测试到 8.8.8.8"
    echo "  $0 www.baidu.com     # 测试到百度"
    echo "  sudo $0              # 以 root 权限运行"
    echo ""
    echo "功能:"
    echo "  - 网络接口信息"
    echo "  - 网关和路由"
    echo "  - DNS 配置"
    echo "  - 连通性测试"
    echo "  - 延迟测试"
    echo "  - 路由追踪"
    echo "  - 端口扫描"
    echo "  - 带宽测试"
    echo "  - 网络连接统计"
    echo "  - 网络故障诊断"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local target="${1:-$DEFAULT_TARGET}"
    
    echo "========================================"
    echo "       网络诊断报告"
    echo "========================================"
    echo "诊断时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "目标主机：$target"
    echo "========================================"
    
    # 检查 root 权限
    check_root
    
    # 执行所有诊断
    network_interfaces
    gateway_and_routing
    dns_configuration
    connectivity_test "$target"
    latency_test
    traceroute_test "$target"
    port_scan localhost
    bandwidth_test
    connection_stats
    network_troubleshoot
    generate_report
    
    echo ""
    echo "========================================"
    echo "        诊断完成"
    echo "========================================"
    echo "诊断时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
else
    main "$@"
fi

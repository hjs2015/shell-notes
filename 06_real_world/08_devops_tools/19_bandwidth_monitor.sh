#!/bin/bash
# =============================================================================
# 脚本名称：19_bandwidth_monitor.sh
# 功能描述：网络带宽监控脚本（实时流量、历史统计、告警）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 网络接口监控
#   - 流量统计
#   - 历史数据记录
#   - 带宽告警
# 使用方法：
#   ./19_bandwidth_monitor.sh --realtime              # 实时监控
#   ./19_bandwidth_monitor.sh --interface eth0        # 指定网卡
#   ./19_bandwidth_monitor.sh --history               # 查看历史
#   ./19_bandwidth_monitor.sh --alert --threshold 100 # 告警模式
# 代码说明：
#   - 使用 /proc/net/dev 或 ip 命令
#   - 支持多网卡监控
#   - 记录历史数据
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
INTERFACE=""
DATA_DIR="/var/log/bandwidth"
INTERVAL=2
ALERT_THRESHOLD=100  # Mbps
LOG_FILE="${DATA_DIR}/bandwidth.log"

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "========================================"
}

# 打印结果
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

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  --realtime           实时监控模式"
    echo "  --interface IFACE    指定网络接口"
    echo "  --list               列出所有接口"
    echo "  --history            查看历史数据"
    echo "  --report             生成报告"
    echo "  --alert              启用告警模式"
    echo "  --threshold N        告警阈值 (Mbps, 默认：100)"
    echo "  --interval N         采样间隔 (秒，默认：2)"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 --realtime"
    echo "  $0 --interface eth0 --realtime"
    echo "  $0 --alert --threshold 50"
}

# =============================================================================
# 列出网络接口
# =============================================================================
list_interfaces() {
    print_header "网络接口列表"
    
    echo ""
    printf "%-15s %-15s %-15s %-15s\n" "接口" "状态" "IP 地址" "MAC 地址"
    echo "------------------------------------------------------------"
    
    # 获取所有接口
    for iface in $(ls /sys/class/net/ 2>/dev/null); do
        local status=$(cat /sys/class/net/$iface/operstate 2>/dev/null || echo "unknown")
        local ip_addr=$(ip addr show $iface 2>/dev/null | grep "inet " | awk '{print $2}' | cut -d'/' -f1 | head -1)
        local mac_addr=$(cat /sys/class/net/$iface/address 2>/dev/null || echo "N/A")
        
        [[ -z "$ip_addr" ]] && ip_addr="N/A"
        
        if [[ "$status" == "up" ]]; then
            echo -e "${GREEN}%-15s${NC} %-15s %-15s %-15s\n" "$iface" "$status" "$ip_addr" "$mac_addr"
        else
            printf "%-15s %-15s %-15s %-15s\n" "$iface" "$status" "$ip_addr" "$mac_addr"
        fi
    done
}

# =============================================================================
# 获取接口统计
# =============================================================================
get_interface_stats() {
    local iface=$1
    
    # 从 /proc/net/dev 读取
    local stats=$(grep "$iface:" /proc/net/dev 2>/dev/null)
    
    if [[ -z "$stats" ]]; then
        echo ""
        return
    fi
    
    # 解析统计信息
    # 格式：Inter-|   Receive                                                |  Transmit
    #      face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    
    local rx_bytes=$(echo "$stats" | awk '{print $2}')
    local rx_packets=$(echo "$stats" | awk '{print $3}')
    local tx_bytes=$(echo "$stats" | awk '{print $10}')
    local tx_packets=$(echo "$stats" | awk '{print $11}')
    
    echo "$rx_bytes $rx_packets $tx_bytes $tx_packets"
}

# =============================================================================
# 计算带宽
# =============================================================================
calculate_bandwidth() {
    local iface=$1
    local interval=$2
    
    # 第一次采样
    local stats1=$(get_interface_stats "$iface")
    local rx_bytes1=$(echo "$stats1" | awk '{print $1}')
    local tx_bytes1=$(echo "$stats1" | awk '{print $3}')
    
    sleep "$interval"
    
    # 第二次采样
    local stats2=$(get_interface_stats "$iface")
    local rx_bytes2=$(echo "$stats2" | awk '{print $1}')
    local tx_bytes2=$(echo "$stats2" | awk '{print $3}')
    
    # 计算差值
    local rx_diff=$((rx_bytes2 - rx_bytes1))
    local tx_diff=$((tx_bytes2 - tx_bytes1))
    
    # 计算速率 (bytes/s → Mbps)
    local rx_mbps=$(echo "scale=2; $rx_diff * 8 / $interval / 1000000" | bc)
    local tx_mbps=$(echo "scale=2; $tx_diff * 8 / $interval / 1000000" | bc)
    local total_mbps=$(echo "scale=2; $rx_mbps + $tx_mbps" | bc)
    
    echo "$rx_mbps $tx_mbps $total_mbps"
}

# =============================================================================
# 实时监控
# =============================================================================
realtime_monitor() {
    local iface=${1:-"all"}
    
    print_header "实时带宽监控"
    
    echo "监控接口：$iface"
    echo "采样间隔：${INTERVAL}秒"
    echo "按 Ctrl+C 退出"
    echo ""
    
    # 如果是 all，监控所有接口
    if [[ "$iface" == "all" ]]; then
        interfaces=$(ls /sys/class/net/ 2>/dev/null | grep -v lo)
    else
        interfaces="$iface"
    fi
    
    # 显示表头
    printf "%-20s " "时间"
    for ifc in $interfaces; do
        printf "%-25s " "$ifc (RX/TX)"
    done
    echo ""
    echo "========================================================================================================"
    
    # 持续监控
    while true; do
        local timestamp=$(date '+%H:%M:%S')
        printf "%-20s " "$timestamp"
        
        for ifc in $interfaces; do
            local bandwidth=$(calculate_bandwidth "$ifc" "$INTERVAL")
            local rx=$(echo "$bandwidth" | awk '{print $1}')
            local tx=$(echo "$bandwidth" | awk '{print $2}')
            
            # 格式化输出
            printf "%-8s/%-8s " "${rx}Mbps" "${tx}Mbps"
            
            # 记录日志
            echo "$(date '+%Y-%m-%d %H:%M:%S') $ifc RX:${rx}Mbps TX:${tx}Mbps" >> "$LOG_FILE"
            
            # 告警检查
            check_alert "$ifc" "$rx" "$tx"
        done
        
        echo ""
    done
}

# =============================================================================
# 告警检查
# =============================================================================
check_alert() {
    local iface=$1
    local rx=$2
    local tx=$3
    
    # 检查是否超过阈值
    local rx_int=${rx%.*}
    local tx_int=${tx%.*}
    
    if [[ $rx_int -gt $ALERT_THRESHOLD ]] || [[ $tx_int -gt $ALERT_THRESHOLD ]]; then
        print_result "WARN" "$iface 带宽超过阈值：RX=${rx}Mbps, TX=${tx}Mbps (阈值：${ALERT_THRESHOLD}Mbps)"
        
        # 记录告警
        echo "$(date '+%Y-%m-%d %H:%M:%S') ALERT $iface RX:${rx}Mbps TX:${tx}Mbps" >> "${DATA_DIR}/alerts.log"
    fi
}

# =============================================================================
# 历史数据
# =============================================================================
show_history() {
    local iface=${1:-"all"}
    local hours=${2:-24}
    
    print_header "历史带宽数据"
    
    if [[ ! -f "$LOG_FILE" ]]; then
        print_result "INFO" "无历史数据"
        return
    fi
    
    echo "接口：$iface"
    echo "时间范围：最近 $hours 小时"
    echo ""
    
    # 显示最近的记录
    tail -50 "$LOG_FILE" | while read -r line; do
        echo "$line"
    done
    
    echo ""
    echo "统计信息:"
    
    # 计算平均值
    if [[ "$iface" == "all" ]]; then
        local count=$(wc -l < "$LOG_FILE")
        echo "  总记录数：$count"
    else
        local count=$(grep "$iface" "$LOG_FILE" | wc -l)
        echo "  $iface 记录数：$count"
    fi
}

# =============================================================================
# 生成报告
# =============================================================================
generate_report() {
    print_header "生成带宽报告"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local report_file="${DATA_DIR}/bandwidth_report_${timestamp}.txt"
    
    mkdir -p "$DATA_DIR"
    
    {
        echo "========================================"
        echo "       网络带宽监控报告"
        echo "========================================"
        echo ""
        echo "生成时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
        
        # 接口列表
        echo "========================================"
        echo "网络接口"
        echo "========================================"
        list_interfaces
        echo ""
        
        # 当前带宽
        echo "========================================"
        echo "当前带宽使用"
        echo "========================================"
        
        for iface in $(ls /sys/class/net/ 2>/dev/null | grep -v lo); do
            local bandwidth=$(calculate_bandwidth "$iface" 1)
            local rx=$(echo "$bandwidth" | awk '{print $1}')
            local tx=$(echo "$bandwidth" | awk '{print $2}')
            
            echo "$iface: RX=${rx}Mbps, TX=${tx}Mbps"
        done
        echo ""
        
        # 历史统计
        if [[ -f "$LOG_FILE" ]]; then
            echo "========================================"
            echo "历史统计"
            echo "========================================"
            
            local today=$(date '+%Y-%m-%d')
            local today_count=$(grep "$today" "$LOG_FILE" | wc -l)
            local alert_count=$(grep "ALERT" "$LOG_FILE" | wc -l)
            
            echo "今日记录数：$today_count"
            echo "告警次数：$alert_count"
        fi
        
    } > "$report_file"
    
    print_result "OK" "报告已保存：$report_file"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local action=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --realtime)
                action="realtime"
                shift
                ;;
            --interface)
                INTERFACE="$2"
                shift 2
                ;;
            --list)
                action="list"
                shift
                ;;
            --history)
                action="history"
                shift
                ;;
            --report)
                action="report"
                shift
                ;;
            --alert)
                action="alert"
                shift
                ;;
            --threshold)
                ALERT_THRESHOLD="$2"
                shift 2
                ;;
            --interval)
                INTERVAL="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "未知选项：$1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # 创建数据目录
    mkdir -p "$DATA_DIR"
    
    # 执行操作
    case $action in
        "list")
            list_interfaces
            ;;
        "realtime")
            realtime_monitor "$INTERFACE"
            ;;
        "history")
            show_history "$INTERFACE"
            ;;
        "report")
            generate_report
            ;;
        "alert")
            # 告警模式后台运行
            nohup "$0" --realtime --interface "$INTERFACE" --alert &
            print_result "OK" "告警监控已启动 (PID: $!)"
            ;;
        *)
            show_help
            ;;
    esac
}

# 执行主程序
main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：10_performance_monitor.sh
# 功能描述：性能监控脚本（CPU、内存、磁盘、网络实时监控）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 系统性能监控
#   - 资源使用统计
#   - 性能瓶颈分析
#   - 告警阈值设置
#   - 历史数据记录
# 使用方法：
#   chmod +x 10_performance_monitor.sh
#   ./10_performance_monitor.sh              # 实时监控
#   ./10_performance_monitor.sh --interval 5 # 5 秒间隔
#   ./10_performance_monitor.sh --log        # 记录日志
# 代码说明：
#   - 支持自定义监控间隔
#   - 支持日志记录
#   - 实时性能展示
#   - 性能瓶颈告警
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 默认配置
DEFAULT_INTERVAL=2
LOG_FILE="/tmp/performance_monitor.log"
ALERT_CPU_THRESHOLD=80
ALERT_MEM_THRESHOLD=80
ALERT_DISK_THRESHOLD=90

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "------------------------------------"
}

# 打印监控数据
print_monitor() {
    local label=$1
    local value=$2
    local threshold=${3:-0}
    local unit=${4:-""}
    
    printf "%-15s: " "$label"
    
    if [[ $threshold -gt 0 ]]; then
        local num_value=$(echo "$value" | grep -oP '[\d.]+')
        if (( $(echo "$num_value >= $threshold" | bc -l 2>/dev/null || echo 0) )); then
            echo -e "${RED}${value}${unit} ⚠${NC}"
        elif (( $(echo "$num_value >= $threshold * 0.8" | bc -l 2>/dev/null || echo 0) )); then
            echo -e "${YELLOW}${value}${unit} ⚠${NC}"
        else
            echo -e "${GREEN}${value}${unit} ✓${NC}"
        fi
    else
        echo -e "${CYAN}${value}${unit}${NC}"
    fi
}

# 进度条显示
print_progress() {
    local percent=$1
    local width=${2:-30}
    local filled=$((percent * width / 100))
    local empty=$((width - filled))
    
    printf "["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" "$percent"
    
    if [[ $percent -ge 90 ]]; then
        echo -e " ${RED}⚠${NC}"
    elif [[ $percent -ge 70 ]]; then
        echo -e " ${YELLOW}⚠${NC}"
    else
        echo -e " ${GREEN}✓${NC}"
    fi
}

# =============================================================================
# CPU 监控
# =============================================================================
monitor_cpu() {
    print_header "CPU 使用率"
    
    # CPU 总使用率
    local cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
    [[ -z "$cpu_idle" ]] && cpu_idle=$(vmstat 1 2 | tail -1 | awk '{print $15}')
    [[ -z "$cpu_idle" ]] && cpu_idle=0
    
    local cpu_usage=$(echo "100 - $cpu_idle" | bc 2>/dev/null || echo 0)
    cpu_usage=${cpu_usage%.*}
    
    echo "总体使用率:"
    print_progress "$cpu_usage"
    echo ""
    
    # 每个核心的使用率
    echo "每个核心:"
    if [[ -f /proc/stat ]]; then
        local cpu_count=$(grep -c "^cpu[0-9]" /proc/stat)
        for i in $(seq 0 $((cpu_count - 1))); do
            local cpu_line=$(grep "^cpu$i " /proc/stat)
            local user=$(echo "$cpu_line" | awk '{print $2}')
            local nice=$(echo "$cpu_line" | awk '{print $3}')
            local system=$(echo "$cpu_line" | awk '{print $4}')
            local idle=$(echo "$cpu_line" | awk '{print $5}')
            local total=$((user + nice + system + idle))
            local used=$((user + nice + system))
            local percent=$((used * 100 / (total + 1)))
            
            printf "  CPU%-2d: " "$i"
            print_progress "$percent" 20
        done
    fi
    echo ""
    
    # 负载
    echo "系统负载:"
    if [[ -f /proc/loadavg ]]; then
        local loadavg=$(cat /proc/loadavg)
        local load1=$(echo "$loadavg" | awk '{print $1}')
        local load5=$(echo "$loadavg" | awk '{print $2}')
        local load15=$(echo "$loadavg" | awk '{print $3}')
        local cpu_count=$(nproc 2>/dev/null || grep -c "^processor" /proc/cpuinfo)
        
        print_table_row "1 分钟" "5 分钟" "15 分钟" "核心数"
        print_table_row "$load1" "$load5" "$load15" "$cpu_count"
        
        # 负载评估
        local load_percent=$(echo "scale=0; $load1 * 100 / $cpu_count" | bc 2>/dev/null || echo 0)
        echo ""
        if [[ $load_percent -ge 100 ]]; then
            print_result "ERROR" "负载过高 (${load_percent}%)"
        elif [[ $load_percent -ge 70 ]]; then
            print_result "WARN" "负载较高 (${load_percent}%)"
        else
            print_result "OK" "负载正常 (${load_percent}%)"
        fi
    fi
}

# =============================================================================
# 内存监控
# =============================================================================
monitor_memory() {
    print_header "内存使用"
    
    # 物理内存
    echo "物理内存:"
    if command -v free &> /dev/null; then
        local mem_info=$(free -m | grep Mem:)
        local total=$(echo "$mem_info" | awk '{print $2}')
        local used=$(echo "$mem_info" | awk '{print $3}')
        local free=$(echo "$mem_info" | awk '{print $4}')
        local available=$(echo "$mem_info" | awk '{print $7}')
        local percent=$((used * 100 / total))
        
        print_table_row "总量" "已用" "空闲" "可用"
        print_table_row "${total}MB" "${used}MB" "${free}MB" "${available}MB"
        echo ""
        
        echo "使用率:"
        print_progress "$percent"
        echo ""
        
        # 内存评估
        if [[ $percent -ge $ALERT_MEM_THRESHOLD ]]; then
            print_result "ERROR" "内存使用率过高 (${percent}%)"
        elif [[ $percent -ge 70 ]]; then
            print_result "WARN" "内存使用率较高 (${percent}%)"
        else
            print_result "OK" "内存使用正常 (${percent}%)"
        fi
    fi
    echo ""
    
    # 交换空间
    echo "交换空间:"
    if command -v free &> /dev/null; then
        local swap_info=$(free -m | grep Swap:)
        local swap_total=$(echo "$swap_info" | awk '{print $2}')
        local swap_used=$(echo "$swap_info" | awk '{print $3}')
        
        if [[ $swap_total -gt 0 ]]; then
            local swap_percent=$((swap_used * 100 / swap_total))
            print_table_row "总量" "已用" "使用率"
            print_table_row "${swap_total}MB" "${swap_used}MB" "${swap_percent}%"
            
            if [[ $swap_percent -ge 50 ]]; then
                echo ""
                print_result "WARN" "交换空间使用率较高"
            fi
        else
            print_result "INFO" "未配置交换空间"
        fi
    fi
    echo ""
    
    # TOP 内存进程
    echo "内存占用 TOP5 进程:"
    ps aux --sort=-%mem | head -6 | tail -5 | while read -r line; do
        local user=$(echo "$line" | awk '{print $1}')
        local pid=$(echo "$line" | awk '{print $2}')
        local mem=$(echo "$line" | awk '{print $4}')
        local cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        printf "  PID %-6s  %-10s  %6s%%  %s\n" "$pid" "$user" "$mem" "${cmd:0:40}"
    done
}

# =============================================================================
# 磁盘监控
# =============================================================================
monitor_disk() {
    print_header "磁盘使用"
    
    # 磁盘空间
    echo "磁盘空间:"
    print_table_row "文件系统" "使用率" "总量" "已用" "可用"
    echo "--------------------------------------------------"
    
    df -h 2>/dev/null | grep -E "^/dev/" | while read -r line; do
        local fs=$(echo "$line" | awk '{print $1}')
        local size=$(echo "$line" | awk '{print $2}')
        local used=$(echo "$line" | awk '{print $3}')
        local avail=$(echo "$line" | awk '{print $4}')
        local percent=$(echo "$line" | awk '{print $5}' | tr -d '%')
        local mount=$(echo "$line" | awk '{print $6}')
        
        # 根据使用率显示颜色
        if [[ $percent -ge $ALERT_DISK_THRESHOLD ]]; then
            echo -e "${RED}"
        elif [[ $percent -ge 70 ]]; then
            echo -e "${YELLOW}"
        fi
        
        printf "%-15s %6s%% %8s %8s %8s  %s\n" "$fs" "$percent" "$size" "$used" "$avail" "$mount"
        echo -e "${NC}"
    done
    echo ""
    
    # inode 使用
    echo "inode 使用:"
    df -i 2>/dev/null | grep -E "^/dev/" | head -5 | while read -r line; do
        local fs=$(echo "$line" | awk '{print $1}')
        local percent=$(echo "$line" | awk '{print $5}' | tr -d '%')
        local mount=$(echo "$line" | awk '{print $6}')
        
        if [[ $percent -ge 80 ]]; then
            echo -e "${YELLOW}"
        fi
        
        printf "  %-20s %6s%%  %s\n" "$fs" "$percent" "$mount"
        echo -e "${NC}"
    done
    echo ""
    
    # 磁盘 IO
    echo "磁盘 IO:"
    if command -v iostat &> /dev/null; then
        iostat -x 1 1 2>/dev/null | grep -E "^sd|^vd|^nvme" | head -5 | while read -r line; do
            local device=$(echo "$line" | awk '{print $1}')
            local util=$(echo "$line" | awk '{print $NF}')
            printf "  %-10s  利用率：%6s%%\n" "$device" "$util"
        done
    else
        print_result "INFO" "未安装 iostat (sysstat 包)"
    fi
}

# =============================================================================
# 网络监控
# =============================================================================
monitor_network() {
    print_header "网络流量"
    
    # 网络接口流量
    echo "接口流量:"
    print_table_row "接口" "接收" "发送" "状态"
    echo "--------------------------------------------------"
    
    for iface in $(ls /sys/class/net/ 2>/dev/null); do
        [[ "$iface" == "lo" ]] && continue
        
        # 获取 RX/TX 字节
        local rx_bytes=$(cat /sys/class/net/"$iface"/statistics/rx_bytes 2>/dev/null || echo 0)
        local tx_bytes=$(cat /sys/class/net/"$iface"/statistics/tx_bytes 2>/dev/null || echo 0)
        
        # 转换为可读格式
        local rx_human=$(numfmt --to=iec-i --suffix=B $rx_bytes 2>/dev/null || echo "${rx_bytes}B")
        local tx_human=$(numfmt --to=iec-i --suffix=B $tx_bytes 2>/dev/null || echo "${tx_bytes}B")
        
        # 获取状态
        local state=$(cat /sys/class/net/"$iface"/operstate 2>/dev/null || echo "unknown")
        
        if [[ "$state" == "up" ]]; then
            echo -e "${GREEN}"
        else
            echo -e "${YELLOW}"
        fi
        
        print_table_row "$iface" "$rx_human" "$tx_human" "$state"
        echo -e "${NC}"
    done
    echo ""
    
    # 网络连接数
    echo "网络连接:"
    if command -v ss &> /dev/null; then
        local established=$(ss -t 2>/dev/null | grep -c ESTAB || echo 0)
        local time_wait=$(ss -t 2>/dev/null | grep -c TIME-WAIT || echo 0)
        local listen=$(ss -t 2>/dev/null | grep -c LISTEN || echo 0)
        
        print_table_row "已建立" "TIME-WAIT" "监听中" "总计"
        local total=$((established + time_wait + listen))
        print_table_row "$established" "$time_wait" "$listen" "$total"
    fi
}

# =============================================================================
# 进程监控
# =============================================================================
monitor_processes() {
    print_header "进程监控"
    
    # 进程总数
    local total_procs=$(ps aux | wc -l)
    local running_procs=$(ps aux | grep -c " R " || echo 0)
    local sleeping_procs=$(ps aux | grep -c " S " || echo 0)
    local zombie_procs=$(ps aux | grep -c " Z " || echo 0)
    
    print_table_row "总数" "运行中" "睡眠中" "僵尸进程"
    print_table_row "$total_procs" "$running_procs" "$sleeping_procs" "$zombie_procs"
    
    if [[ $zombie_procs -gt 0 ]]; then
        echo ""
        print_result "WARN" "发现 $zombie_procs 个僵尸进程"
    fi
    echo ""
    
    # CPU 占用 TOP5
    echo "CPU 占用 TOP5:"
    ps aux --sort=-%cpu | head -6 | tail -5 | while read -r line; do
        local user=$(echo "$line" | awk '{print $1}')
        local pid=$(echo "$line" | awk '{print $2}')
        local cpu=$(echo "$line" | awk '{print $3}')
        local cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        printf "  PID %-6s  %-10s  %6s%%  %s\n" "$pid" "$user" "$cpu" "${cmd:0:40}"
    done
    echo ""
    
    # 内存占用 TOP5
    echo "内存占用 TOP5:"
    ps aux --sort=-%mem | head -6 | tail -5 | while read -r line; do
        local user=$(echo "$line" | awk '{print $1}')
        local pid=$(echo "$line" | awk '{print $2}')
        local mem=$(echo "$line" | awk '{print $4}')
        local cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        printf "  PID %-6s  %-10s  %6s%%  %s\n" "$pid" "$user" "$mem" "${cmd:0:40}"
    done
}

# =============================================================================
# 打印表格
# =============================================================================
print_table_row() {
    printf "%-15s %-15s %-15s %-15s\n" "$1" "$2" "$3" "$4"
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
# 记录日志
# =============================================================================
log_performance() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # 获取关键指标
    local cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
    [[ -z "$cpu_idle" ]] && cpu_idle=0
    local cpu_usage=$(echo "100 - $cpu_idle" | bc 2>/dev/null || echo 0)
    
    local mem_info=$(free -m | grep Mem:)
    local mem_total=$(echo "$mem_info" | awk '{print $2}')
    local mem_used=$(echo "$mem_info" | awk '{print $3}')
    local mem_percent=$((mem_used * 100 / mem_total))
    
    local load1=$(cat /proc/loadavg | awk '{print $1}')
    
    # 写入日志
    echo "$timestamp, CPU:${cpu_usage}%, MEM:${mem_percent}%, LOAD:$load1" >> "$LOG_FILE"
}

# =============================================================================
# 实时监控循环
# =============================================================================
realtime_monitor() {
    local interval=${1:-$DEFAULT_INTERVAL}
    local enable_log=${2:-false}
    
    echo "========================================"
    echo "       性能实时监控"
    echo "========================================"
    echo "监控间隔：${interval}秒"
    echo "日志记录：${enable_log}"
    echo "按 Ctrl+C 停止监控"
    echo "========================================"
    
    while true; do
        clear
        
        echo "========================================"
        echo "       性能监控报告"
        echo "========================================"
        echo "时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "主机：$(hostname)"
        echo "========================================"
        
        # 执行所有监控
        monitor_cpu
        monitor_memory
        monitor_disk
        monitor_network
        monitor_processes
        
        # 记录日志
        if [[ "$enable_log" == "true" ]]; then
            log_performance
        fi
        
        echo ""
        echo "========================================"
        echo "下次更新：${interval}秒后"
        echo "========================================"
        
        sleep "$interval"
    done
}

# =============================================================================
# 单次监控
# =============================================================================
single_monitor() {
    echo "========================================"
    echo "       性能监控报告"
    echo "========================================"
    echo "时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机：$(hostname)"
    echo "========================================"
    
    # 执行所有监控
    monitor_cpu
    monitor_memory
    monitor_disk
    monitor_network
    monitor_processes
    
    echo ""
    echo "========================================"
    echo "        监控完成"
    echo "========================================"
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  -i, --interval N    监控间隔（秒，默认：$DEFAULT_INTERVAL）"
    echo "  -l, --log           启用日志记录"
    echo "  -o, --once          单次监控（不循环）"
    echo "  -h, --help          显示帮助"
    echo ""
    echo "示例:"
    echo "  $0                  # 实时监控（默认间隔）"
    echo "  $0 -i 5             # 5 秒间隔监控"
    echo "  $0 -l               # 启用日志记录"
    echo "  $0 -o               # 单次监控"
    echo ""
    echo "日志文件：$LOG_FILE"
    echo "告警阈值:"
    echo "  CPU: ${ALERT_CPU_THRESHOLD}%"
    echo "  内存：${ALERT_MEM_THRESHOLD}%"
    echo "  磁盘：${ALERT_DISK_THRESHOLD}%"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local interval=$DEFAULT_INTERVAL
    local enable_log=false
    local single_mode=false
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--interval)
                interval="$2"
                shift 2
                ;;
            -l|--log)
                enable_log=true
                shift
                ;;
            -o|--once)
                single_mode=true
                shift
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
    
    if [[ "$single_mode" == "true" ]]; then
        single_monitor
    else
        realtime_monitor "$interval" "$enable_log"
    fi
}

# 执行主程序
main "$@"

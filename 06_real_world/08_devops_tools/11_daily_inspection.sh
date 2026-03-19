#!/bin/bash
# =============================================================================
# 脚本名称：11_daily_inspection.sh
# 功能描述：每日自动巡检脚本（组合多个检查，生成综合报告）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 组合调用多个脚本
#   - 报告生成和格式化
#   - 邮件发送（可选）
#   - 定时任务集成
# 使用方法：
#   chmod +x 11_daily_inspection.sh
#   ./11_daily_inspection.sh                    # 生成报告
#   ./11_daily_inspection.sh --email admin@example.com  # 发送邮件
#   ./11_daily_inspection.sh --output report.txt        # 保存到文件
# 代码说明：
#   - 自动调用其他巡检脚本
#   - 生成综合巡检报告
#   - 支持邮件发送
#   - 支持定时任务
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_DIR="/var/log/inspection"
DATE=$(date +%Y%m%d_%H%M%S)
REPORT_FILE="${REPORT_DIR}/daily_inspection_${DATE}.txt"
HOSTNAME=$(hostname)

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
# 初始化检查
# =============================================================================
init_check() {
    print_header "初始化检查"
    
    # 检查报告目录
    if [[ ! -d "$REPORT_DIR" ]]; then
        mkdir -p "$REPORT_DIR"
        print_result "OK" "创建报告目录：$REPORT_DIR"
    else
        print_result "OK" "报告目录已存在"
    fi
    
    # 检查依赖脚本
    local required_scripts=(
        "06_server_inspection.sh"
        "07_project_check.sh"
        "10_performance_monitor.sh"
    )
    
    echo ""
    echo "检查依赖脚本:"
    for script in "${required_scripts[@]}"; do
        if [[ -x "${SCRIPT_DIR}/${script}" ]]; then
            print_result "OK" "$script 存在且可执行"
        else
            print_result "WARN" "$script 不存在或不可执行"
        fi
    done
}

# =============================================================================
# 系统信息摘要
# =============================================================================
system_summary() {
    print_header "系统信息摘要"
    
    echo "巡检时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机名：$HOSTNAME"
    echo "操作系统：$(cat /etc/*-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "内核版本：$(uname -r)"
    echo "运行时间：$(uptime -p 2>/dev/null || uptime | awk -F, '{print $1,$2}')"
    
    # 系统负载
    local loadavg=$(cat /proc/loadavg)
    local load1=$(echo "$loadavg" | awk '{print $1}')
    local cpu_count=$(nproc 2>/dev/null || grep -c "^processor" /proc/cpuinfo)
    local load_percent=$(echo "scale=0; $load1 * 100 / $cpu_count" | bc 2>/dev/null || echo 0)
    
    echo ""
    echo "系统负载："
    echo "  1 分钟平均：$load1 (${load_percent}%)"
    
    # 内存使用
    local mem_info=$(free -m | grep Mem:)
    local mem_total=$(echo "$mem_info" | awk '{print $2}')
    local mem_used=$(echo "$mem_info" | awk '{print $3}')
    local mem_percent=$((mem_used * 100 / mem_total))
    
    echo "  内存使用：${mem_used}MB / ${mem_total}MB (${mem_percent}%)"
    
    # 磁盘使用
    local disk_info=$(df -h / | grep -v Filesystem)
    local disk_percent=$(echo "$disk_info" | awk '{print $5}' | tr -d '%')
    
    echo "  根分区使用：${disk_percent}%"
    
    # 负载评估
    echo ""
    if [[ $load_percent -ge 100 ]]; then
        print_result "ERROR" "系统负载过高 (${load_percent}%)"
    elif [[ $load_percent -ge 70 ]]; then
        print_result "WARN" "系统负载较高 (${load_percent}%)"
    else
        print_result "OK" "系统负载正常 (${load_percent}%)"
    fi
    
    if [[ $mem_percent -ge 90 ]]; then
        print_result "ERROR" "内存使用率过高 (${mem_percent}%)"
    elif [[ $mem_percent -ge 80 ]]; then
        print_result "WARN" "内存使用率较高 (${mem_percent}%)"
    else
        print_result "OK" "内存使用正常 (${mem_percent}%)"
    fi
    
    if [[ $disk_percent -ge 95 ]]; then
        print_result "ERROR" "磁盘使用率过高 (${disk_percent}%)"
    elif [[ $disk_percent -ge 85 ]]; then
        print_result "WARN" "磁盘使用率较高 (${disk_percent}%)"
    else
        print_result "OK" "磁盘使用正常 (${disk_percent}%)"
    fi
}

# =============================================================================
# 服务状态检查
# =============================================================================
service_status() {
    print_header "服务状态检查"
    
    # 关键服务列表
    local services=(
        "sshd"
        "cron"
        "nginx"
        "mysql"
        "redis"
        "docker"
    )
    
    echo "关键服务状态:"
    echo ""
    
    local running=0
    local stopped=0
    
    for service in "${services[@]}"; do
        if command -v systemctl &> /dev/null; then
            if systemctl is-active --quiet "$service" 2>/dev/null; then
                print_result "OK" "$service - 运行中"
                ((running++))
            else
                print_result "WARN" "$service - 未运行"
                ((stopped++))
            fi
        elif command -v service &> /dev/null; then
            if service "$service" status &>/dev/null; then
                print_result "OK" "$service - 运行中"
                ((running++))
            else
                print_result "WARN" "$service - 未运行"
                ((stopped++))
            fi
        else
            print_result "INFO" "$service - 无法检查"
        fi
    done
    
    echo ""
    echo "服务统计："
    echo "  运行中：$running"
    echo "  未运行：$stopped"
    
    if [[ $stopped -gt 0 ]]; then
        print_result "WARN" "发现 $stopped 个服务未运行"
    else
        print_result "OK" "所有关键服务运行正常"
    fi
}

# =============================================================================
# 安全状态检查
# =============================================================================
security_status() {
    print_header "安全状态检查"
    
    # 检查失败登录
    echo "失败登录尝试:"
    if command -v lastb &> /dev/null; then
        local failed_count=$(lastb 2>/dev/null | grep -v "^$" | grep -v "^btmp" | wc -l)
        if [[ $failed_count -gt 0 ]]; then
            print_result "WARN" "发现 $failed_count 次失败登录尝试"
            echo "最近 5 次:"
            lastb 2>/dev/null | head -5 | sed 's/^/    /'
        else
            print_result "OK" "无失败登录尝试"
        fi
    else
        print_result "INFO" "未安装 lastb 工具"
    fi
    
    # 检查异常端口
    echo ""
    echo "监听端口检查:"
    local suspicious_ports=(23 25 110 143 445 3389)
    local found_suspicious=0
    
    for port in "${suspicious_ports[@]}"; do
        if netstat -tlnp 2>/dev/null | grep -q ":$port "; then
            print_result "WARN" "发现潜在危险端口：$port"
            ((found_suspicious++))
        fi
    done
    
    if [[ $found_suspicious -eq 0 ]]; then
        print_result "OK" "未发现常见危险端口"
    fi
    
    # 检查 777 权限文件
    echo ""
    echo "777 权限文件检查:"
    local dangerous_files=$(find /etc /home /root -perm 0777 -type f 2>/dev/null | wc -l)
    if [[ $dangerous_files -gt 0 ]]; then
        print_result "ERROR" "发现 $dangerous_files 个 777 权限文件"
        find /etc /home /root -perm 0777 -type f 2>/dev/null | head -5 | sed 's/^/    /'
    else
        print_result "OK" "未发现 777 权限文件"
    fi
}

# =============================================================================
# 备份状态检查
# =============================================================================
backup_status() {
    print_header "备份状态检查"
    
    local backup_dirs=(
        "/backup"
        "/backups"
        "/var/backups"
    )
    
    echo "备份目录检查:"
    
    for dir in "${backup_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            local file_count=$(find "$dir" -type f 2>/dev/null | wc -l)
            local latest=$(find "$dir" -type f -mtime -1 2>/dev/null | wc -l)
            
            print_result "OK" "$dir - 大小：$size, 文件数：$file_count"
            
            if [[ $latest -gt 0 ]]; then
                echo "    ✓ 24 小时内有更新 ($latest 个文件)"
            else
                echo "    ⚠ 24 小时内无更新"
            fi
        fi
    done
    
    # 检查最新备份文件
    echo ""
    echo "最新备份文件:"
    find "${backup_dirs[@]}" -type f -name "*.gz" -o -name "*.tar" -o -name "*.sql" 2>/dev/null | \
        xargs ls -lt 2>/dev/null | head -5 | sed 's/^/    /'
}

# =============================================================================
# 日志状态检查
# =============================================================================
log_status() {
    print_header "日志状态检查"
    
    local log_dirs=(
        "/var/log"
        "/var/log/nginx"
        "/var/log/mysql"
    )
    
    echo "日志目录大小:"
    
    for dir in "${log_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            local file_count=$(find "$dir" -type f -name "*.log" 2>/dev/null | wc -l)
            
            print_result "INFO" "$dir - 大小：$size, 日志文件数：$file_count"
            
            # 检查大日志文件
            local large_logs=$(find "$dir" -type f -name "*.log" -size +100M 2>/dev/null | wc -l)
            if [[ $large_logs -gt 0 ]]; then
                echo "    ⚠ 发现 $large_logs 个大于 100MB 的日志文件"
            fi
        fi
    done
    
    # 检查系统日志错误
    echo ""
    echo "系统日志错误（最近 24 小时）:"
    if [[ -f /var/log/syslog ]]; then
        local error_count=$(grep -c "error\|Error\|ERROR" /var/log/syslog 2>/dev/null || echo 0)
        if [[ $error_count -gt 0 ]]; then
            print_result "WARN" "发现 $error_count 条错误日志"
            grep -i "error" /var/log/syslog 2>/dev/null | tail -5 | sed 's/^/    /'
        else
            print_result "OK" "未发现明显错误日志"
        fi
    elif [[ -f /var/log/messages ]]; then
        local error_count=$(grep -c "error\|Error\|ERROR" /var/log/messages 2>/dev/null || echo 0)
        if [[ $error_count -gt 0 ]]; then
            print_result "WARN" "发现 $error_count 条错误日志"
        else
            print_result "OK" "未发现明显错误日志"
        fi
    else
        print_result "INFO" "未找到系统日志文件"
    fi
}

# =============================================================================
# 性能摘要
# =============================================================================
performance_summary() {
    print_header "性能摘要"
    
    # CPU 使用率
    local cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
    [[ -z "$cpu_idle" ]] && cpu_idle=0
    local cpu_usage=$(echo "100 - $cpu_idle" | bc 2>/dev/null || echo 0)
    cpu_usage=${cpu_usage%.*}
    
    echo "CPU 使用率：${cpu_usage}%"
    if [[ $cpu_usage -ge 80 ]]; then
        print_result "WARN" "CPU 使用率较高"
    else
        print_result "OK" "CPU 使用正常"
    fi
    
    # 内存使用率
    local mem_info=$(free -m | grep Mem:)
    local mem_total=$(echo "$mem_info" | awk '{print $2}')
    local mem_used=$(echo "$mem_info" | awk '{print $3}')
    local mem_percent=$((mem_used * 100 / mem_total))
    
    echo "内存使用率：${mem_percent}%"
    if [[ $mem_percent -ge 80 ]]; then
        print_result "WARN" "内存使用率较高"
    else
        print_result "OK" "内存使用正常"
    fi
    
    # 磁盘 IO
    echo ""
    echo "磁盘 IO 统计:"
    if command -v iostat &> /dev/null; then
        iostat -x 1 1 2>/dev/null | grep -E "^sd|^vd|^nvme" | head -3 | while read -r line; do
            local device=$(echo "$line" | awk '{print $1}')
            local util=$(echo "$line" | awk '{print $NF}')
            echo "  $device: 利用率 ${util}%"
        done
    else
        print_result "INFO" "未安装 iostat"
    fi
    
    # 网络连接数
    echo ""
    echo "网络连接:"
    local established=$(ss -t 2>/dev/null | grep -c ESTAB || echo 0)
    local time_wait=$(ss -t 2>/dev/null | grep -c TIME-WAIT || echo 0)
    echo "  已建立连接：$established"
    echo "  TIME-WAIT: $time_wait"
}

# =============================================================================
# 生成报告摘要
# =============================================================================
generate_summary() {
    print_header "巡检总结"
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local issues=0
    local warnings=0
    
    # 统计问题
    echo "问题统计:"
    
    # 检查系统负载
    local load1=$(cat /proc/loadavg | awk '{print $1}')
    local cpu_count=$(nproc 2>/dev/null || grep -c "^processor" /proc/cpuinfo)
    local load_percent=$(echo "scale=0; $load1 * 100 / $cpu_count" | bc 2>/dev/null || echo 0)
    
    if [[ $load_percent -ge 100 ]]; then
        echo "  ${RED}✗${NC} 系统负载过高"
        ((issues++))
    elif [[ $load_percent -ge 70 ]]; then
        echo "  ${YELLOW}⚠${NC} 系统负载较高"
        ((warnings++))
    fi
    
    # 检查内存
    local mem_percent=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    if [[ $mem_percent -ge 90 ]]; then
        echo "  ${RED}✗${NC} 内存使用率过高"
        ((issues++))
    elif [[ $mem_percent -ge 80 ]]; then
        echo "  ${YELLOW}⚠${NC} 内存使用率较高"
        ((warnings++))
    fi
    
    # 检查磁盘
    local disk_percent=$(df / | grep -v Filesystem | awk '{print $5}' | tr -d '%')
    if [[ $disk_percent -ge 95 ]]; then
        echo "  ${RED}✗${NC} 磁盘使用率过高"
        ((issues++))
    elif [[ $disk_percent -ge 85 ]]; then
        echo "  ${YELLOW}⚠${NC} 磁盘使用率较高"
        ((warnings++))
    fi
    
    echo ""
    echo "巡检结果:"
    echo "  严重问题：${RED}${issues}${NC}"
    echo "  警告信息：${YELLOW}${warnings}${NC}"
    echo ""
    
    if [[ $issues -eq 0 && $warnings -eq 0 ]]; then
        print_result "OK" "系统运行正常"
    elif [[ $issues -eq 0 ]]; then
        print_result "WARN" "系统存在 $warnings 个警告"
    else
        print_result "ERROR" "系统存在 $issues 个严重问题"
    fi
    
    echo ""
    echo "报告文件：$REPORT_FILE"
    echo "巡检完成时间：$timestamp"
}

# =============================================================================
# 发送邮件（可选）
# =============================================================================
send_email() {
    local email=$1
    
    print_header "发送邮件"
    
    if command -v mail &> /dev/null; then
        mail -s "[$HOSTNAME] 每日巡检报告 $(date +%Y-%m-%d)" "$email" < "$REPORT_FILE"
        print_result "OK" "报告已发送到：$email"
    else
        print_result "WARN" "未安装 mail 命令，跳过邮件发送"
    fi
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local output_file=""
    local email=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -e|--email)
                email="$2"
                shift 2
                ;;
            -h|--help)
                echo "用法：$0 [选项]"
                echo ""
                echo "选项:"
                echo "  -o, --output FILE  保存到文件"
                echo "  -e, --email EMAIL  发送邮件"
                echo "  -h, --help         显示帮助"
                exit 0
                ;;
            *)
                echo "未知选项：$1"
                exit 1
                ;;
        esac
    done
    
    # 开始巡检
    echo "========================================"
    echo "       每日自动巡检"
    echo "========================================"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机名：$HOSTNAME"
    echo "========================================"
    
    # 执行所有检查
    {
        init_check
        system_summary
        service_status
        security_status
        backup_status
        log_status
        performance_summary
        generate_summary
    } | tee "$REPORT_FILE"
    
    # 如果指定了输出文件
    if [[ -n "$output_file" ]]; then
        cp "$REPORT_FILE" "$output_file"
        print_result "OK" "报告已保存到：$output_file"
    fi
    
    # 如果指定了邮件
    if [[ -n "$email" ]]; then
        send_email "$email"
    fi
    
    echo ""
    echo "========================================"
    echo "       巡检完成"
    echo "========================================"
    echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
main "$@"

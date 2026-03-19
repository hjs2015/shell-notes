#!/bin/bash
# =============================================================================
# 脚本名称：14_log_analysis.sh
# 功能描述：日志分析脚本（统计、搜索、告警、报告生成）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 日志统计分析
#   - 正则表达式匹配
#   - 错误模式识别
#   - 告警阈值设置
#   - 报告生成
# 使用方法：
#   ./14_log_analysis.sh -l /var/log/nginx/access.log    # 分析指定日志
#   ./14_log_analysis.sh -l /var/log/syslog --top-ip     # 查看 TOP IP
#   ./14_log_analysis.sh -l /var/log/app.log --error     # 统计错误
#   ./14_log_analysis.sh -l /var/log/app.log --watch     # 实时监控
# 代码说明：
#   - 支持多种日志格式
#   - 自动识别日志类型
#   - 生成统计报告
#   - 支持实时监控
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
LOG_FILE=""
REPORT_DIR="/var/log/analysis"
TOP_N=10
ERROR_THRESHOLD=100
WATCH_INTERVAL=2

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
    echo "  -l, --log FILE       日志文件路径"
    echo "  -t, --top N          显示前 N 条（默认：10）"
    echo "  --top-ip             显示访问 TOP IP"
    echo "  --top-url            显示访问 TOP URL"
    echo "  --top-status         显示状态码统计"
    echo "  --error              统计错误日志"
    echo "  --search PATTERN     搜索关键字"
    echo "  --time-range START END  时间范围分析"
    echo "  --watch              实时监控模式"
    echo "  --report             生成分析报告"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 -l /var/log/nginx/access.log --top-ip"
    echo "  $0 -l /var/log/app.log --error"
    echo "  $0 -l /var/log/syslog --search 'error'"
    echo "  $0 -l /var/log/nginx/access.log --watch"
}

# =============================================================================
# 检查日志文件
# =============================================================================
check_log_file() {
    if [[ -z "$LOG_FILE" ]]; then
        print_result "ERROR" "请指定日志文件 (-l)"
        exit 1
    fi
    
    if [[ ! -f "$LOG_FILE" ]]; then
        print_result "ERROR" "日志文件不存在：$LOG_FILE"
        exit 1
    fi
    
    if [[ ! -r "$LOG_FILE" ]]; then
        print_result "ERROR" "无法读取日志文件：$LOG_FILE"
        exit 1
    fi
    
    print_result "OK" "日志文件：$LOG_FILE"
}

# =============================================================================
# 识别日志类型
# =============================================================================
identify_log_type() {
    local file=$1
    
    # Nginx access log
    if grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ - .* \[.+\] "' "$file" 2>/dev/null | head -1; then
        echo "nginx_access"
        return
    fi
    
    # Nginx error log
    if grep -qE '^[0-9]{4}/[0-9]{2}/[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} \[error\]' "$file" 2>/dev/null | head -1; then
        echo "nginx_error"
        return
    fi
    
    # Syslog
    if grep -qE '^[A-Z][a-z]{2} +[0-9]+ [0-9]{2}:[0-9]{2}:[0-9]{2}' "$file" 2>/dev/null | head -1; then
        echo "syslog"
        return
    fi
    
    # Apache access log
    if grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ - .* \[.+\] "GET|POST' "$file" 2>/dev/null | head -1; then
        echo "apache_access"
        return
    fi
    
    # MySQL slow log
    if grep -qE '^# Time:|Query_time:' "$file" 2>/dev/null | head -1; then
        echo "mysql_slow"
        return
    fi
    
    # 通用日志
    echo "generic"
}

# =============================================================================
# 基础统计
# =============================================================================
basic_stats() {
    print_header "基础统计"
    
    local total_lines=$(wc -l < "$LOG_FILE")
    local file_size=$(du -h "$LOG_FILE" | cut -f1)
    local first_line=$(head -1 "$LOG_FILE")
    local last_line=$(tail -1 "$LOG_FILE")
    
    echo "文件信息:"
    echo "  总行数：$total_lines"
    echo "  文件大小：$file_size"
    echo ""
    echo "时间范围:"
    echo "  第一条：${first_line:0:60}..."
    echo "  最后一条：${last_line:0:60}..."
    
    print_result "OK" "统计完成"
}

# =============================================================================
# TOP IP 分析
# =============================================================================
top_ip() {
    print_header "TOP $TOP_N IP 地址"
    
    local log_type=$(identify_log_type "$LOG_FILE")
    
    case $log_type in
        "nginx_access"|"apache_access")
            awk '{print $1}' "$LOG_FILE" | \
                sort | uniq -c | sort -rn | head -n "$TOP_N" | \
                awk '{printf "%-8s %-20s %s\n", $1, $2, ""}'
            ;;
        "syslog")
            grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$LOG_FILE" | \
                sort | uniq -c | sort -rn | head -n "$TOP_N" | \
                awk '{printf "%-8s %-20s\n", $1, $2}'
            ;;
        *)
            print_result "INFO" "未识别到 IP 地址格式"
            ;;
    esac
}

# =============================================================================
# TOP URL 分析
# =============================================================================
top_url() {
    print_header "TOP $TOP_N 访问 URL"
    
    local log_type=$(identify_log_type "$LOG_FILE")
    
    case $log_type in
        "nginx_access"|"apache_access")
            awk -F'"' '{print $2}' "$LOG_FILE" | \
                awk '{print $2}' | \
                sort | uniq -c | sort -rn | head -n "$TOP_N" | \
                awk '{printf "%-8s %s\n", $1, $2}'
            ;;
        *)
            print_result "INFO" "未识别到 URL 格式"
            ;;
    esac
}

# =============================================================================
# 状态码统计
# =============================================================================
top_status() {
    print_header "HTTP 状态码统计"
    
    local log_type=$(identify_log_type "$LOG_FILE")
    
    case $log_type in
        "nginx_access"|"apache_access")
            awk -F'"' '{print $3}' "$LOG_FILE" | \
                awk '{print $1}' | \
                sort | uniq -c | sort -rn | \
                awk '{
                    code=$2
                    count=$1
                    if(code ~ /^2/) status="✓ 成功"
                    else if(code ~ /^3/) status="→ 重定向"
                    else if(code ~ /^4/) status="⚠ 客户端错误"
                    else if(code ~ /^5/) status="✗ 服务器错误"
                    else status="?"
                    printf "%-8s %-15s %s\n", count, code, status
                }'
            ;;
        *)
            print_result "INFO" "未识别到状态码格式"
            ;;
    esac
}

# =============================================================================
# 错误统计
# =============================================================================
error_stats() {
    print_header "错误日志统计"
    
    local total_lines=$(wc -l < "$LOG_FILE")
    local error_count=$(grep -ciE 'error|exception|fatal|critical' "$LOG_FILE")
    local warn_count=$(grep -ciE 'warn|warning' "$LOG_FILE")
    local critical_count=$(grep -ciE 'fatal|critical|emergency|alert' "$LOG_FILE")
    
    echo "错误统计:"
    printf "%-20s %-10s %-10s\n" "类型" "数量" "占比"
    echo "----------------------------------------"
    
    if [[ $error_count -gt 0 ]]; then
        local error_percent=$(echo "scale=2; $error_count * 100 / $total_lines" | bc)
        printf "%-20s %-10s %-10s\n" "错误 (Error)" "$error_count" "${error_percent}%"
    fi
    
    if [[ $warn_count -gt 0 ]]; then
        local warn_percent=$(echo "scale=2; $warn_count * 100 / $total_lines" | bc)
        printf "%-20s %-10s %-10s\n" "警告 (Warning)" "$warn_count" "${warn_percent}%"
    fi
    
    if [[ $critical_count -gt 0 ]]; then
        local critical_percent=$(echo "scale=2; $critical_count * 100 / $total_lines" | bc)
        printf "%-20s %-10s %-10s\n" "严重 (Critical)" "$critical_count" "${critical_percent}%"
    fi
    
    echo ""
    
    # 评估
    if [[ $critical_count -gt 0 ]]; then
        print_result "ERROR" "发现 $critical_count 条严重错误"
    elif [[ $error_count -gt $ERROR_THRESHOLD ]]; then
        print_result "WARN" "错误数量超过阈值 ($error_count > $ERROR_THRESHOLD)"
    elif [[ $error_count -gt 0 ]]; then
        print_result "WARN" "发现 $error_count 条错误"
    else
        print_result "OK" "未发现明显错误"
    fi
    
    # 显示最近错误
    echo ""
    echo "最近 10 条错误:"
    grep -iE 'error|exception|fatal|critical' "$LOG_FILE" | tail -10 | while read -r line; do
        echo -e "${RED}$line${NC}"
    done
}

# =============================================================================
# 关键字搜索
# =============================================================================
search_keyword() {
    local pattern=$1
    
    print_header "搜索关键字：$pattern"
    
    local match_count=$(grep -ci "$pattern" "$LOG_FILE")
    
    echo "匹配结果:"
    echo "  匹配行数：$match_count"
    echo ""
    
    if [[ $match_count -gt 0 ]]; then
        echo "最近 20 条匹配:"
        grep -i "$pattern" "$LOG_FILE" | tail -20 | while read -r line; do
            # 高亮显示
            echo "$line" | sed "s/$pattern/${RED}$pattern${NC}/gi"
        done
    else
        print_result "INFO" "未找到匹配项"
    fi
}

# =============================================================================
# 时间范围分析
# =============================================================================
time_range_analysis() {
    local start_time=$1
    local end_time=$2
    
    print_header "时间范围分析"
    
    echo "分析范围：$start_time 到 $end_time"
    echo ""
    
    # 简单实现：统计每个小时的日志数量
    echo "每小时日志数量:"
    
    local log_type=$(identify_log_type "$LOG_FILE")
    
    case $log_type in
        "syslog")
            awk '{print $3}' "$LOG_FILE" | cut -d':' -f1 | \
                sort | uniq -c | sort -k2n | \
                awk '{printf "%-10s %s\n", $2":00", $1}'
            ;;
        "nginx_access"|"apache_access")
            awk -F'[\\[:]' '{print $2":"$3":00"}' "$LOG_FILE" | \
                sort | uniq -c | sort -k2 | \
                awk '{printf "%-10s %s\n", $2, $1}'
            ;;
        *)
            print_result "INFO" "未识别到时间格式"
            ;;
    esac
}

# =============================================================================
# 实时监控
# =============================================================================
watch_log() {
    print_header "实时监控模式"
    
    echo "监控文件：$LOG_FILE"
    echo "刷新间隔：${WATCH_INTERVAL}秒"
    echo "按 Ctrl+C 退出"
    echo ""
    
    # 显示最新 10 行
    echo "最新 10 行:"
    tail -10 "$LOG_FILE"
    
    echo ""
    echo "开始实时监控..."
    echo "----------------------------------------"
    
    # 使用 tail -f 实时监控
    tail -f "$LOG_FILE" | while read -r line; do
        local timestamp=$(date '+%H:%M:%S')
        
        # 高亮显示错误
        if echo "$line" | grep -qiE 'error|exception|fatal'; then
            echo -e "${RED}[$timestamp] $line${NC}"
        elif echo "$line" | grep -qiE 'warn|warning'; then
            echo -e "${YELLOW}[$timestamp] $line${NC}"
        else
            echo "[$timestamp] $line"
        fi
    done
}

# =============================================================================
# 生成报告
# =============================================================================
generate_report() {
    print_header "生成分析报告"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local report_file="${REPORT_DIR}/log_analysis_${timestamp}.txt"
    
    mkdir -p "$REPORT_DIR"
    
    {
        echo "========================================"
        echo "       日志分析报告"
        echo "========================================"
        echo ""
        echo "分析时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "日志文件：$LOG_FILE"
        echo "文件大小：$(du -h "$LOG_FILE" | cut -f1)"
        echo "总行数：$(wc -l < "$LOG_FILE")"
        echo ""
        
        echo "========================================"
        echo "基础统计"
        echo "========================================"
        basic_stats
        echo ""
        
        echo "========================================"
        echo "TOP IP 地址"
        echo "========================================"
        top_ip
        echo ""
        
        echo "========================================"
        echo "错误统计"
        echo "========================================"
        error_stats
        echo ""
        
    } > "$report_file"
    
    print_result "OK" "报告已保存：$report_file"
    echo "报告路径：$report_file"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local action=""
    local search_pattern=""
    local start_time=""
    local end_time=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -l|--log)
                LOG_FILE="$2"
                shift 2
                ;;
            -t|--top)
                TOP_N="$2"
                shift 2
                ;;
            --top-ip)
                action="top-ip"
                shift
                ;;
            --top-url)
                action="top-url"
                shift
                ;;
            --top-status)
                action="top-status"
                shift
                ;;
            --error)
                action="error"
                shift
                ;;
            --search)
                action="search"
                search_pattern="$2"
                shift 2
                ;;
            --time-range)
                action="time-range"
                start_time="$2"
                end_time="$3"
                shift 3
                ;;
            --watch)
                action="watch"
                shift
                ;;
            --report)
                action="report"
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
    
    # 检查日志文件
    check_log_file
    
    # 识别日志类型
    local log_type=$(identify_log_type "$LOG_FILE")
    print_result "OK" "日志类型：$log_type"
    
    # 执行操作
    case $action in
        "top-ip")
            top_ip
            ;;
        "top-url")
            top_url
            ;;
        "top-status")
            top_status
            ;;
        "error")
            error_stats
            ;;
        "search")
            search_keyword "$search_pattern"
            ;;
        "time-range")
            time_range_analysis "$start_time" "$end_time"
            ;;
        "watch")
            watch_log
            ;;
        "report")
            generate_report
            ;;
        *)
            # 默认显示所有统计
            basic_stats
            echo ""
            top_ip
            echo ""
            error_stats
            ;;
    esac
}

# 执行主程序
main "$@"

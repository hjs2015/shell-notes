#!/bin/bash
# =============================================================================
# 脚本名称：17_ssl_monitor.sh
# 功能描述：SSL 证书监控脚本（过期检查、告警、多域名监控）
# 难度等级：⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - SSL 证书检查
#   - 过期告警
#   - 多域名监控
#   - 报告生成
# 使用方法：
#   ./17_ssl_monitor.sh -d example.com                 # 检查单个域名
#   ./17_ssl_monitor.sh -f domains.txt                 # 批量检查
#   ./17_ssl_monitor.sh --alert --days 30              # 告警模式
#   ./17_ssl_monitor.sh --report                       # 生成报告
# 代码说明：
#   - 使用 openssl 检查证书
#   - 支持多域名监控
#   - 自动告警通知
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
DOMAINS_FILE=""
ALERT_DAYS=30
ALERT_EMAIL=""
REPORT_DIR="/var/log/ssl_monitor"

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
    echo "  -d, --domain DOMAIN  检查单个域名"
    echo "  -f, --file FILE      批量检查域名列表"
    echo "  -p, --port PORT      端口（默认：443）"
    echo "  --alert              启用告警模式"
    echo "  --days N             告警阈值天数（默认：30）"
    echo "  --email EMAIL        告警邮箱"
    echo "  --report             生成报告"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 -d example.com"
    echo "  $0 -f domains.txt --alert --days 30"
    echo "  $0 --report"
}

# =============================================================================
# 检查单个域名证书
# =============================================================================
check_ssl_cert() {
    local domain=$1
    local port=${2:-443}
    
    # 检查 openssl
    if ! command -v openssl &> /dev/null; then
        print_result "ERROR" "未安装 openssl"
        return 1
    fi
    
    # 获取证书信息
    local cert_info=$(echo | openssl s_client -servername "$domain" -connect "$domain:$port" 2>/dev/null | openssl x509 -noout -dates -subject -issuer 2>/dev/null)
    
    if [[ -z "$cert_info" ]]; then
        print_result "ERROR" "无法获取证书信息：$domain"
        return 1
    fi
    
    # 解析信息
    local subject=$(echo "$cert_info" | grep "subject=" | cut -d'=' -f2-)
    local issuer=$(echo "$cert_info" | grep "issuer=" | cut -d'=' -f2-)
    local not_before=$(echo "$cert_info" | grep "notBefore=" | cut -d'=' -f2-)
    local not_after=$(echo "$cert_info" | grep "notAfter=" | cut -d'=' -f2-)
    
    # 计算过期时间
    local not_after_epoch=$(date -d "$not_after" +%s 2>/dev/null)
    local current_epoch=$(date +%s)
    local days_left=$(( (not_after_epoch - current_epoch) / 86400 ))
    
    # 显示信息
    echo ""
    echo -e "${CYAN}域名：${NC}$domain"
    echo "----------------------------------------"
    echo "证书主题：$subject"
    echo "颁发机构：$issuer"
    echo "生效时间：$not_before"
    echo "过期时间：$not_after"
    echo ""
    
    # 评估状态
    if [[ $days_left -lt 0 ]]; then
        print_result "ERROR" "证书已过期！过期 ${days_left#-} 天"
        return 2
    elif [[ $days_left -lt 7 ]]; then
        print_result "ERROR" "证书即将过期！剩余 $days_left 天"
        return 2
    elif [[ $days_left -lt $ALERT_DAYS ]]; then
        print_result "WARN" "证书将在 $days_left 天后过期"
        return 1
    else
        print_result "OK" "证书有效，剩余 $days_left 天"
        return 0
    fi
}

# =============================================================================
# 批量检查
# =============================================================================
batch_check() {
    local file=$1
    
    print_header "批量 SSL 证书检查"
    
    if [[ ! -f "$file" ]]; then
        print_result "ERROR" "域名列表文件不存在：$file"
        exit 1
    fi
    
    local total=0
    local ok=0
    local warn=0
    local error=0
    
    echo "域名列表：$file"
    echo "告警阈值：$ALERT_DAYS 天"
    echo ""
    
    # 读取域名列表
    while IFS= read -r domain || [[ -n "$domain" ]]; do
        # 跳过空行和注释
        [[ -z "$domain" || "$domain" =~ ^# ]] && continue
        
        ((total++))
        
        check_ssl_cert "$domain"
        local status=$?
        
        case $status in
            0) ((ok++)) ;;
            1) ((warn++)) ;;
            2) ((error++)) ;;
        esac
        
        echo ""
    done < "$file"
    
    # 统计
    print_header "检查统计"
    echo "总域名数：$total"
    echo -e "正常：${GREEN}$ok${NC}"
    echo -e "警告：${YELLOW}$warn${NC}"
    echo -e "错误：${RED}$error${NC}"
    
    # 返回状态
    [[ $error -gt 0 ]] && return 2
    [[ $warn -gt 0 ]] && return 1
    return 0
}

# =============================================================================
# 发送告警
# =============================================================================
send_alert() {
    local domain=$1
    local days_left=$2
    local status=$3
    
    local subject="[SSL 告警] $domain 证书剩余 $days_left 天"
    local body="域名：$domain\n证书状态：$status\n剩余天数：$days_left\n检查时间：$(date '+%Y-%m-%d %H:%M:%S')"
    
    if command -v mail &> /dev/null && [[ -n "$ALERT_EMAIL" ]]; then
        echo -e "$body" | mail -s "$subject" "$ALERT_EMAIL"
        print_result "OK" "告警邮件已发送：$ALERT_EMAIL"
    else
        print_result "INFO" "告警信息：$subject"
        echo -e "$body"
    fi
}

# =============================================================================
# 生成报告
# =============================================================================
generate_report() {
    print_header "生成 SSL 证书报告"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local report_file="${REPORT_DIR}/ssl_report_${timestamp}.txt"
    
    mkdir -p "$REPORT_DIR"
    
    {
        echo "========================================"
        echo "       SSL 证书监控报告"
        echo "========================================"
        echo ""
        echo "生成时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "告警阈值：$ALERT_DAYS 天"
        echo ""
        
        # 如果有域名列表
        if [[ -n "$DOMAINS_FILE" && -f "$DOMAINS_FILE" ]]; then
            while IFS= read -r domain || [[ -n "$domain" ]]; do
                [[ -z "$domain" || "$domain" =~ ^# ]] && continue
                
                check_ssl_cert "$domain"
                echo ""
                echo "----------------------------------------"
                echo ""
            done < "$DOMAINS_FILE"
        fi
        
    } > "$report_file"
    
    print_result "OK" "报告已保存：$report_file"
}

# =============================================================================
# 显示证书详情
# =============================================================================
show_cert_details() {
    local domain=$1
    local port=${2:-443}
    
    print_header "证书详情：$domain"
    
    # 获取完整证书信息
    echo | openssl s_client -servername "$domain" -connect "$domain:$port" 2>/dev/null | \
        openssl x509 -noout -text 2>/dev/null | head -50
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local domain=""
    local port=443
    local action="check"
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--domain)
                domain="$2"
                action="single"
                shift 2
                ;;
            -f|--file)
                DOMAINS_FILE="$2"
                action="batch"
                shift 2
                ;;
            -p|--port)
                port="$2"
                shift 2
                ;;
            --alert)
                action="alert"
                shift
                ;;
            --days)
                ALERT_DAYS="$2"
                shift 2
                ;;
            --email)
                ALERT_EMAIL="$2"
                shift 2
                ;;
            --report)
                action="report"
                shift
                ;;
            --details)
                action="details"
                domain="$2"
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
    
    # 执行操作
    case $action in
        "single")
            check_ssl_cert "$domain" "$port"
            ;;
        "batch")
            batch_check "$DOMAINS_FILE"
            ;;
        "alert")
            # 告警模式
            if [[ -n "$DOMAINS_FILE" ]]; then
                while IFS= read -r domain || [[ -n "$domain" ]]; do
                    [[ -z "$domain" || "$domain" =~ ^# ]] && continue
                    
                    local cert_info=$(echo | openssl s_client -servername "$domain" -connect "$domain:$port" 2>/dev/null | openssl x509 -noout -dates 2>/dev/null)
                    local not_after=$(echo "$cert_info" | grep "notAfter=" | cut -d'=' -f2-)
                    local not_after_epoch=$(date -d "$not_after" +%s 2>/dev/null)
                    local current_epoch=$(date +%s)
                    local days_left=$(( (not_after_epoch - current_epoch) / 86400 ))
                    
                    if [[ $days_left -lt $ALERT_DAYS ]]; then
                        send_alert "$domain" "$days_left" "即将过期"
                    fi
                done < "$DOMAINS_FILE"
            fi
            ;;
        "report")
            generate_report
            ;;
        "details")
            show_cert_details "$domain" "$port"
            ;;
        *)
            show_help
            ;;
    esac
}

# 执行主程序
main "$@"

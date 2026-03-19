#!/bin/bash
# =============================================================================
# 脚本名称：21_security_baseline.sh
# 功能描述：系统安全基线检查脚本（合规检查、等保 2.0、CIS Benchmark）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 安全基线检查
#   - 等保 2.0 合规
#   - CIS Benchmark
#   - 风险评估
# 使用方法：
#   sudo ./21_security_baseline.sh --check            # 安全检查
#   sudo ./21_security_baseline.sh --level basic      # 基础级别
#   sudo ./21_security_baseline.sh --report           # 生成报告
#   sudo ./21_security_baseline.sh --fix              # 自动修复
# 代码说明：
#   - 参考等保 2.0 和 CIS Benchmark
#   - 支持多级安全检查
#   - 自动生成修复建议
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
CHECK_LEVEL="basic"  # basic, standard, strict
AUTO_FIX=false
REPORT_DIR="/var/log/security_baseline"
SCORE=0
TOTAL=0

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
        "PASS")
            echo -e "${GREEN}✓ 通过${NC} $message"
            ((SCORE++))
            ;;
        "FAIL")
            echo -e "${RED}✗ 失败${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}⚠ 警告${NC} $message"
            ((SCORE++))
            ;;
        "INFO")
            echo -e "${CYAN}ℹ${NC} $message"
            ;;
    esac
    ((TOTAL++))
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  --check              执行安全检查"
    echo "  --level LEVEL        检查级别 (basic/standard/strict)"
    echo "  --fix                自动修复（谨慎使用）"
    echo "  --report             生成报告"
    echo "  --category CAT       指定检查类别"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "检查类别:"
    echo "  account     账户安全"
    echo "  password    密码策略"
    echo "  ssh         SSH 配置"
    echo "  firewall    防火墙"
    echo "  audit       审计日志"
    echo "  file        文件权限"
    echo "  service     服务安全"
    echo ""
    echo "示例:"
    echo "  $0 --check --level basic"
    echo "  $0 --check --category ssh"
}

# =============================================================================
# 账户安全检查
# =============================================================================
check_accounts() {
    print_header "账户安全检查"
    
    # 检查 root 账户
    local root_locked=$(passwd -S root 2>/dev/null | awk '{print $2}')
    if [[ "$root_locked" == "L" || "$root_locked" == "LK" ]]; then
        print_result "PASS" "root 账户已锁定"
    else
        print_result "FAIL" "root 账户未锁定（建议锁定）"
        [[ "$AUTO_FIX" == "true" ]] && passwd -l root
    fi
    
    # 检查空密码账户
    local empty_pwd=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)
    if [[ -z "$empty_pwd" ]]; then
        print_result "PASS" "无空密码账户"
    else
        print_result "FAIL" "发现空密码账户：$empty_pwd"
    fi
    
    # 检查 UID 0 账户
    local uid_zero=$(awk -F: '($3 == 0) {print $1}' /etc/passwd 2>/dev/null)
    if [[ "$uid_zero" == "root" ]]; then
        print_result "PASS" "仅 root 拥有 UID 0"
    else
        print_result "FAIL" "发现多个 UID 0 账户：$uid_zero"
    fi
    
    # 检查最后登录
    echo ""
    echo "最近登录:"
    last -5 2>/dev/null | head -5 | sed 's/^/  /'
}

# =============================================================================
# 密码策略检查
# =============================================================================
check_password_policy() {
    print_header "密码策略检查"
    
    # 检查密码过期策略
    local pass_max_days=$(grep "^PASS_MAX_DAYS" /etc/login.defs 2>/dev/null | awk '{print $2}')
    if [[ -n "$pass_max_days" && $pass_max_days -le 90 ]]; then
        print_result "PASS" "密码最大有效期：$pass_max_days 天"
    else
        print_result "FAIL" "密码最大有效期过长：${pass_max_days:-未设置} 天（建议≤90）"
        [[ "$AUTO_FIX" == "true" ]] && sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
    fi
    
    # 检查密码最小长度
    local minlen=$(grep -E "^minlen" /etc/security/pwquality.conf 2>/dev/null | cut -d'=' -f2)
    if [[ -n "$minlen" && $minlen -ge 8 ]]; then
        print_result "PASS" "密码最小长度：$minlen"
    else
        print_result "FAIL" "密码最小长度不足：${minlen:-未设置}（建议≥8）"
    fi
    
    # 检查密码复杂度
    if grep -q "ucredit\|lcredit\|dcredit\|ocredit" /etc/security/pwquality.conf 2>/dev/null; then
        print_result "PASS" "密码复杂度要求已配置"
    else
        print_result "FAIL" "未配置密码复杂度要求"
    fi
    
    # 检查登录失败锁定
    local deny=$(grep "^deny" /etc/security/faillock.conf 2>/dev/null | cut -d'=' -f2)
    if [[ -n "$deny" ]]; then
        print_result "PASS" "登录失败锁定：$deny 次"
    else
        print_result "WARN" "未配置登录失败锁定"
    fi
}

# =============================================================================
# SSH 配置检查
# =============================================================================
check_ssh_config() {
    print_header "SSH 配置检查"
    
    local ssh_config="/etc/ssh/sshd_config"
    
    if [[ ! -f "$ssh_config" ]]; then
        print_result "INFO" "未安装 SSH 服务"
        return
    fi
    
    # 检查 PermitRootLogin
    local root_login=$(grep -E "^PermitRootLogin" "$ssh_config" 2>/dev/null | awk '{print $2}')
    if [[ "$root_login" == "no" ]]; then
        print_result "PASS" "禁止 root 登录"
    else
        print_result "FAIL" "允许 root 登录：${root_login:-未设置}（建议 no）"
        [[ "$AUTO_FIX" == "true" ]] && sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$ssh_config"
    fi
    
    # 检查密码认证
    local pwd_auth=$(grep -E "^PasswordAuthentication" "$ssh_config" 2>/dev/null | awk '{print $2}')
    if [[ "$pwd_auth" == "no" ]]; then
        print_result "PASS" "禁用密码认证"
    else
        print_result "WARN" "启用密码认证：${pwd_auth:-未设置}（建议使用密钥认证）"
    fi
    
    # 检查 SSH 端口
    local port=$(grep -E "^Port" "$ssh_config" 2>/dev/null | awk '{print $2}')
    if [[ "$port" != "22" ]]; then
        print_result "PASS" "使用非标准端口：$port"
    else
        print_result "WARN" "使用默认 SSH 端口：22（建议修改）"
    fi
    
    # 检查空闲超时
    local client_alive=$(grep -E "^ClientAliveInterval" "$ssh_config" 2>/dev/null | awk '{print $2}')
    if [[ -n "$client_alive" && $client_alive -gt 0 ]]; then
        print_result "PASS" "SSH 空闲超时：$client_alive 秒"
    else
        print_result "WARN" "未配置 SSH 空闲超时"
    fi
    
    # 检查 Protocol
    local protocol=$(grep -E "^Protocol" "$ssh_config" 2>/dev/null | awk '{print $2}')
    if [[ "$protocol" == "2" ]]; then
        print_result "PASS" "使用 SSH Protocol 2"
    else
        print_result "INFO" "SSH Protocol: ${protocol:-2}"
    fi
}

# =============================================================================
# 防火墙检查
# =============================================================================
check_firewall() {
    print_header "防火墙检查"
    
    # 检查 firewalld
    if command -v firewall-cmd &> /dev/null; then
        local fw_status=$(systemctl is-active firewalld 2>/dev/null)
        if [[ "$fw_status" == "active" ]]; then
            print_result "PASS" "firewalld 运行中"
            
            echo ""
            echo "开放端口:"
            firewall-cmd --list-ports 2>/dev/null | sed 's/^/  /'
        else
            print_result "FAIL" "firewalld 未运行"
        fi
        return
    fi
    
    # 检查 ufw
    if command -v ufw &> /dev/null; then
        local ufw_status=$(ufw status 2>/dev/null | head -1)
        if echo "$ufw_status" | grep -q "active"; then
            print_result "PASS" "ufw 防火墙启用"
        else
            print_result "FAIL" "ufw 防火墙未启用"
        fi
        return
    fi
    
    # 检查 iptables
    if command -v iptables &> /dev/null; then
        local ipt_rules=$(iptables -L -n 2>/dev/null | wc -l)
        if [[ $ipt_rules -gt 5 ]]; then
            print_result "PASS" "iptables 有规则配置（$ipt_rules 条）"
        else
            print_result "WARN" "iptables 规则较少"
        fi
        return
    fi
    
    print_result "INFO" "未检测到防火墙服务"
}

# =============================================================================
# 审计日志检查
# =============================================================================
check_audit() {
    print_header "审计日志检查"
    
    # 检查 auditd
    if command -v auditd &> /dev/null; then
        local audit_status=$(systemctl is-active auditd 2>/dev/null)
        if [[ "$audit_status" == "active" ]]; then
            print_result "PASS" "auditd 服务运行中"
        else
            print_result "FAIL" "auditd 服务未运行"
        fi
    else
        print_result "INFO" "未安装 auditd"
    fi
    
    # 检查 rsyslog
    local rsyslog_status=$(systemctl is-active rsyslog 2>/dev/null)
    if [[ "$rsyslog_status" == "active" ]]; then
        print_result "PASS" "rsyslog 服务运行中"
    else
        print_result "FAIL" "rsyslog 服务未运行"
    fi
    
    # 检查日志轮转
    if [[ -f "/etc/logrotate.conf" ]]; then
        print_result "PASS" "日志轮转已配置"
    else
        print_result "WARN" "未配置日志轮转"
    fi
    
    # 检查日志保护
    local log_perms=$(stat -c '%a' /var/log/messages 2>/dev/null || stat -c '%a' /var/log/syslog 2>/dev/null)
    if [[ -n "$log_perms" && "$log_perms" =~ ^6[04]0$ ]]; then
        print_result "PASS" "日志文件权限合理：$log_perms"
    else
        print_result "WARN" "日志文件权限：${log_perms:-未知}（建议 600 或 640）"
    fi
}

# =============================================================================
# 文件权限检查
# =============================================================================
check_file_permissions() {
    print_header "文件权限检查"
    
    # 检查 /etc/passwd
    local passwd_perms=$(stat -c '%a' /etc/passwd 2>/dev/null)
    if [[ "$passwd_perms" == "644" ]]; then
        print_result "PASS" "/etc/passwd 权限：$passwd_perms"
    else
        print_result "FAIL" "/etc/passwd 权限：${passwd_perms:-未知}（应为 644）"
    fi
    
    # 检查 /etc/shadow
    local shadow_perms=$(stat -c '%a' /etc/shadow 2>/dev/null)
    if [[ "$shadow_perms" == "000" || "$shadow_perms" == "600" || "$shadow_perms" == "640" ]]; then
        print_result "PASS" "/etc/shadow 权限：$shadow_perms"
    else
        print_result "FAIL" "/etc/shadow 权限：${shadow_perms:-未知}（应为 600 或 640）"
    fi
    
    # 检查 SUID 文件
    local suid_count=$(find / -perm -4000 -type f 2>/dev/null | wc -l)
    if [[ $suid_count -lt 50 ]]; then
        print_result "PASS" "SUID 文件数量：$suid_count"
    else
        print_result "WARN" "SUID 文件过多：$suid_count（建议检查）"
    fi
    
    # 检查 777 权限文件
    local world_writable=$(find / -perm -0002 -type f 2>/dev/null | wc -l)
    if [[ $world_writable -eq 0 ]]; then
        print_result "PASS" "无 777 权限文件"
    else
        print_result "FAIL" "发现 $world_writable 个 777 权限文件"
    fi
    
    # 检查关键文件权限
    echo ""
    echo "关键文件权限:"
    for file in /etc/passwd /etc/shadow /etc/group /etc/gshadow; do
        if [[ -f "$file" ]]; then
            local perms=$(stat -c '%a %U:%G' "$file" 2>/dev/null)
            echo "  $file: $perms"
        fi
    done
}

# =============================================================================
# 服务安全检查
# =============================================================================
check_services() {
    print_header "服务安全检查"
    
    # 检查不必要的服务
    local unnecessary_services=("telnet" "rsh" "rlogin" "nis" "ypbind" "xinetd")
    
    echo "检查不必要的服务:"
    for service in "${unnecessary_services[@]}"; do
        if systemctl is-enabled "$service" &>/dev/null; then
            print_result "FAIL" "启用不必要的服务：$service"
            [[ "$AUTO_FIX" == "true" ]] && systemctl disable "$service"
        fi
    done
    
    # 检查运行级别
    echo ""
    echo "默认运行级别:"
    systemctl get-default 2>/dev/null | sed 's/^/  /'
    
    # 检查自启动服务
    echo ""
    echo "自启动服务数量:"
    local enabled_count=$(systemctl list-unit-files --state=enabled 2>/dev/null | wc -l)
    echo "  $enabled_count 个服务"
    
    # 检查失败服务
    local failed_services=$(systemctl --failed 2>/dev/null | grep -c "failed" || echo 0)
    if [[ $failed_services -eq 0 ]]; then
        print_result "PASS" "无失败服务"
    else
        print_result "WARN" "发现 $failed_services 个失败服务"
    fi
}

# =============================================================================
# 计算安全评分
# =============================================================================
calculate_score() {
    print_header "安全评分"
    
    local percentage=0
    if [[ $TOTAL -gt 0 ]]; then
        percentage=$((SCORE * 100 / TOTAL))
    fi
    
    echo "总检查项：$TOTAL"
    echo "通过项数：$SCORE"
    echo "安全评分：$percentage%"
    echo ""
    
    # 评级
    if [[ $percentage -ge 90 ]]; then
        echo -e "评级：${GREEN}优秀${NC}"
    elif [[ $percentage -ge 75 ]]; then
        echo -e "评级：${CYAN}良好${NC}"
    elif [[ $percentage -ge 60 ]]; then
        echo -e "评级：${YELLOW}合格${NC}"
    else
        echo -e "评级：${RED}不合格${NC}"
    fi
}

# =============================================================================
# 生成报告
# =============================================================================
generate_report() {
    print_header "生成安全报告"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local report_file="${REPORT_DIR}/security_baseline_${timestamp}.txt"
    
    mkdir -p "$REPORT_DIR"
    
    {
        echo "========================================"
        echo "       系统安全基线检查报告"
        echo "========================================"
        echo ""
        echo "检查时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "检查级别：$CHECK_LEVEL"
        echo "主机名：$(hostname)"
        echo "系统：$(cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2)"
        echo ""
        
        echo "========================================"
        echo "检查详情"
        echo "========================================"
        
        check_accounts
        echo ""
        check_password_policy
        echo ""
        check_ssh_config
        echo ""
        check_firewall
        echo ""
        check_audit
        echo ""
        check_file_permissions
        echo ""
        check_services
        echo ""
        
        echo "========================================"
        echo "安全评分"
        echo "========================================"
        calculate_score
        
    } > "$report_file"
    
    print_result "OK" "报告已保存：$report_file"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local action="check"
    local category="all"
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --check)
                action="check"
                shift
                ;;
            --level)
                CHECK_LEVEL="$2"
                shift 2
                ;;
            --fix)
                AUTO_FIX=true
                shift
                ;;
            --report)
                action="report"
                shift
                ;;
            --category)
                category="$2"
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
    
    # 检查 root 权限
    if [[ $EUID -ne 0 ]]; then
        print_result "ERROR" "此脚本需要 root 权限"
        exit 1
    fi
    
    echo "========================================"
    echo "       系统安全基线检查"
    echo "========================================"
    echo "检查级别：$CHECK_LEVEL"
    echo "自动修复：$AUTO_FIX"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
    
    # 执行检查
    case $action in
        "check")
            case $category in
                "all")
                    check_accounts
                    echo ""
                    check_password_policy
                    echo ""
                    check_ssh_config
                    echo ""
                    check_firewall
                    echo ""
                    check_audit
                    echo ""
                    check_file_permissions
                    echo ""
                    check_services
                    ;;
                "account")
                    check_accounts
                    ;;
                "password")
                    check_password_policy
                    ;;
                "ssh")
                    check_ssh_config
                    ;;
                "firewall")
                    check_firewall
                    ;;
                "audit")
                    check_audit
                    ;;
                "file")
                    check_file_permissions
                    ;;
                "service")
                    check_services
                    ;;
                *)
                    echo "未知类别：$category"
                    ;;
            esac
            
            calculate_score
            ;;
            
        "report")
            generate_report
            ;;
    esac
    
    echo ""
    echo "========================================"
    echo "       检查完成"
    echo "========================================"
    echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
main "$@"

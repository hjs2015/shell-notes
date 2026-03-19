#!/bin/bash
# =============================================================================
# 脚本名称：08_security_audit.sh
# 功能描述：服务器安全审计脚本（检查安全隐患）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 系统安全检测
#   - 日志分析
#   - 权限检查
#   - 用户和组管理
#   - 网络服务检测
# 使用方法：
#   chmod +x 08_security_audit.sh
#   sudo ./08_security_audit.sh
# 代码说明：
#   - 需要 root 权限运行
#   - 检查系统安全配置
#   - 检测异常登录
#   - 审计敏感文件权限
#   - 生成安全报告
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "------------------------------------"
}

# 打印检查结果
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
    printf "%-25s %-20s %-30s\n" "$1" "$2" "$3"
}

# =============================================================================
# 检查 root 权限
# =============================================================================
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}错误：此脚本需要 root 权限运行${NC}"
        echo "请使用：sudo $0"
        exit 1
    fi
}

# =============================================================================
# 系统信息
# =============================================================================
system_info() {
    print_header "系统信息"
    
    echo "操作系统：$(cat /etc/*-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "内核版本：$(uname -r)"
    echo "主机名：$(hostname)"
    echo "运行时间：$(uptime -p 2>/dev/null || uptime | awk -F, '{print $1,$2}')"
}

# =============================================================================
# 用户账户审计
# =============================================================================
user_audit() {
    print_header "用户账户审计"
    
    # UID 为 0 的用户（除 root 外）
    echo "UID 为 0 的用户:"
    local uid0_users=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
    if [[ "$uid0_users" == "root" ]]; then
        print_result "OK" "只有 root 用户具有 UID 0"
    else
        print_result "ERROR" "发现其他 UID 为 0 的用户：$uid0_users"
    fi
    echo ""
    
    # 空密码用户
    echo "空密码用户:"
    local empty_pwd_users=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)
    if [[ -z "$empty_pwd_users" ]]; then
        print_result "OK" "没有空密码用户"
    else
        print_result "ERROR" "发现空密码用户：$empty_pwd_users"
    fi
    echo ""
    
    # 最近创建的用户
    echo "最近 30 天创建的用户:"
    find /home -mindepth 1 -maxdepth 1 -type d -mtime -30 2>/dev/null | while read -r dir; do
        username=$(basename "$dir")
        print_result "INFO" "用户：$username (目录：$dir)"
    done
    echo ""
    
    # 用户统计
    local total_users=$(wc -l < /etc/passwd)
    local total_groups=$(wc -l < /etc/group)
    echo "系统用户总数：$total_users"
    echo "系统组总数：$total_groups"
}

# =============================================================================
# sudo 配置审计
# =============================================================================
sudo_audit() {
    print_header "sudo 配置审计"
    
    # 检查 sudoers 文件
    if [[ -f /etc/sudoers ]]; then
        print_result "OK" "sudoers 文件存在"
        
        # 检查语法
        if visudo -c &>/dev/null; then
            print_result "OK" "sudoers 文件语法正确"
        else
            print_result "ERROR" "sudoers 文件语法错误"
        fi
    else
        print_result "WARN" "未找到 sudoers 文件"
    fi
    echo ""
    
    # 具有 sudo 权限的用户
    echo "具有 sudo 权限的用户:"
    getent group sudo | cut -d: -f4 2>/dev/null | tr ',' '\n' | while read -r user; do
        [[ -n "$user" ]] && print_result "INFO" "sudo 组成员：$user"
    done
    
    getent group wheel | cut -d: -f4 2>/dev/null | tr ',' '\n' | while read -r user; do
        [[ -n "$user" ]] && print_result "INFO" "wheel 组成员：$user"
    done
    echo ""
    
    # 检查 NOPASSWD 配置
    echo "NOPASSWD 配置:"
    if grep -q "NOPASSWD" /etc/sudoers 2>/dev/null; then
        grep "NOPASSWD" /etc/sudoers | grep -v "^#" | while read -r line; do
            print_result "WARN" "$line"
        done
    else
        print_result "OK" "未发现 NOPASSWD 配置"
    fi
}

# =============================================================================
# SSH 配置审计
# =============================================================================
ssh_audit() {
    print_header "SSH 配置审计"
    
    local sshd_config="/etc/ssh/sshd_config"
    
    if [[ ! -f "$sshd_config" ]]; then
        print_result "WARN" "未找到 SSH 配置文件"
        return
    fi
    
    # 检查 PermitRootLogin
    local root_login=$(grep -i "^PermitRootLogin" "$sshd_config" | awk '{print $2}')
    if [[ "$root_login" == "no" ]]; then
        print_result "OK" "禁止 root 登录"
    elif [[ "$root_login" == "prohibit-password" ]]; then
        print_result "OK" "禁止 root 密码登录（允许密钥）"
    else
        print_result "WARN" "允许 root 登录：$root_login"
    fi
    
    # 检查 PasswordAuthentication
    local pwd_auth=$(grep -i "^PasswordAuthentication" "$sshd_config" | awk '{print $2}')
    if [[ "$pwd_auth" == "no" ]]; then
        print_result "OK" "禁用密码认证"
    else
        print_result "WARN" "启用密码认证"
    fi
    
    # 检查 PermitEmptyPasswords
    local empty_pwd=$(grep -i "^PermitEmptyPasswords" "$sshd_config" | awk '{print $2}')
    if [[ "$empty_pwd" == "no" ]]; then
        print_result "OK" "禁止空密码"
    else
        print_result "ERROR" "允许空密码"
    fi
    
    # 检查 X11Forwarding
    local x11=$(grep -i "^X11Forwarding" "$sshd_config" | awk '{print $2}')
    if [[ "$x11" == "no" ]]; then
        print_result "OK" "禁用 X11 转发"
    else
        print_result "WARN" "启用 X11 转发"
    fi
    
    # 检查使用的端口
    local ports=$(grep -i "^Port" "$sshd_config" | awk '{print $2}' | tr '\n' ' ')
    print_result "INFO" "SSH 端口：${ports:-22}"
    
    # 检查最近登录
    echo ""
    echo "最近 SSH 登录:"
    last -n 5 sshd 2>/dev/null | grep -v "^$" | head -5 | while read -r line; do
        echo "  $line"
    done
}

# =============================================================================
# 防火墙审计
# =============================================================================
firewall_audit() {
    print_header "防火墙审计"
    
    # 检查 firewall-cmd
    if command -v firewall-cmd &> /dev/null; then
        echo "firewalld 状态:"
        if firewall-cmd --state &>/dev/null; then
            print_result "OK" "firewalld 运行中"
            
            local default_zone=$(firewall-cmd --get-default-zone 2>/dev/null)
            print_result "INFO" "默认区域：$default_zone"
            
            local ports=$(firewall-cmd --list-ports 2>/dev/null | xargs)
            print_result "INFO" "开放端口：${ports:-无}"
        else
            print_result "WARN" "firewalld 未运行"
        fi
    # 检查 ufw
    elif command -v ufw &> /dev/null; then
        echo "UFW 状态:"
        local ufw_status=$(ufw status 2>/dev/null | head -1)
        if [[ "$ufw_status" == *"active"* ]]; then
            print_result "OK" "UFW 运行中"
            ufw status 2>/dev/null | grep -E "^[0-9]+" | while read -r line; do
                echo "  $line"
            done
        else
            print_result "WARN" "UFW 未启用"
        fi
    # 检查 iptables
    elif command -v iptables &> /dev/null; then
        echo "iptables 规则:"
        local rules_count=$(iptables -L -n 2>/dev/null | wc -l)
        print_result "INFO" "iptables 规则数：$rules_count"
        
        # 检查默认策略
        local input_policy=$(iptables -L INPUT 2>/dev/null | head -1 | awk '{print $4}' | tr -d ')')
        print_result "INFO" "INPUT 默认策略：$input_policy"
    else
        print_result "WARN" "未检测到防火墙工具"
    fi
}

# =============================================================================
# 服务审计
# =============================================================================
service_audit() {
    print_header "服务审计"
    
    # 监听的服务
    echo "监听的服务:"
    print_table_row "端口" "进程" "状态"
    echo "--------------------------------------------------"
    
    netstat -tlnp 2>/dev/null | grep LISTEN | while read -r line; do
        local port=$(echo "$line" | awk '{print $4}' | rev | cut -d':' -f1 | rev)
        local process=$(echo "$line" | awk '{print $7}' | cut -d'/' -f2)
        [[ -z "$process" ]] && process="unknown"
        print_table_row "$port" "$process" "LISTEN"
    done
    echo ""
    
    # 检查危险服务
    echo "潜在危险服务:"
    local dangerous_services=("telnet" "ftp" "rsh" "rlogin" "rexec")
    for service in "${dangerous_services[@]}"; do
        if netstat -tlnp 2>/dev/null | grep -q ":$(grep "$service" /etc/services | head -1 | awk '{print $2}' | cut -d'/' -f1)"; then
            print_result "ERROR" "发现危险服务：$service"
        fi
    done
    print_result "OK" "未发现常见危险服务"
}

# =============================================================================
# 文件权限审计
# =============================================================================
file_permission_audit() {
    print_header "文件权限审计"
    
    # 检查 /etc/passwd 权限
    local passwd_perm=$(stat -c '%a' /etc/passwd 2>/dev/null)
    if [[ "$passwd_perm" == "644" ]]; then
        print_result "OK" "/etc/passwd 权限正确 (644)"
    else
        print_result "WARN" "/etc/passwd 权限异常：$passwd_perm"
    fi
    
    # 检查 /etc/shadow 权限
    local shadow_perm=$(stat -c '%a' /etc/shadow 2>/dev/null)
    if [[ "$shadow_perm" == "640" || "$shadow_perm" == "000" ]]; then
        print_result "OK" "/etc/shadow 权限正确"
    else
        print_result "ERROR" "/etc/shadow 权限异常：$shadow_perm"
    fi
    
    # 检查 /etc/sudoers 权限
    local sudoers_perm=$(stat -c '%a' /etc/sudoers 2>/dev/null)
    if [[ "$sudoers_perm" == "440" ]]; then
        print_result "OK" "/etc/sudoers 权限正确 (440)"
    else
        print_result "ERROR" "/etc/sudoers 权限异常：$sudoers_perm"
    fi
    
    # 检查 777 权限文件
    echo ""
    echo "777 权限文件（危险）:"
    local dangerous_files=$(find /etc /home /root /var -perm 0777 -type f 2>/dev/null | head -10)
    if [[ -n "$dangerous_files" ]]; then
        echo "$dangerous_files" | while read -r file; do
            print_result "ERROR" "$file"
        done
    else
        print_result "OK" "未发现 777 权限文件"
    fi
    
    # 检查 SUID/SGID 文件
    echo ""
    echo "SUID 文件（前 10 个）:"
    find /usr /bin /sbin -perm -4000 -type f 2>/dev/null | head -10 | while read -r file; do
        print_result "INFO" "$file"
    done
    
    echo ""
    echo "SGID 文件（前 10 个）:"
    find /usr /bin /sbin -perm -2000 -type f 2>/dev/null | head -10 | while read -r file; do
        print_result "INFO" "$file"
    done
}

# =============================================================================
# 日志审计
# =============================================================================
log_audit() {
    print_header "日志审计"
    
    # 检查日志服务
    if command -v systemctl &> /dev/null; then
        local rsyslog_status=$(systemctl is-active rsyslog 2>/dev/null)
        local syslog_status=$(systemctl is-active syslog 2>/dev/null)
        local journal_status=$(systemctl is-active systemd-journald 2>/dev/null)
        
        if [[ "$rsyslog_status" == "active" || "$syslog_status" == "active" || "$journal_status" == "active" ]]; then
            print_result "OK" "日志服务运行中"
        else
            print_result "WARN" "日志服务未运行"
        fi
    fi
    
    # 检查日志文件大小
    echo ""
    echo "日志文件大小:"
    print_table_row "日志文件" "大小 (MB)" "最后修改"
    echo "--------------------------------------------------"
    
    for logfile in /var/log/syslog /var/log/messages /var/log/auth.log /var/log/secure; do
        if [[ -f "$logfile" ]]; then
            local size=$(du -m "$logfile" 2>/dev/null | cut -f1)
            local mod_time=$(stat -c '%y' "$logfile" 2>/dev/null | cut -d'.' -f1)
            print_table_row "$(basename $logfile)" "$size" "$mod_time"
        fi
    done
    
    # 检查失败的登录尝试
    echo ""
    echo "最近失败的登录尝试:"
    if command -v lastb &> /dev/null; then
        local failed_count=$(lastb 2>/dev/null | grep -v "^$" | grep -v "^btmp" | wc -l)
        if [[ $failed_count -gt 0 ]]; then
            print_result "WARN" "发现 $failed_count 次失败登录尝试"
            lastb 2>/dev/null | head -5 | while read -r line; do
                echo "  $line"
            done
        else
            print_result "OK" "无失败登录尝试"
        fi
    else
        print_result "INFO" "需要安装 lastb 工具"
    fi
}

# =============================================================================
# 异常进程检测
# =============================================================================
process_audit() {
    print_header "异常进程检测"
    
    # 检查可疑进程名
    echo "可疑进程检测:"
    local suspicious_names=("cryptominer" "xmrig" "minerd" "kworker" "sysupdate")
    for name in "${suspicious_names[@]}"; do
        if ps aux | grep -v grep | grep -q "$name"; then
            print_result "ERROR" "发现可疑进程：$name"
            ps aux | grep -v grep | grep "$name" | head -3
        fi
    done
    print_result "OK" "未发现常见可疑进程"
    
    # CPU 使用率异常的进程
    echo ""
    echo "CPU 使用率 TOP5:"
    ps aux --sort=-%cpu | head -6 | tail -5 | while read -r line; do
        local cpu=$(echo "$line" | awk '{print $3}')
        local cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        if (( $(echo "$cpu > 50" | bc -l 2>/dev/null || echo 0) )); then
            print_result "WARN" "CPU: ${cpu}% - $cmd"
        else
            print_result "INFO" "CPU: ${cpu}% - $cmd"
        fi
    done
    
    # 内存使用率异常的进程
    echo ""
    echo "内存使用率 TOP5:"
    ps aux --sort=-%mem | head -6 | tail -5 | while read -r line; do
        local mem=$(echo "$line" | awk '{print $4}')
        local cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        if (( $(echo "$mem > 50" | bc -l 2>/dev/null || echo 0) )); then
            print_result "WARN" "内存：${mem}% - $cmd"
        else
            print_result "INFO" "内存：${mem}% - $cmd"
        fi
    done
}

# =============================================================================
# 生成安全报告
# =============================================================================
generate_report() {
    print_header "安全审计总结"
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local report_file="/tmp/security_audit_$(date +%Y%m%d_%H%M%S).txt"
    
    echo "审计时间：$timestamp"
    echo "主机名：$(hostname)"
    echo "报告文件：$report_file"
    echo ""
    
    # 保存报告
    {
        echo "========================================"
        echo "       服务器安全审计报告"
        echo "========================================"
        echo "审计时间：$timestamp"
        echo "主机名：$(hostname)"
        echo "操作系统：$(cat /etc/*-release | grep PRETTY_NAME | cut -d'"' -f2)"
        echo "内核版本：$(uname -r)"
        echo "========================================"
    } > "$report_file"
    
    echo -e "${GREEN}✓${NC} 安全报告已生成：$report_file"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    echo "========================================"
    echo "       服务器安全审计报告"
    echo "========================================"
    echo "审计时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机名：$(hostname)"
    echo "========================================"
    
    # 检查 root 权限
    check_root
    
    # 执行所有审计
    system_info
    user_audit
    sudo_audit
    ssh_audit
    firewall_audit
    service_audit
    file_permission_audit
    log_audit
    process_audit
    generate_report
    
    echo ""
    echo "========================================"
    echo "        安全审计完成"
    echo "========================================"
    echo "审计时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
    echo ""
    echo -e "${YELLOW}提示：请根据审计结果修复安全问题${NC}"
}

# 执行主程序
main "$@"

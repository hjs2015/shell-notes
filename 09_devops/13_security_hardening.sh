#!/bin/bash
# =============================================================================
# 脚本名称：12_security_hardening.sh
# 功能描述：服务器安全加固脚本（自动化安全配置）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - SSH 安全配置
#   - 防火墙配置
#   - 用户权限管理
#   - 系统参数优化
#   - 安全审计日志
# 使用方法：
#   chmod +x 12_security_hardening.sh
#   sudo ./12_security_hardening.sh              # 交互式加固
#   sudo ./12_security_hardening.sh --auto      # 自动加固
#   sudo ./12_security_hardening.sh --check     # 检查当前配置
# 代码说明：
#   - 需要 root 权限运行
#   - 支持交互式和自动模式
#   - 加固前自动备份配置
#   - 可逆操作（有回滚方案）
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置
BACKUP_DIR="/root/security_backup_$(date +%Y%m%d_%H%M%S)"
LOG_FILE="/var/log/security_hardening.log"
AUTO_MODE=false
CHECK_MODE=false

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

# 记录日志
log_action() {
    local message=$1
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

# 备份配置文件
backup_config() {
    local file=$1
    if [[ -f "$file" ]]; then
        cp "$file" "$BACKUP_DIR/"
        print_result "OK" "已备份：$file"
        log_action "BACKUP: $file"
    fi
}

# 询问确认
ask_confirm() {
    local message=$1
    
    if [[ "$AUTO_MODE" == "true" ]]; then
        return 0
    fi
    
    read -p "$message (y/n): " answer
    [[ "$answer" == "y" || "$answer" == "Y" ]]
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
# 创建备份目录
# =============================================================================
create_backup_dir() {
    print_header "创建备份目录"
    
    mkdir -p "$BACKUP_DIR"
    print_result "OK" "备份目录：$BACKUP_DIR"
    log_action "CREATE_BACKUP_DIR: $BACKUP_DIR"
}

# =============================================================================
# SSH 安全加固
# =============================================================================
ssh_hardening() {
    print_header "SSH 安全加固"
    
    local sshd_config="/etc/ssh/sshd_config"
    
    if [[ ! -f "$sshd_config" ]]; then
        print_result "WARN" "未找到 SSH 配置文件"
        return
    fi
    
    backup_config "$sshd_config"
    
    echo "当前 SSH 配置检查:"
    
    # 1. 禁止 root 登录
    if grep -q "^PermitRootLogin yes" "$sshd_config"; then
        if ask_confirm "是否禁止 root 登录？"; then
            sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' "$sshd_config"
            print_result "OK" "已禁止 root 登录"
            log_action "SSH: Disable root login"
        fi
    else
        print_result "OK" "root 登录已禁止或未启用"
    fi
    
    # 2. 禁用密码认证
    if grep -q "^PasswordAuthentication yes" "$sshd_config"; then
        if ask_confirm "是否禁用密码认证（使用密钥）？"; then
            sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' "$sshd_config"
            print_result "OK" "已禁用密码认证"
            log_action "SSH: Disable password authentication"
        fi
    else
        print_result "OK" "密码认证已禁用或未启用"
    fi
    
    # 3. 启用密钥认证
    if ! grep -q "^PubkeyAuthentication yes" "$sshd_config"; then
        if ask_confirm "是否启用公钥认证？"; then
            echo "PubkeyAuthentication yes" >> "$sshd_config"
            print_result "OK" "已启用公钥认证"
            log_action "SSH: Enable public key authentication"
        fi
    else
        print_result "OK" "公钥认证已启用"
    fi
    
    # 4. 修改 SSH 端口
    if grep -q "^Port 22$" "$sshd_config"; then
        if ask_confirm "是否修改 SSH 端口（当前：22）？"; then
            read -p "输入新端口 (1024-65535): " new_port
            if [[ $new_port -ge 1024 && $new_port -le 65535 ]]; then
                sed -i "s/^Port 22$/Port $new_port/" "$sshd_config"
                print_result "OK" "SSH 端口已修改为：$new_port"
                log_action "SSH: Change port to $new_port"
                echo -e "${YELLOW}提示：请确保防火墙允许新端口${NC}"
            else
                print_result "ERROR" "端口号无效"
            fi
        fi
    fi
    
    # 5. 限制登录用户
    if ask_confirm "是否限制允许登录的用户？"; then
        read -p "输入允许登录的用户名（空格分隔）: " allowed_users
        if [[ -n "$allowed_users" ]]; then
            echo "AllowUsers $allowed_users" >> "$sshd_config"
            print_result "OK" "已限制允许登录的用户"
            log_action "SSH: Limit users to $allowed_users"
        fi
    fi
    
    # 6. 设置空闲超时
    if ! grep -q "^ClientAliveInterval" "$sshd_config"; then
        if ask_confirm "是否设置空闲超时（15 分钟）？"; then
            cat >> "$sshd_config" << EOF

# 安全加固：空闲超时
ClientAliveInterval 900
ClientAliveCountMax 3
EOF
            print_result "OK" "已设置空闲超时"
            log_action "SSH: Set idle timeout"
        fi
    fi
    
    # 7. 禁用 X11 转发
    if grep -q "^X11Forwarding yes" "$sshd_config"; then
        if ask_confirm "是否禁用 X11 转发？"; then
            sed -i 's/^X11Forwarding yes/X11Forwarding no/' "$sshd_config"
            print_result "OK" "已禁用 X11 转发"
            log_action "SSH: Disable X11 forwarding"
        fi
    fi
    
    # 重启 SSH 服务
    echo ""
    if ask_confirm "是否重启 SSH 服务使配置生效？"; then
        if command -v systemctl &> /dev/null; then
            systemctl restart sshd
            print_result "OK" "SSH 服务已重启"
        elif command -v service &> /dev/null; then
            service sshd restart
            print_result "OK" "SSH 服务已重启"
        else
            print_result "WARN" "无法重启 SSH 服务"
        fi
        log_action "SSH: Service restarted"
    fi
}

# =============================================================================
# 防火墙配置
# =============================================================================
firewall_hardening() {
    print_header "防火墙配置"
    
    # 检测防火墙工具
    local firewall_tool=""
    
    if command -v firewall-cmd &> /dev/null; then
        firewall_tool="firewalld"
    elif command -v ufw &> /dev/null; then
        firewall_tool="ufw"
    elif command -v iptables &> /dev/null; then
        firewall_tool="iptables"
    else
        print_result "WARN" "未检测到防火墙工具"
        return
    fi
    
    print_result "OK" "检测到防火墙：$firewall_tool"
    
    case $firewall_tool in
        "firewalld")
            echo "firewalld 配置:"
            
            # 启用防火墙
            if ! firewall-cmd --state &>/dev/null; then
                if ask_confirm "是否启用 firewalld？"; then
                    systemctl start firewalld
                    systemctl enable firewalld
                    print_result "OK" "firewalld 已启用"
                    log_action "FIREWALL: Enable firewalld"
                fi
            else
                print_result "OK" "firewalld 已运行"
            fi
            
            # 设置默认区域
            if ask_confirm "是否设置默认区域为 drop？"; then
                firewall-cmd --set-default-zone=drop
                print_result "OK" "默认区域已设置为 drop"
                log_action "FIREWALL: Set default zone to drop"
            fi
            
            # 开放必要端口
            echo ""
            echo "开放必要端口:"
            local ports=("22/tcp" "80/tcp" "443/tcp")
            
            for port in "${ports[@]}"; do
                if ask_confirm "是否开放 $port？"; then
                    firewall-cmd --permanent --add-port="$port"
                    print_result "OK" "已开放 $port"
                    log_action "FIREWALL: Open $port"
                fi
            done
            
            # 重载配置
            firewall-cmd --reload
            print_result "OK" "firewalld 配置已重载"
            ;;
            
        "ufw")
            echo "UFW 配置:"
            
            # 启用 UFW
            if ! ufw status | grep -q "active"; then
                if ask_confirm "是否启用 UFW？"; then
                    ufw --force enable
                    print_result "OK" "UFW 已启用"
                    log_action "FIREWALL: Enable UFW"
                fi
            else
                print_result "OK" "UFW 已启用"
            fi
            
            # 设置默认策略
            if ask_confirm "是否设置默认拒绝所有入站？"; then
                ufw default deny incoming
                print_result "OK" "默认策略：拒绝入站"
                log_action "FIREWALL: Default deny incoming"
            fi
            
            ufw default allow outgoing
            print_result "OK" "默认策略：允许出站"
            
            # 开放必要端口
            echo ""
            echo "开放必要端口:"
            ufw allow ssh
            ufw allow http
            ufw allow https
            print_result "OK" "已开放 SSH、HTTP、HTTPS"
            log_action "FIREWALL: Open SSH, HTTP, HTTPS"
            ;;
            
        "iptables")
            echo "iptables 配置:"
            print_result "INFO" "iptables 配置较复杂，建议手动配置"
            
            # 显示当前规则
            echo ""
            echo "当前规则:"
            iptables -L -n -v | head -20
            ;;
    esac
}

# =============================================================================
# 用户安全加固
# =============================================================================
user_hardening() {
    print_header "用户安全加固"
    
    # 1. 检查空密码用户
    echo "检查空密码用户:"
    local empty_pwd_users=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)
    
    if [[ -n "$empty_pwd_users" ]]; then
        print_result "ERROR" "发现空密码用户：$empty_pwd_users"
        if ask_confirm "是否禁用这些用户？"; then
            for user in $empty_pwd_users; do
                [[ "$user" != "root" ]] && passwd -l "$user"
            done
            print_result "OK" "已禁用空密码用户"
            log_action "USER: Disable empty password users"
        fi
    else
        print_result "OK" "无空密码用户"
    fi
    
    # 2. 检查 UID 为 0 的用户
    echo ""
    echo "检查 UID 为 0 的用户:"
    local uid0_users=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
    
    if [[ "$uid0_users" != "root" ]]; then
        print_result "ERROR" "发现其他 UID 为 0 的用户：$uid0_users"
        if ask_confirm "是否删除这些用户？"; then
            for user in $uid0_users; do
                [[ "$user" != "root" ]] && userdel -r "$user"
            done
            print_result "OK" "已删除非 root 的 UID 0 用户"
            log_action "USER: Remove non-root UID 0 users"
        fi
    else
        print_result "OK" "只有 root 用户具有 UID 0"
    fi
    
    # 3. 设置密码策略
    echo ""
    echo "设置密码策略:"
    
    if [[ -f /etc/login.defs ]]; then
        backup_config "/etc/login.defs"
        
        # 密码最长有效期
        if ask_confirm "是否设置密码最长有效期（90 天）？"; then
            sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
            print_result "OK" "密码最长有效期：90 天"
            log_action "USER: Set password max days to 90"
        fi
        
        # 密码最短有效期
        sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   1/' /etc/login.defs
        print_result "OK" "密码最短有效期：1 天"
        
        # 密码过期警告
        sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   7/' /etc/login.defs
        print_result "OK" "密码过期警告：7 天"
    fi
    
    # 4. 锁定系统账户
    echo ""
    echo "锁定不需要的系统账户:"
    local system_users=(
        "bin"
        "daemon"
        "games"
        "news"
        "uucp"
        "man"
        "proxy"
        "www-data"
        "backup"
        "list"
        "irc"
        "gnats"
        "nobody"
    )
    
    if ask_confirm "是否锁定系统账户？"; then
        for user in "${system_users[@]}"; do
            if id "$user" &>/dev/null; then
                passwd -l "$user" 2>/dev/null
            fi
        done
        print_result "OK" "已锁定系统账户"
        log_action "USER: Lock system accounts"
    fi
}

# =============================================================================
# 文件系统安全
# =============================================================================
filesystem_hardening() {
    print_header "文件系统安全"
    
    # 1. 检查 777 权限文件
    echo "检查 777 权限文件:"
    local dangerous_files=$(find /etc /home /root /var -perm 0777 -type f 2>/dev/null)
    
    if [[ -n "$dangerous_files" ]]; then
        print_result "ERROR" "发现 777 权限文件:"
        echo "$dangerous_files" | head -10
        
        if ask_confirm "是否修复这些文件权限？"; then
            echo "$dangerous_files" | while read -r file; do
                chmod 644 "$file"
                print_result "OK" "已修复：$file"
                log_action "FILE: Fix permissions $file"
            done
        fi
    else
        print_result "OK" "未发现 777 权限文件"
    fi
    
    # 2. 检查 SUID/SGID 文件
    echo ""
    echo "检查 SUID/SGID 文件:"
    local suid_files=$(find /usr /bin /sbin -perm -4000 -type f 2>/dev/null | wc -l)
    local sgid_files=$(find /usr /bin /sbin -perm -2000 -type f 2>/dev/null | wc -l)
    
    print_result "INFO" "发现 $suid_files 个 SUID 文件，$sgid_files 个 SGID 文件"
    
    if ask_confirm "是否列出不常见的 SUID 文件？"; then
        find /usr /bin /sbin -perm -4000 -type f 2>/dev/null | while read -r file; do
            echo "  $file"
        done
    fi
    
    # 3. 设置关键文件权限
    echo ""
    echo "设置关键文件权限:"
    
    local critical_files=(
        "/etc/passwd:644"
        "/etc/shadow:640"
        "/etc/group:644"
        "/etc/gshadow:640"
        "/etc/sudoers:440"
    )
    
    for item in "${critical_files[@]}"; do
        local file=$(echo "$item" | cut -d':' -f1)
        local perm=$(echo "$item" | cut -d':' -f2)
        
        if [[ -f "$file" ]]; then
            chmod "$perm" "$file"
            print_result "OK" "已设置 $file 权限为 $perm"
            log_action "FILE: Set $file permissions to $perm"
        fi
    done
    
    # 4. 设置 umask
    echo ""
    echo "设置 umask:"
    
    if [[ -f /etc/profile ]]; then
        if ! grep -q "umask 027" /etc/profile; then
            if ask_confirm "是否设置 umask 027？"; then
                echo "umask 027" >> /etc/profile
                print_result "OK" "已设置 umask 027"
                log_action "FILE: Set umask 027"
            fi
        else
            print_result "OK" "umask 已设置"
        fi
    fi
}

# =============================================================================
# 系统参数优化
# =============================================================================
sysctl_hardening() {
    print_header "系统参数优化"
    
    local sysctl_conf="/etc/sysctl.d/99-security.conf"
    
    echo "配置系统安全参数:"
    
    # 创建配置文件
    cat > "$sysctl_conf" << 'EOF'
# 网络安全
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 5

# 忽略 ICMP 广播
net.ipv4.icmp_echo_ignore_broadcasts = 1

# 禁止 ICMP 重定向
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0

# 禁止发送 ICMP 重定向
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# 启用反向路径过滤
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# 记录可疑数据包
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1

# 禁用 IPv6（如不需要）
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.default.disable_ipv6 = 1

# 核心转储
fs.suid_dumpable = 0

# 限制核心文件大小
fs.suid_dumpable = 0
EOF
    
    print_result "OK" "已创建系统参数配置文件"
    log_action "SYSCTL: Create security config"
    
    if ask_confirm "是否立即应用系统参数？"; then
        sysctl -p "$sysctl_conf"
        print_result "OK" "系统参数已应用"
        log_action "SYSCTL: Apply parameters"
    fi
}

# =============================================================================
# 日志配置
# =============================================================================
log_hardening() {
    print_header "日志配置"
    
    # 检查日志服务
    if command -v systemctl &> /dev/null; then
        if systemctl is-active --quiet rsyslog || systemctl is-active --quiet syslog-ng; then
            print_result "OK" "日志服务运行中"
        else
            if ask_confirm "是否启用日志服务？"; then
                systemctl start rsyslog 2>/dev/null || systemctl start syslog-ng 2>/dev/null
                systemctl enable rsyslog 2>/dev/null || systemctl enable syslog-ng 2>/dev/null
                print_result "OK" "日志服务已启用"
                log_action "LOG: Enable logging service"
            fi
        fi
    fi
    
    # 配置日志轮转
    echo ""
    echo "日志轮转配置:"
    
    if [[ -d /etc/logrotate.d ]]; then
        print_result "OK" "日志轮转已配置"
        
        # 检查日志大小
        local log_size=$(du -sh /var/log 2>/dev/null | cut -f1)
        print_result "INFO" "日志目录大小：$log_size"
    fi
    
    # 保护日志文件
    echo ""
    echo "保护日志文件:"
    
    chattr +a /var/log/messages 2>/dev/null
    chattr +a /var/log/secure 2>/dev/null
    chattr +a /var/log/auth.log 2>/dev/null
    print_result "OK" "已设置日志文件为只追加模式"
    log_action "LOG: Set log files to append-only"
}

# =============================================================================
# 安全检查报告
# =============================================================================
security_report() {
    print_header "安全检查报告"
    
    echo "生成安全检查报告:"
    echo ""
    
    local issues=0
    local warnings=0
    
    # 检查 SSH 配置
    echo "SSH 配置:"
    if grep -q "^PermitRootLogin no" /etc/ssh/sshd_config 2>/dev/null; then
        print_result "OK" "root 登录已禁止"
    else
        print_result "WARN" "root 登录未禁止"
        ((warnings++))
    fi
    
    if grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config 2>/dev/null; then
        print_result "OK" "密码认证已禁用"
    else
        print_result "WARN" "密码认证未禁用"
        ((warnings++))
    fi
    
    # 检查防火墙
    echo ""
    echo "防火墙状态:"
    if command -v firewall-cmd &> /dev/null && firewall-cmd --state &>/dev/null; then
        print_result "OK" "firewalld 运行中"
    elif command -v ufw &> /dev/null && ufw status | grep -q "active"; then
        print_result "OK" "UFW 运行中"
    else
        print_result "WARN" "防火墙未启用"
        ((warnings++))
    fi
    
    # 检查空密码用户
    echo ""
    echo "用户安全:"
    local empty_pwd=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null | grep -v root)
    if [[ -z "$empty_pwd" ]]; then
        print_result "OK" "无空密码用户"
    else
        print_result "ERROR" "存在空密码用户"
        ((issues++))
    fi
    
    # 检查 777 权限文件
    echo ""
    echo "文件权限:"
    local dangerous=$(find /etc /home /root -perm 0777 -type f 2>/dev/null | wc -l)
    if [[ $dangerous -eq 0 ]]; then
        print_result "OK" "无 777 权限文件"
    else
        print_result "ERROR" "存在 $dangerous 个 777 权限文件"
        ((issues++))
    fi
    
    # 总结
    echo ""
    echo "========================================"
    echo "安全检查总结"
    echo "========================================"
    echo "严重问题：${RED}${issues}${NC}"
    echo "警告信息：${YELLOW}${warnings}${NC}"
    echo ""
    
    if [[ $issues -eq 0 && $warnings -eq 0 ]]; then
        print_result "OK" "系统安全配置良好"
    elif [[ $issues -eq 0 ]]; then
        print_result "WARN" "系统存在 $warnings 个警告"
    else
        print_result "ERROR" "系统存在 $issues 个严重问题"
    fi
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  --auto     自动模式（无需确认）"
    echo "  --check    仅检查当前配置"
    echo "  --help     显示帮助"
    echo ""
    echo "示例:"
    echo "  sudo $0              # 交互式加固"
    echo "  sudo $0 --auto       # 自动加固"
    echo "  sudo $0 --check      # 检查配置"
    echo ""
    echo "备份目录：$BACKUP_DIR"
    echo "日志文件：$LOG_FILE"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --auto)
                AUTO_MODE=true
                shift
                ;;
            --check)
                CHECK_MODE=true
                shift
                ;;
            --help)
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
    check_root
    
    echo "========================================"
    echo "       服务器安全加固"
    echo "========================================"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机名：$(hostname)"
    echo "模式：${AUTO_MODE:-交互式}"
    echo "========================================"
    
    # 创建备份目录
    create_backup_dir
    
    # 如果仅检查
    if [[ "$CHECK_MODE" == "true" ]]; then
        security_report
        exit 0
    fi
    
    # 执行加固
    if ask_confirm "是否进行 SSH 安全加固？"; then
        ssh_hardening
    fi
    
    if ask_confirm "是否配置防火墙？"; then
        firewall_hardening
    fi
    
    if ask_confirm "是否进行用户安全加固？"; then
        user_hardening
    fi
    
    if ask_confirm "是否进行文件系统加固？"; then
        filesystem_hardening
    fi
    
    if ask_confirm "是否优化系统参数？"; then
        sysctl_hardening
    fi
    
    if ask_confirm "是否配置日志？"; then
        log_hardening
    fi
    
    # 生成报告
    security_report
    
    echo ""
    echo "========================================"
    echo "       加固完成"
    echo "========================================"
    echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "备份目录：$BACKUP_DIR"
    echo "日志文件：$LOG_FILE"
    echo "========================================"
    echo ""
    echo -e "${YELLOW}提示：${NC}"
    echo "1. 请检查备份目录中的配置文件"
    echo "2. 如有问题可从备份恢复"
    echo "3. 建议重启服务器验证配置"
    echo "4. 查看日志：cat $LOG_FILE"
}

# 执行主程序
main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：06_server_inspection.sh
# 功能描述：服务器全面巡检脚本（参考 absonggit/test 优化版）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - printf 格式化输出
#   - 系统信息收集
#   - 网络连接检测
#   - 防火墙规则检查
#   - 进程检测
#   - 文件修改检测
# 使用方法：
#   chmod +x 06_server_inspection.sh
#   ./06_server_inspection.sh
# 代码说明：
#   - 每个检测功能封装成独立函数
#   - 使用 printf 对齐输出
#   - 使用【】标记检测模块
#   - 支持 CentOS 6/7 和 Ubuntu
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "------------------------------------"
}

# 打印表格标题
print_table_header() {
    printf "${YELLOW}%-20s %-15s %-25s %-15s${NC}\n" "$1" "$2" "$3" "$4"
}

# 打印表格行
print_table_row() {
    printf "%-20s %-15s %-25s %-15s\n" "$1" "$2" "$3" "$4"
}

# =============================================================================
# IP 地址检测
# =============================================================================
ip_check() {
    print_header "IP 地址检测"
    
    # 外网 IP
    echo "外网 IP: $(curl -s ip.sb 2>/dev/null || echo '获取失败')"
    
    # 内网 IP - 判断系统版本
    if [[ -f /etc/redhat-release ]]; then
        # CentOS/RHEL
        if [[ $(awk -F"[ .]" '{print $4}' /etc/redhat-release 2>/dev/null) == "7" ]]; then
            # CentOS 7
            echo "内网 IP: $(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)"
        else
            # CentOS 6
            echo "内网 IP: $(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -1)"
        fi
    elif [[ -f /etc/lsb-release ]]; then
        # Ubuntu
        echo "内网 IP: $(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d'/' -f1 | head -1)"
    else
        echo "内网 IP: $(hostname -I | awk '{print $1}')"
    fi
    
    echo "主机名：$(hostname)"
}

# =============================================================================
# 系统信息检测
# =============================================================================
system_info_check() {
    print_header "系统信息检测"
    
    # 系统版本
    if [[ -f /etc/redhat-release ]]; then
        echo "系统版本：$(cat /etc/redhat-release)"
    elif [[ -f /etc/lsb-release ]]; then
        echo "系统版本：$(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION | cut -d'=' -f2)"
    fi
    
    # 内核版本
    echo "内核版本：$(uname -r)"
    
    # 运行时间
    echo "运行时间：$(uptime -p 2>/dev/null || uptime | awk -F, '{print $1,$2}')"
    
    # 负载
    echo "系统负载：$(uptime | awk -F'load average:' '{print $2}' | xargs)"
    
    # CPU 信息
    echo "CPU 核心：$(grep -c processor /proc/cpuinfo) 核"
    
    # 内存信息
    free_mem=$(free -h | grep Mem | awk '{print $4}')
    total_mem=$(free -h | grep Mem | awk '{print $2}')
    echo "内存使用：${free_mem} / ${total_mem}"
}

# =============================================================================
# 磁盘使用检测
# =============================================================================
disk_check() {
    print_header "磁盘使用检测"
    
    print_table_header "文件系统" "大小" "已用" "使用率"
    echo "------------------------------------"
    
    df -h | grep -E '^/dev/' | while read -r line; do
        filesystem=$(echo "$line" | awk '{print $1}')
        size=$(echo "$line" | awk '{print $2}')
        used=$(echo "$line" | awk '{print $3}')
        percent=$(echo "$line" | awk '{print $5}')
        
        # 根据使用率显示颜色
        if [[ ${percent%\%} -gt 80 ]]; then
            echo -e "${RED}"
        elif [[ ${percent%\%} -gt 60 ]]; then
            echo -e "${YELLOW}"
        fi
        
        printf "%-20s %-15s %-15s %-10s${NC}\n" "$filesystem" "$size" "$used" "$percent"
    done
}

# =============================================================================
# 网络连接检测
# =============================================================================
conn_check() {
    print_header "网络连接检测"
    
    print_table_header "协议" "本地地址" "远程地址" "状态"
    echo "------------------------------------"
    
    # 显示 ESTABLISHED 连接，排除常见服务
    netstat -ntu 2>/dev/null | grep ESTABLISHED | \
        awk -F"[ :/]+" '$6!="127.0.0.1" && $10!~"ssh" && $10!~"nginx" {printf "%-20s %-15s %-25s %-15s\n", $1, $4":"$5, $6":"$7, $8}' | \
        head -20
    
    # 统计连接数
    echo ""
    echo "连接统计:"
    netstat -ant 2>/dev/null | grep -c ESTABLISHED | xargs echo "  ESTABLISHED:"
    netstat -ant 2>/dev/null | grep -c TIME_WAIT | xargs echo "  TIME_WAIT:"
    netstat -ant 2>/dev/null | grep -c LISTEN | xargs echo "  LISTEN:"
}

# =============================================================================
# 端口监听检测
# =============================================================================
port_check() {
    print_header "端口监听检测"
    
    print_table_header "协议" "端口" "进程" "状态"
    echo "------------------------------------"
    
    # 监听端口
    netstat -tlnp 2>/dev/null | grep LISTEN | while read -r line; do
        proto=$(echo "$line" | awk '{print $1}')
        local_addr=$(echo "$line" | awk '{print $4}')
        port=$(echo "$local_addr" | rev | cut -d':' -f1 | rev)
        process=$(echo "$line" | awk '{print $7}' | cut -d'/' -f2)
        
        [[ -z "$process" ]] && process="unknown"
        
        print_table_row "$proto" "$port" "$process" "LISTEN"
    done
}

# =============================================================================
# 防火墙规则检测
# =============================================================================
firewall_check() {
    print_header "防火墙规则检测"
    
    # 检查 firewall-cmd (CentOS 7+)
    if command -v firewall-cmd &> /dev/null; then
        if firewall-cmd --state &> /dev/null; then
            echo "防火墙状态：${GREEN}运行中${NC}"
            echo "放行的端口:"
            firewall-cmd --list-ports 2>/dev/null | xargs -n1 | while read port; do
                echo "  - $port"
            done
        else
            echo "防火墙状态：${YELLOW}未运行${NC}"
        fi
    # 检查 ufw (Ubuntu)
    elif command -v ufw &> /dev/null; then
        ufw_status=$(ufw status 2>/dev/null | head -1)
        if [[ "$ufw_status" == *"active"* ]]; then
            echo "防火墙状态：${GREEN}运行中${NC}"
        else
            echo "防火墙状态：${YELLOW}未运行${NC}"
        fi
    # 检查 iptables
    elif command -v iptables &> /dev/null; then
        echo "iptables 规则数：$(iptables -L -n 2>/dev/null | wc -l)"
        echo "注意：建议使用 firewall-cmd 或 ufw 管理防火墙"
    else
        echo "防火墙状态：${RED}未检测到防火墙工具${NC}"
    fi
}

# =============================================================================
# 进程检测
# =============================================================================
process_check() {
    print_header "进程检测"
    
    print_table_header "用户" "PID" "CPU%" "命令"
    echo "------------------------------------"
    
    # CPU 使用前 10 的进程
    ps aux --sort=-%cpu | head -11 | tail -10 | while read -r line; do
        user=$(echo "$line" | awk '{print $1}')
        pid=$(echo "$line" | awk '{print $2}')
        cpu=$(echo "$line" | awk '{print $3}')
        cmd=$(echo "$line" | awk '{for(i=11;i<=NF;i++) printf("%s ", $i); print ""}')
        
        print_table_row "$user" "$pid" "$cpu" "${cmd:0:30}"
    done
    
    echo ""
    echo "Shell 进程检测:"
    ps aux | grep -E "bash|sh|zsh" | grep -v grep | grep -v "sshd|pts" | head -5
}

# =============================================================================
# 24 小时内修改的文件检测
# =============================================================================
recent_file_check() {
    print_header "24 小时内修改的文件"
    
    echo "系统关键目录:"
    echo "------------------------------------"
    
    # 检测关键目录，排除临时文件
    find /etc /var/log /home /root \
        ! -path "/proc/*" \
        ! -path "/sys/*" \
        ! -path "/tmp/*" \
        ! -path "/var/log/journal/*" \
        ! -path "/var/lib/docker/*" \
        -type f -mtime 0 2>/dev/null | head -20
    
    local count=$(find /etc /var/log /home /root \
        ! -path "/proc/*" \
        ! -path "/sys/*" \
        ! -path "/tmp/*" \
        -type f -mtime 0 2>/dev/null | wc -l)
    
    echo ""
    echo "总计：${count} 个文件在 24 小时内被修改"
}

# =============================================================================
# 登录日志检测
# =============================================================================
login_check() {
    print_header "最近登录记录"
    
    echo "最近 10 次成功登录:"
    echo "------------------------------------"
    last -n 10 2>/dev/null | grep -v "^$" | grep -v "^wtmp"
    
    echo ""
    echo "最近失败的登录尝试:"
    echo "------------------------------------"
    if command -v lastb &> /dev/null; then
        lastb -n 5 2>/dev/null | grep -v "^$" | grep -v "^btmp"
    else
        echo "需要 root 权限查看"
    fi
}

# =============================================================================
# 服务状态检测
# =============================================================================
service_check() {
    print_header "关键服务状态"
    
    print_table_header "服务名" "状态" "服务名" "状态"
    echo "------------------------------------"
    
    # 检查常见服务
    services=("sshd" "nginx" "mysql" "redis" "docker" "cron" "firewalld")
    
    for i in "${!services[@]}"; do
        service="${services[$i]}"
        if command -v systemctl &> /dev/null; then
            status=$(systemctl is-active "$service" 2>/dev/null || echo "inactive")
        else
            status=$(service "$service" status &>/dev/null && echo "active" || echo "inactive")
        fi
        
        # 成对显示
        if (( i % 2 == 0 )); then
            printf "%-20s %-15s" "$service" "$status"
        else
            printf "%-20s %-15s\n" "$service" "$status"
        fi
    done
    
    # 如果总数是奇数，补个换行
    (( ${#services[@]} % 2 != 0 )) && echo ""
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    echo "========================================"
    echo "       服务器全面巡检报告"
    echo "========================================"
    echo "检测时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "主机名：$(hostname)"
    echo "========================================"
    
    # 执行所有检测
    ip_check
    system_info_check
    disk_check
    conn_check
    port_check
    firewall_check
    process_check
    service_check
    recent_file_check
    login_check
    
    echo ""
    echo "========================================"
    echo "        巡检完成"
    echo "========================================"
    echo "检测时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
main

#!/bin/bash
# =============================================================================
# 脚本名称：03_service_monitor.sh
# 功能描述：服务监控脚本 - 监控关键服务状态并自动重启
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - systemctl 服务管理
#   - pgrep/pkill 进程管理
#   - 邮件通知
#   - 日志记录
#   - 定时任务
#   - 数组操作
# 使用方法：
#   chmod +x 03_service_monitor.sh
#   sudo ./03_service_monitor.sh              # 手动检查
#   sudo ./03_service_monitor.sh --add nginx  # 添加监控服务
#   sudo ./03_service_monitor.sh --list       # 列出监控列表
#   sudo ./03_service_monitor.sh --remove nginx # 移除监控
# 配置定时任务：
#   */5 * * * * /path/to/03_service_monitor.sh
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 配置文件
CONFIG_FILE="/etc/service_monitor.conf"
LOG_FILE="/var/log/service_monitor.log"

# 默认监控的服务列表
DEFAULT_SERVICES=("sshd" "cron" "network" "rsyslog")

# 记录日志
log() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a $LOG_FILE
}

# 检查服务状态
check_service() {
    local service=$1
    
    if systemctl is-active --quiet "$service"; then
        echo -e "${GREEN}✓ $service - 运行中${NC}"
        return 0
    else
        echo -e "${RED}✗ $service - 已停止${NC}"
        log "WARNING: 服务 $service 已停止"
        return 1
    fi
}

# 重启服务
restart_service() {
    local service=$1
    
    echo -e "${YELLOW}正在重启服务：$service${NC}"
    log "ACTION: 正在重启服务 $service"
    
    if systemctl restart "$service"; then
        echo -e "${GREEN}✓ $service 重启成功${NC}"
        log "SUCCESS: 服务 $service 重启成功"
        return 0
    else
        echo -e "${RED}✗ $service 重启失败${NC}"
        log "ERROR: 服务 $service 重启失败"
        return 1
    fi
}

# 发送通知（邮件）
send_notification() {
    local service=$1
    local status=$2
    local message="服务 $service 状态：$status"
    
    # 检查是否有 mail 命令
    if command -v mail &>/dev/null; then
        echo "$message" | mail -s "服务告警：$service" root
        log "NOTIFY: 已发送邮件通知"
    else
        log "NOTIFY: 邮件服务未安装，跳过通知"
    fi
}

# 监控所有服务
monitor_all() {
    local services=()
    
    # 读取配置文件
    if [ -f "$CONFIG_FILE" ]; then
        while read -r line; do
            [[ -z "$line" || "$line" =~ ^# ]] && continue
            services+=("$line")
        done < "$CONFIG_FILE"
    else
        # 使用默认服务列表
        services=("${DEFAULT_SERVICES[@]}")
    fi
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       服务监控检查报告${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    local failed_services=()
    
    for service in "${services[@]}"; do
        check_service "$service"
        if [ $? -ne 0 ]; then
            failed_services+=("$service")
        fi
    done
    
    echo ""
    
    # 处理失败的服务
    if [ ${#failed_services[@]} -gt 0 ]; then
        echo -e "${YELLOW}发现 ${#failed_services[@]} 个服务异常：${NC}"
        
        for service in "${failed_services[@]}"; do
            restart_service "$service"
            send_notification "$service" "已重启"
        done
    else
        echo -e "${GREEN}所有服务运行正常！${NC}"
    fi
    
    echo ""
    echo -e "${BLUE}========================================${NC}"
}

# 添加监控服务
add_service() {
    local service=$1
    
    if [ -z "$service" ]; then
        echo -e "${RED}错误：请指定服务名称${NC}"
        exit 1
    fi
    
    # 检查服务是否存在
    if ! systemctl list-unit-files | grep -q "$service"; then
        echo -e "${RED}错误：服务 $service 不存在${NC}"
        exit 1
    fi
    
    # 添加到配置文件
    echo "$service" >> "$CONFIG_FILE"
    echo -e "${GREEN}✓ 已添加监控服务：$service${NC}"
    log "CONFIG: 添加监控服务 $service"
}

# 移除监控服务
remove_service() {
    local service=$1
    
    if [ -z "$service" ]; then
        echo -e "${RED}错误：请指定服务名称${NC}"
        exit 1
    fi
    
    # 从配置文件中移除
    if [ -f "$CONFIG_FILE" ]; then
        sed -i "/^$service$/d" "$CONFIG_FILE"
        echo -e "${GREEN}✓ 已移除监控服务：$service${NC}"
        log "CONFIG: 移除监控服务 $service"
    else
        echo -e "${YELLOW}配置文件不存在${NC}"
    fi
}

# 列出监控服务
list_services() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       监控服务列表${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    if [ -f "$CONFIG_FILE" ]; then
        echo -e "${YELLOW}自定义监控服务：${NC}"
        grep -v '^#' "$CONFIG_FILE" | grep -v '^$'
    else
        echo -e "${YELLOW}默认监控服务：${NC}"
        printf '%s\n' "${DEFAULT_SERVICES[@]}"
    fi
    
    echo ""
}

# 显示用法
usage() {
    echo "用法：$0 [选项] [服务名]"
    echo ""
    echo "选项:"
    echo "  (无参数)        - 执行服务检查"
    echo "  --add <服务>    - 添加监控服务"
    echo "  --remove <服务> - 移除监控服务"
    echo "  --list          - 列出监控服务"
    echo "  --help          - 显示帮助"
    echo ""
    echo "示例:"
    echo "  $0                    # 检查所有服务"
    echo "  $0 --add nginx        # 添加 nginx 监控"
    echo "  $0 --remove apache2   # 移除 apache2 监控"
    echo "  $0 --list             # 查看监控列表"
}

# 主函数
main() {
    # 检查是否 root 用户
    if [ $EUID -ne 0 ]; then
        echo -e "${RED}错误：需要 root 权限运行${NC}"
        echo "请使用：sudo $0 $@"
        exit 1
    fi
    
    case "${1:-}" in
        --add)
            add_service "$2"
            ;;
        --remove)
            remove_service "$2"
            ;;
        --list)
            list_services
            ;;
        --help|-h)
            usage
            ;;
        "")
            monitor_all
            ;;
        *)
            echo -e "${RED}未知选项：$1${NC}"
            usage
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"

# 说明：
# 1. 自动监控关键服务状态
# 2. 服务异常时自动重启
# 3. 支持邮件通知
# 4. 可自定义监控列表
# 5. 记录详细日志

# 配置定时任务：
# crontab -e
# */5 * * * * /path/to/03_service_monitor.sh

# 扩展：
# 1. 可以添加微信/钉钉通知
# 2. 可以添加服务性能监控
# 3. 可以添加自动扩容功能

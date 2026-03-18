#!/bin/bash
# =============================================================================
# 脚本名称：05_backup_automation.sh
# 功能描述：自动化备份脚本 - 备份重要数据和数据库
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 知识点：
#   - tar 打包压缩
#   - mysqldump 数据库备份
#   - rsync 文件同步
#   - 日期处理
#   - 远程备份（scp/rsync）
#   - 备份轮换
#   - 完整性校验
# 使用方法：
#   chmod +x 05_backup_automation.sh
#   sudo ./05_backup_automation.sh              # 完整备份
#   sudo ./05_backup_automation.sh --database   # 只备份数据库
#   sudo ./05_backup_automation.sh --files      # 只备份文件
#   sudo ./05_backup_automation.sh --restore    # 恢复备份
# 配置说明：
#   编辑脚本中的 BACKUP_DIR, DATABASES, FILES_TO_BACKUP 等变量
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ==================== 配置区域 ====================

# 备份目录
BACKUP_DIR="/backup"

# 数据库配置
DB_USER="root"
DB_PASSWORD=""  # 建议写入 ~/.my.cnf
DATABASES=("mysql" "information_schema" "performance_schema")

# 要备份的文件和目录
FILES_TO_BACKUP=(
    "/etc"
    "/home"
    "/var/www"
    "/opt"
    "/root"
)

# 排除的目录
EXCLUDE_DIRS=(
    "*.log"
    "*.tmp"
    "node_modules"
    ".git"
    "__pycache__"
    "*.pyc"
)

# 备份保留策略
DAILY_RETAIN=7      # 日备份保留 7 天
WEEKLY_RETAIN=4     # 周备份保留 4 周
MONTHLY_RETAIN=12   # 月备份保留 12 个月

# 远程备份配置（可选）
REMOTE_BACKUP=false
REMOTE_USER="backup"
REMOTE_HOST="backup.example.com"
REMOTE_DIR="/backups"

# ==================== 函数定义 ====================

# 记录日志
log() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" | tee -a "$BACKUP_DIR/backup.log"
}

# 创建备份目录
init_backup_dir() {
    local date_str=$1
    mkdir -p "$BACKUP_DIR"/{daily,weekly,monthly}
    mkdir -p "$BACKUP_DIR/daily/$date_str"
    log "备份目录已创建：$BACKUP_DIR/daily/$date_str"
}

# 备份数据库
backup_database() {
    local backup_path=$1
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       备份数据库${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    for db in "${DATABASES[@]}"; do
        local dump_file="$backup_path/${db}_${timestamp}.sql"
        
        echo -n "  备份数据库：$db ... "
        
        if mysqldump -u"$DB_USER" "$db" > "$dump_file" 2>/dev/null; then
            # 压缩
            gzip "$dump_file"
            echo -e "${GREEN}✓ 完成${NC}"
            log "数据库备份成功：$db"
        else
            echo -e "${RED}✗ 失败${NC}"
            log "数据库备份失败：$db"
        fi
    done
    
    echo ""
}

# 备份文件
backup_files() {
    local backup_path=$1
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local archive_file="$backup_path/files_${timestamp}.tar.gz"
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       备份文件系统${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # 构建排除参数
    local exclude_args=""
    for dir in "${EXCLUDE_DIRS[@]}"; do
        exclude_args="$exclude_args --exclude=$dir"
    done
    
    echo "  备份目标："
    for dir in "${FILES_TO_BACKUP[@]}"; do
        if [ -d "$dir" ] || [ -f "$dir" ]; then
            echo "    - $dir"
        fi
    done
    echo ""
    
    echo -n "  创建压缩包 ... "
    
    # 使用 tar 备份
    if tar -czf "$archive_file" $exclude_args "${FILES_TO_BACKUP[@]}" 2>/dev/null; then
        local size=$(du -h "$archive_file" | cut -f1)
        echo -e "${GREEN}✓ 完成 ($size)${NC}"
        log "文件备份成功：$archive_file ($size)"
    else
        echo -e "${RED}✗ 失败${NC}"
        log "文件备份失败"
    fi
    
    echo ""
}

# 备份配置
backup_config() {
    local backup_path=$1
    local config_file="$backup_path/backup_config_$(date '+%Y%m%d').txt"
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       备份系统配置${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # 保存系统信息
    {
        echo "=== 备份信息 ==="
        echo "时间：$(date)"
        echo "主机名：$(hostname)"
        echo "内核：$(uname -r)"
        echo ""
        echo "=== 网络配置 ==="
        ip addr
        echo ""
        echo "=== 磁盘使用 ==="
        df -h
        echo ""
        echo "=== 已安装服务 ==="
        systemctl list-units --type=service --state=running
    } > "$config_file"
    
    echo -e "  ${GREEN}✓ 系统配置已保存${NC}"
    log "系统配置已备份：$config_file"
    echo ""
}

# 计算校验和
calculate_checksum() {
    local backup_path=$1
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       计算校验和${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    find "$backup_path" -type f -name "*.gz" -o -name "*.sql" -o -name "*.tar.gz" | \
    while read -r file; do
        md5sum "$file" >> "$backup_path/CHECKSUMS.md5"
    done
    
    echo -e "  ${GREEN}✓ 校验和已计算${NC}"
    log "校验和已计算：$backup_path/CHECKSUMS.md5"
    echo ""
}

# 备份轮换
rotate_backups() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       备份轮换${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # 删除过期的日备份
    echo "  清理 $DAILY_RETAIN 天前的日备份..."
    find "$BACKUP_DIR/daily" -type d -mtime +$DAILY_RETAIN -exec rm -rf {} \;
    
    # 删除过期的周备份
    echo "  清理 $WEEKLY_RETAIN 周前的周备份..."
    find "$BACKUP_DIR/weekly" -type d -mtime +$((WEEKLY_RETAIN * 7)) -exec rm -rf {} \;
    
    # 删除过期的月备份
    echo "  清理 $MONTHLY_RETAIN 月前的月备份..."
    find "$BACKUP_DIR/monthly" -type d -mtime +$((MONTHLY_RETAIN * 30)) -exec rm -rf {} \;
    
    echo -e "  ${GREEN}✓ 轮换完成${NC}"
    log "备份轮换完成"
    echo ""
}

# 远程同步
sync_remote() {
    if [ "$REMOTE_BACKUP" = true ]; then
        echo -e "${BLUE}========================================${NC}"
        echo -e "${GREEN}       远程同步${NC}"
        echo -e "${BLUE}========================================${NC}"
        echo ""
        
        echo -n "  同步到 $REMOTE_HOST ... "
        
        if rsync -avz -e ssh "$BACKUP_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" 2>/dev/null; then
            echo -e "${GREEN}✓ 完成${NC}"
            log "远程同步成功：$REMOTE_HOST"
        else
            echo -e "${YELLOW}⚠ 失败（跳过）${NC}"
            log "远程同步失败：$REMOTE_HOST"
        fi
        
        echo ""
    fi
}

# 显示备份统计
show_stats() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       备份统计${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    echo "  备份目录：$BACKUP_DIR"
    echo "  总大小：$(du -sh "$BACKUP_DIR" | cut -f1)"
    echo "  日备份数量：$(find "$BACKUP_DIR/daily" -type d | wc -l)"
    echo "  周备份数量：$(find "$BACKUP_DIR/weekly" -type d | wc -l)"
    echo "  月备份数量：$(find "$BACKUP_DIR/monthly" -type d | wc -l)"
    echo ""
}

# 显示用法
usage() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  (无参数)      - 完整备份（数据库 + 文件 + 配置）"
    echo "  --database    - 只备份数据库"
    echo "  --files       - 只备份文件"
    echo "  --config      - 只备份配置"
    echo "  --restore     - 恢复备份（交互模式）"
    echo "  --stats       - 显示备份统计"
    echo "  --rotate      - 执行备份轮换"
    echo "  --help        - 显示帮助"
    echo ""
    echo "示例:"
    echo "  $0                    # 完整备份"
    echo "  $0 --database         # 只备份数据库"
    echo "  $0 --stats            # 查看统计"
}

# 主函数
main() {
    # 检查是否 root 用户
    if [ $EUID -ne 0 ]; then
        echo -e "${RED}错误：需要 root 权限运行${NC}"
        exit 1
    fi
    
    local action="${1:-full}"
    local date_str=$(date '+%Y%m%d')
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local backup_path="$BACKUP_DIR/daily/$date_str"
    
    case $action in
        --database)
            init_backup_dir "$date_str"
            backup_database "$backup_path"
            ;;
        --files)
            init_backup_dir "$date_str"
            backup_files "$backup_path"
            ;;
        --config)
            init_backup_dir "$date_str"
            backup_config "$backup_path"
            ;;
        --restore)
            echo "恢复功能待实现"
            echo "请手动从 $BACKUP_DIR 选择备份文件"
            ;;
        --stats)
            show_stats
            ;;
        --rotate)
            rotate_backups
            ;;
        --help|-h)
            usage
            ;;
        full|"")
            log "=== 开始完整备份 ==="
            
            init_backup_dir "$date_str"
            backup_database "$backup_path"
            backup_files "$backup_path"
            backup_config "$backup_path"
            calculate_checksum "$backup_path"
            rotate_backups
            sync_remote
            show_stats
            
            log "=== 完整备份完成 ==="
            ;;
        *)
            echo -e "${RED}未知选项：$action${NC}"
            usage
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"

# 说明：
# 1. 完整的备份解决方案
# 2. 支持数据库和文件备份
# 3. 自动备份轮换
# 4. 可选远程同步
# 5. 完整性校验

# 配置定时任务：
# crontab -e
# 0 2 * * * /path/to/05_backup_automation.sh
# 0 3 * * 0 /path/to/05_backup_automation.sh --rotate

# 安全提示：
# 1. 数据库密码建议使用 ~/.my.cnf
# 2. 远程备份使用 SSH 密钥认证
# 3. 定期测试恢复流程
# 4. 备份文件加密存储

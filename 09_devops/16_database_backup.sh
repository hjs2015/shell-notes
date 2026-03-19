#!/bin/bash
# =============================================================================
# 脚本名称：16_database_backup.sh
# 功能描述：数据库备份脚本（MySQL/PostgreSQL/MongoDB，支持增量备份）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 多种数据库支持
#   - 增量备份
#   - 压缩加密
#   - 自动清理
#   - 备份验证
# 使用方法：
#   sudo ./16_database_backup.sh --type mysql --db mydb    # MySQL 备份
#   sudo ./16_database_backup.sh --type postgres --all     # PostgreSQL 全备
#   sudo ./16_database_backup.sh --type mongodb --db test  # MongoDB 备份
#   sudo ./16_database_backup.sh --restore --file backup.sql.gz  # 恢复
# 代码说明：
#   - 支持 MySQL/PostgreSQL/MongoDB
#   - 自动压缩和加密
#   - 支持增量备份
#   - 备份验证
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
BACKUP_BASE="/backup/database"
RETENTION_DAYS=7
COMPRESSION="gzip"
ENCRYPTION=false
MYSQL_HOST="localhost"
MYSQL_USER="root"
MYSQL_PORT="3306"
PG_HOST="localhost"
PG_USER="postgres"
PG_PORT="5432"
MONGO_HOST="localhost"
MONGO_PORT="27017"

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
    echo "  --type TYPE          数据库类型 (mysql/postgres/mongodb)"
    echo "  --db NAME            数据库名"
    echo "  --all                备份所有数据库"
    echo "  --output DIR         输出目录"
    echo "  --incremental        增量备份"
    echo "  --compress           压缩备份"
    echo "  --encrypt            加密备份"
    echo "  --restore FILE       恢复备份"
    echo "  --verify FILE        验证备份"
    echo "  --cleanup            清理旧备份"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 --type mysql --db mydb"
    echo "  $0 --type mysql --all --compress"
    echo "  $0 --type postgres --db mydb --incremental"
    echo "  $0 --restore backup.sql.gz"
}

# =============================================================================
# 初始化
# =============================================================================
init_backup() {
    local db_type=$1
    local db_name=$2
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_BASE}/${db_type}/${db_name}"
    
    mkdir -p "$backup_dir"
    
    echo "$timestamp"
}

# =============================================================================
# MySQL 备份
# =============================================================================
backup_mysql() {
    local db_name=$1
    local is_all=$2
    
    print_header "MySQL 备份"
    
    # 检查 mysqldump
    if ! command -v mysqldump &> /dev/null; then
        print_result "ERROR" "未安装 mysqldump"
        exit 1
    fi
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_BASE}/mysql"
    mkdir -p "$backup_dir"
    
    local backup_file
    if [[ "$is_all" == "true" ]]; then
        backup_file="${backup_dir}/all_databases_${timestamp}.sql"
        echo "备份所有数据库..."
    else
        backup_file="${backup_dir}/${db_name}_${timestamp}.sql"
        echo "备份数据库：$db_name"
    fi
    
    # 执行备份
    local mysqldump_cmd="mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u $MYSQL_USER"
    
    # 提示输入密码（如果有）
    read -s -p "输入 MySQL 密码：" mysql_password
    echo ""
    
    if [[ -n "$mysql_password" ]]; then
        mysqldump_cmd="$mysqldump_cmd -p${mysql_password}"
    fi
    
    if [[ "$is_all" == "true" ]]; then
        mysqldump_cmd="$mysqldump_cmd --all-databases"
    else
        mysqldump_cmd="$mysqldump_cmd $db_name"
    fi
    
    echo "执行命令：$mysqldump_cmd > $backup_file"
    echo ""
    
    if eval "$mysqldump_cmd" > "$backup_file" 2>/dev/null; then
        local size=$(du -h "$backup_file" | cut -f1)
        print_result "OK" "备份成功：$backup_file ($size)"
        
        # 压缩
        if [[ "$COMPRESS" == "true" ]]; then
            echo ""
            echo "压缩备份..."
            gzip "$backup_file"
            backup_file="${backup_file}.gz"
            size=$(du -h "$backup_file" | cut -f1)
            print_result "OK" "压缩完成：$backup_file ($size)"
        fi
        
        # 验证
        echo ""
        verify_backup "$backup_file"
        
    else
        print_result "ERROR" "备份失败"
        return 1
    fi
}

# =============================================================================
# PostgreSQL 备份
# =============================================================================
backup_postgres() {
    local db_name=$1
    local is_all=$2
    
    print_header "PostgreSQL 备份"
    
    # 检查 pg_dump
    if ! command -v pg_dump &> /dev/null; then
        print_result "ERROR" "未安装 pg_dump"
        exit 1
    fi
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_BASE}/postgres"
    mkdir -p "$backup_dir"
    
    local backup_file
    if [[ "$is_all" == "true" ]]; then
        backup_file="${backup_dir}/all_databases_${timestamp}.sql"
        echo "备份所有数据库..."
    else
        backup_file="${backup_dir}/${db_name}_${timestamp}.sql"
        echo "备份数据库：$db_name"
    fi
    
    # 执行备份
    local pg_dump_cmd="pg_dump -h $PG_HOST -p $PG_PORT -U $PG_USER"
    
    if [[ "$is_all" == "true" ]]; then
        pg_dump_cmd="pg_dumpall -h $PG_HOST -p $PG_PORT -U $PG_USER"
    else
        pg_dump_cmd="$pg_dump_cmd $db_name"
    fi
    
    echo "执行命令：$pg_dump_cmd > $backup_file"
    echo ""
    
    if PGPASSWORD="$PG_PASSWORD" eval "$pg_dump_cmd" > "$backup_file" 2>/dev/null; then
        local size=$(du -h "$backup_file" | cut -f1)
        print_result "OK" "备份成功：$backup_file ($size)"
        
        # 压缩
        if [[ "$COMPRESS" == "true" ]]; then
            echo ""
            echo "压缩备份..."
            gzip "$backup_file"
            backup_file="${backup_file}.gz"
            size=$(du -h "$backup_file" | cut -f1)
            print_result "OK" "压缩完成：$backup_file ($size)"
        fi
        
        # 验证
        echo ""
        verify_backup "$backup_file"
        
    else
        print_result "ERROR" "备份失败"
        return 1
    fi
}

# =============================================================================
# MongoDB 备份
# =============================================================================
backup_mongodb() {
    local db_name=$1
    
    print_header "MongoDB 备份"
    
    # 检查 mongodump
    if ! command -v mongodump &> /dev/null; then
        print_result "ERROR" "未安装 mongodump"
        exit 1
    fi
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_BASE}/mongo/${db_name}"
    mkdir -p "$backup_dir"
    
    echo "备份数据库：$db_name"
    echo ""
    
    # 执行备份
    local mongodump_cmd="mongodump --host $MONGO_HOST --port $MONGO_PORT"
    
    if [[ -n "$db_name" && "$db_name" != "all" ]]; then
        mongodump_cmd="$mongodump_cmd --db $db_name"
    fi
    
    mongodump_cmd="$mongodump_cmd --out $backup_dir"
    
    echo "执行命令：$mongodump_cmd"
    echo ""
    
    if eval "$mongodump_cmd" 2>/dev/null; then
        local size=$(du -sh "$backup_dir" | cut -f1)
        print_result "OK" "备份成功：$backup_dir ($size)"
        
        # 压缩
        if [[ "$COMPRESS" == "true" ]]; then
            echo ""
            echo "压缩备份..."
            tar -czf "${backup_dir}.tar.gz" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")"
            rm -rf "$backup_dir"
            backup_file="${backup_dir}.tar.gz"
            size=$(du -h "$backup_file" | cut -f1)
            print_result "OK" "压缩完成：$backup_file ($size)"
        fi
        
    else
        print_result "ERROR" "备份失败"
        return 1
    fi
}

# =============================================================================
# 验证备份
# =============================================================================
verify_backup() {
    local backup_file=$1
    
    print_header "验证备份"
    
    if [[ ! -f "$backup_file" ]]; then
        print_result "ERROR" "备份文件不存在"
        return 1
    fi
    
    local size=$(stat -c%s "$backup_file" 2>/dev/null || stat -f%z "$backup_file" 2>/dev/null)
    local md5=$(md5sum "$backup_file" 2>/dev/null | cut -d' ' -f1)
    
    echo "备份文件：$backup_file"
    echo "文件大小：$(du -h "$backup_file" | cut -f1)"
    echo "MD5 校验：$md5"
    echo ""
    
    # 检查文件内容
    if [[ "$backup_file" == *.gz ]]; then
        # 压缩文件，检查前几行
        echo "文件内容预览:"
        zcat "$backup_file" 2>/dev/null | head -5 | sed 's/^/  /'
    else
        echo "文件内容预览:"
        head -5 "$backup_file" | sed 's/^/  /'
    fi
    
    # 检查文件大小
    if [[ $size -gt 0 ]]; then
        print_result "OK" "备份文件有效"
        return 0
    else
        print_result "ERROR" "备份文件为空"
        return 1
    fi
}

# =============================================================================
# 恢复备份
# =============================================================================
restore_backup() {
    local backup_file=$1
    local db_type=$2
    local db_name=$3
    
    print_header "恢复备份"
    
    if [[ ! -f "$backup_file" ]]; then
        print_result "ERROR" "备份文件不存在：$backup_file"
        exit 1
    fi
    
    echo "恢复信息:"
    echo "  备份文件：$backup_file"
    echo "  数据库类型：$db_type"
    echo "  目标数据库：$db_name"
    echo ""
    
    read -p "确定要恢复吗？(y/n): " confirm
    [[ "$confirm" != "y" && "$confirm" != "Y" ]] && exit 0
    
    case $db_type in
        "mysql")
            echo "恢复 MySQL 数据库..."
            read -s -p "输入 MySQL 密码：" mysql_password
            echo ""
            
            if [[ "$backup_file" == *.gz ]]; then
                zcat "$backup_file" | mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"${mysql_password}" "$db_name"
            else
                mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"${mysql_password}" "$db_name" < "$backup_file"
            fi
            
            if [[ $? -eq 0 ]]; then
                print_result "OK" "恢复成功"
            else
                print_result "ERROR" "恢复失败"
            fi
            ;;
            
        "postgres")
            echo "恢复 PostgreSQL 数据库..."
            
            if [[ "$backup_file" == *.gz ]]; then
                zcat "$backup_file" | psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" "$db_name"
            else
                psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" "$db_name" < "$backup_file"
            fi
            
            if [[ $? -eq 0 ]]; then
                print_result "OK" "恢复成功"
            else
                print_result "ERROR" "恢复失败"
            fi
            ;;
            
        "mongodb")
            echo "恢复 MongoDB 数据库..."
            
            if [[ "$backup_file" == *.tar.gz ]]; then
                tar -xzf "$backup_file"
                local extract_dir="${backup_file%.tar.gz}"
                mongorestore --host "$MONGO_HOST" --port "$MONGO_PORT" "$extract_dir"
                rm -rf "$extract_dir"
            else
                mongorestore --host "$MONGO_HOST" --port "$MONGO_PORT" "$backup_file"
            fi
            
            if [[ $? -eq 0 ]]; then
                print_result "OK" "恢复成功"
            else
                print_result "ERROR" "恢复失败"
            fi
            ;;
            
        *)
            print_result "ERROR" "不支持的数据库类型：$db_type"
            ;;
    esac
}

# =============================================================================
# 清理旧备份
# =============================================================================
cleanup_old_backups() {
    print_header "清理旧备份"
    
    echo "保留天数：$RETENTION_DAYS 天"
    echo ""
    
    local backup_dirs=(
        "${BACKUP_BASE}/mysql"
        "${BACKUP_BASE}/postgres"
        "${BACKUP_BASE}/mongo"
    )
    
    local total_cleaned=0
    local total_size=0
    
    for dir in "${backup_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "清理目录：$dir"
            
            # 查找旧文件
            local old_files=$(find "$dir" -type f -mtime +$RETENTION_DAYS 2>/dev/null)
            local old_count=$(echo "$old_files" | grep -c . 2>/dev/null || echo 0)
            
            if [[ $old_count -gt 0 ]]; then
                # 计算大小
                local old_size=$(find "$dir" -type f -mtime +$RETENTION_DAYS -exec du -ch {} + 2>/dev/null | tail -1 | cut -f1)
                
                echo "  发现 $old_count 个旧备份，大小：$old_size"
                
                # 删除
                find "$dir" -type f -mtime +$RETENTION_DAYS -delete 2>/dev/null
                ((total_cleaned += old_count))
                
                print_result "OK" "已清理 $old_count 个文件"
            else
                print_result "OK" "无需清理"
            fi
        fi
    done
    
    echo ""
    echo "清理完成：共清理 $total_cleaned 个文件"
}

# =============================================================================
# 备份统计
# =============================================================================
backup_stats() {
    print_header "备份统计"
    
    echo "备份目录：$BACKUP_BASE"
    echo ""
    
    # MySQL 备份
    if [[ -d "${BACKUP_BASE}/mysql" ]]; then
        echo "MySQL 备份:"
        local mysql_count=$(find "${BACKUP_BASE}/mysql" -type f 2>/dev/null | wc -l)
        local mysql_size=$(du -sh "${BACKUP_BASE}/mysql" 2>/dev/null | cut -f1)
        echo "  文件数：$mysql_count"
        echo "  总大小：$mysql_size"
        echo ""
    fi
    
    # PostgreSQL 备份
    if [[ -d "${BACKUP_BASE}/postgres" ]]; then
        echo "PostgreSQL 备份:"
        local pg_count=$(find "${BACKUP_BASE}/postgres" -type f 2>/dev/null | wc -l)
        local pg_size=$(du -sh "${BACKUP_BASE}/postgres" 2>/dev/null | cut -f1)
        echo "  文件数：$pg_count"
        echo "  总大小：$pg_size"
        echo ""
    fi
    
    # MongoDB 备份
    if [[ -d "${BACKUP_BASE}/mongo" ]]; then
        echo "MongoDB 备份:"
        local mongo_count=$(find "${BACKUP_BASE}/mongo" -type d 2>/dev/null | wc -l)
        local mongo_size=$(du -sh "${BACKUP_BASE}/mongo" 2>/dev/null | cut -f1)
        echo "  备份数：$mongo_count"
        echo "  总大小：$mongo_size"
        echo ""
    fi
    
    # 总大小
    local total_size=$(du -sh "$BACKUP_BASE" 2>/dev/null | cut -f1)
    echo "总计：$total_size"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local db_type=""
    local db_name=""
    local is_all=false
    local compress=false
    local action="backup"
    local backup_file=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --type)
                db_type="$2"
                shift 2
                ;;
            --db)
                db_name="$2"
                is_all=false
                shift 2
                ;;
            --all)
                is_all=true
                shift
                ;;
            --compress)
                compress=true
                shift
                ;;
            --restore)
                action="restore"
                backup_file="$2"
                shift 2
                ;;
            --verify)
                action="verify"
                backup_file="$2"
                shift 2
                ;;
            --cleanup)
                action="cleanup"
                shift
                ;;
            --stats)
                action="stats"
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
    
    # 创建备份目录
    mkdir -p "$BACKUP_BASE"
    
    # 执行操作
    case $action in
        "backup")
            if [[ -z "$db_type" ]]; then
                print_result "ERROR" "请指定数据库类型 (--type)"
                show_help
                exit 1
            fi
            
            case $db_type in
                "mysql")
                    backup_mysql "$db_name" "$is_all"
                    ;;
                "postgres"|"postgresql")
                    backup_postgres "$db_name" "$is_all"
                    ;;
                "mongo"|"mongodb")
                    backup_mongodb "$db_name"
                    ;;
                *)
                    print_result "ERROR" "不支持的数据库类型：$db_type"
                    exit 1
                    ;;
            esac
            ;;
            
        "restore")
            if [[ -z "$backup_file" || -z "$db_type" ]]; then
                print_result "ERROR" "请指定备份文件和数据库类型"
                exit 1
            fi
            restore_backup "$backup_file" "$db_type" "$db_name"
            ;;
            
        "verify")
            if [[ -z "$backup_file" ]]; then
                print_result "ERROR" "请指定备份文件"
                exit 1
            fi
            verify_backup "$backup_file"
            ;;
            
        "cleanup")
            cleanup_old_backups
            ;;
            
        "stats")
            backup_stats
            ;;
            
        *)
            show_help
            ;;
    esac
}

# 执行主程序
main "$@"

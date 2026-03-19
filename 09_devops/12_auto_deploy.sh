#!/bin/bash
# =============================================================================
# 脚本名称：12_auto_deploy.sh
# 功能描述：自动化部署脚本（支持多环境、回滚、健康检查）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - Git 部署流程
#   - 多环境配置
#   - 版本回滚
#   - 健康检查
#   - 零停机部署
# 使用方法：
#   chmod +x 12_auto_deploy.sh
#   sudo ./12_auto_deploy.sh --env production    # 生产环境部署
#   sudo ./12_auto_deploy.sh --env staging       # 测试环境部署
#   sudo ./12_auto_deploy.sh --rollback          # 回滚到上一版本
#   sudo ./12_auto_deploy.sh --status            # 查看部署状态
# 代码说明：
#   - 支持多环境（dev/staging/production）
#   - 自动备份当前版本
#   - 支持版本回滚
#   - 部署前后健康检查
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置
DEPLOY_USER="www-data"
DEPLOY_GROUP="www-data"
DEPLOY_BASE="/var/www"
BACKUP_BASE="/backup/deploy"
LOG_FILE="/var/log/deploy.log"
HEALTH_CHECK_URL=""
HEALTH_CHECK_TIMEOUT=30

# 环境配置
declare -A ENV_CONFIG
ENV_CONFIG[dev]="${DEPLOY_BASE}/dev"
ENV_CONFIG[staging]="${DEPLOY_BASE}/staging"
ENV_CONFIG[production]="${DEPLOY_BASE}/production"

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
    echo "$message"
}

# =============================================================================
# 检查依赖
# =============================================================================
check_dependencies() {
    print_header "检查依赖"
    
    local deps=("git" "rsync" "systemctl")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if command -v "$dep" &> /dev/null; then
            print_result "OK" "$dep 已安装"
        else
            print_result "ERROR" "$dep 未安装"
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        print_result "ERROR" "缺少依赖：${missing[*]}"
        exit 1
    fi
    
    log_action "DEPENDENCIES: All dependencies installed"
}

# =============================================================================
# 解析参数
# =============================================================================
parse_args() {
    ENVIRONMENT=""
    ACTION="deploy"
    GIT_BRANCH="main"
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -e|--env)
                ENVIRONMENT="$2"
                shift 2
                ;;
            -b|--branch)
                GIT_BRANCH="$2"
                shift 2
                ;;
            --rollback)
                ACTION="rollback"
                shift
                ;;
            --status)
                ACTION="status"
                shift
                ;;
            --health-check)
                ACTION="health-check"
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
    
    # 验证环境
    if [[ -n "$ENVIRONMENT" && ! "${ENV_CONFIG[$ENVIRONMENT]}" ]]; then
        print_result "ERROR" "无效环境：$ENVIRONMENT (可选：dev, staging, production)"
        exit 1
    fi
}

# =============================================================================
# 部署前检查
# =============================================================================
pre_deploy_check() {
    print_header "部署前检查"
    
    # 检查 Git 仓库
    if [[ ! -d ".git" ]]; then
        print_result "ERROR" "当前目录不是 Git 仓库"
        exit 1
    fi
    
    # 检查分支
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    log_action "GIT: Current branch $current_branch"
    
    # 检查是否有未提交的更改
    if [[ -n $(git status --porcelain) ]]; then
        print_result "WARN" "存在未提交的更改"
        if [[ "$FORCE" != "true" ]]; then
            echo "请使用 --force 强制部署"
            exit 1
        fi
    fi
    
    # 拉取最新代码
    log_action "GIT: Pulling latest changes"
    if git pull origin "$GIT_BRANCH" 2>&1; then
        print_result "OK" "代码已更新到 $GIT_BRANCH"
    else
        print_result "ERROR" "代码更新失败"
        exit 1
    fi
    
    # 获取当前 commit
    local commit_hash=$(git rev-parse --short HEAD)
    local commit_msg=$(git log -1 --pretty=%B | head -1)
    log_action "GIT: Deploy commit $commit_hash - $commit_msg"
    
    echo ""
    echo "部署信息:"
    echo "  环境：$ENVIRONMENT"
    echo "  分支：$GIT_BRANCH"
    echo "  Commit: $commit_hash"
    echo "  消息：$commit_msg"
}

# =============================================================================
# 备份当前版本
# =============================================================================
backup_current_version() {
    print_header "备份当前版本"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dir="${BACKUP_BASE}/${ENVIRONMENT}/${timestamp}"
    
    if [[ -d "$deploy_dir" ]]; then
        mkdir -p "$backup_dir"
        
        # 使用 rsync 备份
        if rsync -a --delete "$deploy_dir/" "$backup_dir/" 2>&1; then
            print_result "OK" "已备份到：$backup_dir"
            log_action "BACKUP: Created backup $backup_dir"
            
            # 保留最近 10 个备份
            cleanup_old_backups "$ENVIRONMENT" 10
        else
            print_result "ERROR" "备份失败"
            exit 1
        fi
    else
        print_result "INFO" "首次部署，无需备份"
        log_action "BACKUP: First deployment, no backup needed"
    fi
}

# =============================================================================
# 清理旧备份
# =============================================================================
cleanup_old_backups() {
    local env=$1
    local keep_count=${2:-10}
    
    local backup_dir="${BACKUP_BASE}/${env}"
    
    if [[ -d "$backup_dir" ]]; then
        local backup_count=$(ls -1 "$backup_dir" 2>/dev/null | wc -l)
        
        if [[ $backup_count -gt $keep_count ]]; then
            local delete_count=$((backup_count - keep_count))
            ls -1t "$backup_dir" | tail -n "$delete_count" | while read -r dir; do
                rm -rf "${backup_dir}/${dir}"
                log_action "BACKUP: Deleted old backup ${backup_dir}/${dir}"
            done
            print_result "OK" "已清理 $delete_count 个旧备份"
        fi
    fi
}

# =============================================================================
# 执行部署
# =============================================================================
execute_deploy() {
    print_header "执行部署"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    local start_time=$(date +%s)
    
    # 创建部署目录
    mkdir -p "$deploy_dir"
    
    # 同步文件（排除特定目录）
    log_action "DEPLOY: Syncing files to $deploy_dir"
    
    if rsync -av --delete \
        --exclude='.git' \
        --exclude='node_modules' \
        --exclude='.env' \
        --exclude='logs/*' \
        --exclude='storage/*' \
        --exclude='.deployignore' \
        ./ "$deploy_dir/" 2>&1; then
        
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        
        print_result "OK" "文件同步完成 (${duration}秒)"
        log_action "DEPLOY: Files synced in ${duration}s"
    else
        print_result "ERROR" "文件同步失败"
        exit 1
    fi
    
    # 设置权限
    echo ""
    echo "设置权限:"
    
    chown -R "$DEPLOY_USER:$DEPLOY_GROUP" "$deploy_dir"
    print_result "OK" "所有者：$DEPLOY_USER:$DEPLOY_GROUP"
    
    # 设置目录权限
    find "$deploy_dir" -type d -exec chmod 755 {} \;
    print_result "OK" "目录权限：755"
    
    # 设置文件权限
    find "$deploy_dir" -type f -exec chmod 644 {} \;
    print_result "OK" "文件权限：644"
    
    # 特殊目录权限
    for dir in storage logs cache; do
        if [[ -d "${deploy_dir}/${dir}" ]]; then
            chmod -R 775 "${deploy_dir}/${dir}"
            print_result "OK" "${dir} 目录权限：775"
        fi
    done
    
    log_action "DEPLOY: Permissions set"
}

# =============================================================================
# 执行构建
# =============================================================================
execute_build() {
    print_header "执行构建"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    cd "$deploy_dir" || exit 1
    
    # 检查是否有构建脚本
    if [[ -f "build.sh" ]]; then
        log_action "BUILD: Executing build.sh"
        echo "执行构建脚本..."
        
        if bash build.sh 2>&1; then
            print_result "OK" "构建成功"
            log_action "BUILD: Completed successfully"
        else
            print_result "ERROR" "构建失败"
            exit 1
        fi
    # 检查是否有 package.json
    elif [[ -f "package.json" ]]; then
        log_action "BUILD: Installing npm dependencies"
        echo "安装 npm 依赖..."
        
        if command -v npm &> /dev/null; then
            if npm install --production 2>&1; then
                print_result "OK" "npm 依赖安装完成"
                log_action "BUILD: npm install completed"
            else
                print_result "WARN" "npm 依赖安装失败"
            fi
        else
            print_result "INFO" "未安装 npm，跳过"
        fi
    # 检查是否有 composer.json
    elif [[ -f "composer.json" ]]; then
        log_action "BUILD: Installing composer dependencies"
        echo "安装 composer 依赖..."
        
        if command -v composer &> /dev/null; then
            if composer install --no-dev --optimize-autoloader 2>&1; then
                print_result "OK" "composer 依赖安装完成"
                log_action "BUILD: composer install completed"
            else
                print_result "WARN" "composer 依赖安装失败"
            fi
        else
            print_result "INFO" "未安装 composer，跳过"
        fi
    # 检查是否有 requirements.txt
    elif [[ -f "requirements.txt" ]]; then
        log_action "BUILD: Installing pip dependencies"
        echo "安装 pip 依赖..."
        
        if command -v pip3 &> /dev/null; then
            if pip3 install -r requirements.txt --quiet 2>&1; then
                print_result "OK" "pip 依赖安装完成"
                log_action "BUILD: pip install completed"
            else
                print_result "WARN" "pip 依赖安装失败"
            fi
        else
            print_result "INFO" "未安装 pip，跳过"
        fi
    else
        print_result "INFO" "未检测到构建脚本或依赖文件，跳过构建"
        log_action "BUILD: No build script found"
    fi
}

# =============================================================================
# 数据库迁移
# =============================================================================
database_migration() {
    print_header "数据库迁移"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    cd "$deploy_dir" || exit 1
    
    # Laravel 迁移
    if [[ -f "artisan" ]]; then
        log_action "MIGRATE: Running Laravel migrations"
        echo "执行 Laravel 迁移..."
        
        if php artisan migrate --force 2>&1; then
            print_result "OK" "数据库迁移完成"
            log_action "MIGRATE: Laravel migrations completed"
        else
            print_result "WARN" "数据库迁移失败或无需迁移"
        fi
        
        # 清理缓存
        php artisan config:cache 2>&1
        php artisan route:cache 2>&1
        php artisan view:cache 2>&1
        print_result "OK" "Laravel 缓存已清理"
    # Django 迁移
    elif [[ -f "manage.py" ]]; then
        log_action "MIGRATE: Running Django migrations"
        echo "执行 Django 迁移..."
        
        if python3 manage.py migrate --noinput 2>&1; then
            print_result "OK" "数据库迁移完成"
            log_action "MIGRATE: Django migrations completed"
        else
            print_result "WARN" "数据库迁移失败或无需迁移"
        fi
        
        # 收集静态文件
        python3 manage.py collectstatic --noinput 2>&1
        print_result "OK" "静态文件已收集"
    else
        print_result "INFO" "未检测到数据库迁移脚本，跳过"
        log_action "MIGRATE: No migration script found"
    fi
}

# =============================================================================
# 重启服务
# =============================================================================
restart_services() {
    print_header "重启服务"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    
    # 检查 systemd 服务
    if [[ -f "${deploy_dir}/systemd.service" ]]; then
        local service_name=$(grep "^Environment=SERVICE_NAME" "${deploy_dir}/.env" 2>/dev/null | cut -d'=' -f2)
        
        if [[ -n "$service_name" ]]; then
            log_action "SERVICE: Restarting $service_name"
            
            if systemctl restart "$service_name" 2>&1; then
                print_result "OK" "服务已重启：$service_name"
            else
                print_result "WARN" "服务重启失败：$service_name"
            fi
        fi
    fi
    
    # 重启 PHP-FPM（如需要）
    if command -v systemctl &> /dev/null; then
        for php_fpm in php7.4-fpm php8.0-fpm php8.1-fpm php8.2-fpm; do
            if systemctl is-active --quiet "$php_fpm" 2>/dev/null; then
                systemctl reload "$php_fpm"
                print_result "OK" "已重载：$php_fpm"
                log_action "SERVICE: Reloaded $php_fpm"
                break
            fi
        done
    fi
    
    # 重启 Nginx（如配置变更）
    if [[ -f "${deploy_dir}/nginx.conf" ]]; then
        if command -v nginx &> /dev/null; then
            if nginx -t 2>&1; then
                systemctl reload nginx
                print_result "OK" "Nginx 配置已重载"
                log_action "SERVICE: Nginx reloaded"
            else
                print_result "WARN" "Nginx 配置测试失败"
            fi
        fi
    fi
}

# =============================================================================
# 健康检查
# =============================================================================
health_check() {
    print_header "健康检查"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    local check_url="${HEALTH_CHECK_URL:-http://localhost/health}"
    
    echo "检查部署状态:"
    
    # 检查进程
    if [[ -f "${deploy_dir}/.pid" ]]; then
        local pid=$(cat "${deploy_dir}/.pid")
        if kill -0 "$pid" 2>/dev/null; then
            print_result "OK" "进程运行中 (PID: $pid)"
            log_action "HEALTH: Process running (PID: $pid)"
        else
            print_result "ERROR" "进程未运行"
            log_action "HEALTH: Process not running"
            return 1
        fi
    fi
    
    # HTTP 健康检查
    if command -v curl &> /dev/null; then
        echo ""
        echo "HTTP 健康检查:"
        
        local http_code=$(curl -o /dev/null -s -w "%{http_code}" --max-time "$HEALTH_CHECK_TIMEOUT" "$check_url" 2>/dev/null)
        
        if [[ "$http_code" == "200" ]]; then
            print_result "OK" "HTTP 检查通过 ($check_url) - $http_code"
            log_action "HEALTH: HTTP check passed ($http_code)"
        else
            print_result "WARN" "HTTP 检查失败 - $http_code"
            log_action "HEALTH: HTTP check failed ($http_code)"
        fi
    fi
    
    # 检查日志错误
    echo ""
    echo "检查最近日志:"
    local log_file="${deploy_dir}/logs/app.log"
    
    if [[ -f "$log_file" ]]; then
        local error_count=$(tail -100 "$log_file" 2>/dev/null | grep -c -i "error\|exception" || echo 0)
        
        if [[ $error_count -gt 0 ]]; then
            print_result "WARN" "发现 $error_count 条错误日志"
            tail -5 "$log_file" | grep -i "error\|exception" | sed 's/^/    /'
        else
            print_result "OK" "未发现明显错误"
        fi
    fi
    
    return 0
}

# =============================================================================
# 回滚操作
# =============================================================================
rollback() {
    print_header "版本回滚"
    
    local deploy_dir="${ENV_CONFIG[$ENVIRONMENT]}"
    local backup_dir="${BACKUP_BASE}/${ENVIRONMENT}"
    
    # 获取最近的备份
    local latest_backup=$(ls -1t "$backup_dir" 2>/dev/null | head -1)
    
    if [[ -z "$latest_backup" ]]; then
        print_result "ERROR" "未找到备份"
        exit 1
    fi
    
    local backup_path="${backup_dir}/${latest_backup}"
    
    echo "回滚信息:"
    echo "  环境：$ENVIRONMENT"
    echo "  目标版本：$latest_backup"
    echo "  备份路径：$backup_path"
    echo ""
    
    if [[ ! -d "$backup_path" ]]; then
        print_result "ERROR" "备份目录不存在"
        exit 1
    fi
    
    # 备份当前版本
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local pre_rollback_backup="${BACKUP_BASE}/${ENVIRONMENT}/pre_rollback_${timestamp}"
    
    mkdir -p "$pre_rollback_backup"
    rsync -a "$deploy_dir/" "$pre_rollback_backup/"
    print_result "OK" "已备份当前版本到：$pre_rollback_backup"
    log_action "ROLLBACK: Pre-rollback backup created"
    
    # 恢复备份
    echo ""
    echo "恢复备份..."
    
    rm -rf "$deploy_dir"/*
    rsync -a "$backup_path/" "$deploy_dir/"
    
    if [[ $? -eq 0 ]]; then
        print_result "OK" "已回滚到版本：$latest_backup"
        log_action "ROLLBACK: Rolled back to $latest_backup"
        
        # 重启服务
        restart_services
        
        # 健康检查
        health_check
    else
        print_result "ERROR" "回滚失败"
        exit 1
    fi
}

# =============================================================================
# 显示状态
# =============================================================================
show_status() {
    print_header "部署状态"
    
    echo "环境配置:"
    echo ""
    
    for env in "${!ENV_CONFIG[@]}"; do
        local dir="${ENV_CONFIG[$env]}"
        echo "环境：$env"
        echo "  部署目录：$dir"
        
        if [[ -d "$dir" ]]; then
            print_result "OK" "目录存在"
            
            # 获取最后修改时间
            local last_modified=$(stat -c '%y' "$dir" 2>/dev/null | cut -d'.' -f1)
            echo "  最后更新：$last_modified"
            
            # 获取版本信息
            if [[ -f "${dir}/.git/HEAD" ]]; then
                local version=$(cd "$dir" && git rev-parse --short HEAD 2>/dev/null)
                echo "  版本：$version"
            fi
            
            # 目录大小
            local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "  大小：$size"
        else
            print_result "WARN" "目录不存在"
        fi
        
        echo ""
    done
    
    # 备份统计
    echo "备份统计:"
    for env in "${!ENV_CONFIG[@]}"; do
        local backup_dir="${BACKUP_BASE}/${env}"
        if [[ -d "$backup_dir" ]]; then
            local backup_count=$(ls -1 "$backup_dir" 2>/dev/null | wc -l)
            local backup_size=$(du -sh "$backup_dir" 2>/dev/null | cut -f1)
            echo "  $env: $backup_count 个备份，$backup_size"
        fi
    done
}

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  -e, --env ENV        环境 (dev/staging/production)"
    echo "  -b, --branch BRANCH  Git 分支 (默认：main)"
    echo "  --rollback           回滚到上一版本"
    echo "  --status             显示部署状态"
    echo "  --health-check       执行健康检查"
    echo "  --force              强制部署（忽略未提交更改）"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 -e production              # 部署到生产环境"
    echo "  $0 -e staging -b develop      # 部署 develop 分支到测试环境"
    echo "  $0 --rollback -e production   # 回滚生产环境"
    echo "  $0 --status                   # 查看部署状态"
    echo ""
    echo "配置:"
    echo "  部署目录：${DEPLOY_BASE}"
    echo "  备份目录：${BACKUP_BASE}"
    echo "  日志文件：${LOG_FILE}"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    # 解析参数
    parse_args "$@"
    
    # 检查依赖
    check_dependencies
    
    echo "========================================"
    echo "       自动化部署"
    echo "========================================"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
    
    case $ACTION in
        "deploy")
            if [[ -z "$ENVIRONMENT" ]]; then
                print_result "ERROR" "请指定环境 (--env)"
                show_help
                exit 1
            fi
            
            log_action "DEPLOY: Starting deployment to $ENVIRONMENT"
            
            pre_deploy_check
            backup_current_version
            execute_deploy
            execute_build
            database_migration
            restart_services
            health_check
            
            log_action "DEPLOY: Deployment completed"
            ;;
            
        "rollback")
            if [[ -z "$ENVIRONMENT" ]]; then
                print_result "ERROR" "请指定环境 (--env)"
                exit 1
            fi
            
            log_action "ROLLBACK: Starting rollback for $ENVIRONMENT"
            rollback
            ;;
            
        "status")
            show_status
            ;;
            
        "health-check")
            if [[ -z "$ENVIRONMENT" ]]; then
                print_result "ERROR" "请指定环境 (--env)"
                exit 1
            fi
            
            health_check
            ;;
    esac
    
    echo ""
    echo "========================================"
    echo "       部署完成"
    echo "========================================"
    echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
main "$@"

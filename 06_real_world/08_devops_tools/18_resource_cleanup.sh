#!/bin/bash
# =============================================================================
# 脚本名称：18_resource_cleanup.sh
# 功能描述：系统资源清理脚本（磁盘/内存/日志/临时文件）
# 难度等级：⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - 磁盘清理
#   - 内存释放
#   - 日志清理
#   - 临时文件清理
#   - 包管理器清理
# 使用方法：
#   sudo ./18_resource_cleanup.sh --all                # 清理所有
#   sudo ./18_resource_cleanup.sh --disk               # 磁盘清理
#   sudo ./18_resource_cleanup.sh --memory             # 内存释放
#   sudo ./18_resource_cleanup.sh --dry-run            # 预览模式
# 代码说明：
#   - 安全清理系统资源
#   - 支持预览模式
#   - 自动备份重要文件
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
DRY_RUN=false
BACKUP_DIR="/backup/cleanup"
LOG_FILE="/var/log/resource_cleanup.log"

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

# =============================================================================
# 显示帮助
# =============================================================================
show_help() {
    echo "用法：$0 [选项]"
    echo ""
    echo "选项:"
    echo "  --all                清理所有项目"
    echo "  --disk               磁盘清理"
    echo "  --memory             内存释放"
    echo "  --logs               日志清理"
    echo "  --temp               临时文件清理"
    echo "  --packages           包管理器清理"
    echo "  --docker             Docker 清理"
    echo "  --dry-run            预览模式（不实际清理）"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 --dry-run              # 预览可清理的内容"
    echo "  $0 --all                  # 清理所有"
    echo "  $0 --disk --logs          # 清理磁盘和日志"
}

# =============================================================================
# 检查 root 权限
# =============================================================================
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_result "ERROR" "此脚本需要 root 权限"
        echo "请使用：sudo $0"
        exit 1
    fi
}

# =============================================================================
# 磁盘使用统计
# =============================================================================
disk_usage() {
    print_header "磁盘使用统计"
    
    echo "分区使用:"
    df -h | grep -E '^/dev' | awk '{printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5}'
    
    echo ""
    echo "大目录 TOP 10:"
    du -ah --max-depth=1 / 2>/dev/null | sort -rh | head -10 | while read -r line; do
        echo "  $line"
    done
    
    echo ""
    echo "大文件 TOP 10 (>100MB):"
    find / -type f -size +100M 2>/dev/null | xargs du -h 2>/dev/null | sort -rh | head -10 | while read -r line; do
        echo "  $line"
    done
}

# =============================================================================
# 清理包管理器缓存
# =============================================================================
cleanup_packages() {
    print_header "包管理器清理"
    
    local cleaned=0
    
    # APT (Debian/Ubuntu)
    if command -v apt-get &> /dev/null; then
        echo "清理 APT 缓存..."
        
        if [[ "$DRY_RUN" == "true" ]]; then
            local apt_size=$(du -sh /var/cache/apt/archives 2>/dev/null | cut -f1)
            print_result "INFO" "APT 缓存大小：$apt_size (预览模式)"
        else
            apt-get clean -y
            apt-get autoremove -y
            print_result "OK" "APT 缓存已清理"
            ((cleaned++))
            log_action "CLEANUP: APT cache cleaned"
        fi
    fi
    
    # YUM (CentOS/RHEL)
    if command -v yum &> /dev/null; then
        echo "清理 YUM 缓存..."
        
        if [[ "$DRY_RUN" == "true" ]]; then
            local yum_size=$(du -sh /var/cache/yum 2>/dev/null | cut -f1)
            print_result "INFO" "YUM 缓存大小：$yum_size (预览模式)"
        else
            yum clean all
            print_result "OK" "YUM 缓存已清理"
            ((cleaned++))
            log_action "CLEANUP: YUM cache cleaned"
        fi
    fi
    
    # DNF (Fedora)
    if command -v dnf &> /dev/null; then
        echo "清理 DNF 缓存..."
        
        if [[ "$DRY_RUN" == "true" ]]; then
            local dnf_size=$(du -sh /var/cache/dnf 2>/dev/null | cut -f1)
            print_result "INFO" "DNF 缓存大小：$dnf_size (预览模式)"
        else
            dnf clean all
            print_result "OK" "DNF 缓存已清理"
            ((cleaned++))
            log_action "CLEANUP: DNF cache cleaned"
        fi
    fi
    
    echo ""
    echo "清理完成：$cleaned 项"
}

# =============================================================================
# 清理日志文件
# =============================================================================
cleanup_logs() {
    print_header "日志清理"
    
    local log_dirs=(
        "/var/log"
        "/var/log/nginx"
        "/var/log/mysql"
        "/var/log/apache2"
        "/var/log/journal"
    )
    
    local total_cleaned=0
    local total_size=0
    
    for dir in "${log_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "检查目录：$dir"
            
            # 查找旧日志文件（>7 天）
            local old_logs=$(find "$dir" -type f -name "*.log" -mtime +7 2>/dev/null)
            local old_count=$(echo "$old_logs" | grep -c . 2>/dev/null || echo 0)
            
            if [[ $old_count -gt 0 ]]; then
                local old_size=$(find "$dir" -type f -name "*.log" -mtime +7 -exec du -ch {} + 2>/dev/null | tail -1 | cut -f1)
                
                echo "  发现 $old_count 个旧日志文件，大小：$old_size"
                
                if [[ "$DRY_RUN" != "true" ]]; then
                    find "$dir" -type f -name "*.log" -mtime +7 -delete 2>/dev/null
                    print_result "OK" "已清理 $old_count 个日志文件"
                    log_action "CLEANUP: Cleaned $old_count log files in $dir"
                fi
                
                ((total_cleaned += old_count))
            else
                print_result "OK" "无需清理"
            fi
        fi
    done
    
    # 清理 systemd 日志
    if command -v journalctl &> /dev/null; then
        echo ""
        echo "清理 systemd 日志..."
        
        if [[ "$DRY_RUN" == "true" ]]; then
            local journal_size=$(journalctl --disk-usage 2>/dev/null)
            print_result "INFO" "systemd 日志大小：$journal_size (预览模式)"
        else
            journalctl --vacuum-time=7d
            print_result "OK" "systemd 日志已清理（保留 7 天）"
            log_action "CLEANUP: Journal logs vacuumed"
        fi
    fi
    
    echo ""
    echo "日志清理完成：共清理 $total_cleaned 个文件"
}

# =============================================================================
# 清理临时文件
# =============================================================================
cleanup_temp() {
    print_header "临时文件清理"
    
    local temp_dirs=(
        "/tmp"
        "/var/tmp"
        "/var/cache"
    )
    
    local total_cleaned=0
    
    for dir in "${temp_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            echo "检查目录：$dir"
            
            # 查找旧临时文件（>3 天）
            local old_files=$(find "$dir" -type f -atime +3 2>/dev/null | wc -l)
            
            if [[ $old_files -gt 0 ]]; then
                echo "  发现 $old_files 个旧临时文件"
                
                if [[ "$DRY_RUN" != "true" ]]; then
                    find "$dir" -type f -atime +3 -delete 2>/dev/null
                    print_result "OK" "已清理 $old_files 个临时文件"
                    log_action "CLEANUP: Cleaned $old_files temp files in $dir"
                fi
                
                ((total_cleaned += old_files))
            else
                print_result "OK" "无需清理"
            fi
        fi
    done
    
    echo ""
    echo "临时文件清理完成：共清理 $total_cleaned 个文件"
}

# =============================================================================
# 释放内存
# =============================================================================
free_memory() {
    print_header "内存释放"
    
    echo "释放前内存状态:"
    free -h
    
    echo ""
    
    if [[ "$DRY_RUN" == "true" ]]; then
        print_result "INFO" "预览模式，不执行内存释放"
        return
    fi
    
    # 同步缓存到磁盘
    echo "同步缓存到磁盘..."
    sync
    
    # 清理 PageCache
    echo "清理 PageCache..."
    echo 1 > /proc/sys/vm/drop_caches
    print_result "OK" "PageCache 已清理"
    
    # 清理 dentries 和 inodes
    echo "清理 dentries 和 inodes..."
    echo 2 > /proc/sys/vm/drop_caches
    print_result "OK" "dentries 和 inodes 已清理"
    
    # 清理 PageCache + dentries + inodes
    echo "清理所有缓存..."
    echo 3 > /proc/sys/vm/drop_caches
    print_result "OK" "所有缓存已清理"
    
    log_action "MEMORY: Cache cleared"
    
    echo ""
    echo "释放后内存状态:"
    free -h
}

# =============================================================================
# Docker 清理
# =============================================================================
cleanup_docker() {
    print_header "Docker 清理"
    
    if ! command -v docker &> /dev/null; then
        print_result "INFO" "未安装 Docker，跳过"
        return
    fi
    
    if ! docker info &>/dev/null; then
        print_result "INFO" "Docker 服务未运行，跳过"
        return
    fi
    
    local cleaned=0
    
    # 清理已停止容器
    echo "清理已停止容器..."
    if [[ "$DRY_RUN" == "true" ]]; then
        local stopped=$(docker ps -a --filter "status=exited" -q 2>/dev/null | wc -l)
        print_result "INFO" "已停止容器：$stopped (预览模式)"
    else
        docker container prune -f
        print_result "OK" "已停止容器已清理"
        ((cleaned++))
        log_action "CLEANUP: Docker stopped containers pruned"
    fi
    
    # 清理悬空镜像
    echo "清理悬空镜像..."
    if [[ "$DRY_RUN" == "true" ]]; then
        local dangling=$(docker images --filter "dangling=true" -q 2>/dev/null | wc -l)
        print_result "INFO" "悬空镜像：$dangling (预览模式)"
    else
        docker image prune -f
        print_result "OK" "悬空镜像已清理"
        ((cleaned++))
        log_action "CLEANUP: Docker dangling images pruned"
    fi
    
    # 清理构建缓存
    echo "清理构建缓存..."
    if [[ "$DRY_RUN" == "true" ]]; then
        print_result "INFO" "构建缓存将清理 (预览模式)"
    else
        docker builder prune -f
        print_result "OK" "构建缓存已清理"
        ((cleaned++))
        log_action "CLEANUP: Docker builder cache pruned"
    fi
    
    echo ""
    echo "Docker 清理完成：$cleaned 项"
}

# =============================================================================
# 查找并清理大文件
# =============================================================================
cleanup_large_files() {
    print_header "大文件清理"
    
    local size_threshold="100M"
    
    echo "查找大于 $size_threshold 的文件..."
    echo ""
    
    local large_files=$(find / -type f -size +$size_threshold 2>/dev/null | head -20)
    
    if [[ -n "$large_files" ]]; then
        echo "发现以下大文件:"
        echo "$large_files" | while read -r file; do
            [[ -n "$file" ]] && du -h "$file" 2>/dev/null
        done
        
        echo ""
        
        if [[ "$DRY_RUN" != "true" ]]; then
            read -p "是否清理这些文件？(y/n): " confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                echo "$large_files" | while read -r file; do
                    [[ -n "$file" ]] && rm -f "$file" && print_result "OK" "已删除：$file"
                done
                log_action "CLEANUP: Large files deleted"
            fi
        fi
    else
        print_result "OK" "未发现大于 $size_threshold 的文件"
    fi
}

# =============================================================================
# 清理后统计
# =============================================================================
post_cleanup_stats() {
    print_header "清理后统计"
    
    echo "磁盘使用:"
    df -h | grep -E '^/dev' | awk '{printf "%-20s %-10s %-10s %-10s %-10s\n", $1, $2, $3, $4, $5}'
    
    echo ""
    echo "内存使用:"
    free -h
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local actions=()
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --all)
                actions=("packages" "logs" "temp" "docker")
                shift
                ;;
            --disk)
                actions+=("large_files")
                shift
                ;;
            --memory)
                actions+=("memory")
                shift
                ;;
            --logs)
                actions+=("logs")
                shift
                ;;
            --temp)
                actions+=("temp")
                shift
                ;;
            --packages)
                actions+=("packages")
                shift
                ;;
            --docker)
                actions+=("docker")
                shift
                ;;
            --dry-run)
                DRY_RUN=true
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
    
    # 检查 root 权限
    check_root
    
    echo "========================================"
    echo "       系统资源清理"
    echo "========================================"
    echo "开始时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "模式：${DRY_RUN:-实际清理}"
    echo "========================================"
    
    # 如果没有指定操作，显示帮助
    if [[ ${#actions[@]} -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    # 显示磁盘使用前统计
    disk_usage
    
    # 执行清理操作
    for action in "${actions[@]}"; do
        case $action in
            "packages")
                cleanup_packages
                ;;
            "logs")
                cleanup_logs
                ;;
            "temp")
                cleanup_temp
                ;;
            "memory")
                free_memory
                ;;
            "docker")
                cleanup_docker
                ;;
            "large_files")
                cleanup_large_files
                ;;
        esac
    done
    
    # 显示清理后统计
    post_cleanup_stats
    
    echo ""
    echo "========================================"
    echo "       清理完成"
    echo "========================================"
    echo "结束时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 执行主程序
main "$@"

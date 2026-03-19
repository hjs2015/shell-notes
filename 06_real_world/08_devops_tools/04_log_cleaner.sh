#!/bin/bash
# =============================================================================
# 脚本名称：04_log_cleaner.sh
# 功能描述：日志清理脚本 - 清理过期日志文件，释放磁盘空间
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - find 文件查找
#   - du 磁盘使用
#   - 日期计算
#   - 文件操作
#   - 日志轮转
# 使用方法：
#   chmod +x 04_log_cleaner.sh
#   sudo ./04_log_cleaner.sh              # 清理 30 天前日志
#   sudo ./04_log_cleaner.sh 7            # 清理 7 天前日志
#   sudo ./04_log_cleaner.sh 30 --dry-run # 模拟清理（不删除）
#   sudo ./04_log_cleaner.sh --help       # 显示帮助
# 应用场景：
#   - 定期清理系统日志
#   - 释放磁盘空间
#   - 日志归档前清理
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 默认保留天数
DEFAULT_DAYS=30

# 日志目录
LOG_DIRS=(
    "/var/log"
    "/var/log/nginx"
    "/var/log/apache2"
    "/var/log/mysql"
    "/var/log/postgresql"
    "/opt/logs"
    "/home/*/logs"
)

# 统计变量
total_size=0
total_files=0
deleted_files=0

# 显示磁盘使用情况
show_disk_usage() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       磁盘使用情况${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    df -h | grep -E '^/dev|Filesystem'
    
    echo ""
    echo -e "${YELLOW}日志目录大小：${NC}"
    for dir in "${LOG_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "  $dir: $size"
        fi
    done
    
    echo ""
}

# 查找日志文件
find_log_files() {
    local days=$1
    local pattern=$2
    
    find /var/log -name "$pattern" -type f -mtime +$days 2>/dev/null
}

# 计算文件大小
calc_size() {
    local file=$1
    stat -c%s "$file" 2>/dev/null || echo 0
}

# 清理日志文件
clean_logs() {
    local days=$1
    local dry_run=$2
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       日志清理报告${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo -e "${YELLOW}保留天数：$days 天${NC}"
    if [ "$dry_run" = true ]; then
        echo -e "${YELLOW}模式：模拟清理（不删除文件）${NC}"
    else
        echo -e "${YELLOW}模式：实际清理${NC}"
    fi
    echo ""
    
    # 清理不同类型的日志文件
    local patterns=("*.log" "*.log.*" "*.gz" "*.bz2" "*.xz" "*.old" "*.bak")
    
    for pattern in "${patterns[@]}"; do
        echo -e "${BLUE}查找模式：$pattern${NC}"
        
        while IFS= read -r file; do
            if [ -n "$file" ]; then
                local size=$(calc_size "$file")
                total_size=$((total_size + size))
                total_files=$((total_files + 1))
                
                if [ "$dry_run" = true ]; then
                    echo -e "  ${YELLOW}[模拟] 将删除：$file ($(numfmt --to=iec $size))${NC}"
                else
                    rm -f "$file"
                    if [ $? -eq 0 ]; then
                        echo -e "  ${GREEN}✓ 已删除：$file ($(numfmt --to=iec $size))${NC}"
                        deleted_files=$((deleted_files + 1))
                    else
                        echo -e "  ${RED}✗ 删除失败：$file${NC}"
                    fi
                fi
            fi
        done < <(find_log_files "$days" "$pattern")
        
        echo ""
    done
    
    # 清理空的日志目录
    echo -e "${BLUE}清理空目录：${NC}"
    find /var/log -type d -empty -delete 2>/dev/null
    echo "  ✓ 完成"
    
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       清理统计${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo "  扫描文件数：$total_files"
    echo "  删除文件数：$deleted_files"
    echo "  释放空间：$(numfmt --to=iec $total_size)"
    echo ""
}

# 压缩旧日志
compress_logs() {
    local days=$1
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}       压缩旧日志${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # 查找 7 天前未压缩的日志
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            echo -e "  压缩：$file"
            gzip "$file" 2>/dev/null
        fi
    done < <(find /var/log -name "*.log" -type f -mtime +$days ! -name "*.gz" 2>/dev/null)
    
    echo ""
}

# 显示用法
usage() {
    echo "用法：$0 [天数] [选项]"
    echo ""
    echo "参数:"
    echo "  天数          - 保留的天数（默认：$DEFAULT_DAYS）"
    echo ""
    echo "选项:"
    echo "  --dry-run     - 模拟清理（不删除文件）"
    echo "  --compress    - 压缩旧日志"
    echo "  --disk        - 只显示磁盘使用情况"
    echo "  --help        - 显示帮助"
    echo ""
    echo "示例:"
    echo "  $0                    # 清理 30 天前日志"
    echo "  $0 7                  # 清理 7 天前日志"
    echo "  $0 30 --dry-run       # 模拟清理"
    echo "  $0 7 --compress       # 清理并压缩"
    echo "  $0 --disk             # 查看磁盘使用"
}

# 主函数
main() {
    # 检查是否 root 用户
    if [ $EUID -ne 0 ]; then
        echo -e "${RED}错误：需要 root 权限运行${NC}"
        echo "请使用：sudo $0 $@"
        exit 1
    fi
    
    local days=$DEFAULT_DAYS
    local dry_run=false
    local compress=false
    local disk_only=false
    
    # 解析参数
    for arg in "$@"; do
        case $arg in
            --dry-run)
                dry_run=true
                ;;
            --compress)
                compress=true
                ;;
            --disk)
                disk_only=true
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                if [[ "$arg" =~ ^[0-9]+$ ]]; then
                    days=$arg
                else
                    echo -e "${RED}未知参数：$arg${NC}"
                    usage
                    exit 1
                fi
                ;;
        esac
    done
    
    if [ "$disk_only" = true ]; then
        show_disk_usage
        exit 0
    fi
    
    show_disk_usage
    clean_logs "$days" "$dry_run"
    
    if [ "$compress" = true ]; then
        compress_logs 7
    fi
}

# 执行主函数
main "$@"

# 说明：
# 1. 安全清理过期日志
# 2. 支持模拟运行
# 3. 显示详细统计
# 4. 可压缩旧日志
# 5. 释放磁盘空间

# 配置定时任务：
# crontab -e
# 0 2 * * * /path/to/04_log_cleaner.sh 30 --compress

# 安全提示：
# 1. 建议先用 --dry-run 测试
# 2. 重要日志先备份再清理
# 3. 生产环境谨慎使用

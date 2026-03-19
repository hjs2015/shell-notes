#!/bin/bash
# =============================================================================
# 脚本名称：20_file_sync.sh
# 功能描述：文件同步脚本（本地/远程、增量同步、冲突处理）
# 难度等级：⭐⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - rsync 同步
#   - 增量备份
#   - 冲突检测
#   - 远程同步
# 使用方法：
#   ./20_file_sync.sh --local /src /dst              # 本地同步
#   ./20_file_sync.sh --remote user@host:/src /dst   # 远程同步
#   ./20_file_sync.sh --backup /src /backup          # 增量备份
#   ./20_file_sync.sh --compare /src /dst            # 比较差异
# 代码说明：
#   - 基于 rsync 实现
#   - 支持本地和远程同步
#   - 增量同步节省带宽
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置
SOURCE=""
DEST=""
SSH_KEY=""
EXCLUDE_FILE=""
DRY_RUN=false
DELETE=false
COMPRESS=true

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
    echo "  --local SRC DST      本地同步"
    echo "  --remote SRC DST     远程同步 (SRC 格式：user@host:/path)"
    echo "  --backup SRC DST     增量备份"
    echo "  --compare A B        比较差异"
    echo "  --sync SSH_KEY       SSH 密钥路径"
    echo "  --exclude FILE       排除文件列表"
    echo "  --delete             删除目标多余文件"
    echo "  --dry-run            预览模式"
    echo "  --no-compress        不压缩"
    echo "  -h, --help           显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 --local /data/source /data/backup"
    echo "  $0 --remote user@192.168.1.100:/data /backup"
    echo "  $0 --backup /var/www /backup/www --delete"
}

# =============================================================================
# 检查 rsync
# =============================================================================
check_rsync() {
    if ! command -v rsync &> /dev/null; then
        print_result "ERROR" "未安装 rsync"
        echo "请安装：sudo apt install rsync 或 sudo yum install rsync"
        exit 1
    fi
    
    print_result "OK" "rsync 已安装"
}

# =============================================================================
# 本地同步
# =============================================================================
sync_local() {
    local src=$1
    local dst=$2
    
    print_header "本地文件同步"
    
    # 验证路径
    if [[ ! -d "$src" ]]; then
        print_result "ERROR" "源目录不存在：$src"
        exit 1
    fi
    
    # 创建目标目录
    mkdir -p "$dst"
    
    echo "同步信息:"
    echo "  源目录：$src"
    echo "  目标目录：$dst"
    echo "  模式：${DRY_RUN:+预览模式}${DELETE:+删除多余文件}"
    echo ""
    
    # 构建 rsync 命令
    local rsync_cmd="rsync -av --progress"
    
    [[ "$DRY_RUN" == "true" ]] && rsync_cmd="$rsync_cmd --dry-run"
    [[ "$DELETE" == "true" ]] && rsync_cmd="$rsync_cmd --delete"
    [[ "$COMPRESS" == "true" ]] && rsync_cmd="$rsync_cmd --compress"
    
    # 排除文件
    if [[ -n "$EXCLUDE_FILE" && -f "$EXCLUDE_FILE" ]]; then
        rsync_cmd="$rsync_cmd --exclude-from=$EXCLUDE_FILE"
        echo "排除文件：$EXCLUDE_FILE"
    fi
    
    rsync_cmd="$rsync_cmd $src/ $dst/"
    
    echo "执行命令：$rsync_cmd"
    echo ""
    
    # 执行同步
    if eval "$rsync_cmd"; then
        if [[ "$DRY_RUN" == "true" ]]; then
            print_result "OK" "预览完成（未实际同步）"
        else
            print_result "OK" "同步完成"
            
            # 显示统计
            echo ""
            echo "同步统计:"
            local src_size=$(du -sh "$src" | cut -f1)
            local dst_size=$(du -sh "$dst" | cut -f1)
            echo "  源目录大小：$src_size"
            echo "  目标目录大小：$dst_size"
        fi
    else
        print_result "ERROR" "同步失败"
        return 1
    fi
}

# =============================================================================
# 远程同步
# =============================================================================
sync_remote() {
    local src=$1
    local dst=$2
    
    print_header "远程文件同步"
    
    # 验证 SSH 密钥
    if [[ -n "$SSH_KEY" && ! -f "$SSH_KEY" ]]; then
        print_result "ERROR" "SSH 密钥不存在：$SSH_KEY"
        exit 1
    fi
    
    echo "同步信息:"
    echo "  源：$src"
    echo "  目标：$dst"
    [[ -n "$SSH_KEY" ]] && echo "  SSH 密钥：$SSH_KEY"
    echo ""
    
    # 构建 rsync 命令
    local rsync_cmd="rsync -avz --progress"
    
    [[ "$DRY_RUN" == "true" ]] && rsync_cmd="$rsync_cmd --dry-run"
    [[ "$DELETE" == "true" ]] && rsync_cmd="$rsync_cmd --delete"
    
    # SSH 配置
    if [[ -n "$SSH_KEY" ]]; then
        rsync_cmd="$rsync_cmd -e 'ssh -i $SSH_KEY -o StrictHostKeyChecking=no'"
    else
        rsync_cmd="$rsync_cmd -e 'ssh -o StrictHostKeyChecking=no'"
    fi
    
    rsync_cmd="$rsync_cmd $src $dst"
    
    echo "执行命令：$rsync_cmd"
    echo ""
    
    # 执行同步
    if eval "$rsync_cmd"; then
        if [[ "$DRY_RUN" == "true" ]]; then
            print_result "OK" "预览完成（未实际同步）"
        else
            print_result "OK" "远程同步完成"
        fi
    else
        print_result "ERROR" "远程同步失败"
        return 1
    fi
}

# =============================================================================
# 增量备份
# =============================================================================
backup_incremental() {
    local src=$1
    local dst=$2
    
    print_header "增量备份"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_dst="${dst}/backup_${timestamp}"
    
    # 验证源目录
    if [[ ! -d "$src" ]]; then
        print_result "ERROR" "源目录不存在：$src"
        exit 1
    fi
    
    # 创建备份目录
    mkdir -p "$backup_dst"
    
    echo "备份信息:"
    echo "  源目录：$src"
    echo "  备份目录：$backup_dst"
    echo ""
    
    # 如果有之前的备份，使用硬链接
    local latest_backup=$(ls -td ${dst}/backup_* 2>/dev/null | head -1)
    
    local rsync_cmd="rsync -av --delete"
    
    if [[ -n "$latest_backup" ]]; then
        rsync_cmd="$rsync_cmd --link-dest=$latest_backup"
        echo "使用硬链接：$latest_backup"
    fi
    
    rsync_cmd="$rsync_cmd $src/ $backup_dst/"
    
    echo "执行命令：$rsync_cmd"
    echo ""
    
    if eval "$rsync_cmd"; then
        print_result "OK" "增量备份完成：$backup_dst"
        
        # 显示备份大小
        local backup_size=$(du -sh "$backup_dst" | cut -f1)
        echo "备份大小：$backup_size"
        
        # 清理旧备份（保留最近 7 个）
        cleanup_old_backups "$dst" 7
        
    else
        print_result "ERROR" "备份失败"
        return 1
    fi
}

# =============================================================================
# 清理旧备份
# =============================================================================
cleanup_old_backups() {
    local backup_dir=$1
    local keep_count=${2:-7}
    
    local backups=$(ls -td ${backup_dir}/backup_* 2>/dev/null)
    local backup_count=$(echo "$backups" | grep -c . 2>/dev/null || echo 0)
    
    if [[ $backup_count -gt $keep_count ]]; then
        local delete_count=$((backup_count - keep_count))
        echo "清理 $delete_count 个旧备份..."
        
        echo "$backups" | tail -n "$delete_count" | while read -r backup; do
            [[ -n "$backup" ]] && rm -rf "$backup" && print_result "OK" "已删除：$backup"
        done
    fi
}

# =============================================================================
# 比较目录差异
# =============================================================================
compare_dirs() {
    local dir1=$1
    local dir2=$2
    
    print_header "目录比较"
    
    echo "目录 1: $dir1"
    echo "目录 2: $dir2"
    echo ""
    
    # 检查目录
    if [[ ! -d "$dir1" ]]; then
        print_result "ERROR" "目录不存在：$dir1"
        return 1
    fi
    
    if [[ ! -d "$dir2" ]]; then
        print_result "ERROR" "目录不存在：$dir2"
        return 1
    fi
    
    # 使用 diff 比较
    echo "差异分析:"
    echo "----------------------------------------"
    
    # 只在 dir1 的文件
    echo "只在 $dir1 中:"
    diff -rq "$dir1" "$dir2" 2>/dev/null | grep "Only in $dir1" | sed 's/^/  /'
    
    echo ""
    echo "只在 $dir2 中:"
    diff -rq "$dir1" "$dir2" 2>/dev/null | grep "Only in $dir2" | sed 's/^/  /'
    
    echo ""
    echo "文件内容不同:"
    diff -rq "$dir1" "$dir2" 2>/dev/null | grep "differ" | sed 's/^/  /'
    
    echo ""
    echo "统计:"
    local only_in_dir1=$(diff -rq "$dir1" "$dir2" 2>/dev/null | grep -c "Only in $dir1" || echo 0)
    local only_in_dir2=$(diff -rq "$dir1" "$dir2" 2>/dev/null | grep -c "Only in $dir2" || echo 0)
    local differ=$(diff -rq "$dir1" "$dir2" 2>/dev/null | grep -c "differ" || echo 0)
    
    echo "  只在目录 1: $only_in_dir1 个文件"
    echo "  只在目录 2: $only_in_dir2 个文件"
    echo "  内容不同：$differ 个文件"
}

# =============================================================================
# 同步统计
# =============================================================================
sync_stats() {
    print_header "同步统计"
    
    echo "同步配置:"
    echo "  预览模式：$DRY_RUN"
    echo "  删除多余：$DELETE"
    echo "  压缩：$COMPRESS"
    [[ -n "$EXCLUDE_FILE" ]] && echo "  排除文件：$EXCLUDE_FILE"
    [[ -n "$SSH_KEY" ]] && echo "  SSH 密钥：$SSH_KEY"
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local action=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --local)
                action="local"
                SOURCE="$2"
                DEST="$3"
                shift 3
                ;;
            --remote)
                action="remote"
                SOURCE="$2"
                DEST="$3"
                shift 3
                ;;
            --backup)
                action="backup"
                SOURCE="$2"
                DEST="$3"
                shift 3
                ;;
            --compare)
                action="compare"
                SOURCE="$2"
                DEST="$3"
                shift 3
                ;;
            --sync)
                SSH_KEY="$2"
                shift 2
                ;;
            --exclude)
                EXCLUDE_FILE="$2"
                shift 2
                ;;
            --delete)
                DELETE=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --no-compress)
                COMPRESS=false
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
    
    # 检查 rsync
    check_rsync
    
    # 显示统计
    sync_stats
    
    # 执行操作
    case $action in
        "local")
            if [[ -z "$SOURCE" || -z "$DEST" ]]; then
                print_result "ERROR" "请指定源目录和目标目录"
                exit 1
            fi
            sync_local "$SOURCE" "$DEST"
            ;;
        "remote")
            if [[ -z "$SOURCE" || -z "$DEST" ]]; then
                print_result "ERROR" "请指定源和目标"
                exit 1
            fi
            sync_remote "$SOURCE" "$DEST"
            ;;
        "backup")
            if [[ -z "$SOURCE" || -z "$DEST" ]]; then
                print_result "ERROR" "请指定源目录和备份目录"
                exit 1
            fi
            backup_incremental "$SOURCE" "$DEST"
            ;;
        "compare")
            if [[ -z "$SOURCE" || -z "$DEST" ]]; then
                print_result "ERROR" "请指定两个目录"
                exit 1
            fi
            compare_dirs "$SOURCE" "$DEST"
            ;;
        "stats")
            sync_stats
            ;;
        *)
            show_help
            ;;
    esac
}

# 执行主程序
main "$@"

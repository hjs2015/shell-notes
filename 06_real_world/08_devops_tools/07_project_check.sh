#!/bin/bash
# =============================================================================
# 脚本名称：07_project_check.sh
# 功能描述：项目文件巡检脚本（统计文件数、检测最近修改）
# 难度等级：⭐⭐⭐⭐
# 知识点：
#   - 函数化组织代码
#   - find 命令高级用法
#   - 数组和循环处理
#   - 格式化输出
#   - 排除目录技巧
# 使用方法：
#   chmod +x 07_project_check.sh
#   ./07_project_check.sh [项目目录]
#   ./07_project_check.sh /home/wwwroot
# 代码说明：
#   - 支持自定义项目目录
#   - 自动排除临时目录
#   - 统计文件数和代码行数
#   - 检测 24/7 天内修改的文件
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 默认项目目录
DEFAULT_PROJECT_DIR="/home/wwwroot"

# 打印分区标题
print_header() {
    echo ""
    echo -e "${BLUE}【$1】${NC}"
    echo "------------------------------------"
}

# 打印表格标题
print_table_header() {
    printf "${YELLOW}%-15s %-10s %-12s %-15s %-20s${NC}\n" "$1" "$2" "$3" "$4" "$5"
}

# 打印表格行
print_table_row() {
    printf "%-15s %-10s %-12s %-15s %-20s\n" "$1" "$2" "$3" "$4" "$5"
}

# =============================================================================
# 排除的目录模式
# =============================================================================
EXCLUDE_PATTERNS=(
    "runtime"
    "logs"
    "log"
    "tmp"
    "temp"
    "cache"
    ".git"
    "node_modules"
    "vendor"
    "storage/framework"
    "storage/logs"
    "public/uploads"
    "assets"
)

# 构建 find 排除参数
build_exclude_args() {
    local args=""
    for pattern in "${EXCLUDE_PATTERNS[@]}"; do
        args="$args ! -path \"*/$pattern/*\""
    done
    echo "$args"
}

# =============================================================================
# 项目概览统计
# =============================================================================
project_overview() {
    local project_dir=$1
    
    print_header "项目概览"
    
    # 项目总数
    local total_projects=$(find "$project_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
    echo "项目目录：$project_dir"
    echo "项目总数：${CYAN}${total_projects}${NC} 个"
    echo ""
    
    # 统计每个项目
    print_table_header "项目名称" "文件数" "代码行数" "大小 (MB)" "最后修改"
    echo "--------------------------------------------------------------------------------"
    
    find "$project_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort | while read -r proj_path; do
        proj_name=$(basename "$proj_path")
        
        # 文件数统计（排除临时目录）
        local file_count=$(find "$proj_path" \
            ! -path "*/runtime/*" \
            ! -path "*/logs/*" \
            ! -path "*/.git/*" \
            ! -path "*/node_modules/*" \
            -type f 2>/dev/null | wc -l)
        
        # 代码文件行数统计
        local code_lines=$(find "$proj_path" \
            ! -path "*/runtime/*" \
            ! -path "*/logs/*" \
            ! -path "*/.git/*" \
            -type f \( -name "*.php" -o -name "*.js" -o -name "*.py" -o -name "*.java" -o -name "*.go" \) \
            -exec cat {} \; 2>/dev/null | wc -l)
        
        # 目录大小（MB）
        local dir_size=$(du -sm "$proj_path" 2>/dev/null | cut -f1)
        
        # 最后修改时间
        local last_modified=$(find "$proj_path" -type f -printf '%T@\n' 2>/dev/null | sort -rn | head -1 | cut -d'.' -f1)
        if [[ -n "$last_modified" ]]; then
            last_modified_date=$(date -d "@${last_modified%.*}" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "未知")
        else
            last_modified_date="未知"
        fi
        
        # 根据文件数显示颜色
        if [[ $file_count -gt 1000 ]]; then
            echo -e "${GREEN}"
        elif [[ $file_count -gt 100 ]]; then
            echo -e "${YELLOW}"
        fi
        
        print_table_row "$proj_name" "$file_count" "$code_lines" "${dir_size:-0}" "$last_modified_date"
        echo -e "${NC}"
    done
}

# =============================================================================
# 24 小时内修改的文件
# =============================================================================
check_recent_files_24h() {
    local project_dir=$1
    
    print_header "24 小时内修改的文件"
    
    local count=0
    find "$project_dir" -mindepth 2 -maxdepth 3 \
        ! -path "*/runtime/*" \
        ! -path "*/logs/*" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        ! -path "*/cache/*" \
        -type f -mtime 0 2>/dev/null | while read -r file; do
        local mod_time=$(stat -c '%y' "$file" 2>/dev/null | cut -d'.' -f1)
        local file_size=$(stat -c '%s' "$file" 2>/dev/null)
        printf "%-60s %s %10s\n" "$file" "$mod_time" "${file_size}B"
        ((count++))
    done
    
    local total=$(find "$project_dir" -mindepth 2 -maxdepth 3 \
        ! -path "*/runtime/*" \
        ! -path "*/logs/*" \
        ! -path "*/.git/*" \
        ! -path "*/node_modules/*" \
        -type f -mtime 0 2>/dev/null | wc -l)
    
    echo ""
    echo "总计：${CYAN}${total}${NC} 个文件在 24 小时内被修改"
}

# =============================================================================
# 7 天内修改的文件
# =============================================================================
check_recent_files_7d() {
    local project_dir=$1
    
    print_header "7 天内修改的文件（按项目统计）"
    
    print_table_header "项目名称" "修改文件数" "最新修改时间"
    echo "--------------------------------------------------"
    
    find "$project_dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort | while read -r proj_path; do
        proj_name=$(basename "$proj_path")
        
        # 7 天内修改的文件数
        local recent_count=$(find "$proj_path" \
            ! -path "*/runtime/*" \
            ! -path "*/logs/*" \
            ! -path "*/.git/*" \
            ! -path "*/node_modules/*" \
            -type f -mtime -7 2>/dev/null | wc -l)
        
        # 最新修改时间
        local latest_mod=$(find "$proj_path" -type f -printf '%T@\n' 2>/dev/null | sort -rn | head -1 | cut -d'.' -f1)
        if [[ -n "$latest_mod" ]]; then
            latest_date=$(date -d "@${latest_mod%.*}" '+%Y-%m-%d' 2>/dev/null || echo "未知")
        else
            latest_date="未知"
        fi
        
        # 根据修改数显示颜色
        if [[ $recent_count -gt 10 ]]; then
            echo -e "${GREEN}"
        elif [[ $recent_count -gt 0 ]]; then
            echo -e "${YELLOW}"
        fi
        
        print_table_row "$proj_name" "$recent_count" "$latest_date"
        echo -e "${NC}"
    done
}

# =============================================================================
# 代码文件统计
# =============================================================================
check_code_files() {
    local project_dir=$1
    
    print_header "代码文件统计"
    
    print_table_header "文件类型" "文件数" "总行数" "平均行数" "最大文件"
    echo "--------------------------------------------------------------------------------"
    
    # PHP 文件
    local php_count=$(find "$project_dir" -name "*.php" -type f 2>/dev/null | wc -l)
    local php_lines=$(find "$project_dir" -name "*.php" -type f -exec cat {} \; 2>/dev/null | wc -l)
    local php_avg=$((php_lines / (php_count + 1)))
    local php_max=$(find "$project_dir" -name "*.php" -type f -exec wc -l {} \; 2>/dev/null | sort -rn | head -1)
    print_table_row ".php" "$php_count" "$php_lines" "$php_avg" "${php_max:-0}"
    
    # JavaScript 文件
    local js_count=$(find "$project_dir" -name "*.js" -type f 2>/dev/null | wc -l)
    local js_lines=$(find "$project_dir" -name "*.js" -type f -exec cat {} \; 2>/dev/null | wc -l)
    local js_avg=$((js_lines / (js_count + 1)))
    local js_max=$(find "$project_dir" -name "*.js" -type f -exec wc -l {} \; 2>/dev/null | sort -rn | head -1)
    print_table_row ".js" "$js_count" "$js_lines" "$js_avg" "${js_max:-0}"
    
    # Python 文件
    local py_count=$(find "$project_dir" -name "*.py" -type f 2>/dev/null | wc -l)
    local py_lines=$(find "$project_dir" -name "*.py" -type f -exec cat {} \; 2>/dev/null | wc -l)
    local py_avg=$((py_lines / (py_count + 1)))
    local py_max=$(find "$project_dir" -name "*.py" -type f -exec wc -l {} \; 2>/dev/null | sort -rn | head -1)
    print_table_row ".py" "$py_count" "$py_lines" "$py_avg" "${py_max:-0}"
    
    # Java 文件
    local java_count=$(find "$project_dir" -name "*.java" -type f 2>/dev/null | wc -l)
    local java_lines=$(find "$project_dir" -name "*.java" -type f -exec cat {} \; 2>/dev/null | wc -l)
    local java_avg=$((java_lines / (java_count + 1)))
    local java_max=$(find "$project_dir" -name "*.java" -type f -exec wc -l {} \; 2>/dev/null | sort -rn | head -1)
    print_table_row ".java" "$java_count" "$java_lines" "$java_avg" "${java_max:-0}"
    
    # Go 文件
    local go_count=$(find "$project_dir" -name "*.go" -type f 2>/dev/null | wc -l)
    local go_lines=$(find "$project_dir" -name "*.go" -type f -exec cat {} \; 2>/dev/null | wc -l)
    local go_avg=$((go_lines / (go_count + 1)))
    local go_max=$(find "$project_dir" -name "*.go" -type f -exec wc -l {} \; 2>/dev/null | sort -rn | head -1)
    print_table_row ".go" "$go_count" "$go_lines" "$go_avg" "${go_max:-0}"
}

# =============================================================================
# 大文件检测
# =============================================================================
check_large_files() {
    local project_dir=$1
    local size_threshold=${2:-10485760}  # 默认 10MB
    
    print_header "大文件检测（>${size_threshold} 字节）"
    
    find "$project_dir" \
        ! -path "*/logs/*" \
        ! -path "*/.git/*" \
        -type f -size +${size_threshold}c 2>/dev/null | \
        while read -r file; do
        local size=$(stat -c '%s' "$file" 2>/dev/null)
        local size_mb=$(echo "scale=2; $size / 1048576" | bc 2>/dev/null || echo "N/A")
        printf "%-60s %12sB (%s MB)\n" "$file" "$size" "$size_mb"
    done | sort -t' ' -k2 -rn | head -20
    
    local large_count=$(find "$project_dir" \
        ! -path "*/logs/*" \
        ! -path "*/.git/*" \
        -type f -size +${size_threshold}c 2>/dev/null | wc -l)
    
    echo ""
    echo "总计：${CYAN}${large_count}${NC} 个文件大于 ${size_threshold} 字节"
}

# =============================================================================
# 空目录检测
# =============================================================================
check_empty_dirs() {
    local project_dir=$1
    
    print_header "空目录检测"
    
    find "$project_dir" -type d -empty 2>/dev/null | while read -r dir; do
        echo "  - $dir"
    done
    
    local empty_count=$(find "$project_dir" -type d -empty 2>/dev/null | wc -l)
    echo ""
    echo "总计：${CYAN}${empty_count}${NC} 个空目录"
}

# =============================================================================
# 配置文件检测
# =============================================================================
check_config_files() {
    local project_dir=$1
    
    print_header "配置文件检测"
    
    echo "常见配置文件:"
    echo "------------------------------------"
    
    # 查找常见配置文件
    local config_patterns=(
        "config.php"
        "config.json"
        "config.yaml"
        "config.yml"
        ".env"
        ".env.local"
        "settings.py"
        "application.yml"
        "docker-compose.yml"
        "Dockerfile"
        "nginx.conf"
        "apache.conf"
    )
    
    for pattern in "${config_patterns[@]}"; do
        local found=$(find "$project_dir" -name "$pattern" -type f 2>/dev/null)
        if [[ -n "$found" ]]; then
            echo -e "${GREEN}✓${NC} $pattern"
            echo "$found" | head -5 | sed 's/^/    /'
            local count=$(echo "$found" | wc -l)
            [[ $count -gt 5 ]] && echo "    ... 共 $count 个"
            echo ""
        fi
    done
}

# =============================================================================
# 权限检测
# =============================================================================
check_permissions() {
    local project_dir=$1
    
    print_header "权限检测"
    
    # 可执行文件
    echo "可执行文件 (.sh, .py):"
    find "$project_dir" \
        \( -name "*.sh" -o -name "*.py" \) \
        ! -perm /111 \
        -type f 2>/dev/null | head -10 | sed 's/^/  /'
    
    local no_exec_count=$(find "$project_dir" \
        \( -name "*.sh" -o -name "*.py" \) \
        ! -perm /111 \
        -type f 2>/dev/null | wc -l)
    echo "  共 ${no_exec_count} 个脚本缺少执行权限"
    echo ""
    
    # 777 权限文件（危险）
    echo "777 权限文件（危险）:"
    find "$project_dir" -perm 0777 -type f 2>/dev/null | head -10 | sed 's/^/  /'
    
    local dangerous_count=$(find "$project_dir" -perm 0777 -type f 2>/dev/null | wc -l)
    if [[ $dangerous_count -gt 0 ]]; then
        echo -e "  ${RED}警告：${dangerous_count} 个文件权限过于开放${NC}"
    else
        echo "  ${GREEN}未发现 777 权限文件${NC}"
    fi
}

# =============================================================================
# 主程序
# =============================================================================
main() {
    local project_dir="${1:-$DEFAULT_PROJECT_DIR}"
    
    # 检查目录是否存在
    if [[ ! -d "$project_dir" ]]; then
        echo -e "${RED}错误：目录不存在 - $project_dir${NC}"
        echo "用法：$0 [项目目录]"
        echo "示例：$0 /home/wwwroot"
        exit 1
    fi
    
    echo "========================================"
    echo "       项目文件巡检报告"
    echo "========================================"
    echo "检测时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "项目目录：$project_dir"
    echo "========================================"
    
    # 执行所有检测
    project_overview "$project_dir"
    check_recent_files_24h "$project_dir"
    check_recent_files_7d "$project_dir"
    check_code_files "$project_dir"
    check_large_files "$project_dir"
    check_empty_dirs "$project_dir"
    check_config_files "$project_dir"
    check_permissions "$project_dir"
    
    echo ""
    echo "========================================"
    echo "        巡检完成"
    echo "========================================"
    echo "检测时间：$(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================"
}

# 显示帮助
show_help() {
    echo "用法：$0 [项目目录]"
    echo ""
    echo "参数:"
    echo "  项目目录    要检测的项目目录（默认：$DEFAULT_PROJECT_DIR）"
    echo ""
    echo "示例:"
    echo "  $0                  # 检测默认目录"
    echo "  $0 /home/wwwroot    # 检测指定目录"
    echo "  $0 /var/www         # 检测其他目录"
    echo ""
    echo "功能:"
    echo "  - 项目概览统计"
    echo "  - 24/7 天内修改的文件"
    echo "  - 代码文件统计"
    echo "  - 大文件检测"
    echo "  - 空目录检测"
    echo "  - 配置文件检测"
    echo "  - 权限检测"
}

# 执行主程序
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
else
    main "$@"
fi

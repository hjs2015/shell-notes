#!/bin/bash
# ============================================================================
# 脚本名称：01_shell_function_library.sh
# 功能描述：通用 Shell 函数库 - 可复用函数集合、最佳实践、工程化模板
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：函数封装、代码复用、错误处理、日志记录、配置管理
# 使用方法：source shell_function_library.sh
# 依赖命令：bash builtins
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================================================
# 日志函数
# ============================================================================

log_info() {
    echo -e "${GREEN}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $(date '+%Y-%m-%d %H:%M:%S') $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') $*" >&2
}

log_debug() {
    if [ "${DEBUG:-0}" = "1" ]; then
        echo -e "${BLUE}[DEBUG]${NC} $(date '+%Y-%m-%d %H:%M:%S') $*"
    fi
}

# ============================================================================
# 错误处理函数
# ============================================================================

die() {
    log_error "$@"
    exit 1
}

check_command() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        die "命令未找到：$cmd"
    fi
    log_debug "命令检查通过：$cmd"
}

check_root() {
    if [ "$EUID" -ne 0 ]; then
        die "请使用 root 权限运行此脚本"
    fi
    log_debug "root 权限检查通过"
}

# ============================================================================
# 文件操作函数
# ============================================================================

file_exists() {
    local file=$1
    if [ ! -f "$file" ]; then
        log_error "文件不存在：$file"
        return 1
    fi
    log_debug "文件检查通过：$file"
    return 0
}

dir_exists() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        log_error "目录不存在：$dir"
        return 1
    fi
    log_debug "目录检查通过：$dir"
    return 0
}

create_dir() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir" && log_info "创建目录：$dir" || die "创建目录失败：$dir"
    else
        log_debug "目录已存在：$dir"
    fi
}

backup_file() {
    local file=$1
    local backup="${file}.bak.$(date +%Y%m%d_%H%M%S)"
    if [ -f "$file" ]; then
        cp "$file" "$backup" && log_info "备份文件：$backup" || die "备份失败：$file"
    fi
}

# ============================================================================
# 网络检查函数
# ============================================================================

check_port() {
    local host=$1
    local port=$2
    if timeout 2 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
        log_info "端口开放：$host:$port"
        return 0
    else
        log_warn "端口关闭：$host:$port"
        return 1
    fi
}

check_url() {
    local url=$1
    if curl -s --head --request GET "$url" &> /dev/null; then
        log_info "URL 可访问：$url"
        return 0
    else
        log_warn "URL 不可访问：$url"
        return 1
    fi
}

check_internet() {
    if ping -c 1 8.8.8.8 &> /dev/null; then
        log_debug "网络连接正常"
        return 0
    else
        log_warn "网络连接中断"
        return 1
    fi
}

# ============================================================================
# 配置管理函数
# ============================================================================

load_config() {
    local config_file=$1
    if file_exists "$config_file"; then
        source "$config_file"
        log_info "加载配置：$config_file"
    else
        log_warn "配置文件不存在，使用默认值"
    fi
}

get_config() {
    local key=$1
    local default=$2
    local value="${!key:-$default}"
    echo "$value"
}

# ============================================================================
# 进度显示函数
# ============================================================================

show_progress() {
    local current=$1
    local total=$2
    local percent=$((current * 100 / total))
    local filled=$((percent / 5))
    local empty=$((20 - filled))
    
    printf "\r["
    printf "%${filled}s" | tr ' ' '#'
    printf "%${empty}s" | tr ' ' '-'
    printf "] %3d%%" "$percent"
    
    if [ $current -eq $total ]; then
        echo ""
    fi
}

# ============================================================================
# 交互式函数
# ============================================================================

confirm() {
    local message=$1
    local default=${2:-n}
    
    while true; do
        if [ "$default" = "y" ]; then
            read -p "$message [Y/n]: " response
            response=${response:-y}
        else
            read -p "$message [y/N]: " response
            response=${response:-n}
        fi
        
        case $response in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "请输入 Y 或 N" ;;
        esac
    done
}

prompt_input() {
    local prompt=$1
    local default=$2
    local varname=$3
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " value
        value=${value:-$default}
    else
        read -p "$prompt: " value
    fi
    
    eval "$varname='$value'"
}

prompt_password() {
    local prompt=$1
    local varname=$2
    
    read -s -p "$prompt: " password
    echo ""
    eval "$varname='$password'"
}

# ============================================================================
# 系统信息函数
# ============================================================================

get_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif [ -f /etc/redhat-release ]; then
        echo "rhel"
    else
        echo "unknown"
    fi
}

check_disk_space() {
    local path=$1
    local required=$2  # 单位：MB
    
    local available=$(df -m "$path" 2>/dev/null | awk 'NR==2 {print $4}')
    if [ -n "$available" ] && [ "$available" -ge "$required" ]; then
        log_debug "磁盘空间充足：${available}MB >= ${required}MB"
        return 0
    else
        log_error "磁盘空间不足：${available:-0}MB < ${required}MB"
        return 1
    fi
}

check_memory() {
    local required=$2  # 单位：MB
    
    local available=$(free -m | awk 'NR==2 {print $7}')
    if [ -n "$available" ] && [ "$available" -ge "$required" ]; then
        log_debug "内存充足：${available}MB >= ${required}MB"
        return 0
    else
        log_error "内存不足：${available:-0}MB < ${required}MB"
        return 1
    fi
}

# ============================================================================
# 示例用法
# ============================================================================

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "=== Shell 函数库示例 ==="
    echo ""
    
    # 日志示例
    log_info "这是一条信息日志"
    log_warn "这是一条警告日志"
    log_error "这是一条错误日志"
    DEBUG=1 log_debug "这是一条调试日志"
    echo ""
    
    # 检查示例
    check_command bash
    check_command ls
    echo ""
    
    # 网络检查
    check_internet
    echo ""
    
    # 进度条示例
    echo "进度条示例："
    for i in {1..20}; do
        show_progress $i 20
        sleep 0.1
    done
    echo ""
    
    # 系统信息
    echo "操作系统：$(get_os)"
    echo ""
    
    echo "✅ 函数库加载成功！"
fi

#!/bin/bash
# =============================================================================
# 脚本名称：Shell 环境与版本检测脚本
# 难度等级：⭐ 入门
# 所属阶段：阶段 1 - 快速开始（00_quickstart/）
# 知识点：Shell 版本检测、环境变量校验、系统识别、环境排障
# 功能描述：检测当前 Shell 环境，包括解释器版本、操作系统、环境变量等
# 使用方法：bash 04_shell_environment_check.sh
# 输出示例：
#   ========================================
#   Shell 环境检测报告
#   ========================================
#   操作系统：Linux Ubuntu 22.04
#   Shell 类型：bash
#   Shell 版本：5.1.16(1)-release
#   当前用户：root
#   主机名称：server-01
#   工作目录：/root
#   ========================================
# 创建时间：2026-03-20
# 最后更新：2026-03-20
# =============================================================================

# 设置颜色输出（兼容不同终端）
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# =============================================================================
# 函数：打印带颜色的消息
# 参数：$1 - 颜色（RED/GREEN/YELLOW/BLUE）
#       $2 - 消息内容
# =============================================================================
print_color() {
    local color="$1"
    local message="$2"
    echo -e "${!color}${message}${NC}"
}

# =============================================================================
# 函数：打印分隔线
# =============================================================================
print_separator() {
    echo "========================================"
}

# =============================================================================
# 函数：检测操作系统信息
# =============================================================================
detect_os() {
    local os_name=""
    local os_version=""
    
    # 检测操作系统类型
    if [[ -f /etc/os-release ]]; then
        # 现代 Linux 发行版（Ubuntu/Debian/CentOS 等）
        source /etc/os-release
        os_name="$NAME"
        os_version="$VERSION"
    elif [[ -f /etc/redhat-release ]]; then
        # RedHat/CentOS 旧版本
        os_name="RedHat/CentOS"
        os_version=$(cat /etc/redhat-release)
    elif [[ -f /etc/debian_version ]]; then
        # Debian
        os_name="Debian"
        os_version=$(cat /etc/debian_version)
    elif [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        os_name="macOS"
        os_version=$(sw_vers -productVersion)
    else
        # 其他系统
        os_name="$(uname -s)"
        os_version="$(uname -r)"
    fi
    
    echo "${os_name} ${os_version}"
}

# =============================================================================
# 函数：检测 Shell 解释器信息
# =============================================================================
detect_shell() {
    local shell_name=""
    local shell_version=""
    
    # 获取当前 Shell 名称
    shell_name=$(basename "$SHELL")
    
    # 获取 Shell 版本（不同 Shell 有不同参数）
    case "$shell_name" in
        bash)
            shell_version=$("$SHELL" --version | head -n 1)
            ;;
        zsh)
            shell_version=$("$SHELL" --version | head -n 1)
            ;;
        sh|dash)
            # sh/dash 通常不支持 --version
            shell_version="N/A (POSIX sh)"
            ;;
        *)
            shell_version="Unknown"
            ;;
    esac
    
    echo "${shell_name}|${shell_version}"
}

# =============================================================================
# 函数：检查环境变量
# =============================================================================
check_env_variables() {
    local vars=("PATH" "HOME" "USER" "PWD" "LANG" "TERM")
    
    echo ""
    print_color BLUE "【环境变量检查】"
    
    for var in "${vars[@]}"; do
        if [[ -n "${!var}" ]]; then
            print_color GREEN "  ✓ ${var}: ${!var:0:50}"
        else
            print_color YELLOW "  ⚠ ${var}: 未设置"
        fi
    done
}

# =============================================================================
# 函数：检查 Shell 特性支持
# =============================================================================
check_shell_features() {
    echo ""
    print_color BLUE "【Shell 特性支持】"
    
    # 检查是否为 bash
    if [[ "$BASH_VERSION" ]]; then
        print_color GREEN "  ✓ Bash 版本：$BASH_VERSION"
    fi
    
    # 检查是否支持数组
    if (eval 'test -n "${arr[@]}"' 2>/dev/null); then
        print_color GREEN "  ✓ 支持数组"
    else
        print_color YELLOW "  ⚠ 不支持数组"
    fi
    
    # 检查是否支持关联数组（Bash 4.0+）
    if [[ -v BASH_VERSINFO[0] ]] && [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
        print_color GREEN "  ✓ 支持关联数组（Bash 4.0+）"
    else
        print_color YELLOW "  ⚠ 不支持关联数组（需要 Bash 4.0+）"
    fi
    
    # 检查是否支持进程替换
    if [[ -c /dev/fd/0 ]]; then
        print_color GREEN "  ✓ 支持进程替换"
    else
        print_color YELLOW "  ⚠ 不支持进程替换"
    fi
}

# =============================================================================
# 函数：环境兼容性检查
# =============================================================================
check_compatibility() {
    echo ""
    print_color BLUE "【环境兼容性检查】"
    
    # 检查常用命令是否存在
    local commands=("grep" "sed" "awk" "find" "curl" "wget")
    
    for cmd in "${commands[@]}"; do
        if command -v "$cmd" &> /dev/null; then
            print_color GREEN "  ✓ $cmd: 已安装"
        else
            print_color RED "  ✗ $cmd: 未安装（可能影响部分脚本运行）"
        fi
    done
}

# =============================================================================
# 函数：生成环境检测报告
# =============================================================================
generate_report() {
    print_separator
    print_color GREEN "Shell 环境检测报告"
    print_separator
    
    # 操作系统信息
    local os_info=$(detect_os)
    print_color BLUE "【操作系统】"
    echo "  $os_info"
    
    # Shell 信息
    local shell_info=$(detect_shell)
    local shell_name=$(echo "$shell_info" | cut -d'|' -f1)
    local shell_version=$(echo "$shell_info" | cut -d'|' -f2)
    print_color BLUE "【Shell 解释器】"
    echo "  类型：$shell_name"
    echo "  版本：$shell_version"
    echo "  路径：$SHELL"
    
    # 用户信息
    print_color BLUE "【用户信息】"
    echo "  当前用户：$(whoami)"
    echo "  主机名称：$(hostname)"
    echo "  工作目录：$(pwd)"
    echo "  用户 ID：$(id -u)"
    echo "  组 ID：$(id -g)"
    
    # 系统信息
    print_color BLUE "【系统信息】"
    echo "  内核版本：$(uname -r)"
    echo "  架构：$(uname -m)"
    echo "  运行时间：$(uptime -p 2>/dev/null || uptime)"
    
    # 环境变量检查
    check_env_variables
    
    # Shell 特性检查
    check_shell_features
    
    # 兼容性检查
    check_compatibility
    
    print_separator
    print_color GREEN "环境检测完成！"
    print_separator
}

# =============================================================================
# 函数：故障排查建议
# =============================================================================
troubleshooting_tips() {
    echo ""
    print_color YELLOW "【故障排查建议】"
    echo ""
    echo "如果遇到脚本运行问题，请检查以下几点："
    echo ""
    echo "1. Shell 版本兼容性："
    echo "   - 本仓库脚本主要基于 Bash 4.0+ 编写"
    echo "   - 使用 'bash --version' 检查版本"
    echo "   - 如需升级：sudo apt install bash (Ubuntu/Debian)"
    echo ""
    echo "2. 执行权限问题："
    echo "   - 确保脚本有执行权限：chmod +x script.sh"
    echo "   - 或使用 bash script.sh 方式运行"
    echo ""
    echo "3. 环境变量问题："
    echo "   - 检查 PATH 是否包含所需命令"
    echo "   - 检查 HOME、USER 等基础变量"
    echo ""
    echo "4. 编码问题："
    echo "   - 确保脚本为 UTF-8 编码（无 BOM）"
    echo "   - 检查 LANG 环境变量：echo \$LANG"
    echo ""
}

# =============================================================================
# 主程序入口
# =============================================================================
main() {
    # 检查是否传入参数
    case "${1:-}" in
        -h|--help)
            echo "用法：$0 [选项]"
            echo ""
            echo "选项："
            echo "  -h, --help      显示帮助信息"
            echo "  -r, --report    生成完整环境报告（默认）"
            echo "  -t, --tips      显示故障排查建议"
            echo "  -q, --quick     快速检查（仅基本信息）"
            echo ""
            exit 0
            ;;
        -t|--tips)
            troubleshooting_tips
            exit 0
            ;;
        -q|--quick)
            print_separator
            print_color GREEN "快速环境检查"
            print_separator
            echo "操作系统：$(detect_os)"
            local shell_info=$(detect_shell)
            echo "Shell: $(echo "$shell_info" | cut -d'|' -f1) ($(echo "$shell_info" | cut -d'|' -f2))"
            echo "用户：$(whoami)@$(hostname)"
            echo "目录：$(pwd)"
            print_separator
            exit 0
            ;;
        -r|--report|"")
            generate_report
            troubleshooting_tips
            exit 0
            ;;
        *)
            echo "未知选项：$1"
            echo "使用 -h 或 --help 查看帮助"
            exit 1
            ;;
    esac
}

# 执行主程序
main "$@"

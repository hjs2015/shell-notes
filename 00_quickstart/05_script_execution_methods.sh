#!/bin/bash
# =============================================================================
# 脚本名称：脚本执行权限与运行方式详解脚本
# 难度等级：⭐ 入门
# 所属阶段：阶段 1 - 快速开始（00_quickstart/）
# 知识点：执行权限、路径运行、source/exec/bash/sh 执行差异、shebang 规范
# 功能描述：演示 Shell 脚本的各种执行方式及其区别，帮助新手避免常见错误
# 使用方法：bash 05_script_execution_methods.sh
# 输出示例：
#   ========================================
#   脚本执行方式演示
#   ========================================
#   方式 1: bash script.sh（推荐新手使用）
#   方式 2: ./script.sh（需要执行权限）
#   方式 3: source script.sh（在当前 Shell 执行）
#   ...
# 创建时间：2026-03-20
# 最后更新：2026-03-20
# =============================================================================

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_color() {
    local color="$1"
    local message="$2"
    echo -e "${!color}${message}${NC}"
}

# 打印分隔线
print_separator() {
    echo "========================================"
}

# =============================================================================
# 演示 1：检查脚本执行权限
# =============================================================================
demo_permission_check() {
    print_separator
    print_color GREEN "【演示 1】检查脚本执行权限"
    print_separator
    
    # 获取当前脚本路径
    local script_path="$(readlink -f "$0")"
    
    echo "当前脚本路径：$script_path"
    echo ""
    
    # 检查文件权限
    echo "文件权限详情："
    ls -l "$script_path"
    echo ""
    
    # 解析权限
    local perms=$(stat -c "%a" "$script_path" 2>/dev/null || stat -f "%Lp" "$script_path" 2>/dev/null)
    echo "权限数字表示：$perms"
    echo ""
    
    # 检查是否有执行权限
    if [[ -x "$script_path" ]]; then
        print_color GREEN "✓ 当前脚本有执行权限（可以直接 ./script.sh 运行）"
    else
        print_color YELLOW "⚠ 当前脚本没有执行权限（需要使用 bash script.sh 运行）"
        echo ""
        echo "添加执行权限的方法："
        echo "  chmod +x $script_path"
    fi
    echo ""
}

# =============================================================================
# 演示 2：不同执行方式对比
# =============================================================================
demo_execution_methods() {
    print_separator
    print_color GREEN "【演示 2】不同执行方式对比"
    print_separator
    
    # 创建一个测试脚本
    local test_script="/tmp/test_execution_$$"
    cat > "$test_script" << 'EOF'
#!/bin/bash
echo "子脚本执行中..."
echo "当前 Shell PID: $$"
echo "当前 Shell: $SHELL"
echo "脚本路径：$0"
TEST_VAR="我在子脚本中定义"
export EXPORT_VAR="我导出了"
EOF
    
    chmod +x "$test_script"
    
    echo "测试脚本已创建：$test_script"
    echo ""
    
    # 方式 1：bash script.sh
    print_color BLUE "方式 1: bash script.sh"
    echo "命令：bash $test_script"
    echo "特点："
    echo "  - 启动新的 bash 子进程"
    echo "  - 不需要脚本有执行权限"
    echo "  - 使用 bash 解释器执行"
    echo "  - 适合任何 Shell 环境"
    echo "运行结果："
    bash "$test_script"
    echo ""
    
    # 方式 2：./script.sh
    print_color BLUE "方式 2: ./script.sh"
    echo "命令：./$test_script"
    echo "特点："
    echo "  - 需要脚本有执行权限（chmod +x）"
    echo "  - 使用 shebang 指定的解释器"
    echo "  - 在当前目录运行"
    echo "运行结果："
    ./"$test_script"
    echo ""
    
    # 方式 3：source script.sh 或 . script.sh
    print_color BLUE "方式 3: source script.sh（在当前 Shell 执行）"
    echo "命令：source $test_script"
    echo "特点："
    echo "  - 在当前 Shell 进程执行（不创建子进程）"
    echo "  - 可以修改当前 Shell 的环境变量"
    echo "  - 变量在当前 Shell 可用"
    echo "运行结果："
    source "$test_script"
    echo ""
    echo "验证变量是否保留："
    if [[ -n "$TEST_VAR" ]]; then
        print_color GREEN "  ✓ TEST_VAR 已定义：$TEST_VAR"
    else
        print_color YELLOW "  ⚠ TEST_VAR 未定义（说明是在子进程执行）"
    fi
    echo ""
    
    # 方式 4：sh script.sh
    print_color BLUE "方式 4: sh script.sh"
    echo "命令：sh $test_script"
    echo "特点："
    echo "  - 使用 sh 解释器（可能是 dash）"
    echo "  - 可能不支持 bash 特性"
    echo "  - 适合 POSIX 兼容脚本"
    echo "运行结果："
    sh "$test_script"
    echo ""
    
    # 方式 5：exec script.sh
    print_color BLUE "方式 5: exec script.sh（替换当前 Shell）"
    echo "命令：exec $test_script（演示中不实际执行，会替换当前 Shell）"
    echo "特点："
    echo "  - 用脚本替换当前 Shell 进程"
    echo "  - 脚本结束后会退出当前 Shell"
    echo "  - 通常用于启动服务或替换环境"
    echo "警告：⚠️ 不要在交互式 Shell 中随意使用 exec！"
    echo ""
    
    # 清理测试脚本
    rm -f "$test_script"
}

# =============================================================================
# 演示 3：路径运行方式对比
# =============================================================================
demo_path_methods() {
    print_separator
    print_color GREEN "【演示 3】路径运行方式对比"
    print_separator
    
    local script_name="test_script.sh"
    local script_path="/tmp/$script_name"
    
    # 创建测试脚本
    cat > "$script_path" << 'EOF'
#!/bin/bash
echo "脚本执行成功！"
echo "脚本路径：$0"
echo "工作目录：$(pwd)"
EOF
    
    chmod +x "$script_path"
    
    echo "测试脚本：$script_path"
    echo ""
    
    # 方式 1：绝对路径
    print_color BLUE "方式 1: 绝对路径运行"
    echo "命令：$script_path"
    echo "优点：任何目录都可以执行"
    echo "缺点：路径较长"
    echo "运行："
    "$script_path"
    echo ""
    
    # 方式 2：相对路径
    print_color BLUE "方式 2: 相对路径运行"
    echo "命令：./$script_name（在脚本所在目录）"
    echo "优点：路径简短"
    echo "缺点：必须在脚本所在目录"
    echo "运行："
    (cd /tmp && ./"$script_name")
    echo ""
    
    # 方式 3：通过 PATH
    print_color BLUE "方式 3: 通过 PATH 环境变量运行"
    echo "将脚本复制到 PATH 中的目录："
    echo "  cp $script_path /usr/local/bin/"
    echo "  然后可以直接：$script_name"
    echo ""
    
    # 清理
    rm -f "$script_path"
}

# =============================================================================
# 演示 4：shebang 行规范
# =============================================================================
demo_shebang() {
    print_separator
    print_color GREEN "【演示 4】shebang 行规范"
    print_separator
    
    echo "shebang 是脚本第一行的特殊标记，格式：#!解释器路径"
    echo ""
    
    # 创建不同 shebang 的测试脚本
    local scripts=()
    
    # Bash 脚本
    local bash_script="/tmp/test_bash_$$"
    cat > "$bash_script" << 'EOF'
#!/bin/bash
echo "使用 Bash 执行"
echo "BASH_VERSION: $BASH_VERSION"
EOF
    scripts+=("$bash_script:Bash")
    
    # POSIX sh 脚本
    local sh_script="/tmp/test_sh_$$"
    cat > "$sh_script" << 'EOF'
#!/bin/sh
echo "使用 POSIX sh 执行"
echo "Shell: $0"
EOF
    scripts+=("$sh_script:POSIX sh")
    
    # 使用 env（推荐的可移植方式）
    local env_script="/tmp/test_env_$$"
    cat > "$env_script" << 'EOF'
#!/usr/bin/env bash
echo "使用 env 查找 bash"
echo "BASH_VERSION: $BASH_VERSION"
EOF
    scripts+=("$env_script:env bash")
    
    # Python 脚本（展示其他语言）
    local py_script="/tmp/test_py_$$"
    cat > "$py_script" << 'EOF'
#!/usr/bin/env python3
print("使用 Python 执行")
print(f"Python 版本：{__import__('sys').version}")
EOF
    scripts+=("$py_script:Python")
    
    for script_info in "${scripts[@]}"; do
        local script=$(echo "$script_info" | cut -d':' -f1)
        local name=$(echo "$script_info" | cut -d':' -f2)
        chmod +x "$script"
        
        print_color CYAN "$name 脚本："
        echo "shebang: $(head -n1 "$script")"
        echo "运行结果："
        "$script"
        echo ""
        
        rm -f "$script"
    done
    
    echo "shebang 最佳实践："
    echo "  ✓ #!/bin/bash - 明确指定 bash（推荐）"
    echo "  ✓ #!/usr/bin/env bash - 更便携（推荐用于跨平台）"
    echo "  ✓ #!/bin/sh - POSIX 兼容脚本"
    echo "  ✗ #!bash - 错误！需要完整路径"
    echo "  ✗ 没有 shebang - 会用当前 Shell 执行，可能不兼容"
    echo ""
}

# =============================================================================
# 演示 5：常见错误与解决方案
# =============================================================================
demo_common_errors() {
    print_separator
    print_color GREEN "【演示 5】常见错误与解决方案"
    print_separator
    
    echo "错误 1: Permission denied（权限拒绝）"
    echo "  现象：./script.sh 提示 Permission denied"
    echo "  原因：脚本没有执行权限"
    echo "  解决：chmod +x script.sh"
    echo "  或：bash script.sh"
    echo ""
    
    echo "错误 2: command not found（命令未找到）"
    echo "  现象：script.sh 提示 command not found"
    echo "  原因 1：脚本不在 PATH 中，需要用./或完整路径"
    echo "  原因 2：脚本内使用的命令未安装"
    echo "  解决：./script.sh 或安装缺失的命令"
    echo ""
    
    echo "错误 3: bad interpreter（解释器错误）"
    echo "  现象：bash: /path/to/script: /bin/bash^M: bad interpreter"
    echo "  原因：Windows 换行符（CRLF）导致"
    echo "  解决：dos2unix script.sh 或 sed -i 's/\r$//' script.sh"
    echo ""
    
    echo "错误 4: 变量在子 Shell 中丢失"
    echo "  现象：脚本中定义的变量，运行后在当前 Shell 找不到"
    echo "  原因：脚本在子 Shell 执行，变量作用域限制"
    echo "  解决：使用 source script.sh 在当前 Shell 执行"
    echo ""
    
    echo "错误 5: shebang 行不是第一行"
    echo "  现象：脚本有空行或注释在 shebang 之前"
    echo "  原因：shebang 必须是文件的第一行第一列"
    echo "  解决：确保#!/bin/bash 在文件最开头"
    echo ""
}

# =============================================================================
# 演示 6：执行方式选择建议
# =============================================================================
demo_best_practices() {
    print_separator
    print_color GREEN "【演示 6】执行方式选择建议"
    print_separator
    
    echo "场景 1: 开发测试阶段"
    echo "  推荐：bash script.sh"
    echo "  理由：不需要权限，快速测试"
    echo ""
    
    echo "场景 2: 生产环境部署"
    echo "  推荐：./script.sh 或 /path/to/script.sh"
    echo "  理由：使用 shebang 指定的解释器，更规范"
    echo "  前提：chmod +x script.sh"
    echo ""
    
    echo "场景 3: 需要修改当前 Shell 环境"
    echo "  推荐：source script.sh 或 . script.sh"
    echo "  理由：在当前 Shell 执行，变量保留"
    echo "  场景：加载配置文件、设置环境变量"
    echo ""
    
    echo "场景 4: 跨平台脚本"
    echo "  推荐：#!/usr/bin/env bash + ./script.sh"
    echo "  理由：env 会在 PATH 中查找 bash，更便携"
    echo ""
    
    echo "场景 5: 系统服务脚本"
    echo "  推荐：#!/bin/bash + 绝对路径 + exec"
    echo "  理由：明确解释器，避免路径问题"
    echo ""
}

# =============================================================================
# 总结表格
# =============================================================================
print_summary_table() {
    print_separator
    print_color GREEN "执行方式对比总结表"
    print_separator
    
    printf "%-20s %-15s %-15s %-15s\n" "执行方式" "需要权限" "Shell 进程" "适用场景"
    printf "%-20s %-15s %-15s %-15s\n" "--------" "--------" "--------" "--------"
    printf "%-20s %-15s %-15s %-15s\n" "bash script.sh" "否" "子进程" "开发测试"
    printf "%-20s %-15s %-15s %-15s\n" "./script.sh" "是" "子进程" "生产部署"
    printf "%-20s %-15s %-15s %-15s\n" "source script.sh" "否" "当前进程" "加载配置"
    printf "%-20s %-15s %-15s %-15s\n" "sh script.sh" "否" "子进程" "POSIX 脚本"
    printf "%-20s %-15s %-15s %-15s\n" "/path/to/script" "是" "子进程" "系统服务"
    echo ""
}

# =============================================================================
# 主程序入口
# =============================================================================
main() {
    print_separator
    print_color CYAN "脚本执行权限与运行方式详解"
    print_separator
    echo ""
    
    case "${1:-}" in
        -h|--help)
            echo "用法：$0 [选项]"
            echo ""
            echo "选项："
            echo "  -h, --help      显示帮助信息"
            echo "  -a, --all       运行所有演示（默认）"
            echo "  -p, --permission 仅演示权限检查"
            echo "  -e, --execution 仅演示执行方式"
            echo "  -s, --shebang   仅演示 shebang"
            echo "  -E, --errors    仅演示常见错误"
            echo ""
            exit 0
            ;;
        -p|--permission)
            demo_permission_check
            ;;
        -e|--execution)
            demo_execution_methods
            ;;
        -r|--path)
            demo_path_methods
            ;;
        -s|--shebang)
            demo_shebang
            ;;
        -E|--errors)
            demo_common_errors
            ;;
        -b|--best-practices)
            demo_best_practices
            ;;
        -a|--all|"")
            demo_permission_check
            demo_execution_methods
            demo_path_methods
            demo_shebang
            demo_common_errors
            demo_best_practices
            print_summary_table
            ;;
        *)
            echo "未知选项：$1"
            echo "使用 -h 或 --help 查看帮助"
            exit 1
            ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

# 执行主程序
main "$@"

#!/bin/bash
#===============================================================================
# 脚本名称：06_shell_execution_modes.sh
# 功能描述：演示 Shell 脚本的四种执行方式及其区别
# 难度等级：★☆☆☆☆ (初级)
# 知识点：
#   - ./script.sh (子 shell 执行，需要执行权限)
#   - bash script.sh (子 shell 执行，不需要执行权限)
#   - . script.sh (当前 shell 执行，不需要执行权限)
#   - source script.sh (当前 shell 执行，不需要执行权限)
#   - 子 shell 与当前 shell 的区别
#   - 环境变量在不同执行方式下的传递
# 使用方法：
#   chmod +x 06_shell_execution_modes.sh
#   ./06_shell_execution_modes.sh
#   bash 06_shell_execution_modes.sh
#   . 06_shell_execution_modes.sh
#   source 06_shell_execution_modes.sh
# 示例输出：
#   【执行方式 1】./script.sh - 子 shell 执行
#   当前 PID: 12345
#   执行目录：/root/shell-notes/01_basic
#   【执行方式 2】bash script.sh - 子 shell 执行
#   当前 PID: 12346
#   【执行方式 3】. script.sh - 当前 shell 执行
#   当前 PID: 12340 (与终端相同)
#   【执行方式 4】source script.sh - 当前 shell 执行
#   当前 PID: 12340 (与终端相同)
# 参考来源：cnblogs Shell 指南 1.2 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印分隔线
print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

# 打印标题
print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

# 打印信息
print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

# 打印变量
print_var() {
    printf "${YELLOW}%-20s${NC}%s\n" "$1:" "$2"
}

#===============================================================================
# 主函数：演示不同执行方式
#===============================================================================
main() {
    print_separator
    print_title "Shell 脚本执行方式演示"
    print_separator
    
    # 显示当前 shell 信息
    print_info "当前终端信息:"
    print_var "终端 PID" "$$"
    print_var "当前目录" "$(pwd)"
    print_var "脚本路径" "$0"
    print_var "脚本名称" "$(basename $0)"
    echo
    
    # 执行方式 1: ./script.sh
    print_title "执行方式 1: ./script.sh - 子 shell 执行"
    print_info "特点:"
    echo "  - 需要脚本有执行权限 (chmod +x)"
    echo "  - 在新的子 shell 中执行"
    echo "  - 变量修改不影响当前 shell"
    echo "  - 目录切换不影响当前 shell"
    print_var "示例" "./06_shell_execution_modes.sh"
    echo
    
    # 执行方式 2: bash script.sh
    print_title "执行方式 2: bash script.sh - 子 shell 执行"
    print_info "特点:"
    echo "  - 不需要执行权限"
    echo "  - 使用 bash 解释器执行"
    echo "  - 在新的子 shell 中执行"
    echo "  - 变量修改不影响当前 shell"
    print_var "示例" "bash 06_shell_execution_modes.sh"
    echo
    
    # 执行方式 3: . script.sh
    print_title "执行方式 3: . script.sh - 当前 shell 执行"
    print_info "特点:"
    echo "  - 不需要执行权限"
    echo "  - 在当前 shell 中执行 (source 的简写)"
    echo "  - 变量修改会影响当前 shell"
    echo "  - 目录切换会影响当前 shell"
    print_var "示例" ". 06_shell_execution_modes.sh"
    echo
    
    # 执行方式 4: source script.sh
    print_title "执行方式 4: source script.sh - 当前 shell 执行"
    print_info "特点:"
    echo "  - 不需要执行权限"
    echo "  - 在当前 shell 中执行 (. 的完整形式)"
    echo "  - 变量修改会影响当前 shell"
    echo "  - 目录切换会影响当前 shell"
    print_var "示例" "source 06_shell_execution_modes.sh"
    echo
    
    # 对比表格
    print_title "执行方式对比表"
    printf "${YELLOW}%-25s %-15s %-15s %-20s${NC}\n" "执行方式" "需要权限" "Shell 类型" "变量/目录影响"
    printf "%-25s %-15s %-15s %-20s\n" "-------------------------" "---------------" "---------------" "--------------------"
    printf "%-25s %-15s %-15s %-20s\n" "./script.sh" "是" "子 shell" "不影响"
    printf "%-25s %-15s %-15s %-20s\n" "bash script.sh" "否" "子 shell" "不影响"
    printf "%-25s %-15s %-15s %-20s\n" ". script.sh" "否" "当前 shell" "影响"
    printf "%-25s %-15s %-15s %-20s\n" "source script.sh" "否" "当前 shell" "影响"
    echo
    
    # 实际演示
    print_title "实际演示：创建一个测试脚本"
    
    # 创建测试脚本
    cat > /tmp/test_exec.sh << 'EOF'
#!/bin/bash
TEST_VAR="我在子 shell 中定义的变量"
echo "子 shell PID: $$"
echo "TEST_VAR: $TEST_VAR"
cd /tmp
echo "子 shell 目录：$(pwd)"
EOF
    
    chmod +x /tmp/test_exec.sh
    
    print_info "1. 使用 ./test_exec.sh 执行:"
    ./tmp/test_exec.sh 2>/dev/null || echo "  (需要 cd 到 /tmp 目录执行)"
    echo "  返回后目录：$(pwd)"
    echo "  TEST_VAR 是否存在：${TEST_VAR:-不存在}"
    echo
    
    print_info "2. 使用 source /tmp/test_exec.sh 执行:"
    source /tmp/test_exec.sh
    echo "  返回后目录：$(pwd)"
    echo "  TEST_VAR 是否存在：${TEST_VAR:-不存在}"
    echo
    
    # 清理
    rm -f /tmp/test_exec.sh
    
    print_separator
    print_info "演示完成！"
    print_separator
}

# 调用主函数
main "$@"

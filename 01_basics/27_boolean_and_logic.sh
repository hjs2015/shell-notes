#!/bin/bash
#===============================================================================
# 脚本名称：07_boolean_and_logic.sh
# 功能描述：演示 Shell 中的布尔值和逻辑运算符
# 难度等级：★☆☆☆☆ (初级)
# 知识点：
#   - true/false 命令
#   - 逻辑与 (&&) - 前面命令成功才执行后面
#   - 逻辑或 (||) - 前面命令失败才执行后面
#   - 分号 (;) - 无论成功失败都执行
#   - 命令返回值 ($?)
#   - 布尔值在 if 中的应用
# 使用方法：
#   chmod +x 07_boolean_and_logic.sh
#   ./07_boolean_and_logic.sh
# 示例输出：
#   【布尔值演示】
#   true 命令返回值：0 (成功)
#   false 命令返回值：1 (失败)
#   【逻辑运算符演示】
#   命令 1 && 命令 2: 命令 1 成功，执行命令 2
#   命令 1 || 命令 2: 命令 1 失败，执行命令 2
#   命令 1 ; 命令 2: 无论命令 1 成功失败，都执行命令 2
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

# 打印命令结果
print_result() {
    printf "${YELLOW}%-40s${NC} -> 返回值：%s\n" "$1" "$2"
}

#===============================================================================
# 测试 1: 布尔值 true/false
#===============================================================================
test_boolean() {
    print_title "布尔值演示 (true/false)"
    echo
    
    # true 命令
    true
    print_result "true 命令" "$?"
    
    # false 命令
    false
    print_result "false 命令" "$?"
    
    echo
    print_info "说明:"
    echo "  - true: 总是返回 0 (成功)"
    echo "  - false: 总是返回 1 (失败)"
    echo "  - Shell 中：0 表示成功，非 0 表示失败"
    echo "  - 这与常规编程语言相反！"
    echo
}

#===============================================================================
# 测试 2: 逻辑与 (&&)
#===============================================================================
test_logical_and() {
    print_title "逻辑与 (&&) - 前面成功才执行后面"
    echo
    
    # 示例 1: 前面成功
    print_info "示例 1: date && echo '成功'"
    date +%H:%M:%S && echo "✅ 执行了 echo"
    print_result "返回值" "$?"
    echo
    
    # 示例 2: 前面失败
    print_info "示例 2: date111 && echo '不会执行'"
    date111 +%H:%M:%S 2>/dev/null && echo "❌ 这行不会执行"
    print_result "返回值" "$?"
    echo
    
    # 等价写法
    print_info "等价写法:"
    echo "  date && echo '成功'"
    echo "  等价于:"
    echo "  if [ \$(date) ]; then"
    echo "    echo '成功'"
    echo "  fi"
    echo
}

#===============================================================================
# 测试 3: 逻辑或 (||)
#===============================================================================
test_logical_or() {
    print_title "逻辑或 (||) - 前面失败才执行后面"
    echo
    
    # 示例 1: 前面成功
    print_info "示例 1: date || echo '不会执行'"
    date +%H:%M:%S || echo "❌ 这行不会执行"
    print_result "返回值" "$?"
    echo
    
    # 示例 2: 前面失败
    print_info "示例 2: date111 || echo '执行错误处理'"
    date111 +%H:%M:%S 2>/dev/null || echo "✅ 执行了错误处理"
    print_result "返回值" "$?"
    echo
    
    # 实际应用：错误处理
    print_info "实际应用场景:"
    echo "  # 尝试启动服务，失败则记录日志"
    echo "  systemctl start nginx || echo 'Nginx 启动失败' >> /var/log/error.log"
    echo
    echo "  # 检查命令是否存在，不存在则安装"
    echo "  command -v git || yum install -y git"
    echo
}

#===============================================================================
# 测试 4: 分号 (;)
#===============================================================================
test_semicolon() {
    print_title "分号 (;) - 无论成功失败都执行"
    echo
    
    # 示例 1: 前面成功
    print_info "示例 1: date ; echo '总是执行'"
    date +%H:%M:%S ; echo "✅ 执行了 echo"
    print_result "返回值" "$?"
    echo
    
    # 示例 2: 前面失败
    print_info "示例 2: date111 ; echo '还是执行'"
    date111 +%H:%M:%S 2>/dev/null ; echo "✅ 即使前面失败，这行也执行"
    print_result "返回值" "$?"
    echo
    
    # 等价写法
    print_info "等价写法:"
    echo "  date ; echo '总是执行'"
    echo "  等价于:"
    echo "  date"
    echo "  echo '总是执行'"
    echo
}

#===============================================================================
# 测试 5: 组合使用
#===============================================================================
test_combination() {
    print_title "组合使用 && 和 ||"
    echo
    
    # 示例 1: 经典的三段式
    print_info "示例 1: 成功则输出成功，失败则输出失败"
    cat /etc/hosts &>/dev/null && echo "✅ 文件存在" || echo "❌ 文件不存在"
    echo
    
    print_info "示例 2: 测试不存在的文件"
    cat /etc/hosts111 &>/dev/null && echo "✅ 文件存在" || echo "❌ 文件不存在"
    echo
    
    # 示例 2: 多层判断
    print_info "示例 2: 多层条件判断"
    echo "  [ 条件 1 ] && [ 条件 2 ] && echo '都满足' || echo '至少一个不满足'"
    [ -f /etc/hosts ] && [ -r /etc/hosts ] && echo "✅ /etc/hosts 存在且可读" || echo "❌ 条件不满足"
    echo
    
    # 示例 3: 实际应用场景
    print_info "实际应用场景:"
    echo "  # 进入目录并执行命令"
    echo "  cd /path/to/dir && make && make install"
    echo
    echo "  # 下载文件并解压"
    echo "  wget file.tar.gz && tar -xzf file.tar.gz"
    echo
    echo "  # 检查服务状态，失败则重启"
    echo "  systemctl is-active nginx || systemctl restart nginx"
    echo
}

#===============================================================================
# 测试 6: 命令返回值详解
#===============================================================================
test_return_codes() {
    print_title "常见命令返回值"
    echo
    
    printf "${YELLOW}%-30s %-10s %s${NC}\n" "命令/情况" "返回值" "说明"
    printf "%-30s %-10s %s\n" "------------------------------" "----------" "------------------"
    printf "%-30s %-10s %s\n" "成功执行" "0" "成功"
    printf "%-30s %-10s %s\n" "命令不存在" "127" "未找到命令"
    printf "%-30s %-10s %s\n" "命令无执行权限" "126" "权限不足"
    printf "%-30s %-10s %s\n " "Ctrl+C 中断" "130" "被信号中断"
    printf "%-30s %-10s %s\n" "除以零" "1" "算术错误"
    printf "%-30s %-10s %s\n" "命令语法错误" "1-125" "使用错误"
    echo
    
    # 实际测试
    print_info "实际测试:"
    print_result "true" "$(true; echo $?)"
    print_result "false" "$(false; echo $?)"
    print_result "不存在的命令" "$(notexist123 2>/dev/null; echo $?)"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 布尔值和逻辑运算符演示"
    print_separator
    echo
    
    test_boolean
    test_logical_and
    test_logical_or
    test_semicolon
    test_combination
    test_return_codes
    
    print_separator
    print_info "总结:"
    echo "  ✅ && : 与运算，前面成功才执行后面"
    echo "  ✅ || : 或运算，前面失败才执行后面"
    echo "  ✅ ;  : 顺序执行，不管前面成功失败"
    echo "  ✅ 0  : 表示成功 (true)"
    echo "  ✅ 非 0: 表示失败 (false)"
    print_separator
}

# 调用主函数
main "$@"

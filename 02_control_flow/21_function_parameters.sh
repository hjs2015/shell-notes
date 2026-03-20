#!/bin/bash
#===============================================================================
# 脚本名称：02_function_parameters.sh
# 功能描述：演示 Shell 函数参数的高级用法
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - $1-$9 位置参数
#   - ${10} 第十个及以后参数
#   - shift 移动参数
#   - $* vs $@ 区别
#   - 参数默认值
# 使用方法：
#   chmod +x 02_function_parameters.sh
#   ./02_function_parameters.sh
# 参考来源：cnblogs Shell 指南 2.6 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

#===============================================================================
# 示例 1: 位置参数
#===============================================================================
example_positional() {
    print_title "示例 1: 位置参数"
    echo
    echo "示例代码:"
    echo "  func() {"
    echo "    echo \"\$1 \$2 \$3\""
    echo "  }"
    echo "  func \"Hello\" \"World\" \"!\""
    echo
    print_info "演示:"
    func() {
        printf "  %s %s %s\n" "$1" "$2" "$3"
    }
    func "Hello" "World" "!"
    echo
}

#===============================================================================
# 示例 2: 第十个及以后参数
#===============================================================================
example_param10() {
    print_title "示例 2: 第十个及以后参数"
    echo
    echo "注意：\$10 会被解析为 \$1 后跟 0"
    echo "正确：使用 \${10}, \${11}..."
    echo
    echo "示例代码:"
    echo "  func() {"
    echo "    echo \"第 1 个：\$1\""
    echo "    echo \"第 10 个：\${10}\""
    echo "    echo \"第 11 个：\${11}\""
    echo "  }"
    echo
    print_info "演示:"
    func() {
        printf "  第 1 个：%s\n" "$1"
        printf "  第 10 个：%s\n" "${10}"
        printf "  第 11 个：%s\n" "${11}"
    }
    func a b c d e f g h i j k
    echo
}

#===============================================================================
# 示例 3: shift 移动参数
#===============================================================================
example_shift() {
    print_title "示例 3: shift 移动参数"
    echo
    echo "shift 命令：将所有参数向左移动"
    echo "  \$1 被丢弃，\$2 变成 \$1，\$3 变成 \$2..."
    echo
    echo "示例代码:"
    echo "  while [ -n \"\$1\" ]"
    echo "  do"
    echo "    echo \"当前 \$1: \$1\""
    echo "    shift"
    echo "  done"
    echo
    print_info "演示:"
    count=1
    while [ -n "$1" ]
    do
        printf "  当前第 %d 个参数：%s\n" $count "$1"
        shift
        ((count++))
    done
    echo
}

#===============================================================================
# 示例 4: $* vs $@ 区别
#===============================================================================
example_star_at() {
    print_title "示例 4: \$* vs \$@ 区别"
    echo
    echo "关键区别在于双引号内:"
    echo "  \"\$*\"  - 所有参数作为一个单词"
    echo "  \"\$@\"  - 每个参数作为独立单词 (推荐)"
    echo
    echo "示例代码:"
    echo "  func_star() {"
    echo "    for arg in \"\$*\""
    echo "    do"
    echo "      echo \"[\$arg]\""
    echo "    done"
    echo "  }"
    echo
    echo "  func_at() {"
    echo "    for arg in \"\$@\""
    echo "    do"
    echo "      echo \"[\$arg]\""
    echo "    done"
    echo "  }"
    echo
    print_info "演示 \"\$*\":"
    func_star() {
        for arg in "$*"
        do
            printf "  [%s]\n" "$arg"
        done
    }
    func_star "a b" "c d"
    echo
    print_info "演示 \"\$@\":"
    func_at() {
        for arg in "$@"
        do
            printf "  [%s]\n" "$arg"
        done
    }
    func_at "a b" "c d"
    echo
    print_info "结论:"
    echo "  ✅ 遍历参数时用 \"\$@\" (保留空格)"
    echo "  ✅ 打印所有参数时用 \"\$*\""
    echo
}

#===============================================================================
# 示例 5: 参数默认值
#===============================================================================
example_default() {
    print_title "示例 5: 参数默认值"
    echo
    echo "语法：\${1:-default}"
    echo
    echo "示例代码:"
    echo "  greet() {"
    echo "    local name=\${1:-Guest}"
    echo "    echo \"Hello, \$name!\""
    echo "  }"
    echo
    print_info "演示:"
    greet() {
        local name=${1:-Guest}
        printf "  Hello, %s!\n" "$name"
    }
    greet
    greet "黄金生"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 函数参数详解"
    print_separator
    echo
    
    example_positional
    example_param10
    example_shift
    example_star_at
    example_default
    
    print_separator
    print_info "总结:"
    echo "  ✅ \$1-\$9: 位置参数"
    echo "  ✅ \${10}, \${11}...: 第十个及以后参数"
    echo "  ✅ shift: 移动参数"
    echo "  ✅ \"\$*\": 所有参数作为一个单词"
    echo "  ✅ \"\$@\": 每个参数作为独立单词 (推荐)"
    echo "  ✅ \${1:-default}: 参数默认值"
    print_separator
}

# 调用主函数
main "$@"

#!/bin/bash
#===============================================================================
# 脚本名称：03_local_variables.sh
# 功能描述：演示 Shell 函数局部变量的深入用法
# 难度等级：★★★☆☆ (中高级)
# 知识点：
#   - local 关键字作用
#   - 局部变量作用域
#   - 变量遮蔽
#   - 递归中的局部变量
#   - 最佳实践
# 使用方法：
#   chmod +x 03_local_variables.sh
#   ./03_local_variables.sh
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
# 示例 1: local 基本用法
#===============================================================================
example_basic() {
    print_title "示例 1: local 基本用法"
    echo
    echo "示例代码:"
    echo "  my_func() {"
    echo "    local var=\"local value\""
    echo "    echo \"函数内：\$var\""
    echo "  }"
    echo "  var=\"global value\""
    echo "  my_func"
    echo "  echo \"函数外：\$var\""
    echo
    print_info "演示:"
    my_func() {
        local var="local value"
        printf "  函数内：%s\n" "$var"
    }
    var="global value"
    my_func
    printf "  函数外：%s\n" "$var"
    echo
    echo
    print_info "说明:"
    echo "  ✅ local 变量只在函数内有效"
    echo "  ✅ 函数外无法访问局部变量"
    echo "  ✅ 避免污染全局命名空间"
    echo
}

#===============================================================================
# 示例 2: 变量遮蔽
#===============================================================================
example_shadowing() {
    print_title "示例 2: 变量遮蔽 (Shadowing)"
    echo
    echo "当局部变量与全局变量同名时，局部变量会遮蔽全局变量"
    echo
    echo "示例代码:"
    echo "  name=\"Global\""
    echo "  func() {"
    echo "    local name=\"Local\""
    echo "    echo \"函数内：\$name\""
    echo "  }"
    echo "  func"
    echo "  echo \"函数外：\$name\""
    echo
    print_info "演示:"
    name="Global"
    func() {
        local name="Local"
        printf "  函数内：%s\n" "$name"
    }
    func
    printf "  函数外：%s\n" "$name"
    echo
}

#===============================================================================
# 示例 3: 嵌套函数中的局部变量
#===============================================================================
example_nested() {
    print_title "示例 3: 嵌套函数中的局部变量"
    echo
    echo "示例代码:"
    echo "  outer() {"
    echo "    local var=\"outer\""
    echo "    inner() {"
    echo "      local var=\"inner\""
    echo "      echo \"内层：\$var\""
    echo "    }"
    echo "    echo \"外层：\$var\""
    echo "    inner"
    echo "    echo \"外层再次：\$var\""
    echo "  }"
    echo "  outer"
    echo
    print_info "演示:"
    outer() {
        local var="outer"
        inner() {
            local var="inner"
            printf "    内层：%s\n" "$var"
        }
        printf "  外层：%s\n" "$var"
        inner
        printf "  外层再次：%s\n" "$var"
    }
    outer
    echo
}

#===============================================================================
# 示例 4: 递归中的局部变量
#===============================================================================
example_recursive() {
    print_title "示例 4: 递归中的局部变量"
    echo
    echo "示例代码:"
    echo "  factorial() {"
    echo "    local n=\$1"
    echo "    if [ \$n -le 1 ]"
    echo "    then"
    echo "      echo 1"
    echo "    else"
    echo "      local result=\$(( n * \$(factorial \$((n-1))) ))"
    echo "      echo \$result"
    echo "    fi"
    echo "  }"
    echo
    print_info "计算 5!:"
    factorial() {
        local n=$1
        if [ $n -le 1 ]
        then
            echo 1
        else
            local result=$(( n * $(factorial $((n-1))) ))
            echo $result
        fi
    }
    result=$(factorial 5)
    printf "  5! = %d\n" $result
    echo
}

#===============================================================================
# 示例 5: 最佳实践
#===============================================================================
example_best_practices() {
    print_title "示例 5: 最佳实践"
    echo
    print_info "规则 1: 函数内所有变量都用 local"
    echo "  good_func() {"
    echo "    local var1=\"value1\""
    echo "    local var2=\"value2\""
    echo "    local result=\$(( var1 + var2 ))"
    echo "  }"
    echo
    print_info "规则 2: 参数也用 local 接收"
    echo "  process() {"
    echo "    local input=\$1"
    echo "    local option=\${2:-default}"
    echo "  }"
    echo
    print_info "规则 3: 循环变量用 local"
    echo "  process_items() {"
    echo "    local item"
    echo "    for item in \"\$@\""
    echo "    do"
    echo "      echo \"\$item\""
    echo "    done"
    echo "  }"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 函数局部变量深入"
    print_separator
    echo
    
    example_basic
    example_shadowing
    example_nested
    example_recursive
    example_best_practices
    
    print_separator
    print_info "总结:"
    echo "  ✅ local - 声明局部变量"
    echo "  ✅ 局部变量只在函数内有效"
    echo "  ✅ 避免污染全局命名空间"
    echo "  ✅ 支持变量遮蔽"
    echo "  ✅ 递归中每个调用有独立的局部变量"
    echo "  ✅ 最佳实践：函数内所有变量都用 local"
    print_separator
}

main "$@"

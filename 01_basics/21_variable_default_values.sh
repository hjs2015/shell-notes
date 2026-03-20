#!/bin/bash
# =============================================================================
# 脚本名称：变量默认值与参数扩展脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：${VAR:-default}、${VAR:=default}、${VAR:+value}、${VAR:?error}
# 功能描述：演示 Shell 变量默认值和参数扩展的各种用法
# 使用方法：bash 21_variable_default_values.sh
# 创建时间：2026-03-20
# =============================================================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_default_if_unset() {
    print_separator
    print_color GREEN "【演示 1】使用默认值（:-）"
    print_separator
    
    unset VAR
    echo "未设置的变量：\${VAR:-'default'} = '${VAR:-'default'}'"
    
    VAR=""
    echo "空变量：\${VAR:-'default'} = '${VAR:-'default'}'"
    
    VAR="value"
    echo "有值变量：\${VAR:-'default'} = '${VAR:-'default'}'"
    echo ""
}

demo_assign_if_unset() {
    print_separator
    print_color GREEN "【演示 2】赋值并使用（:=）"
    print_separator
    
    unset VAR2
    echo "未设置变量，赋值：\${VAR2:='assigned'} = '${VAR2:='assigned'}'"
    echo "再次访问：VAR2 = '$VAR2'"
    echo ""
}

demo_use_if_set() {
    print_separator
    print_color GREEN "【演示 3】有值则用（:+）"
    print_separator
    
    VAR3="exists"
    echo "有值：\${VAR3:+'has value'} = '${VAR3:+'has value'}'"
    
    unset VAR4
    echo "无值：\${VAR4:+'has value'} = '${VAR4:+'has value'}'"
    echo ""
}

demo_error_if_unset() {
    print_separator
    print_color GREEN "【演示 4】未设置则报错（:?）"
    print_separator
    
    unset REQUIRED
    echo "尝试访问未设置的必需变量："
    echo "\${REQUIRED:?'ERROR: REQUIRED not set'}"
    ${REQUIRED:?'ERROR: REQUIRED not set'} 2>&1 || print_color YELLOW "捕获到错误（预期行为）"
    echo ""
}

demo_string_length() {
    print_separator
    print_color GREEN "【演示 5】字符串长度扩展"
    print_separator
    
    local str="Hello"
    echo "字符串：'$str'"
    echo "长度：\${#str} = ${#str}"
    echo ""
}

demo_substring_expansion() {
    print_separator
    print_color GREEN "【演示 6】子字符串扩展"
    print_separator
    
    local str="Hello World"
    echo "字符串：'$str'"
    echo "从位置 0 取 5 个：\${str:0:5} = '${str:0:5}'"
    echo "从位置 6 到结尾：\${str:6} = '${str:6}'"
    echo ""
}

main() {
    print_separator
    print_color CYAN "变量默认值与参数扩展演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  选项：-d: 默认值 -a: 赋值 -u: 有值则用 -e: 错误 -l: 长度 -s: 子串"; exit 0 ;;
        -d) demo_default_if_unset ;;
        -a) demo_assign_if_unset ;;
        -u) demo_use_if_set ;;
        -e) demo_error_if_unset ;;
        -l) demo_string_length ;;
        -s) demo_substring_expansion ;;
        *) demo_default_if_unset; demo_assign_if_unset; demo_use_if_set; demo_error_if_unset; demo_string_length; demo_substring_expansion ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

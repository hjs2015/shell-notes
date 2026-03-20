#!/bin/bash
# =============================================================================
# 脚本名称：命令输出捕获脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：$()、反引号、重定向、管道
# 功能描述：演示捕获命令输出的各种方法
# 使用方法：bash 26_command_output_capture.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_command_substitution() {
    print_separator
    print_color GREEN "【演示 1】命令替换 $()"
    print_separator
    echo "日期：$(date +%Y-%m-%d)"
    echo "用户：$(whoami)"
    echo "目录：$(pwd)"
    echo ""
}

demo_backticks() {
    print_separator
    print_color GREEN "【演示 2】反引号（旧语法）"
    print_separator
    echo "日期：`date +%Y-%m-%d`"
    echo "注意：不推荐使用，优先使用 $()"
    echo ""
}

demo_nested() {
    print_separator
    print_color GREEN "【演示 3】嵌套命令替换"
    print_separator
    echo "当前目录的父目录：$(basename $(dirname $(pwd)))"
    echo ""
}

main() {
    print_separator; print_color CYAN "命令输出捕获演示"; print_separator
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -c: 命令替换 -b: 反引号 -n: 嵌套"; exit 0 ;;
        -c) demo_command_substitution ;; -b) demo_backticks ;; -n) demo_nested ;;
        *) demo_command_substitution; demo_backticks; demo_nested ;;
    esac
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

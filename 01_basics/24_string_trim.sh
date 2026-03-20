#!/bin/bash
# =============================================================================
# 脚本名称：字符串修剪脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：去除空格、trim、参数扩展、sed
# 功能描述：演示去除字符串首尾空格的方法
# 使用方法：bash 28_string_trim.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_trim_sed() {
    print_separator
    print_color GREEN "【演示 1】sed 修剪"
    print_separator
    local str="  hello world  "
    echo "原始：'$str'"
    local trimmed=$(echo "$str" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    echo "修剪后：'$trimmed'"
    echo ""
}

demo_trim_param() {
    print_separator
    print_color GREEN "【演示 2】参数扩展（需要 extglob）"
    print_separator
    shopt -s extglob
    local str="  hello world  "
    echo "原始：'$str'"
    local trimmed="${str##+([[:space:]])}"
    trimmed="${trimmed%%+([[:space:]])}"
    echo "修剪后：'$trimmed'"
    shopt -u extglob
    echo ""
}

main() {
    print_separator; print_color CYAN "字符串修剪演示"; print_separator
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -s: sed -p: 参数扩展"; exit 0 ;;
        -s) demo_trim_sed ;; -p) demo_trim_param ;;
        *) demo_trim_sed; demo_trim_param ;;
    esac
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

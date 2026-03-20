#!/bin/bash
# =============================================================================
# 脚本名称：大小写转换脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：大小写转换、参数扩展、tr 命令、awk
# 功能描述：演示 Shell 中字符串大小写转换的各种方法
# 使用方法：bash 24_case_conversion.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_bash4() {
    print_separator
    print_color GREEN "【演示 1】Bash 4+ 参数扩展"
    print_separator
    local str="HeLLo WoRLd"
    echo "原始：$str"
    echo "小写：${str,,}"
    echo "大写：${str^^}"
    echo "首字母大写：${str^}"
    echo "首字母小写：${str,}"
    echo ""
}

demo_tr() {
    print_separator
    print_color GREEN "【演示 2】tr 命令"
    print_separator
    local str="Hello World"
    echo "原始：$str"
    echo "小写：$(echo "$str" | tr '[:upper:]' '[:lower:]')"
    echo "大写：$(echo "$str" | tr '[:lower:]' '[:upper:]')"
    echo ""
}

demo_awk() {
    print_separator
    print_color GREEN "【演示 3】awk 命令"
    print_separator
    local str="Hello World"
    echo "原始：$str"
    echo "小写：$(echo "$str" | awk '{print tolower($0)}')"
    echo "大写：$(echo "$str" | awk '{print toupper($0)}')"
    echo ""
}

main() {
    print_separator; print_color CYAN "大小写转换演示"; print_separator
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -b: Bash4 -t: tr -a: awk"; exit 0 ;;
        -b) demo_bash4 ;; -t) demo_tr ;; -a) demo_awk ;;
        *) demo_bash4; demo_tr; demo_awk ;;
    esac
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：变量间接引用脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：${!VAR}、间接引用、动态变量名
# 功能描述：演示 Shell 中间接引用的使用方法
# 使用方法：bash 25_indirect_reference.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_indirect() {
    print_separator
    print_color GREEN "【演示 1】间接引用"
    print_separator
    local var_name="MY_VAR"
    local MY_VAR="Hello from MY_VAR"
    echo "变量名：$var_name"
    echo "间接引用：\${!var_name} = ${!var_name}"
    echo ""
}

demo_dynamic() {
    print_separator
    print_color GREEN "【演示 2】动态变量名"
    print_separator
    for i in 1 2 3; do
        declare "var_$i=Value $i"
    done
    for i in 1 2 3; do
        local var_name="var_$i"
        echo "\$$var_name = ${!var_name}"
    done
    echo ""
}

main() {
    print_separator; print_color CYAN "间接引用演示"; print_separator
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -i: 间接 -d: 动态"; exit 0 ;;
        -i) demo_indirect ;; -d) demo_dynamic ;;
        *) demo_indirect; demo_dynamic ;;
    esac
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

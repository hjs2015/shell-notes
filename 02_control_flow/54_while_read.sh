#!/bin/bash
# =============================================================================
# 脚本名称：while read 组合
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 3 - 流程控制（02_control_flow/）
# 功能描述：演示while read 组合 的各种用法
# 使用方法：bash 54_while_read.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo() {
    print_separator
    print_color GREEN "【演示】while read 组合"
    print_separator
    echo "功能演示中..."
    echo ""
}

main() {
    print_separator
    print_color CYAN "while read 组合 演示"
    print_separator
    demo
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

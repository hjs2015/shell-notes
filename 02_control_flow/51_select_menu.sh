#!/bin/bash
# =============================================================================
# 脚本名称：select 菜单
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 3 - 流程控制（02_control_flow/）
# 功能描述：演示select 菜单 的各种用法
# 使用方法：bash 51_select_menu.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo() {
    print_separator
    print_color GREEN "【演示】select 菜单"
    print_separator
    echo "功能演示中..."
    echo ""
}

main() {
    print_separator
    print_color CYAN "select 菜单 演示"
    print_separator
    demo
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

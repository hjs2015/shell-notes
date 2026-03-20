#!/bin/bash
# =============================================================================
# 脚本名称：环境变量与局部变量脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：export、env、local、变量作用域
# 功能描述：演示环境变量和局部变量的区别
# 使用方法：bash 27_environment_vs_local.sh
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_export() {
    print_separator
    print_color GREEN "【演示 1】export 导出变量"
    print_separator
    local MY_VAR="I am local"
    export EXPORTED_VAR="I am exported"
    echo "局部变量在子进程：$(bash -c 'echo $MY_VAR')"
    echo "导出变量在子进程：$(bash -c 'echo $EXPORTED_VAR')"
    echo ""
}

demo_local() {
    print_separator
    print_color GREEN "【演示 2】local 局部变量"
    print_separator
    test_func() {
        local local_var="local"
        global_var="global"
        echo "函数内：local_var=$local_var, global_var=$global_var"
    }
    test_func
    echo "函数外：global_var=$global_var, local_var=${local_var:-未定义}"
    echo ""
}

main() {
    print_separator; print_color CYAN "环境变量与局部变量演示"; print_separator
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -e: export -l: local"; exit 0 ;;
        -e) demo_export ;; -l) demo_local ;;
        *) demo_export; demo_local ;;
    esac
    print_separator; print_color GREEN "演示完成！"; print_separator
}
main "$@"

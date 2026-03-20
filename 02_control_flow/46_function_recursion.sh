#!/bin/bash
# =============================================================================
# 脚本名称：递归函数详解
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 3 - 流程控制（02_control_flow/）
# 知识点：递归、基线条件、递归调用、栈溢出
# 功能描述：演示 Shell 中递归函数的实现和注意事项
# 使用方法：bash 46_function_recursion.sh
# 创建时间：2026-03-20
# =============================================================================

GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 阶乘递归
factorial() {
    local n=$1
    if [ $n -le 1 ]; then
        echo 1
    else
        echo $((n * $(factorial $((n-1)))))
    fi
}

# 斐波那契数列
fibonacci() {
    local n=$1
    if [ $n -le 1 ]; then
        echo $n
    else
        echo $(( $(fibonacci $((n-1))) + $(fibonacci $((n-2))) ))
    fi
}

# 递归求和
sum_recursive() {
    local n=$1
    if [ $n -le 0 ]; then
        echo 0
    else
        echo $((n + $(sum_recursive $((n-1)))))
    fi
}

demo_factorial() {
    print_separator
    print_color GREEN "【演示 1】阶乘递归"
    print_separator
    for i in 1 3 5 7 10; do
        echo "$i! = $(factorial $i)"
    done
    echo ""
}

demo_fibonacci() {
    print_separator
    print_color GREEN "【演示 2】斐波那契数列"
    print_separator
    echo "前 10 项斐波那契数列："
    for i in $(seq 0 9); do
        echo -n "$(fibonacci $i) "
    done
    echo -e "\n"
}

demo_sum() {
    print_separator
    print_color GREEN "【演示 3】递归求和"
    print_separator
    for n in 10 50 100; do
        echo "1 到 $n 的和 = $(sum_recursive $n)"
    done
    echo ""
}

main() {
    print_separator
    print_color CYAN "递归函数演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -f: 阶乘 -b: 斐波那契 -s: 求和"; exit 0 ;;
        -f) demo_factorial ;; -b) demo_fibonacci ;; -s) demo_sum ;;
        *) demo_factorial; demo_fibonacci; demo_sum ;;
    esac
    
    print_separator; print_color GREEN "演示完成！"; print_separator
}

main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：数组基础操作脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：数组声明、访问、遍历、添加、删除、切片
# 功能描述：演示 Shell 数组的基本操作方法
# 使用方法：bash 22_array_basics.sh
# 创建时间：2026-03-20
# =============================================================================

GREEN='\033[0;32m'
NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_array_declaration() {
    print_separator
    print_color GREEN "【演示 1】数组声明"
    print_separator
    
    # 方法 1：直接声明
    local arr1=(1 2 3 4 5)
    echo "方法 1: arr=(1 2 3 4 5)"
    echo "  结果：${arr1[*]}"
    
    # 方法 2：逐个赋值
    local arr2
    arr2[0]="apple"
    arr2[1]="banana"
    arr2[2]="cherry"
    echo -e "\n方法 2：逐个赋值"
    echo "  结果：${arr2[*]}"
    
    # 方法 3：declare
    declare -a arr3
    arr3=(red green blue)
    echo -e "\n方法 3: declare -a"
    echo "  结果：${arr3[*]}"
    echo ""
}

demo_array_access() {
    print_separator
    print_color GREEN "【演示 2】数组访问"
    print_separator
    
    local fruits=("apple" "banana" "cherry" "date" "elderberry")
    echo "数组：${fruits[*]}"
    echo ""
    
    echo "访问单个元素："
    echo "  第 1 个：\${fruits[0]} = ${fruits[0]}"
    echo "  第 3 个：\${fruits[2]} = ${fruits[2]}"
    echo ""
    
    echo "数组长度：\${#fruits[@]} = ${#fruits[@]}"
    echo ""
    
    echo "所有元素：\${fruits[*]} = ${fruits[*]}"
    echo "所有元素（带引号）：\${fruits[@]} = ${fruits[@]}"
    echo ""
}

demo_array_traverse() {
    print_separator
    print_color GREEN "【演示 3】数组遍历"
    print_separator
    
    local nums=(10 20 30 40 50)
    echo "数组：${nums[*]}"
    echo ""
    
    echo "方法 1：for item in array"
    for item in "${nums[@]}"; do
        echo "  $item"
    done
    echo ""
    
    echo "方法 2：for i in {0..n}"
    for ((i=0; i<${#nums[@]}; i++)); do
        echo "  [$i] = ${nums[$i]}"
    done
    echo ""
}

demo_array_modify() {
    print_separator
    print_color GREEN "【演示 4】数组修改"
    print_separator
    
    local arr=(a b c d)
    echo "原始数组：${arr[*]}"
    
    # 添加元素
    arr+=(e f)
    echo "添加元素后：${arr[*]}"
    
    # 修改元素
    arr[1]=B
    echo "修改 arr[1] 后：${arr[*]}"
    
    # 删除元素
    unset arr[0]
    echo "删除 arr[0] 后：${arr[*]}"
    echo ""
}

demo_array_slice() {
    print_separator
    print_color GREEN "【演示 5】数组切片"
    print_separator
    
    local nums=(1 2 3 4 5 6 7 8 9 10)
    echo "原始数组：${nums[*]}"
    echo ""
    
    echo "切片 \${nums[@]:2:3}（从索引 2 开始取 3 个）："
    echo "  ${nums[@]:2:3}"
    echo ""
    
    echo "切片 \${nums[@]:5}（从索引 5 到结尾）："
    echo "  ${nums[@]:5}"
    echo ""
}

main() {
    print_separator
    print_color CYAN "数组基础操作演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -d: 声明 -a: 访问 -t: 遍历 -m: 修改 -s: 切片"; exit 0 ;;
        -d) demo_array_declaration ;;
        -a) demo_array_access ;;
        -t) demo_array_traverse ;;
        -m) demo_array_modify ;;
        -s) demo_array_slice ;;
        *) demo_array_declaration; demo_array_access; demo_array_traverse; demo_array_modify; demo_array_slice ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

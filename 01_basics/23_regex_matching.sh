#!/bin/bash
# =============================================================================
# 脚本名称：正则表达式匹配脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：=~ 运算符、正则模式、捕获组、BASH_REMATCH
# 功能描述：演示 Shell 中正则表达式匹配的方法
# 使用方法：bash 23_regex_matching.sh
# 创建时间：2026-03-20
# =============================================================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_basic_regex() {
    print_separator
    print_color GREEN "【演示 1】基本正则匹配"
    print_separator
    
    local str="Hello World 123"
    echo "字符串：'$str'"
    echo ""
    
    if [[ $str =~ [0-9]+ ]]; then
        print_color GREEN "  ✓ 包含数字"
    else
        print_color YELLOW "  ✗ 不包含数字"
    fi
    
    if [[ $str =~ ^Hello ]]; then
        print_color GREEN "  ✓ 以 Hello 开头"
    fi
    
    if [[ $str =~ World$ ]]; then
        print_color GREEN "  ✓ 以 World 结尾"
    else
        print_color YELLOW "  ✗ 不以 World 结尾"
    fi
    echo ""
}

demo_email_validation() {
    print_separator
    print_color GREEN "【演示 2】邮箱验证"
    print_separator
    
    local emails=("user@example.com" "invalid.email" "test@domain.co.uk" "bad@")
    
    for email in "${emails[@]}"; do
        if [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
            print_color GREEN "  ✓ $email - 有效"
        else
            print_color YELLOW "  ✗ $email - 无效"
        fi
    done
    echo ""
}

demo_capture_groups() {
    print_separator
    print_color GREEN "【演示 3】捕获组"
    print_separator
    
    local text="Name: Alice, Age: 25"
    echo "文本：'$text'"
    
    if [[ $text =~ Name:\ ([A-Za-z]+),\ Age:\ ([0-9]+) ]]; then
        print_color GREEN "  匹配成功！"
        echo "  完整匹配：${BASH_REMATCH[0]}"
        echo "  第 1 组（姓名）：${BASH_REMATCH[1]}"
        echo "  第 2 组（年龄）：${BASH_REMATCH[2]}"
    else
        print_color YELLOW "  ✗ 匹配失败"
    fi
    echo ""
}

demo_date_validation() {
    print_separator
    print_color GREEN "【演示 4】日期格式验证"
    print_separator
    
    local dates=("2026-03-20" "2026/03/20" "20-03-2026" "invalid")
    
    echo "验证 YYYY-MM-DD 格式："
    for date in "${dates[@]}"; do
        if [[ $date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            print_color GREEN "  ✓ $date - 有效"
        else
            print_color YELLOW "  ✗ $date - 无效"
        fi
    done
    echo ""
}

demo_phone_validation() {
    print_separator
    print_color GREEN "【演示 5】电话号码验证"
    print_separator
    
    local phones=("13800138000" "138-0013-8000" "138 0013 8000" "12345")
    
    echo "验证手机号（11 位数字）："
    for phone in "${phones[@]}"; do
        if [[ $phone =~ ^1[3-9][0-9]{9}$ ]]; then
            print_color GREEN "  ✓ $phone - 有效"
        else
            print_color YELLOW "  ✗ $phone - 无效"
        fi
    done
    echo ""
}

main() {
    print_separator
    print_color CYAN "正则表达式匹配演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -b: 基本 -e: 邮箱 -c: 捕获组 -d: 日期 -p: 电话"; exit 0 ;;
        -b) demo_basic_regex ;;
        -e) demo_email_validation ;;
        -c) demo_capture_groups ;;
        -d) demo_date_validation ;;
        -p) demo_phone_validation ;;
        *) demo_basic_regex; demo_email_validation; demo_capture_groups; demo_date_validation; demo_phone_validation ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

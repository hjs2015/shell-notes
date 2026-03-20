#!/bin/bash
# =============================================================================
# 脚本名称：printf 格式化输出脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：printf 格式说明符、对齐、精度、颜色输出、表格制作
# 功能描述：演示 printf 命令的各种格式化输出技巧
# 使用方法：bash 19_printf_formatting.sh
# 创建时间：2026-03-20
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_basic_printf() {
    print_separator
    print_color GREEN "【演示 1】基本格式化"
    print_separator
    
    printf "字符串：%s\n" "Hello"
    printf "整数：%d\n" 42
    printf "浮点数：%f\n" 3.14159
    printf "浮点数（2 位小数）：%.2f\n" 3.14159
    printf "八进制：%o\n" 64
    printf "十六进制：%x\n" 255
    echo ""
}

demo_alignment() {
    print_separator
    print_color GREEN "【演示 2】对齐输出"
    print_separator
    
    echo "左对齐（%-10s）："
    printf "|%-10s|\n" "apple"
    printf "|%-10s|\n" "banana"
    printf "|%-10s|\n" "cherry"
    echo ""
    
    echo "右对齐（%10s）："
    printf "|%10s|\n" "apple"
    printf "|%10s|\n" "banana"
    printf "|%10s|\n" "cherry"
    echo ""
    
    echo "数字右对齐（%5d）："
    printf "|%5d|\n" 1
    printf "|%5d|\n" 23
    printf "|%5d|\n" 456
    echo ""
}

demo_table() {
    print_separator
    print_color GREEN "【演示 3】制作表格"
    print_separator
    
    printf "%-15s %-10s %-8s\n" "姓名" "年龄" "城市"
    printf "%-15s %-10s %-8s\n" "---------------" "----------" "--------"
    printf "%-15s %-10d %-8s\n" "Alice" 25 "Beijing"
    printf "%-15s %-10d %-8s\n" "Bob" 30 "Shanghai"
    printf "%-15s %-10d %-8s\n" "Charlie" 28 "Shenzhen"
    echo ""
}

demo_escape_chars() {
    print_separator
    print_color GREEN "【演示 4】转义字符"
    print_separator
    
    printf "制表符：Hello\tWorld\n"
    printf "换行：Line1\nLine2\n"
    printf "回车：Hello\rWorld\n"
    printf "反斜杠：Path\\to\\file\n"
    printf "双引号：He said \"Hello\"\n"
    echo ""
}

demo_color_output() {
    print_separator
    print_color GREEN "【演示 5】颜色输出"
    print_separator
    
    printf "${RED}红色文字${NC}\n"
    printf "${GREEN}绿色文字${NC}\n"
    printf "${YELLOW}黄色文字${NC}\n"
    printf "${BLUE}蓝色文字${NC}\n"
    echo ""
}

main() {
    print_separator
    print_color CYAN "printf 格式化输出演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -b: 基本 -a: 对齐 -t: 表格 -e: 转义 -c: 颜色"; exit 0 ;;
        -b) demo_basic_printf ;;
        -a) demo_alignment ;;
        -t) demo_table ;;
        -e) demo_escape_chars ;;
        -c) demo_color_output ;;
        *) demo_basic_printf; demo_alignment; demo_table; demo_escape_chars; demo_color_output ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

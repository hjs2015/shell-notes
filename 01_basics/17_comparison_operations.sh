#!/bin/bash
# =============================================================================
# 脚本名称：比较运算详解脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：数值比较、字符串比较、文件测试、test 命令、[ ]、[[ ]]
# 功能描述：演示 Shell 中各种比较运算的方法和使用场景
# 使用方法：bash 17_comparison_operations.sh
# 创建时间：2026-03-20
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 数值比较
demo_numeric_comparison() {
    print_separator
    print_color GREEN "【演示 1】数值比较"
    print_separator
    
    local a=10
    local b=20
    
    echo "比较：a=$a, b=$b"
    echo ""
    
    echo "等于（-eq）："
    [[ $a -eq $b ]] && print_color GREEN "  ✓ 相等" || print_color RED "  ✗ 不相等"
    
    echo "不等于（-ne）："
    [[ $a -ne $b ]] && print_color GREEN "  ✓ 不相等" || print_color RED "  ✗ 相等"
    
    echo "大于（-gt）："
    [[ $a -gt $b ]] && print_color GREEN "  ✓ a>b" || print_color RED "  ✗ a≤b"
    
    echo "小于（-lt）："
    [[ $a -lt $b ]] && print_color GREEN "  ✓ a<b" || print_color RED "  ✗ a≥b"
    
    echo "大于等于（-ge）："
    [[ $a -ge $b ]] && print_color GREEN "  ✓ a≥b" || print_color RED "  ✗ a<b"
    
    echo "小于等于（-le）："
    [[ $a -le $b ]] && print_color GREEN "  ✓ a≤b" || print_color RED "  ✗ a>b"
    echo ""
}

# 字符串比较
demo_string_comparison() {
    print_separator
    print_color GREEN "【演示 2】字符串比较"
    print_separator
    
    local str1="abc"
    local str2="ABC"
    local str3="abc"
    
    echo "比较：str1='$str1', str2='$str2', str3='$str3'"
    echo ""
    
    echo "等于（==）："
    [[ "$str1" == "$str3" ]] && print_color GREEN "  ✓ str1==str3" || print_color RED "  ✗ str1!=str3"
    [[ "$str1" == "$str2" ]] && print_color GREEN "  ✓ str1==str2" || print_color RED "  ✗ str1!=str2"
    
    echo "不等于（!=）："
    [[ "$str1" != "$str2" ]] && print_color GREEN "  ✓ str1!=str2" || print_color RED "  ✗ str1==str2"
    
    echo "空字符串（-z）："
    local empty=""
    [[ -z "$empty" ]] && print_color GREEN "  ✓ 空字符串" || print_color RED "  ✗ 非空"
    
    echo "非空字符串（-n）："
    [[ -n "$str1" ]] && print_color GREEN "  ✓ 非空" || print_color RED "  ✗ 空"
    echo ""
}

# 文件测试
demo_file_test() {
    print_separator
    print_color GREEN "【演示 3】文件测试"
    print_separator
    
    local file="/etc/passwd"
    local dir="/tmp"
    local nonexistent="/nonexistent"
    
    echo "测试文件：$file"
    [[ -e "$file" ]] && print_color GREEN "  ✓ 存在" || print_color RED "  ✗ 不存在"
    [[ -f "$file" ]] && print_color GREEN "  ✓ 普通文件" || print_color RED "  ✗ 非普通文件"
    [[ -r "$file" ]] && print_color GREEN "  ✓ 可读" || print_color RED "  ✗ 不可读"
    [[ -w "$file" ]] && print_color GREEN "  ✓ 可写" || print_color RED "  ✗ 不可写"
    [[ -x "$file" ]] && print_color GREEN "  ✓ 可执行" || print_color RED "  ✗ 不可执行"
    echo ""
    
    echo "测试目录：$dir"
    [[ -d "$dir" ]] && print_color GREEN "  ✓ 是目录" || print_color RED "  ✗ 非目录"
    echo ""
    
    echo "测试不存在的文件：$nonexistent"
    [[ ! -e "$nonexistent" ]] && print_color GREEN "  ✓ 确实不存在" || print_color RED "  ✗ 存在"
    echo ""
}

# test 命令 vs [ ] vs [[ ]]
demo_test_comparison() {
    print_separator
    print_color GREEN "【演示 4】test/[ ]/[[ ]] 对比"
    print_separator
    
    echo "三种方式等价："
    echo "  test 1 -eq 1"
    test 1 -eq 1 && print_color GREEN "  ✓ 真"
    
    echo "  [ 1 -eq 1 ]"
    [ 1 -eq 1 ] && print_color GREEN "  ✓ 真"
    
    echo "  [[ 1 -eq 1 ]]"
    [[ 1 -eq 1 ]] && print_color GREEN "  ✓ 真"
    echo ""
    
    echo "[[ ]] 的优势（支持模式匹配）："
    local str="hello.txt"
    echo "  str='$str'"
    [[ "$str" == *.txt ]] && print_color GREEN "  ✓ 匹配 *.txt" || print_color RED "  ✗ 不匹配"
    echo ""
}

# 比较运算符总结
print_summary() {
    print_separator
    print_color GREEN "比较运算符总结"
    print_separator
    
    echo "数值比较：-eq, -ne, -gt, -lt, -ge, -le"
    echo "字符串：==, !=, -z, -n"
    echo "文件：-e, -f, -d, -r, -w, -x"
    echo ""
}

main() {
    print_separator
    print_color CYAN "比较运算详解演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -n: 数值 -s: 字符串 -f: 文件 -t: test 对比"; exit 0 ;;
        -n) demo_numeric_comparison ;;
        -s) demo_string_comparison ;;
        -f) demo_file_test ;;
        -t) demo_test_comparison ;;
        *) demo_numeric_comparison; demo_string_comparison; demo_file_test; demo_test_comparison; print_summary ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

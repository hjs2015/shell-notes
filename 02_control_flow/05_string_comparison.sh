#!/bin/bash
#===============================================================================
# 脚本名称：06_string_comparison.sh
# 功能描述：演示 Shell 字符串比较操作
# 难度等级：★☆☆☆☆ (初级)
# 知识点：
#   - = 和 == 字符串相等
#   - != 字符串不相等
#   - -z 字符串长度为 0
#   - -n 字符串长度不为 0
#   - < 和 > 字符串比较 (需要转义)
# 使用方法：
#   chmod +x 06_string_comparison.sh
#   ./06_string_comparison.sh
# 参考来源：cnblogs Shell 指南 2.3 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

print_result() {
    printf "${YELLOW}%-40s${NC} -> %s\n" "$1" "$2"
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 字符串比较"
    print_separator
    echo
    
    str1="hello"
    str2="world"
    str3="hello"
    empty=""
    
    print_title "1. = 和 == 字符串相等"
    print_result "[ \"\$str1\" = \"\$str3\" ]" "$([ "$str1" = "$str3" ] && echo "✅ 相等" || echo "❌ 不相等")"
    print_result "[ \"\$str1\" = \"\$str2\" ]" "$([ "$str1" = "$str2" ] && echo "✅ 相等" || echo "❌ 不相等")"
    echo
    
    print_title "2. != 字符串不相等"
    print_result "[ \"\$str1\" != \"\$str2\" ]" "$([ "$str1" != "$str2" ] && echo "✅ 不相等" || echo "❌ 相等")"
    print_result "[ \"\$str1\" != \"\$str3\" ]" "$([ "$str1" != "$str3" ] && echo "✅ 不相等" || echo "❌ 相等")"
    echo
    
    print_title "3. -z 字符串长度为 0"
    print_result "[ -z \"\$empty\" ]" "$([ -z "$empty" ] && echo "✅ 长度为 0" || echo "❌ 长度不为 0")"
    print_result "[ -z \"\$str1\" ]" "$([ -z "$str1" ] && echo "✅ 长度为 0" || echo "❌ 长度不为 0")"
    echo
    
    print_title "4. -n 字符串长度不为 0"
    print_result "[ -n \"\$str1\" ]" "$([ -n "$str1" ] && echo "✅ 长度不为 0" || echo "❌ 长度为 0")"
    print_result "[ -n \"\$empty\" ]" "$([ -n "$empty" ] && echo "✅ 长度不为 0" || echo "❌ 长度为 0")"
    echo
    
    print_title "5. 重要提示：变量要用引号包围"
    echo "  正确：[ -z \"\$var\" ]"
    echo "  错误：[ -z \$var ]  # 变量为空时会报错"
    echo
    
    print_separator
}

main "$@"

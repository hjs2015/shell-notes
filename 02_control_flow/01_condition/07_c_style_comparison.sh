#!/bin/bash
#===============================================================================
# 脚本名称：07_c_style_comparison.sh
# 功能描述：演示 Shell C 语言风格数值比较
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - (( )) 双括号语法
#   - C 语言风格比较运算符
#   - 算术运算
#   - 自增自减
# 使用方法：
#   chmod +x 07_c_style_comparison.sh
#   ./07_c_style_comparison.sh
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
    printf "${YELLOW}%-35s${NC} -> %s\n" "$1" "$2"
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell C 语言风格数值比较"
    print_separator
    echo
    
    a=10
    b=20
    
    print_title "1. (( )) 双括号语法"
    echo "  语法：(( expression ))"
    echo "  特点：支持 C 语言风格运算符，无需转义"
    echo
    print_info "示例:"
    echo "    a=10, b=20"
    echo
    print_result "(( a < b ))" "$(( a < b )) && echo "✅ 真" || echo "❌ 假")"
    print_result "(( a > b ))" "$(( a > b )) && echo "✅ 真" || echo "❌ 假")"
    print_result "(( a == b ))" "$(( a == b )) && echo "✅ 真" || echo "❌ 假")"
    print_result "(( a != b ))" "$(( a != b )) && echo "✅ 真" || echo "❌ 假")"
    print_result "(( a <= 10 ))" "$(( a <= 10 )) && echo "✅ 真" || echo "❌ 假")"
    print_result "(( b >= 20 ))" "$(( b >= 20 )) && echo "✅ 真" || echo "❌ 假")"
    echo
    
    print_title "2. 比较运算符对比"
    printf "${YELLOW}%-20s %-20s %-20s${NC}\n" "运算符" "传统测试" "C 风格"
    printf "%-20s %-20s %-20s\n" "--------------------" "--------------------" "--------------------"
    printf "%-20s %-20s %-20s\n" "小于" "[ \$a -lt \$b ]" "(( a < b ))"
    printf "%-20s %-20s %-20s\n" "大于" "[ \$a -gt \$b ]" "(( a > b ))"
    printf "%-20s %-20s %-20s\n" "等于" "[ \$a -eq \$b ]" "(( a == b ))"
    printf "%-20s %-20s %-20s\n" "不等于" "[ \$a -ne \$b ]" "(( a != b ))"
    printf "%-20s %-20s %-20s\n" "小于等于" "[ \$a -le \$b ]" "(( a <= b ))"
    printf "%-20s %-20s %-20s\n" "大于等于" "[ \$a -ge \$b ]" "(( a >= b ))"
    echo
    
    print_title "3. 算术运算"
    echo "  示例代码:"
    echo "    (( sum = a + b ))"
    echo "    (( diff = b - a ))"
    echo "    (( prod = a * b ))"
    echo "    (( quot = b / a ))"
    echo "    (( remainder = b % a ))"
    echo
    (( sum = a + b ))
    (( diff = b - a ))
    (( prod = a * b ))
    (( quot = b / a ))
    (( remainder = b % a ))
    print_info "计算结果:"
    printf "  %d + %d = %d\n" $a $b $sum
    printf "  %d - %d = %d\n" $b $a $diff
    printf "  %d * %d = %d\n" $a $b $prod
    printf "  %d / %d = %d\n" $b $a $quot
    printf "  %d %% %d = %d\n" $b $a $remainder
    echo
    
    print_title "4. 自增自减"
    echo "  示例代码:"
    echo "    (( i++ ))  # 后置自增"
    echo "    (( ++i ))  # 前置自增"
    echo "    (( i-- ))  # 后置自减"
    echo "    (( --i ))  # 前置自减"
    echo
    i=5
    echo "  初始值：i = $i"
    (( i++ ))
    echo "  (( i++ )) 后：i = $i"
    (( ++i ))
    echo "  (( ++i )) 后：i = $i"
    (( i-- ))
    echo "  (( i-- )) 后：i = $i"
    (( --i ))
    echo "  (( --i )) 后：i = $i"
    echo
    
    print_title "5. C 风格 for 循环"
    echo "  语法：for (( init; condition; increment ))"
    echo
    echo "  示例代码:"
    echo "    for (( i=0; i<5; i++ ))"
    echo "    do"
    echo "      echo \$i"
    echo "    done"
    echo
    print_info "输出:"
    for (( i=0; i<5; i++ ))
    do
        printf "  %d\n" $i
    done
    echo
    
    print_title "6. 实际应用场景"
    echo "  场景 1: 数值范围判断"
    echo "    age=25"
    echo "    if (( age >= 18 && age <= 60 ))"
    echo "    then"
    echo "      echo \"成年人\""
    echo "    fi"
    echo
    echo "  场景 2: 数组遍历"
    echo "    for (( i=0; i<\${#arr[@]}; i++ ))"
    echo "    do"
    echo "      echo \"\${arr[\$i]}\""
    echo "    done"
    echo
    echo "  场景 3: 复杂条件判断"
    echo "    if (( score >= 90 || (score >= 80 && extra_credit > 5) ))"
    echo "    then"
    echo "      echo \"优秀\""
    echo "    fi"
    echo
    
    print_separator
    print_info "总结:"
    echo "  ✅ (( )) - C 语言风格算术运算"
    echo "  ✅ 支持 < > == != <= >= 运算符"
    echo "  ✅ 支持 + - * / % 算术运算"
    echo "  ✅ 支持 ++ -- 自增自减"
    echo "  ✅ 支持 && || ! 逻辑运算"
    echo "  ✅ 代码更简洁，可读性更好"
    print_separator
}

main "$@"

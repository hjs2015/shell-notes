#!/bin/bash
# =============================================================================
# 脚本名称：算术运算详解脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：expr、$[]、$(())、let、bc、awk、运算优先级、进制转换
# 功能描述：演示 Shell 中各种算术运算方法和技巧
# 使用方法：bash 15_arithmetic_operations.sh
# 输出示例：
#   ========================================
#   算术运算演示
#   ========================================
#   加法：10 + 5 = 15
#   减法：10 - 5 = 5
#   乘法：10 * 5 = 50
#   除法：10 / 5 = 2
#   ...
# 创建时间：2026-03-20
# 最后更新：2026-03-20
# =============================================================================

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() {
    echo -e "${!1}${2}${NC}"
}

print_separator() {
    echo "========================================"
}

# =============================================================================
# 演示 1：基本四则运算
# =============================================================================
demo_basic_arithmetic() {
    print_separator
    print_color GREEN "【演示 1】基本四则运算"
    print_separator
    
    local a=10
    local b=5
    
    echo "操作数：a=$a, b=$b"
    echo ""
    
    # 方法 1：$(())
    echo "方法 1: \$(( )) - 推荐"
    echo "  加法：\$((a + b)) = $((a + b))"
    echo "  减法：\$((a - b)) = $((a - b))"
    echo "  乘法：\$((a * b)) = $((a * b))"
    echo "  除法：\$((a / b)) = $((a / b))"
    echo "  取模：\$((a % b)) = $((a % b))"
    echo "  幂运算：\$((a ** b)) = $((a ** b))"
    echo ""
    
    # 方法 2：$[]
    echo "方法 2: \$[ ] - 已废弃但仍可用"
    echo "  加法：\$[a + b] = $[a + b]"
    echo "  乘法：\$[a * b] = $[a * b]"
    echo ""
    
    # 方法 3：expr
    echo "方法 3: expr（注意空格）"
    echo "  加法：expr a + b = $(expr $a + $b)"
    echo "  乘法：expr a \\* b = $(expr $a \* $b)"
    echo ""
    
    # 方法 4：let
    echo "方法 4: let 命令"
    let result=a+b
    echo "  let result=a+b → result=$result"
    let result=a*b
    echo "  let result=a*b → result=$result"
    echo ""
}

# =============================================================================
# 演示 2：浮点数运算（bc）
# =============================================================================
demo_float_arithmetic() {
    print_separator
    print_color GREEN "【演示 2】浮点数运算（bc）"
    print_separator
    
    local a=10
    local b=3
    
    echo "操作数：a=$a, b=$b"
    echo "注意：Bash 整数除法会舍去小数部分"
    echo ""
    
    # 整数除法
    echo "整数除法：\$((a / b)) = $((a / b))"
    echo ""
    
    # bc 浮点除法
    if command -v bc &> /dev/null; then
        echo "bc 浮点除法："
        echo "  echo \"scale=2; $a / $b\" | bc = $(echo "scale=2; $a / $b" | bc)"
        echo "  echo \"scale=4; $a / $b\" | bc = $(echo "scale=4; $a / $b" | bc)"
        echo ""
        
        # bc 高级运算
        echo "bc 高级运算："
        echo "  平方根：echo \"scale=2; sqrt($a)\" | bc = $(echo "scale=2; sqrt($a)" | bc)"
        echo "  幂运算：echo \"scale=2; $a ^ $b\" | bc = $(echo "scale=2; $a ^ $b" | bc)"
        echo "  正弦：echo \"scale=4; s(1)\" | bc -l = $(echo "scale=4; s(1)" | bc -l)"
        echo ""
    else
        print_color YELLOW "  ⚠ bc 未安装，跳过浮点运算演示"
        echo "  安装方法：sudo apt install bc"
        echo ""
    fi
}

# =============================================================================
# 演示 3：自增自减
# =============================================================================
demo_increment_decrement() {
    print_separator
    print_color GREEN "【演示 3】自增自减"
    print_separator
    
    local i=5
    
    echo "初始值：i=$i"
    echo ""
    
    # 后自增
    echo "后自增：j=\$((i++))"
    local j=$((i++))
    echo "  结果：i=$i, j=$j（先赋值后自增）"
    echo ""
    
    # 前自增
    i=5
    echo "前自增：j=\$((++i))"
    j=$((++i))
    echo "  结果：i=$i, j=$j（先自增后赋值）"
    echo ""
    
    # 后自减
    i=5
    echo "后自减：j=\$((i--))"
    j=$((i--))
    echo "  结果：i=$i, j=$j"
    echo ""
    
    # 前自减
    i=5
    echo "前自减：j=\$((--i))"
    j=$((--i))
    echo "  结果：i=$i, j=$j"
    echo ""
    
    # let 自增
    i=5
    echo "let 自增：let i++"
    let i++
    echo "  结果：i=$i"
    echo ""
}

# =============================================================================
# 演示 4：运算优先级
# =============================================================================
demo_precedence() {
    print_separator
    print_color GREEN "【演示 4】运算优先级"
    print_separator
    
    echo "优先级顺序（从高到低）："
    echo "  1. 括号 ( )"
    echo "  2. 一元运算符 + - ! ~"
    echo "  3. 幂运算 **"
    echo "  4. 乘除取模 * / %"
    echo "  5. 加减 + -"
    echo "  6. 位移 << >>"
    echo "  7. 比较 < > <= >="
    echo "  8. 相等 == !="
    echo "  9. 位与 &"
    echo "  10. 位异或 ^"
    echo "  11. 位或 |"
    echo "  12. 逻辑与 &&"
    echo "  13. 逻辑或 ||"
    echo ""
    
    echo "示例："
    echo "  2 + 3 * 4 = $((2 + 3 * 4))（先乘后加）"
    echo "  (2 + 3) * 4 = $(( (2 + 3) * 4 ))（括号优先）"
    echo "  2 ** 3 ** 2 = $((2 ** 3 ** 2))（右结合：2^(3^2) = 2^9 = 512）"
    echo "  10 / 2 * 5 = $((10 / 2 * 5))（左结合：(10/2)*5 = 25）"
    echo ""
}

# =============================================================================
# 演示 5：进制转换
# =============================================================================
demo_base_conversion() {
    print_separator
    print_color GREEN "【演示 5】进制转换"
    print_separator
    
    # 十进制
    local dec=255
    echo "十进制：$dec"
    
    # 转二进制
    echo "转二进制：$(echo "obase=2; $dec" | bc)"
    
    # 转八进制
    printf "转八进制：%o\n" $dec
    
    # 转十六进制
    printf "转十六进制：%x\n" $dec
    echo ""
    
    # 不同进制输入
    echo "不同进制输入："
    echo "  二进制 1010：$((2#1010))"
    echo "  八进制 077：$((077))"
    echo "  十六进制 0xFF：$((0xFF))"
    echo "  36 进制 0-z：$((36#zz))"
    echo ""
}

# =============================================================================
# 演示 6：位运算
# =============================================================================
demo_bitwise() {
    print_separator
    print_color GREEN "【演示 6】位运算"
    print_separator
    
    local a=12  # 1100
    local b=5   # 0101
    
    echo "操作数：a=$a (二进制：$(echo "obase=2; $a" | bc))"
    echo "         b=$b (二进制：$(echo "obase=2; $b" | bc))"
    echo ""
    
    echo "位与（&）：\$((a & b)) = $((a & b))"
    echo "位或（|）：\$((a | b)) = $((a | b))"
    echo "位异或（^）：\$((a ^ b)) = $((a ^ b))"
    echo "位取反（~）：\$((~a)) = $((~a))"
    echo "左移（<<）：\$((a << 1)) = $((a << 1))"
    echo "右移（>>）：\$((a >> 1)) = $((a >> 1))"
    echo ""
}

# =============================================================================
# 演示 7：随机数生成
# =============================================================================
demo_random() {
    print_separator
    print_color GREEN "【演示 7】随机数生成"
    print_separator
    
    echo "使用 \$RANDOM 生成随机数："
    echo "  随机数（0-32767）：$RANDOM"
    echo "  随机数（0-32767）：$RANDOM"
    echo "  随机数（0-32767）：$RANDOM"
    echo ""
    
    # 指定范围
    echo "指定范围："
    echo "  1-10：\$((RANDOM % 10 + 1)) = $((RANDOM % 10 + 1))"
    echo "  1-100：\$((RANDOM % 100 + 1)) = $((RANDOM % 100 + 1))"
    echo "  0-9：\$((RANDOM % 10)) = $((RANDOM % 10))"
    echo ""
    
    # 设置随机种子
    echo "设置随机种子（可重现）："
    RANDOM=12345
    echo "  RANDOM=12345; echo \$RANDOM → $RANDOM"
    RANDOM=12345
    echo "  RANDOM=12345; echo \$RANDOM → $RANDOM（相同种子相同结果）"
    echo ""
}

# =============================================================================
# 演示 8：实用计算案例
# =============================================================================
demo_practical_cases() {
    print_separator
    print_color GREEN "【演示 8】实用计算案例"
    print_separator
    
    # 计算圆的面积
    local radius=5
    if command -v bc &> /dev/null; then
        local area=$(echo "scale=2; 3.14159 * $radius * $radius" | bc)
        echo "计算圆的面积（半径=$radius）："
        echo "  公式：π × r²"
        echo "  结果：$area"
        echo ""
    fi
    
    # 计算百分比
    local part=25
    local total=100
    if command -v bc &> /dev/null; then
        local percent=$(echo "scale=2; $part * 100 / $total" | bc)
        echo "计算百分比（$part/$total）："
        echo "  结果：${percent}%"
        echo ""
    fi
    
    # 计算阶乘
    local num=5
    local factorial=1
    for ((i=1; i<=num; i++)); do
        factorial=$((factorial * i))
    done
    echo "计算阶乘（$num!）："
    echo "  结果：$factorial"
    echo ""
    
    # 计算等差数列和
    local n=10
    local sum=$((n * (n + 1) / 2))
    echo "计算 1 到 $n 的和："
    echo "  公式：n × (n + 1) / 2"
    echo "  结果：$sum"
    echo ""
}

# =============================================================================
# 总结表格
# =============================================================================
print_summary_table() {
    print_separator
    print_color GREEN "算术运算方法对比"
    print_separator
    
    printf "%-15s %-20s %-15s %-10s\n" "方法" "示例" "优点" "缺点"
    printf "%-15s %-20s %-15s %-10s\n" "----" "----" "----" "----"
    printf "%-15s %-20s %-15s %-10s\n" "\$(( ))" "\$((a+b))" "推荐，支持所有" "仅整数"
    printf "%-15s %-20s %-15s %-10s\n" "let" "let a=b+c" "简洁" "语法严格"
    printf "%-15s %-20s %-15s %-10s\n" "expr" "expr a + b" "POSIX 兼容" "需要空格，慢"
    printf "%-15s %-20s %-15s %-10s\n" "bc" "echo \"a+b\"|bc" "支持浮点" "需要安装"
    printf "%-15s %-20s %-15s %-10s\n" "awk" "awk 'BEGIN{a+b}'" "功能强大" "较重"
    echo ""
}

# =============================================================================
# 主程序入口
# =============================================================================
main() {
    print_separator
    print_color CYAN "算术运算详解演示"
    print_separator
    echo ""
    
    case "${1:-}" in
        -h|--help)
            echo "用法：$0 [选项]"
            echo ""
            echo "选项："
            echo "  -h, --help      显示帮助信息"
            echo "  -a, --all       运行所有演示（默认）"
            echo "  -b, --basic     仅演示基本四则运算"
            echo "  -f, --float     仅演示浮点运算"
            echo "  -i, --increment 仅演示自增自减"
            echo "  -p, --precedence 仅演示优先级"
            echo "  -B, --base      仅演示进制转换"
            echo "  -w, --bitwise   仅演示位运算"
            echo "  -r, --random    仅演示随机数"
            echo "  -c, --cases     仅演示实用案例"
            echo ""
            exit 0
            ;;
        -b|--basic)
            demo_basic_arithmetic
            ;;
        -f|--float)
            demo_float_arithmetic
            ;;
        -i|--increment)
            demo_increment_decrement
            ;;
        -p|--precedence)
            demo_precedence
            ;;
        -B|--base)
            demo_base_conversion
            ;;
        -w|--bitwise)
            demo_bitwise
            ;;
        -r|--random)
            demo_random
            ;;
        -c|--cases)
            demo_practical_cases
            ;;
        -a|--all|"")
            demo_basic_arithmetic
            demo_float_arithmetic
            demo_increment_decrement
            demo_precedence
            demo_base_conversion
            demo_bitwise
            demo_random
            demo_practical_cases
            print_summary_table
            ;;
        *)
            echo "未知选项：$1"
            exit 1
            ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

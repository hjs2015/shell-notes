#!/bin/bash
# =============================================================================
# 脚本：07_arithmetic.sh
# 功能：演示 Shell 数值运算
# 难度：⭐⭐
# 知识点：
#   - expr 命令
#   - let 命令
#   - $[] 和 $(())
#   - bc 命令
#   - 自增自减
# 使用方法：
#   ./07_arithmetic.sh
# =============================================================================

echo "=========================================="
echo "【1】expr 命令（老式）"
echo "=========================================="

a=10
b=3

echo "a=$a, b=$b"
echo ""
echo "加法：expr $a + $b = $(expr $a + $b)"
echo "减法：expr $a - $b = $(expr $a - $b)"
echo "乘法：expr $a \* $b = $(expr $a \* $b)"
echo "除法：expr $a / $b = $(expr $a / $b)"
echo "取模：expr $a % $b = $(expr $a % $b)"

echo ""
echo "⚠️  注意：* 需要转义，数字和符号间要有空格"

echo ""
echo "=========================================="
echo "【2】let 命令"
echo "=========================================="

let x=10
let y=3

echo "x=$x, y=$y"
echo ""
let sum=x+y
echo "加法：x + y = $sum"

let diff=x-y
echo "减法：x - y = $diff"

let prod=x*y
echo "乘法：x * y = $prod"

let quot=x/y
echo "除法：x / y = $quot"

let mod=x%y
echo "取模：x % y = $mod"

echo ""
echo "=========================================="
echo "【3】$[] 和 $(()) （推荐）"
echo "=========================================="

m=10
n=3

echo "m=$m, n=$n"
echo ""
echo "使用 \$[]:"
echo "  加法：$((m + n))"
echo "  乘法：$((m * n))"
echo "  除法：$((m / n))"
echo "  幂运算：$((m ** n))"

echo ""
echo "使用 \$(()) (更推荐):"
echo "  加法：$((m + n))"
echo "  复杂运算：$(( (m + n) * (m - n) ))"

echo ""
echo "=========================================="
echo "【4】自增自减"
echo "=========================================="

count=0

echo "初始值：count=$count"
echo ""
echo "count++ (后自增): $((count++))"
echo "现在 count=$count"

echo ""
echo "++count (前自增): $((++count))"
echo "现在 count=$count"

echo ""
echo "count-- (后自减): $((count--))"
echo "现在 count=$count"

echo ""
echo "--count (前自减): $((--count))"
echo "现在 count=$count"

echo ""
echo "=========================================="
echo "【5】bc 命令（浮点运算）"
echo "=========================================="

echo "整数除法：10 / 3 = $((10 / 3))"
echo "浮点除法：10 / 3 = $(echo "scale=2; 10 / 3" | bc)"

echo ""
echo "幂运算：2^10 = $(echo "2^10" | bc)"
echo "平方根：√16 = $(echo "scale=2; sqrt(16)" | bc)"

echo ""
echo "进制转换："
echo "  十进制 15 转二进制：$(echo "obase=2; 15" | bc)"
echo "  二进制 1111 转十进制：$(echo "ibase=2; 1111" | bc)"

echo ""
echo "=========================================="
echo "【6】比较运算"
echo "=========================================="

a=10
b=20

echo "a=$a, b=$b"
echo ""
echo "数值比较："
[ $a -eq $b ] && echo "a == b" || echo "a != b"
[ $a -lt $b ] && echo "a < b" || echo "a >= b"
[ $a -gt $b ] && echo "a > b" || echo "a <= b"

echo ""
echo "字符串比较："
[ "$a" = "$b" ] && echo "字符串相等" || echo "字符串不等"
[ "$a" != "$b" ] && echo "字符串不等" || echo "字符串相等"

echo ""
echo "=========================================="
echo "【7】实战技巧"
echo "=========================================="

echo "技巧 1：计算百分比"
total=100
used=75
percent=$((used * 100 / total))
echo "使用率：$used / $total = ${percent}%"

echo ""
echo "技巧 2：文件大小转换"
bytes=1048576
if [ $bytes -ge 1073741824 ]; then
    size=$(echo "scale=2; $bytes / 1073741824" | bc)
    unit="GB"
elif [ $bytes -ge 1048576 ]; then
    size=$(echo "scale=2; $bytes / 1048576" | bc)
    unit="MB"
elif [ $bytes -ge 1024 ]; then
    size=$(echo "scale=2; $bytes / 1024" | bc)
    unit="KB"
else
    size=$bytes
    unit="B"
fi
echo "$bytes 字节 = ${size}${unit}"

echo ""
echo "技巧 3：倒计时"
echo "倒计时 3 秒..."
for i in 3 2 1; do
    echo -ne "$i \r"
    sleep 1
done
echo "开始！"

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

#!/bin/bash
# =============================================================================
# 脚本名称：awk 文本分析
# 难度等级：⭐⭐⭐⭐ 进阶
# 所属阶段：阶段 5 - 文本处理
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "awk 演示"; print_separator
echo "name age city" > /tmp/test.txt
echo "Alice 25 Shenzhen" >> /tmp/test.txt
echo "Bob 30 Beijing" >> /tmp/test.txt
echo "打印第 1 列："
awk '{print $1}' /tmp/test.txt
echo -e "\n打印第 2 列>25："
awk '$2>25 {print $1, $2}' /tmp/test.txt
echo -e "\n计算平均年龄："
awk 'NR>1 {sum+=$2; count++} END {print sum/count}' /tmp/test.txt
print_color GREEN "演示完成！"

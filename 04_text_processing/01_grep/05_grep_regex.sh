#!/bin/bash
# =============================================================================
# 脚本名称：grep 文本搜索
# 难度等级：⭐⭐⭐⭐ 进阶
# 所属阶段：阶段 5 - 文本处理
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "grep 演示"; print_separator
echo "apple" > /tmp/test.txt
echo "banana" >> /tmp/test.txt
echo "cherry" >> /tmp/test.txt
echo "搜索 'an'："
grep "an" /tmp/test.txt
echo -e "\n-i 忽略大小写："
grep -i "AN" /tmp/test.txt
echo -e "\n-n 显示行号："
grep -n "a" /tmp/test.txt
echo -e "\n-c 计数："
grep -c "a" /tmp/test.txt
print_color GREEN "演示完成！"

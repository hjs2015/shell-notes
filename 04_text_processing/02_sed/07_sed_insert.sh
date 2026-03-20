#!/bin/bash
# =============================================================================
# 脚本名称：sed 流编辑器
# 难度等级：⭐⭐⭐⭐ 进阶
# 所属阶段：阶段 5 - 文本处理
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "sed 演示"; print_separator
echo "line1" > /tmp/test.txt
echo "line2" >> /tmp/test.txt
echo "line3" >> /tmp/test.txt
echo "原文件："
cat /tmp/test.txt
echo -e "\ns 替换："
sed 's/line/Line/' /tmp/test.txt
echo -e "\n2d 删除第 2 行："
sed '2d' /tmp/test.txt
echo -e "\n-p 打印第 2 行："
sed -n '2p' /tmp/test.txt
print_color GREEN "演示完成！"

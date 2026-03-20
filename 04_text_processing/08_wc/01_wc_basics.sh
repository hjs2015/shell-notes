#!/bin/bash
# =============================================================================
# 脚本名称：01_wc_basics.sh
# 功能描述：wc 命令基础用法 - 统计行数、字数、字节数
# 难度等级：⭐ 入门
# 知识点：
#   - wc -l 统计行数
#   - wc -w 统计单词数
#   - wc -c 统计字节数
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

cat > /tmp/test.txt << 'EOF'
Hello World
This is a test file.
It has three lines.
EOF

print_separator
print_color CYAN "wc 命令基础用法演示"
print_separator

print_color YELLOW "\n【示例 1】统计行数（-l）"
echo "命令：wc -l /tmp/test.txt"
wc -l /tmp/test.txt

print_color YELLOW "\n【示例 2】统计单词数（-w）"
echo "命令：wc -w /tmp/test.txt"
wc -w /tmp/test.txt

print_color YELLOW "\n【示例 3】统计字节数（-c）"
echo "命令：wc -c /tmp/test.txt"
wc -c /tmp/test.txt

print_color YELLOW "\n【示例 4】显示所有统计信息"
echo "命令：wc /tmp/test.txt"
wc /tmp/test.txt

print_color YELLOW "\n【示例 5】实战：统计系统用户数"
echo "命令：wc -l /etc/passwd"
wc -l /etc/passwd

rm -f /tmp/test.txt
print_color GREEN "\n演示完成！"

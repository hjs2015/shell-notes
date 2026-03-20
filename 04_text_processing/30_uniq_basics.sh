#!/bin/bash
# =============================================================================
# 脚本名称：01_uniq_basics.sh
# 功能描述：uniq 命令基础用法 - 去除重复行
# 难度等级：⭐⭐ 初级
# 知识点：
#   - uniq 去重（需先排序）
#   - uniq -c 计数
#   - uniq -d 只显示重复的
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

cat > /tmp/data.txt << 'EOF'
apple
banana
apple
cherry
banana
banana
date
EOF

print_separator
print_color CYAN "uniq 命令基础用法演示"
print_separator

print_color YELLOW "\n【示例 1】去重（必须先排序！）"
echo "命令：sort /tmp/data.txt | uniq"
sort /tmp/data.txt | uniq

print_color YELLOW "\n【示例 2】统计每行出现次数（-c）"
echo "命令：sort /tmp/data.txt | uniq -c"
sort /tmp/data.txt | uniq -c

print_color YELLOW "\n【示例 3】只显示重复的行（-d）"
echo "命令：sort /tmp/data.txt | uniq -d"
sort /tmp/data.txt | uniq -d

print_color YELLOW "\n【示例 4】只显示不重复的行（-u）"
echo "命令：sort /tmp/data.txt | uniq -u"
sort /tmp/data.txt | uniq -u

rm -f /tmp/data.txt
print_color GREEN "\n演示完成！"

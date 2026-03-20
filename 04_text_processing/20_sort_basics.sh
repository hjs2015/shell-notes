#!/bin/bash
# =============================================================================
# 脚本名称：01_sort_basics.sh
# 功能描述：sort 命令基础用法 - 文本排序与整理
# 难度等级：⭐⭐ 初级
# 所属阶段：阶段 5 - 文本处理
# 知识点：
#   - sort 基本排序
#   - sort -r 逆序
#   - sort -n 数字排序
#   - sort -u 去重
# 使用方法：
#   chmod +x 01_sort_basics.sh
#   ./01_sort_basics.sh
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 创建测试数据
cat > /tmp/numbers.txt << 'EOF'
23
5
102
45
8
99
EOF

cat > /tmp/names.txt << 'EOF'
apple
Banana
cherry
Apple
banana
EOF

print_separator
print_color CYAN "sort 命令基础用法演示"
print_separator

# 示例 1：基本字母排序
print_color YELLOW "\n【示例 1】基本字母排序（区分大小写）"
echo "命令：sort /tmp/names.txt"
sort /tmp/names.txt

# 示例 2：忽略大小写排序
print_color YELLOW "\n【示例 2】忽略大小写排序（-f）"
echo "命令：sort -f /tmp/names.txt"
sort -f /tmp/names.txt

# 示例 3：数字排序（重要！）
print_color YELLOW "\n【示例 3】数字排序（-n，否则按字母排序）"
echo "命令：sort -n /tmp/numbers.txt"
sort -n /tmp/numbers.txt

# 示例 4：逆序排序
print_color YELLOW "\n【示例 4】逆序排序（-r）"
echo "命令：sort -rn /tmp/numbers.txt"
sort -rn /tmp/numbers.txt

# 示例 5：去重排序
print_color YELLOW "\n【示例 5】去重排序（-u）"
echo "命令：sort -u /tmp/names.txt"
sort -u /tmp/names.txt

# 清理
rm -f /tmp/numbers.txt /tmp/names.txt

print_color GREEN "\n演示完成！"
print_separator

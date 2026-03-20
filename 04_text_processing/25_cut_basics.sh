#!/bin/bash
# =============================================================================
# 脚本名称：01_cut_basics.sh
# 功能描述：cut 命令基础用法 - 按列提取文本数据
# 难度等级：⭐⭐ 初级
# 所属阶段：阶段 5 - 文本处理
# 知识点：
#   - cut -d 指定分隔符
#   - cut -f 提取字段
#   - cut -c 按字符提取
# 使用方法：
#   chmod +x 01_cut_basics.sh
#   ./01_cut_basics.sh
# =============================================================================

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# 辅助函数
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 创建测试数据
cat > /tmp/students.txt << 'EOF'
张三	85	90	88
李四	92	88	95
王五	78	85	80
赵六	95	92	96
EOF

print_separator
print_color CYAN "cut 命令基础用法演示"
print_separator

# 示例 1：提取第一个字段（姓名）
print_color YELLOW "\n【示例 1】提取第一个字段（姓名）"
echo "命令：cut -f1 /tmp/students.txt"
cut -f1 /tmp/students.txt

# 示例 2：提取第 1 和第 3 个字段（姓名和英语成绩）
print_color YELLOW "\n【示例 2】提取第 1 和第 3 个字段（姓名和英语成绩）"
echo "命令：cut -f1,3 /tmp/students.txt"
cut -f1,3 /tmp/students.txt

# 示例 3：提取第 2 到第 4 个字段
print_color YELLOW "\n【示例 3】提取第 2 到第 4 个字段（所有成绩）"
echo "命令：cut -f2-4 /tmp/students.txt"
cut -f2-4 /tmp/students.txt

# 示例 4：指定分隔符（以冒号分隔）
echo -e "\n张三：85:90:88" > /tmp/students_colon.txt
echo "李四：92:88:95" >> /tmp/students_colon.txt
print_color YELLOW "\n【示例 4】指定冒号为分隔符"
echo "命令：cut -d':' -f1 /tmp/students_colon.txt"
cut -d':' -f1 /tmp/students_colon.txt

# 示例 5：按字符位置提取
print_color YELLOW "\n【示例 5】按字符位置提取（第 1-3 个字符）"
echo "命令：cut -c1-3 /tmp/students.txt"
cut -c1-3 /tmp/students.txt

# 清理测试文件
rm -f /tmp/students.txt /tmp/students_colon.txt

print_color GREEN "\n演示完成！"
print_separator

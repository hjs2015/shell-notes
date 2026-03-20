#!/bin/bash
# =============================================================================
# 脚本名称：02_cut_advanced.sh
# 功能描述：cut 命令进阶用法 - 复杂场景与实战技巧
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 5 - 文本处理
# 知识点：
#   - cut 提取 /etc/passwd 字段
#   - 与其他命令组合使用
#   - 实战场景：日志分析
# 使用方法：
#   chmod +x 02_cut_advanced.sh
#   ./02_cut_advanced.sh
# =============================================================================

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "cut 命令进阶用法演示"
print_separator

# 实战场景 1：提取 /etc/passwd 的用户名和家目录
print_color YELLOW "\n【实战 1】提取系统用户信息"
echo "命令：cut -d: -f1,6 /etc/passwd | head -5"
cut -d: -f1,6 /etc/passwd | head -5

# 实战场景 2：提取用户 UID
print_color YELLOW "\n【实战 2】提取用户 UID（第 3 字段）"
echo "命令：cut -d: -f3 /etc/passwd | head -10"
cut -d: -f3 /etc/passwd | head -10

# 实战场景 3：查看登录 Shell
print_color YELLOW "\n【实战 3】查看用户登录 Shell（第 7 字段）"
echo "命令：cut -d: -f7 /etc/passwd | sort | uniq"
cut -d: -f7 /etc/passwd | sort | uniq

# 实战场景 4：组合使用（提取特定用户信息）
print_color YELLOW "\n【实战 4】组合使用：提取用户名和 Shell"
echo "命令：cut -d: -f1,7 /etc/passwd | grep -E 'bash|sh$' | head -5"
cut -d: -f1,7 /etc/passwd | grep -E 'bash|sh$' | head -5

# 实战场景 5：处理 CSV 文件
cat > /tmp/data.csv << 'EOF'
name,age,city,score
张三，25，北京，85
李四，30，上海，92
王五，28，广州，78
EOF

print_color YELLOW "\n【实战 5】处理 CSV 文件（逗号分隔）"
echo "命令：cut -d',' -f1,3 /tmp/data.csv"
cut -d',' -f1,3 /tmp/data.csv

# 实战场景 6：提取固定宽度字段
print_color YELLOW "\n【实战 6】按字符位置提取（固定宽度）"
echo "命令：cut -c1-10 /tmp/data.csv"
cut -c1-10 /tmp/data.csv

# 清理
rm -f /tmp/data.csv

print_color GREEN "\n演示完成！"
print_separator

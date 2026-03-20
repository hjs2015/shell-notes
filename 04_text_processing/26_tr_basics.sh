#!/bin/bash
# =============================================================================
# 脚本名称：01_tr_basics.sh
# 功能描述：tr 命令基础用法 - 字符转换与删除
# 难度等级：⭐⭐ 初级
# 知识点：
#   - tr 字符替换
#   - tr -d 删除字符
#   - tr -s 压缩重复字符
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "tr 命令基础用法演示"
print_separator

print_color YELLOW "\n【示例 1】小写转大写"
echo "命令：echo 'hello world' | tr 'a-z' 'A-Z'"
echo 'hello world' | tr 'a-z' 'A-Z'

print_color YELLOW "\n【示例 2】删除指定字符"
echo "命令：echo 'hello 123' | tr -d '0-9'"
echo 'hello 123' | tr -d '0-9'

print_color YELLOW "\n【示例 3】压缩重复字符（-s）"
echo "命令：echo 'aaabbbccc' | tr -s 'a-z'"
echo 'aaabbbccc' | tr -s 'a-z'

print_color YELLOW "\n【示例 4】替换空格为换行"
echo "命令：echo 'a b c' | tr ' ' '\n'"
echo 'a b c' | tr ' ' '\n'

print_color GREEN "\n演示完成！"

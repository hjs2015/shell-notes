#!/bin/bash
# =============================================================================
# 脚本名称：01_xargs_basics.sh
# 功能描述：xargs 命令基础用法 - 构建和执行命令
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - xargs 将输入转换为参数
#   - xargs -n 指定参数数量
#   - xargs -I 替换字符串
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "xargs 命令基础用法演示"
print_separator

print_color YELLOW "\n【示例 1】基本用法：将输入转换为参数"
echo "命令：echo 'a b c' | xargs echo"
echo 'a b c' | xargs echo

print_color YELLOW "\n【示例 2】指定每行参数数量（-n）"
echo "命令：echo 'a b c d e' | xargs -n 2 echo"
echo 'a b c d e' | xargs -n 2 echo

print_color YELLOW "\n【示例 3】实战：查找并删除临时文件"
echo "命令：find /tmp -name '*.tmp' | xargs rm -f (演示用，不执行)"
echo "find /tmp -name '*.tmp' | xargs rm -f"

print_color YELLOW "\n【示例 4】实战：批量下载文件"
cat > /tmp/urls.txt << 'EOF'
https://example.com/file1.txt
https://example.com/file2.txt
EOF
echo "命令：cat /tmp/urls.txt | xargs -n 1 echo '下载：'"
cat /tmp/urls.txt | xargs -n 1 echo '下载：'

print_color YELLOW "\n【示例 5】使用替换字符串（-I）"
echo "命令：echo 'file1 file2' | xargs -I {} echo '处理：{}'"
echo 'file1 file2' | xargs -I {} echo '处理：{}'

rm -f /tmp/urls.txt
print_color GREEN "\n演示完成！"

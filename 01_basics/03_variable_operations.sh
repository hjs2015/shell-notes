#!/bin/bash
# =============================================================================
# 脚本：06_variable_operations.sh
# 功能：演示变量的高级操作
# 难度：⭐⭐⭐
# 知识点：
#   - 变量长度 (${#var})
#   - 变量删除 (#, ##, %, %%)
#   - 变量替换
#   - 变量切片
#   - 变量默认值
# 使用方法：
#   ./06_variable_operations.sh
# =============================================================================

echo "=========================================="
echo "【1】变量长度"
echo "=========================================="

url="www.example.com.cn"
echo "变量：url=$url"
echo "长度：${#url}"

echo ""
echo "=========================================="
echo "【2】变量删除（从前往后）"
echo "=========================================="

echo "原始值：$url"
echo ""
echo "\${url#*.}  (最短匹配，删除到第一个.)"
echo "结果：${url#*.}"

echo ""
echo "\${url##*.} (最长匹配，删除到最后一个.)"
echo "结果：${url##*.}"

echo ""
echo "=========================================="
echo "【3】变量删除（从后往前）"
echo "=========================================="

echo "原始值：$url"
echo ""
echo "\${url%.*}  (最短匹配，删除最后一个.及之后)"
echo "结果：${url%.*}"

echo ""
echo "\${url%%.*} (最长匹配，删除第一个.及之后)"
echo "结果：${url%%.*}"

echo ""
echo "=========================================="
echo "【4】变量替换"
echo "=========================================="

text="hello world hello"
echo "原始值：$text"
echo ""
echo "\${text/world/China} (替换第一个)"
echo "结果：${text/world/China}"

echo ""
echo "\${text//world/China} (替换所有)"
echo "结果：${text//world/China}"

echo ""
echo "=========================================="
echo "【5】变量切片"
echo "=========================================="

text="Hello World"
echo "原始值：$text"
echo ""
echo "\${text:0:5}  (从 0 开始，取 5 个字符)"
echo "结果：${text:0:5}"

echo ""
echo "\${text:6}    (从 6 开始到结尾)"
echo "结果：${text:6}"

echo ""
echo "\${text: -5}  (最后 5 个字符，注意空格)"
echo "结果：${text: -5}"

echo ""
echo "=========================================="
echo "【6】变量默认值"
echo "=========================================="

# 未定义变量
unset var1
# 空变量
var2=""
# 有值变量
var3="value"

echo "var1 (未定义): '${var1}'"
echo "var2 (空值):   '${var2}'"
echo "var3 (有值):   '${var3}'"

echo ""
echo "\${var1-default}  (未定义时使用默认值)"
echo "结果：${var1-default}"

echo ""
echo "\${var2-default}  (空值不使用默认值)"
echo "结果：${var2-default}"

echo ""
echo "\${var1:-default} (未定义或空都使用默认值)"
echo "var1: ${var1:-default}"
echo "var2: ${var2:-default}"
echo "var3: ${var3:-default}"

echo ""
echo "=========================================="
echo "【7】实战技巧"
echo "=========================================="

# 技巧 1：提取文件名
filepath="/path/to/file.txt"
echo "技巧 1：提取文件名"
echo "路径：$filepath"
echo "文件名：${filepath##*/}"
echo "目录：${filepath%/*}"

echo ""
echo "技巧 2：提取扩展名"
filename="backup.tar.gz"
echo "文件：$filename"
echo "扩展名：${filename##*.}"
echo "主名：${filename%.*}"

echo ""
echo "技巧 3：设置默认配置"
config_port="${PORT:-8080}"
echo "端口配置：$config_port (如果 PORT 未设置则为 8080)"

echo ""
echo "技巧 4：检查变量是否为空"
check_var="${1:?错误：需要传入参数}"
echo "✅ 参数已传入：$check_var"

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

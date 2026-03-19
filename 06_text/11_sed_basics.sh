#!/bin/bash
# =============================================================================
# 脚本：11_sed_basics.sh
# 功能：演示 sed 流编辑器
# 难度：⭐⭐⭐
# 知识点：
#   - sed 基础语法
#   - 替换操作
#   - 删除操作
#   - 插入和追加
#   - 打印特定行
# 使用方法：
#   ./11_sed_basics.sh
# =============================================================================

echo "=========================================="
echo "【1】sed 基础"
echo "=========================================="

echo "sed 是 Stream EDitor（流编辑器）"
echo "主要用于文本替换、删除、插入等操作"
echo ""
echo "基本语法：sed [选项] '命令' 文件"

echo ""
echo "=========================================="
echo "【2】创建测试文件"
echo "=========================================="

cat > /tmp/sed_test.txt << 'EOF'
apple
banana
orange
grape
banana
pear
banana
EOF

echo "测试文件内容："
cat -n /tmp/sed_test.txt

echo ""
echo "=========================================="
echo "【3】替换操作"
echo "=========================================="

echo "示例 1：替换第一个 banana"
echo "命令：sed 's/banana/🍌/' /tmp/sed_test.txt"
sed 's/banana/🍌/' /tmp/sed_test.txt

echo ""
echo "示例 2：替换所有 banana"
echo "命令：sed 's/banana/🍌/g' /tmp/sed_test.txt"
sed 's/banana/🍌/g' /tmp/sed_test.txt

echo ""
echo "示例 3：替换第 2 个 banana"
echo "命令：sed 's/banana/🍌/2' /tmp/sed_test.txt"
sed 's/banana/🍌/2' /tmp/sed_test.txt

echo ""
echo "=========================================="
echo "【4】删除操作"
echo "=========================================="

echo "示例 4：删除包含 banana 的行"
echo "命令：sed '/banana/d' /tmp/sed_test.txt"
sed '/banana/d' /tmp/sed_test.txt

echo ""
echo "示例 5：删除第 3 行"
echo "命令：sed '3d' /tmp/sed_test.txt"
sed '3d' /tmp/sed_test.txt

echo ""
echo "示例 6：删除第 2 到 4 行"
echo "命令：sed '2,4d' /tmp/sed_test.txt"
sed '2,4d' /tmp/sed_test.txt

echo ""
echo "=========================================="
echo "【5】插入和追加"
echo "=========================================="

echo "示例 7：在第 3 行前插入"
echo "命令：sed '3i\\NEW LINE' /tmp/sed_test.txt"
sed '3i\NEW LINE' /tmp/sed_test.txt

echo ""
echo "示例 8：在第 3 行后追加"
echo "命令：sed '3a\\AFTER LINE' /tmp/sed_test.txt"
sed '3a\AFTER LINE' /tmp/sed_test.txt

echo ""
echo "=========================================="
echo "【6】打印操作"
echo "=========================================="

echo "示例 9：打印第 3 行"
echo "命令：sed -n '3p' /tmp/sed_test.txt"
sed -n '3p' /tmp/sed_test.txt

echo ""
echo "示例 10：打印第 2 到 4 行"
echo "命令：sed -n '2,4p' /tmp/sed_test.txt"
sed -n '2,4p' /tmp/sed_test.txt

echo ""
echo "示例 11：打印包含 grape 的行"
echo "命令：sed -n '/grape/p' /tmp/sed_test.txt"
sed -n '/grape/p' /tmp/sed_test.txt

echo ""
echo "=========================================="
echo "【7】实战技巧"
echo "=========================================="

echo "技巧 1：删除空行"
echo -e "line1\n\nline2\n\nline3" | sed '/^$/d'

echo ""
echo "技巧 2：删除行首空格"
echo "  indented  text" | sed 's/^[ \t]*//'

echo ""
echo "技巧 3：删除行尾空格"
echo "text with spaces  " | sed 's/[ \t]*$//'

echo ""
echo "技巧 4：提取 IP 地址"
echo "IP: 192.168.1.100, Port: 8080" | \
    sed -n 's/.*IP: \([0-9.]*\).*/\1/p'

echo ""
echo "技巧 5：多替换组合"
echo "hello world hello" | \
    sed -e 's/hello/hi/g' -e 's/world/universe/g'

echo ""
echo "技巧 6：原地编辑（谨慎使用）"
echo "⚠️  sed -i 's/old/new/g' file.txt"
echo "   会直接修改原文件！"

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
rm -f /tmp/sed_test.txt 2>/dev/null

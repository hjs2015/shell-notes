#!/bin/bash
# =============================================================================
# 脚本：10_regex.sh
# 功能：演示正则表达式
# 难度：⭐⭐⭐
# 知识点：
#   - 基础正则表达式
#   - 扩展正则表达式
#   - grep 使用正则
#   - 常见匹配模式
# 使用方法：
#   ./10_regex.sh
# =============================================================================

echo "=========================================="
echo "【1】基础正则表达式字符"
echo "=========================================="

echo "^  - 行首"
echo "\$  - 行尾"
echo ".  - 任意单个字符"
echo "*  - 前一个字符 0 次或多次"
echo "+  - 前一个字符 1 次或多次"
echo "?  - 前一个字符 0 次或 1 次"
echo "[] - 字符集合"
echo "[^] - 字符取反"
echo "\\  - 转义字符"

echo ""
echo "=========================================="
echo "【2】扩展正则表达式"
echo "=========================================="

echo "()  - 分组"
echo "{}  - 重复次数"
echo "|  - 或"
echo "\d  - 数字"
echo "\w  - 单词字符"
echo "\s  - 空白字符"

echo ""
echo "=========================================="
echo "【3】grep 实战"
echo "=========================================="

# 创建测试文件
cat > /tmp/regex_test.txt << 'EOF'
apple
banana
orange
123
abc123
test@email.com
http://example.com
https://github.com
ERROR: something wrong
WARN: be careful
INFO: all good
EOF

echo "测试文件内容："
cat /tmp/regex_test.txt

echo ""
echo "示例 1：匹配包含数字的行"
echo "命令：grep '[0-9]' /tmp/regex_test.txt"
grep '[0-9]' /tmp/regex_test.txt

echo ""
echo "示例 2：匹配以 http 开头的行"
echo "命令：grep '^http' /tmp/regex_test.txt"
grep '^http' /tmp/regex_test.txt

echo ""
echo "示例 3：匹配 .com 结尾的行"
echo "命令：grep '\.com$' /tmp/regex_test.txt"
grep '\.com$' /tmp/regex_test.txt

echo ""
echo "示例 4：匹配 email 格式"
echo "命令：grep '[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]' /tmp/regex_test.txt"
grep '[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]' /tmp/regex_test.txt

echo ""
echo "示例 5：匹配 ERROR 或 WARN"
echo "命令：grep -E 'ERROR|WARN' /tmp/regex_test.txt"
grep -E 'ERROR|WARN' /tmp/regex_test.txt

echo ""
echo "示例 6：不匹配（反向）"
echo "命令：grep -v 'INFO' /tmp/regex_test.txt"
grep -v 'INFO' /tmp/regex_test.txt

echo ""
echo "=========================================="
echo "【4】常见匹配模式"
echo "=========================================="

echo "匹配 IP 地址："
echo '192.168.1.1' | grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}'

echo ""
echo "匹配日期 (YYYY-MM-DD)："
echo '2024-03-19' | grep -E '[0-9]{4}-[0-9]{2}-[0-9]{2}'

echo ""
echo "匹配手机号："
echo '13812345678' | grep -E '1[3-9][0-9]{9}'

echo ""
echo "匹配 URL："
echo 'https://example.com/path' | grep -E 'https?://[a-zA-Z0-9./-]+'

echo ""
echo "=========================================="
echo "【5】实战技巧"
echo "=========================================="

echo "技巧 1：提取 IP 地址"
echo "从日志中提取 IP："
echo "192.168.1.1 - - [19/Mar/2024] GET /index.html" | \
    grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}'

echo ""
echo "技巧 2：统计错误数量"
echo "日志文件中的 ERROR 数量："
echo -e "INFO: ok\nERROR: fail\nERROR: crash\nWARN: slow" | \
    grep -c "ERROR"

echo ""
echo "技巧 3：匹配空行"
echo "统计空行数："
echo -e "line1\n\nline2\n\n\nline3" | grep -c '^$'

echo ""
echo "技巧 4：匹配特定长度"
echo "匹配 3 位数字："
echo -e "12\n123\n1234" | grep -E '^[0-9]{3}$'

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
rm -f /tmp/regex_test.txt 2>/dev/null

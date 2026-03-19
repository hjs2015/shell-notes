#!/bin/bash
# =============================================================================
# 脚本：04_redirection_and_pipe.sh
# 功能：演示重定向和管道
# 难度：⭐⭐⭐
# 知识点：
#   - 标准输入/输出/错误 (0, 1, 2)
#   - 重定向符号 (>, >>, <, 2>, 2>&1, &>)
#   - 管道 (|)
#   - tee 命令
#   - here document (<<)
# 使用方法：
#   ./04_redirection_and_pipe.sh
# =============================================================================

echo "=========================================="
echo "【1】文件描述符"
echo "=========================================="

echo "标准文件描述符："
echo "  0 - stdin  (标准输入)"
echo "  1 - stdout (标准输出)"
echo "  2 - stderr (标准错误)"

echo ""
ls -l /dev/std* 2>/dev/null | head -3

echo ""
echo "=========================================="
echo "【2】输出重定向"
echo "=========================================="

# 覆盖重定向
echo "示例 1：> 覆盖重定向"
echo "第一行" > /tmp/test_redirect.txt
echo "✅ 写入文件"
cat /tmp/test_redirect.txt

echo ""
echo "第二行（覆盖）" > /tmp/test_redirect.txt
echo "✅ 再次写入（覆盖）"
cat /tmp/test_redirect.txt

# 追加重定向
echo ""
echo "示例 2：>> 追加重定向"
echo "第一行" >> /tmp/test_redirect.txt
echo "✅ 追加内容"
cat /tmp/test_redirect.txt

echo ""
echo "=========================================="
echo "【3】错误重定向"
echo "=========================================="

echo "示例 3：2> 错误重定向"
echo "正常输出到屏幕，错误到文件"
ls /tmp 2>/tmp/redirect_error.txt
echo "✅ 正常输出"
cat /tmp/redirect_error.txt 2>/dev/null || echo "(无错误)"

echo ""
echo "示例 4：2>&1 混合输出"
echo "正常输出和错误都到同一个地方"
ls /tmp /nonexistent 2>&1 | grep -E "(tmp|cannot)" | head -3

echo ""
echo "示例 5：&> 混合重定向"
echo "所有输出到文件"
&> /tmp/redirect_all.txt
echo "✅ 所有输出已重定向"
cat /tmp/redirect_all.txt

echo ""
echo "=========================================="
echo "【4】输入重定向"
echo "=========================================="

echo "示例 6：< 输入重定向"
echo "文件内容："
cat < /etc/hosts | head -3

echo ""
echo "示例 7：here document (<<)"
cat << EOF
这是 here document 示例
可以写多行内容
直到遇到 EOF 标记
EOF

echo ""
echo "示例 8：here string (<<<)"
read line <<< "Hello World"
echo "读取的内容：$line"

echo ""
echo "=========================================="
echo "【5】管道"
echo "=========================================="

echo "示例 9：单管道"
echo "命令：ps aux | grep bash | head -3"
ps aux | grep bash | head -3

echo ""
echo "示例 10：多管道"
echo "命令：cat /etc/passwd | cut -d: -f1 | sort | head -5"
cat /etc/passwd | cut -d: -f1 | sort | head -5

echo ""
echo "=========================================="
echo "【6】tee 命令"
echo "=========================================="

echo "示例 11：tee 同时输出到屏幕和文件"
echo "命令：echo 'test' | tee /tmp/tee_test.txt"
echo "tee 测试内容" | tee /tmp/tee_test.txt
echo "✅ 文件内容："
cat /tmp/tee_test.txt

echo ""
echo "示例 12：tee -a 追加模式"
echo "追加内容" | tee -a /tmp/tee_test.txt
echo "✅ 追加后的文件内容："
cat /tmp/tee_test.txt

echo ""
echo "=========================================="
echo "【7】实战技巧"
echo "=========================================="

echo "技巧 1：丢弃输出"
echo "命令：command > /dev/null 2>&1"
echo "常用于静默执行"

echo ""
echo "技巧 2：同时查看和保存"
echo "命令：command | tee output.log"
echo "适合调试和记录"

echo ""
echo "技巧 3：错误日志分离"
echo "命令：command > output.log 2> error.log"
echo "正常输出和错误分开保存"

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
rm -f /tmp/test_redirect.txt /tmp/redirect_error.txt /tmp/redirect_all.txt /tmp/tee_test.txt 2>/dev/null

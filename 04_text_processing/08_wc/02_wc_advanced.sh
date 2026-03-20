#!/bin/bash
# ============================================================================
# 脚本名称：02_wc_advanced.sh
# 功能描述：wc 命令高级用法 - 多文件统计、组合使用、实战分析
# 难度等级：⭐⭐⭐ 中级
# 知识点：wc 高级选项、多文件统计、组合命令、实战应用
# 使用方法：bash 02_wc_advanced.sh
# 依赖命令：wc, find, cat, echo
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 wc 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 多文件统计
# ------------------------------------------------------------------------------
print_header "🔹 多文件统计"

cat > /tmp/file1.txt << 'EOF'
This is file 1
It has 3 lines
EOF

cat > /tmp/file2.txt << 'EOF'
This is file 2
It has 2 lines
More content here
EOF

echo -e "${YELLOW}【统计多个文件】${NC}"
echo "命令：wc /tmp/file1.txt /tmp/file2.txt"
wc /tmp/file1.txt /tmp/file2.txt
echo ""

echo -e "${YELLOW}【只显示总行数】${NC}"
echo "命令：wc -l /tmp/file1.txt /tmp/file2.txt"
wc -l /tmp/file1.txt /tmp/file2.txt
echo ""

# ------------------------------------------------------------------------------
# 2. 组合选项
# ------------------------------------------------------------------------------
print_header "🔹 组合选项"

echo -e "${YELLOW}【同时显示行数、单词数、字节数】${NC}"
echo "命令：wc -lwc /tmp/file1.txt"
wc -lwc /tmp/file1.txt
echo ""

echo -e "${YELLOW}【显示行数、字符数】${NC}"
echo "命令：wc -lm /tmp/file1.txt"
wc -lm /tmp/file1.txt
echo ""

# ------------------------------------------------------------------------------
# 3. 实战：代码统计
# ------------------------------------------------------------------------------
print_header "🔹 实战：代码统计"

echo -e "${YELLOW}【统计 Shell 脚本数量】${NC}"
echo "命令：find /root/.copaw/github_repos/shell-notes -name '*.sh' | wc -l"
count=$(find /root/.copaw/github_repos/shell-notes -name '*.sh' | wc -l)
echo "Shell 脚本总数：$count"
echo ""

echo -e "${YELLOW}【统计代码总行数】${NC}"
echo "命令：find /root/.copaw/github_repos/shell-notes -name '*.sh' -exec cat {} \\; | wc -l"
total=$(find /root/.copaw/github_repos/shell-notes -name '*.sh' -exec cat {} \; 2>/dev/null | wc -l)
echo "代码总行数：$total"
echo ""

echo -e "${YELLOW}【统计 Markdown 文档数】${NC}"
echo "命令：find /root/.copaw/github_repos/shell-notes -name '*.md' | wc -l"
md_count=$(find /root/.copaw/github_repos/shell-notes -name '*.md' | wc -l)
echo "Markdown 文档数：$md_count"
echo ""

# ------------------------------------------------------------------------------
# 4. 实战：日志分析
# ------------------------------------------------------------------------------
print_header "🔹 实战：日志分析"

cat > /tmp/access.log << 'EOF'
192.168.1.100 - - [21/Mar/2026:10:15:30 +0800] "GET /index.html HTTP/1.1" 200 1234
192.168.1.101 - - [21/Mar/2026:10:15:31 +0800] "POST /api/login HTTP/1.1" 200 567
192.168.1.100 - - [21/Mar/2026:10:15:32 +0800] "GET /style.css HTTP/1.1" 200 890
192.168.1.102 - - [21/Mar/2026:10:15:33 +0800] "GET /index.html HTTP/1.1" 200 1234
EOF

echo -e "${YELLOW}【统计总请求数】${NC}"
echo "命令：wc -l /tmp/access.log"
wc -l /tmp/access.log
echo ""

echo -e "${YELLOW}【统计 GET 请求数】${NC}"
echo "命令：grep 'GET' /tmp/access.log | wc -l"
grep 'GET' /tmp/access.log | wc -l
echo ""

echo -e "${YELLOW}【统计 POST 请求数】${NC}"
echo "命令：grep 'POST' /tmp/access.log | wc -l"
grep 'POST' /tmp/access.log | wc -l
echo ""

echo -e "${YELLOW}【统计不同 IP 数】${NC}"
echo "命令：cut -d' ' -f1 /tmp/access.log | sort -u | wc -l"
cut -d' ' -f1 /tmp/access.log | sort -u | wc -l
echo ""

# ------------------------------------------------------------------------------
# 5. 实战：文件比较
# ------------------------------------------------------------------------------
print_header "🔹 实战：文件比较"

echo -e "${YELLOW}【比较两个文件行数】${NC}"
lines1=$(wc -l < /tmp/file1.txt)
lines2=$(wc -l < /tmp/file2.txt)
echo "file1.txt: $lines1 行"
echo "file2.txt: $lines2 行"
if [ $lines1 -gt $lines2 ]; then
    echo "file1.txt 更多"
elif [ $lines1 -lt $lines2 ]; then
    echo "file2.txt 更多"
else
    echo "两个文件行数相同"
fi
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：目录分析
# ------------------------------------------------------------------------------
print_header "🔹 实战：目录分析"

echo -e "${YELLOW}【统计各类型文件数量】${NC}"
echo "Shell 脚本：$(find /root/.copaw/github_repos/shell-notes -name '*.sh' | wc -l)"
echo "Markdown: $(find /root/.copaw/github_repos/shell-notes -name '*.md' | wc -l)"
echo "文本文件：$(find /root/.copaw/github_repos/shell-notes -name '*.txt' | wc -l)"
echo ""

# ------------------------------------------------------------------------------
# 7. 管道组合
# ------------------------------------------------------------------------------
print_header "🔹 管道组合"

echo -e "${YELLOW}【统计命令输出行数】${NC}"
echo "命令：ps aux | wc -l"
echo "进程总数：$(ps aux | wc -l)"
echo ""

echo -e "${YELLOW}【统计目录中文件数】${NC}"
echo "命令：ls -1 /tmp | wc -l"
echo "/tmp 文件数：$(ls -1 /tmp | wc -l)"
echo ""

# ------------------------------------------------------------------------------
# 8. 性能监控
# ------------------------------------------------------------------------------
print_header "🔹 性能监控"

echo -e "${YELLOW}【监控日志增长速度】${NC}"
for i in 1 2 3; do
    count=$(wc -l < /tmp/access.log)
    echo "第 $i 次：$count 行"
    sleep 1
done
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/file1.txt /tmp/file2.txt /tmp/access.log
print_example "清理完成" "rm -f /tmp/file1.txt /tmp/file2.txt /tmp/access.log"

print_header "✅ wc 命令高级学习完成！"

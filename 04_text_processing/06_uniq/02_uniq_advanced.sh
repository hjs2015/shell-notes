#!/bin/bash
# ============================================================================
# 脚本名称：02_uniq_advanced.sh
# 功能描述：uniq 命令高级用法 - 复杂去重、统计、模式匹配
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：uniq 高级选项、字段去重、统计计数、模式匹配
# 使用方法：bash 02_uniq_advanced.sh
# 依赖命令：uniq, sort, cat, echo
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 uniq 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 统计重复次数
# ------------------------------------------------------------------------------
print_header "🔹 统计重复次数"

cat > /tmp/words.txt << 'EOF'
apple
banana
apple
orange
banana
apple
grape
banana
EOF

echo -e "${YELLOW}【统计每个词出现次数】${NC}"
echo "命令：sort /tmp/words.txt | uniq -c"
sort /tmp/words.txt | uniq -c
echo ""

echo -e "${YELLOW}【按出现次数排序】${NC}"
echo "命令：sort /tmp/words.txt | uniq -c | sort -n -r"
sort /tmp/words.txt | uniq -c | sort -n -r
echo ""

# ------------------------------------------------------------------------------
# 2. 只显示重复/唯一的行
# ------------------------------------------------------------------------------
print_header "🔹 只显示重复/唯一的行"

echo -e "${YELLOW}【只显示重复的行（-d）】${NC}"
echo "命令：sort /tmp/words.txt | uniq -d"
sort /tmp/words.txt | uniq -d
echo ""

echo -e "${YELLOW}【只显示唯一的行（-u）】${NC}"
echo "命令：sort /tmp/words.txt | uniq -u"
sort /tmp/words.txt | uniq -u
echo ""

# ------------------------------------------------------------------------------
# 3. 基于字段去重
# ------------------------------------------------------------------------------
print_header "🔹 基于字段去重"

cat > /tmp/data.txt << 'EOF'
apple red 10
banana yellow 20
apple green 15
orange orange 25
banana green 30
EOF

echo -e "${YELLOW}【按第 1 列去重】${NC}"
echo "命令：sort /tmp/data.txt | uniq -f0"
sort /tmp/data.txt | uniq -f0
echo ""

echo -e "${YELLOW}【跳过前 2 列去重】${NC}"
echo "命令：sort /tmp/data.txt | uniq -f2"
sort /tmp/data.txt | uniq -f2
echo ""

# ------------------------------------------------------------------------------
# 4. 基于字符位置去重
# ------------------------------------------------------------------------------
print_header "🔹 基于字符位置去重"

cat > /tmp/ids.txt << 'EOF'
ID001 apple
ID002 banana
ID003 orange
ID004 grape
EOF

echo -e "${YELLOW}【跳过前 3 个字符去重】${NC}"
echo "命令：sort /tmp/ids.txt | uniq -s3"
sort /tmp/ids.txt | uniq -s3
echo ""

# ------------------------------------------------------------------------------
# 5. 实战：日志分析
# ------------------------------------------------------------------------------
print_header "🔹 实战：日志分析"

cat > /tmp/access.log << 'EOF'
192.168.1.100 GET /index.html
192.168.1.101 GET /style.css
192.168.1.100 POST /api/login
192.168.1.102 GET /index.html
192.168.1.101 GET /script.js
192.168.1.100 GET /images/logo.png
EOF

echo -e "${YELLOW}【统计每个 IP 的访问次数】${NC}"
echo "命令：cut -d' ' -f1 /tmp/access.log | sort | uniq -c | sort -n -r"
cut -d' ' -f1 /tmp/access.log | sort | uniq -c | sort -n -r
echo ""

echo -e "${YELLOW}【统计每个 URL 的访问次数】${NC}"
echo "命令：cut -d' ' -f3 /tmp/access.log | sort | uniq -c | sort -n -r"
cut -d' ' -f3 /tmp/access.log | sort | uniq -c | sort -n -r
echo ""

echo -e "${YELLOW}【找出访问最频繁的 IP】${NC}"
echo "命令：cut -d' ' -f1 /tmp/access.log | sort | uniq -c | sort -n -r | head -1"
cut -d' ' -f1 /tmp/access.log | sort | uniq -c | sort -n -r | head -1
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：错误统计
# ------------------------------------------------------------------------------
print_header "🔹 实战：错误统计"

cat > /tmp/error.log << 'EOF'
ERROR: Connection timeout
WARNING: High memory usage
ERROR: Database connection failed
ERROR: Connection timeout
INFO: Server started
WARNING: High memory usage
ERROR: Connection timeout
EOF

echo -e "${YELLOW}【统计错误类型】${NC}"
echo "命令：cut -d':' -f1 /tmp/error.log | sort | uniq -c | sort -n -r"
cut -d':' -f1 /tmp/error.log | sort | uniq -c | sort -n -r
echo ""

echo -e "${YELLOW}【只显示错误（ERROR）】${NC}"
echo "命令：grep 'ERROR' /tmp/error.log | cut -d':' -f2 | sort | uniq -c"
grep 'ERROR' /tmp/error.log | cut -d':' -f2 | sort | uniq -c
echo ""

# ------------------------------------------------------------------------------
# 7. 比较两个文件
# ------------------------------------------------------------------------------
print_header "🔹 比较两个文件"

cat > /tmp/file1.txt << 'EOF'
apple
banana
orange
grape
EOF

cat > /tmp/file2.txt << 'EOF'
banana
orange
melon
EOF

echo -e "${YELLOW}【文件 1 独有】${NC}"
echo "命令：sort /tmp/file1.txt /tmp/file2.txt | uniq -u"
sort /tmp/file1.txt /tmp/file2.txt | uniq -u
echo ""

echo -e "${YELLOW}【两个文件共有】${NC}"
echo "命令：sort /tmp/file1.txt /tmp/file2.txt | uniq -d"
sort /tmp/file1.txt /tmp/file2.txt | uniq -d
echo ""

# ------------------------------------------------------------------------------
# 8. 零终止符（处理含换行符的数据）
# ------------------------------------------------------------------------------
print_header "🔹 零终止符"

echo -e "${YELLOW}【使用 -z 选项处理特殊数据】${NC}"
echo "命令：echo -e 'a\\0b\\0a\\0c' | tr '\\0' '\\n' | sort | uniq -z | tr '\\0' '\\n'"
echo -e 'a\0b\0a\0c' | tr '\0' '\n' | sort | uniq -z | tr '\0' '\n'
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/words.txt /tmp/data.txt /tmp/ids.txt /tmp/access.log /tmp/error.log /tmp/file1.txt /tmp/file2.txt
print_example "清理完成" "rm -f /tmp/*.txt /tmp/*.log"

print_header "✅ uniq 命令高级学习完成！"

#!/bin/bash
# ============================================================================
# 脚本名称：03_cut_advanced.sh
# 功能描述：cut 命令高级用法 - 复杂文本处理、多字段操作、实战案例
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：cut 高级选项、多字段提取、复杂分隔符、实战应用
# 使用方法：bash 03_cut_advanced.sh
# 依赖命令：cut, echo, cat, ps
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 cut 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 多字段提取
# ------------------------------------------------------------------------------
print_header "🔹 多字段提取"

echo -e "${YELLOW}【提取多个不连续字段】${NC}"
echo "命令：echo 'a,b,c,d,e,f' | cut -d',' -f1,3,5"
echo 'a,b,c,d,e,f' | cut -d',' -f1,3,5
echo ""

echo -e "${YELLOW}【提取字段范围】${NC}"
echo "命令：echo 'a,b,c,d,e,f' | cut -d',' -f2-4"
echo 'a,b,c,d,e,f' | cut -d',' -f2-4
echo ""

echo -e "${YELLOW}【从某字段到末尾】${NC}"
echo "命令：echo 'a,b,c,d,e,f' | cut -d',' -f4-"
echo 'a,b,c,d,e,f' | cut -d',' -f4-
echo ""

# ------------------------------------------------------------------------------
# 2. 字符位置提取
# ------------------------------------------------------------------------------
print_header "🔹 字符位置提取"

echo -e "${YELLOW}【提取前 5 个字符】${NC}"
echo "命令：echo 'Hello World' | cut -c1-5"
echo 'Hello World' | cut -c1-5
echo ""

echo -e "${YELLOW}【提取特定位置字符】${NC}"
echo "命令：echo 'Hello World' | cut -c1,7,9"
echo 'Hello World' | cut -c1,7,9
echo ""

echo -e "${YELLOW}【删除前 3 个字符】${NC}"
echo "命令：echo 'Hello World' | cut -c4-"
echo 'Hello World' | cut -c4-
echo ""

# ------------------------------------------------------------------------------
# 3. 实战：处理 ps 输出
# ------------------------------------------------------------------------------
print_header "🔹 实战：处理 ps 输出"

echo -e "${YELLOW}【提取进程 PID 和命令】${NC}"
echo "命令：ps aux | cut -d' ' -f2,11- | head -10"
ps aux | cut -d' ' -f2,11- | head -10
echo ""

echo -e "${YELLOW}【提取用户和 CPU 使用率】${NC}"
echo "命令：ps aux | cut -d' ' -f1,3-4 | head -10"
ps aux | cut -d' ' -f1,3-4 | head -10
echo ""

# ------------------------------------------------------------------------------
# 4. 实战：处理 /etc/passwd
# ------------------------------------------------------------------------------
print_header "🔹 实战：处理 /etc/passwd"

echo -e "${YELLOW}【提取用户名和 UID】${NC}"
echo "命令：cut -d':' -f1,3 /etc/passwd | head -10"
cut -d':' -f1,3 /etc/passwd | head -10
echo ""

echo -e "${YELLOW}【提取用户名和家目录】${NC}"
echo "命令：cut -d':' -f1,6 /etc/passwd | head -10"
cut -d':' -f1,6 /etc/passwd | head -10
echo ""

echo -e "${YELLOW}【提取所有用户名】${NC}"
echo "命令：cut -d':' -f1 /etc/passwd"
cut -d':' -f1 /etc/passwd | head -10
echo ""

# ------------------------------------------------------------------------------
# 5. 互补选择（--complement）
# ------------------------------------------------------------------------------
print_header "🔹 互补选择（--complement）"

echo -e "${YELLOW}【排除第 1 个字段】${NC}"
echo "命令：echo 'a,b,c,d,e' | cut -d',' -f1 --complement"
echo 'a,b,c,d,e' | cut -d',' -f1 --complement
echo ""

echo -e "${YELLOW}【排除前 2 个字段】${NC}"
echo "命令：echo 'a,b,c,d,e' | cut -d',' -f1-2 --complement"
echo 'a,b,c,d,e' | cut -d',' -f1-2 --complement
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：日志分析
# ------------------------------------------------------------------------------
print_header "🔹 实战：日志分析"

# 创建测试日志
cat > /tmp/test_access.log << 'EOF'
192.168.1.100 - - [21/Mar/2026:10:15:30 +0800] "GET /index.html HTTP/1.1" 200 1234
192.168.1.101 - - [21/Mar/2026:10:15:31 +0800] "POST /api/login HTTP/1.1" 200 567
192.168.1.102 - - [21/Mar/2026:10:15:32 +0800] "GET /style.css HTTP/1.1" 200 890
EOF

echo -e "${YELLOW}【提取 IP 地址】${NC}"
echo "命令：cut -d' ' -f1 /tmp/test_access.log"
cut -d' ' -f1 /tmp/test_access.log
echo ""

echo -e "${YELLOW}【提取时间戳】${NC}"
echo "命令：cut -d'[' -f2 /tmp/test_access.log | cut -d']' -f1"
cut -d'[' -f2 /tmp/test_access.log | cut -d']' -f1
echo ""

echo -e "${YELLOW}【提取请求方法】${NC}"
echo "命令：cut -d'"' -f2 /tmp/test_access.log | cut -d' ' -f1"
cut -d'"' -f2 /tmp/test_access.log | cut -d' ' -f1
echo ""

# ------------------------------------------------------------------------------
# 7. 实战：CSV 处理
# ------------------------------------------------------------------------------
print_header "🔹 实战：CSV 处理"

cat > /tmp/data.csv << 'EOF'
name,age,city,salary
张三，25，北京，15000
李四，30，上海，20000
王五，28，广州，18000
EOF

echo -e "${YELLOW}【提取姓名列】${NC}"
echo "命令：cut -d',' -f1 /tmp/data.csv"
cut -d',' -f1 /tmp/data.csv
echo ""

echo -e "${YELLOW}【提取姓名和工资】${NC}"
echo "命令：cut -d',' -f1,4 /tmp/data.csv"
cut -d',' -f1,4 /tmp/data.csv
echo ""

echo -e "${YELLOW}【排除表头】${NC}"
echo "命令：tail -n +2 /tmp/data.csv | cut -d',' -f1,3"
tail -n +2 /tmp/data.csv | cut -d',' -f1,3
echo ""

# ------------------------------------------------------------------------------
# 8. 组合使用
# ------------------------------------------------------------------------------
print_header "🔹 组合使用"

echo -e "${YELLOW}【cut + sort 去重】${NC}"
echo "命令：cut -d':' -f1 /etc/passwd | sort | uniq -c | sort -rn"
cut -d':' -f1 /etc/passwd | sort | uniq -c | sort -rn | head -5
echo ""

echo -e "${YELLOW}【cut + grep 过滤】${NC}"
echo "命令：cut -d':' -f1,7 /etc/passwd | grep 'bash'"
cut -d':' -f1,7 /etc/passwd | grep 'bash'
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/test_access.log /tmp/data.csv
print_example "清理完成" "rm -f /tmp/test_access.log /tmp/data.csv"

print_header "✅ cut 命令高级学习完成！"

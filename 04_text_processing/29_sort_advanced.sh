#!/bin/bash
# ============================================================================
# 脚本名称：02_sort_advanced.sh
# 功能描述：sort 命令高级用法 - 多关键字排序、自定义排序、性能优化
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：sort 高级选项、多关键字、数值排序、去重、性能优化
# 使用方法：bash 02_sort_advanced.sh
# 依赖命令：sort, echo, cat, du
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 sort 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 多关键字排序
# ------------------------------------------------------------------------------
print_header "🔹 多关键字排序"

cat > /tmp/students.txt << 'EOF'
张三 85 90 88
李四 92 85 90
王五 85 95 92
赵六 90 88 85
钱七 88 90 95
EOF

echo -e "${YELLOW}【按第 1 列排序】${NC}"
echo "命令：sort -k1 /tmp/students.txt"
sort -k1 /tmp/students.txt
echo ""

echo -e "${YELLOW}【按第 2 列数值排序】${NC}"
echo "命令：sort -k2 -n /tmp/students.txt"
sort -k2 -n /tmp/students.txt
echo ""

echo -e "${YELLOW}【多关键字：先按第 2 列，再按第 3 列】${NC}"
echo "命令：sort -k2 -n -k3 -n /tmp/students.txt"
sort -k2 -n -k3 -n /tmp/students.txt
echo ""

# ------------------------------------------------------------------------------
# 2. 反向排序
# ------------------------------------------------------------------------------
print_header "🔹 反向排序"

echo -e "${YELLOW}【降序排序】${NC}"
echo "命令：sort -k2 -n -r /tmp/students.txt"
sort -k2 -n -r /tmp/students.txt
echo ""

echo -e "${YELLOW}【大小写不敏感排序】${NC}"
echo "命令：echo -e 'banana\\nApple\\ncherry' | sort -f"
echo -e 'banana\nApple\ncherry' | sort -f
echo ""

# ------------------------------------------------------------------------------
# 3. 自定义分隔符
# ------------------------------------------------------------------------------
print_header "🔹 自定义分隔符"

cat > /tmp/data.csv << 'EOF'
name,age,salary
张三，25,15000
李四，30,20000
王五，28,18000
EOF

echo -e "${YELLOW}【CSV 按工资排序】${NC}"
echo "命令：tail -n +2 /tmp/data.csv | sort -t',' -k3 -n"
tail -n +2 /tmp/data.csv | sort -t',' -k3 -n
echo ""

# ------------------------------------------------------------------------------
# 4. 去重排序
# ------------------------------------------------------------------------------
print_header "🔹 去重排序"

cat > /tmp/duplicates.txt << 'EOF'
apple
banana
apple
orange
banana
apple
EOF

echo -e "${YELLOW}【去重（-u）】${NC}"
echo "命令：sort /tmp/duplicates.txt -u"
sort /tmp/duplicates.txt -u
echo ""

echo -e "${YELLOW}【统计重复次数】${NC}"
echo "命令：sort /tmp/duplicates.txt | uniq -c"
sort /tmp/duplicates.txt | uniq -c
echo ""

# ------------------------------------------------------------------------------
# 5. 实战：文件排序
# ------------------------------------------------------------------------------
print_header "🔹 实战：文件排序"

echo -e "${YELLOW}【按文件大小排序】${NC}"
echo "命令：ls -l /tmp | tail -n +2 | sort -k5 -n -r | head -10"
ls -l /tmp | tail -n +2 | sort -k5 -n -r | head -10
echo ""

echo -e "${YELLOW}【按目录大小排序】${NC}"
echo "命令：du -sh /root/.copaw/*/ 2>/dev/null | sort -h | tail -5"
du -sh /root/.copaw/*/ 2>/dev/null | sort -h | tail -5
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：进程排序
# ------------------------------------------------------------------------------
print_header "🔹 实战：进程排序"

echo -e "${YELLOW}【按 CPU 使用率排序】${NC}"
echo "命令：ps aux | sort -k3 -n -r | head -10"
ps aux | sort -k3 -n -r | head -10
echo ""

echo -e "${YELLOW}【按内存使用率排序】${NC}"
echo "命令：ps aux | sort -k4 -n -r | head -10"
ps aux | sort -k4 -n -r | head -10
echo ""

# ------------------------------------------------------------------------------
# 7. 随机排序
# ------------------------------------------------------------------------------
print_header "🔹 随机排序"

echo -e "${YELLOW}【随机打乱顺序】${NC}"
echo "命令：echo -e '1\\n2\\n3\\n4\\n5' | sort -R"
echo -e '1\n2\n3\n4\n5' | sort -R
echo ""

# ------------------------------------------------------------------------------
# 8. 月份排序
# ------------------------------------------------------------------------------
print_header "🔹 月份排序"

cat > /tmp/months.txt << 'EOF'
Mar
Jan
Feb
Dec
Apr
EOF

echo -e "${YELLOW}【按月份排序（-M）】${NC}"
echo "命令：sort -M /tmp/months.txt"
sort -M /tmp/months.txt
echo ""

# ------------------------------------------------------------------------------
# 9. 检查是否已排序
# ------------------------------------------------------------------------------
print_header "🔹 检查是否已排序"

echo -e "${YELLOW}【检查文件是否已排序（-c）】${NC}"
echo "命令：sort -c /tmp/duplicates.txt && echo '已排序' || echo '未排序'"
sort -c /tmp/duplicates.txt 2>&1 && echo "已排序" || echo "未排序"
echo ""

echo -e "${YELLOW}【检查排序后的文件】${NC}"
sort /tmp/duplicates.txt > /tmp/sorted.txt
echo "命令：sort -c /tmp/sorted.txt && echo '已排序' || echo '未排序'"
sort -c /tmp/sorted.txt 2>&1 && echo "已排序" || echo "未排序"
echo ""

# ------------------------------------------------------------------------------
# 10. 性能优化
# ------------------------------------------------------------------------------
print_header "🔹 性能优化"

echo -e "${YELLOW}【指定临时目录（大文件排序）】${NC}"
echo "命令：sort -T /tmp -S 50% /tmp/large_file.txt"
echo "说明：-T 指定临时目录，-S 指定内存使用百分比"
echo ""

echo -e "${YELLOW}【并行排序（多核 CPU）】${NC}"
echo "命令：sort --parallel=4 /tmp/large_file.txt"
echo "说明：--parallel 指定线程数"
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/students.txt /tmp/data.csv /tmp/duplicates.txt /tmp/sorted.txt /tmp/months.txt
print_example "清理完成" "rm -f /tmp/*.txt"

print_header "✅ sort 命令高级学习完成！"

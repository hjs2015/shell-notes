#!/bin/bash
# ============================================================================
# 脚本名称：02_head_tail_advanced.sh
# 功能描述：head/tail 命令高级用法 - 日志监控、数据采样、实时跟踪
# 难度等级：⭐⭐⭐ 中级
# 知识点：head/tail 高级选项、日志跟踪、数据采样、实时监控
# 使用方法：bash 02_head_tail_advanced.sh
# 依赖命令：head, tail, cat, echo
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 head/tail 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 指定行数
# ------------------------------------------------------------------------------
print_header "🔹 指定行数"

cat > /tmp/data.txt << 'EOF'
line 1
line 2
line 3
line 4
line 5
line 6
line 7
line 8
line 9
line 10
EOF

echo -e "${YELLOW}【前 5 行】${NC}"
echo "命令：head -n 5 /tmp/data.txt"
head -n 5 /tmp/data.txt
echo ""

echo -e "${YELLOW}【后 5 行】${NC}"
echo "命令：tail -n 5 /tmp/data.txt"
tail -n 5 /tmp/data.txt
echo ""

# ------------------------------------------------------------------------------
# 2. 排除首/尾行
# ------------------------------------------------------------------------------
print_header "🔹 排除首/尾行"

echo -e "${YELLOW}【排除前 3 行】${NC}"
echo "命令：tail -n +4 /tmp/data.txt"
tail -n +4 /tmp/data.txt
echo ""

echo -e "${YELLOW}【排除后 3 行】${NC}"
echo "命令：head -n -3 /tmp/data.txt"
head -n -3 /tmp/data.txt
echo ""

echo -e "${YELLOW}【取中间部分（第 4-7 行）】${NC}"
echo "命令：tail -n +4 /tmp/data.txt | head -n 4"
tail -n +4 /tmp/data.txt | head -n 4
echo ""

# ------------------------------------------------------------------------------
# 3. 指定字节数
# ------------------------------------------------------------------------------
print_header "🔹 指定字节数"

echo -e "${YELLOW}【前 20 个字节】${NC}"
echo "命令：head -c 20 /tmp/data.txt"
head -c 20 /tmp/data.txt
echo ""

echo -e "${YELLOW}【后 20 个字节】${NC}"
echo "命令：tail -c 20 /tmp/data.txt"
tail -c 20 /tmp/data.txt
echo ""

# ------------------------------------------------------------------------------
# 4. 实时监控日志
# ------------------------------------------------------------------------------
print_header "🔹 实时监控日志"

echo -e "${YELLOW}【跟踪日志（-f）】${NC}"
echo "命令：tail -f /var/log/syslog（示例，实际需 root 权限）"
echo "说明：-f 选项实时跟踪文件新增内容"
echo ""

echo -e "${YELLOW}【带名称跟踪（-F）】${NC}"
echo "命令：tail -F /var/log/messages"
echo "说明：-F 选项在文件轮转后继续跟踪"
echo ""

# 创建测试日志
echo -e "${YELLOW}【模拟日志跟踪（3 秒）】${NC}"
> /tmp/test.log
echo "初始日志内容" > /tmp/test.log
tail -n 1 /tmp/test.log
sleep 1
echo "新增日志 1" >> /tmp/test.log
tail -n 2 /tmp/test.log
sleep 1
echo "新增日志 2" >> /tmp/test.log
tail -n 3 /tmp/test.log
echo ""

# ------------------------------------------------------------------------------
# 5. 多文件处理
# ------------------------------------------------------------------------------
print_header "🔹 多文件处理"

cat > /tmp/file1.txt << 'EOF'
file1 line 1
file1 line 2
file1 line 3
EOF

cat > /tmp/file2.txt << 'EOF'
file2 line 1
file2 line 2
file2 line 3
EOF

echo -e "${YELLOW}【显示多个文件的头部】${NC}"
echo "命令：head /tmp/file1.txt /tmp/file2.txt"
head /tmp/file1.txt /tmp/file2.txt
echo ""

echo -e "${YELLOW}【显示多个文件的尾部】${NC}"
echo "命令：tail /tmp/file1.txt /tmp/file2.txt"
tail /tmp/file1.txt /tmp/file2.txt
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：查看系统信息
# ------------------------------------------------------------------------------
print_header "🔹 实战：查看系统信息"

echo -e "${YELLOW}【查看最新登录】${NC}"
echo "命令：last | head -10"
last | head -10
echo ""

echo -e "${YELLOW}【查看 CPU 信息前 10 行】${NC}"
echo "命令：cat /proc/cpuinfo | head -10"
cat /proc/cpuinfo | head -10
echo ""

echo -e "${YELLOW}【查看内存信息后 5 行】${NC}"
echo "命令：cat /proc/meminfo | tail -5"
cat /proc/meminfo | tail -5
echo ""

# ------------------------------------------------------------------------------
# 7. 实战：进程管理
# ------------------------------------------------------------------------------
print_header "🔹 实战：进程管理"

echo -e "${YELLOW}【查看 CPU 占用最高的 5 个进程】${NC}"
echo "命令：ps aux --sort=-%cpu | head -6"
ps aux --sort=-%cpu | head -6
echo ""

echo -e "${YELLOW}【查看内存占用最高的 5 个进程】${NC}"
echo "命令：ps aux --sort=-%mem | head -6"
ps aux --sort=-%mem | head -6
echo ""

# ------------------------------------------------------------------------------
# 8. 实战：数据采样
# ------------------------------------------------------------------------------
print_header "🔹 实战：数据采样"

echo -e "${YELLOW}【生成 1000 行测试数据】${NC}"
seq 1 1000 > /tmp/numbers.txt
echo "已生成 1000 行数据"
echo ""

echo -e "${YELLOW}【随机采样 10 行】${NC}"
echo "命令：shuf -n 10 /tmp/numbers.txt"
shuf -n 10 /tmp/numbers.txt
echo ""

echo -e "${YELLOW}【等距采样（每 100 行取 1 行）】${NC}"
echo "命令：seq 1 100 1000"
seq 1 100 1000
echo ""

# ------------------------------------------------------------------------------
# 9. 组合使用
# ------------------------------------------------------------------------------
print_header "🔹 组合使用"

echo -e "${YELLOW}【查看第 10-20 行】${NC}"
echo "命令：tail -n +10 /tmp/numbers.txt | head -n 11"
tail -n +10 /tmp/numbers.txt | head -n 11
echo ""

echo -e "${YELLOW}【查看倒数第 10-20 行】${NC}"
echo "命令：head -n -10 /tmp/numbers.txt | tail -n 10"
head -n -10 /tmp/numbers.txt | tail -n 10
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/data.txt /tmp/file1.txt /tmp/file2.txt /tmp/test.log /tmp/numbers.txt
print_example "清理完成" "rm -f /tmp/*.txt /tmp/*.log"

print_header "✅ head/tail 命令高级学习完成！"

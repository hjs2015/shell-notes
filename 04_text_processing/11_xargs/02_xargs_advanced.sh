#!/bin/bash
# ============================================================================
# 脚本名称：02_xargs_advanced.sh
# 功能描述：xargs 命令高级用法 - 并行处理、批量操作、管道优化
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：xargs 高级选项、并行处理、批量操作、命令组合
# 使用方法：bash 02_xargs_advanced.sh
# 依赖命令：xargs, echo, find, cat
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 xargs 命令高级用法"

# ------------------------------------------------------------------------------
# 1. 基础用法
# ------------------------------------------------------------------------------
print_header "🔹 基础用法"

echo -e "${YELLOW}【将多行转一行】${NC}"
echo "命令：echo -e 'a\\nb\\nc' | xargs"
echo -e 'a\nb\nc' | xargs
echo ""

echo -e "${YELLOW}【自定义分隔符】${NC}"
echo "命令：echo -e 'a,b,c' | xargs -d ','"
echo -e 'a,b,c' | xargs -d ','
echo ""

# ------------------------------------------------------------------------------
# 2. 指定参数数量
# ------------------------------------------------------------------------------
print_header "🔹 指定参数数量"

echo -e "${YELLOW}【每 2 个参数执行一次】${NC}"
echo "命令：echo -e '1\\n2\\n3\\n4\\n5' | xargs -n 2"
echo -e '1\n2\n3\n4\n5' | xargs -n 2
echo ""

echo -e "${YELLOW}【每 3 个参数执行一次】${NC}"
echo "命令：echo -e 'a\\nb\\nc\\nd\\ne\\nf' | xargs -n 3"
echo -e 'a\nb\nc\nd\ne\nf' | xargs -n 3
echo ""

# ------------------------------------------------------------------------------
# 3. 并行处理
# ------------------------------------------------------------------------------
print_header "🔹 并行处理"

echo -e "${YELLOW}【使用 4 个并行进程】${NC}"
echo "命令：seq 1 8 | xargs -P 4 -n 1 echo"
seq 1 8 | xargs -P 4 -n 1 echo
echo ""

echo -e "${YELLOW}【模拟并行下载】${NC}"
echo "命令：echo -e 'url1\\nurl2\\nurl3' | xargs -P 3 -n 1 echo '下载:'"
echo -e 'url1\nurl2\nurl3' | xargs -P 3 -n 1 echo '下载:'
echo ""

# ------------------------------------------------------------------------------
# 4. 替换参数位置
# ------------------------------------------------------------------------------
print_header "🔹 替换参数位置"

echo -e "${YELLOW}【使用 {} 占位符】${NC}"
echo "命令：echo -e 'file1\\nfile2\\nfile3' | xargs -I {} echo '处理：{}'"
echo -e 'file1\nfile2\nfile3' | xargs -I {} echo '处理：{}'
echo ""

echo -e "${YELLOW}【在命令中间插入参数】${NC}"
echo "命令：echo -e 'txt\\nlog\\nmd' | xargs -I {} echo '文件类型：{}'"
echo -e 'txt\nlog\nmd' | xargs -I {} echo '文件类型：{}'
echo ""

# ------------------------------------------------------------------------------
# 5. 实战：文件批量操作
# ------------------------------------------------------------------------------
print_header "🔹 实战：文件批量操作"

# 创建测试文件
mkdir -p /tmp/xargs_test
touch /tmp/xargs_test/file{1..10}.txt

echo -e "${YELLOW}【批量重命名文件】${NC}"
echo "命令：ls /tmp/xargs_test/*.txt | xargs -I {} echo '重命名：{}'"
ls /tmp/xargs_test/*.txt | xargs -I {} echo '重命名：{}'
echo ""

echo -e "${YELLOW}【批量删除文件】${NC}"
echo "命令：ls /tmp/xargs_test/*.txt | head -3 | xargs echo '将删除:'"
ls /tmp/xargs_test/*.txt | head -3 | xargs echo '将删除:'
echo ""

# ------------------------------------------------------------------------------
# 6. 实战：find + xargs
# ------------------------------------------------------------------------------
print_header "🔹 实战：find + xargs"

echo -e "${YELLOW}【查找并删除空文件】${NC}"
echo "命令：find /tmp/xargs_test -type f -empty | xargs echo '空文件:'"
find /tmp/xargs_test -type f -empty | xargs echo '空文件:'
echo ""

echo -e "${YELLOW}【查找并显示文件详情】${NC}"
echo "命令：find /tmp/xargs_test -name '*.txt' | xargs ls -lh"
find /tmp/xargs_test -name '*.txt' | xargs ls -lh
echo ""

echo -e "${YELLOW}【查找并统计文件数】${NC}"
echo "命令：find /tmp/xargs_test -name '*.txt' | xargs | wc -w"
find /tmp/xargs_test -name '*.txt' | xargs | wc -w
echo ""

# ------------------------------------------------------------------------------
# 7. 实战：进程管理
# ------------------------------------------------------------------------------
print_header "🔹 实战：进程管理"

echo -e "${YELLOW}【批量终止进程】${NC}"
echo "命令：pgrep -f 'sleep' | xargs echo '将终止 PID:'"
pgrep -f 'sleep' 2>/dev/null | xargs echo '将终止 PID:' || echo "未找到 sleep 进程"
echo ""

echo -e "${YELLOW}【批量发送信号】${NC}"
echo "命令：pgrep bash | head -3 | xargs -I {} echo '发送信号到 PID:{}'"
pgrep bash | head -3 | xargs -I {} echo '发送信号到 PID:{}'
echo ""

# ------------------------------------------------------------------------------
# 8. 处理特殊字符
# ------------------------------------------------------------------------------
print_header "🔹 处理特殊字符"

echo -e "${YELLOW}【处理带空格的文件名】${NC}"
echo "命令：echo 'file with spaces.txt' | xargs -I {} echo '处理：{}'"
echo 'file with spaces.txt' | xargs -I {} echo '处理：{}'
echo ""

echo -e "${YELLOW}【使用空字符分隔（-0）】${NC}"
echo "命令：find /tmp/xargs_test -print0 | xargs -0 echo '文件:'"
find /tmp/xargs_test -print0 | xargs -0 echo '文件:' | head -3
echo ""

# ------------------------------------------------------------------------------
# 9. 组合命令
# ------------------------------------------------------------------------------
print_header "🔹 组合命令"

echo -e "${YELLOW}【查找 + 统计】${NC}"
echo "命令：find /root/.copaw/github_repos/shell-notes -name '*.sh' | xargs wc -l | tail -1"
find /root/.copaw/github_repos/shell-notes -name '*.sh' | xargs wc -l 2>/dev/null | tail -1
echo ""

echo -e "${YELLOW}【查找 + 排序】${NC}"
echo "命令：find /root/.copaw/github_repos/shell-notes -name '*.sh' | xargs basename | sort | head -10"
find /root/.copaw/github_repos/shell-notes -name '*.sh' | xargs basename 2>/dev/null | sort | head -10
echo ""

# ------------------------------------------------------------------------------
# 10. 性能优化
# ------------------------------------------------------------------------------
print_header "🔹 性能优化"

echo -e "${YELLOW}【减少命令执行次数】${NC}"
echo "命令：find /tmp/xargs_test -name '*.txt' | xargs ls -l"
echo "说明：xargs 会批量传递参数，比 -exec 更高效"
echo ""

echo -e "${YELLOW}【限制每行参数数量】${NC}"
echo "命令：seq 1 20 | xargs -n 5 echo"
seq 1 20 | xargs -n 5 echo
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -rf /tmp/xargs_test
print_example "清理完成" "rm -rf /tmp/xargs_test"

print_header "✅ xargs 命令高级学习完成！"

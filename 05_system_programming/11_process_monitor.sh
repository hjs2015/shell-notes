#!/bin/bash
# ============================================================================
# 脚本名称：02_process_monitor.sh
# 功能描述：进程监控高级用法 - 实时监控、资源占用、进程树
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：ps/top/htop、进程树、资源监控、性能分析
# 使用方法：bash 02_process_monitor.sh
# 依赖命令：ps, top, pstree, pidof, pgrep
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================================================${NC}"
}

print_header "📌 进程监控高级用法"

# ------------------------------------------------------------------------------
# 1. ps 命令高级选项
# ------------------------------------------------------------------------------
print_header "🔹 ps 命令高级选项"

echo -e "${YELLOW}【显示所有进程的完整信息】${NC}"
echo "命令：ps aux --sort=-%cpu | head -10"
ps aux --sort=-%cpu | head -10
echo ""

echo -e "${YELLOW}【显示进程树状关系】${NC}"
echo "命令：ps auxf | head -20"
ps auxf | head -20
echo ""

echo -e "${YELLOW}【显示特定用户的进程】${NC}"
echo "命令：ps -u root -o pid,ppid,user,%cpu,%mem,cmd"
ps -u root -o pid,ppid,user,%cpu,%mem,cmd | head -10
echo ""

# ------------------------------------------------------------------------------
# 2. 进程资源监控
# ------------------------------------------------------------------------------
print_header "🔹 进程资源监控"

echo -e "${YELLOW}【CPU 占用最高的 5 个进程】${NC}"
ps aux --sort=-%cpu | awk 'NR<=5 {print $0}'
echo ""

echo -e "${YELLOW}【内存占用最高的 5 个进程】${NC}"
ps aux --sort=-%mem | awk 'NR<=5 {print $0}'
echo ""

echo -e "${YELLOW}【统计各用户进程数】${NC}"
ps aux | awk '{print $1}' | sort | uniq -c | sort -rn | head -10
echo ""

# ------------------------------------------------------------------------------
# 3. 进程树查看
# ------------------------------------------------------------------------------
print_header "🔹 进程树查看"

if command -v pstree &> /dev/null; then
    echo -e "${YELLOW}【系统进程树（前 30 行）】${NC}"
    echo "命令：pstree | head -30"
    pstree | head -30
    echo ""
    
    echo -e "${YELLOW}【显示 PID 的进程树】${NC}"
    echo "命令：pstree -p | head -20"
    pstree -p | head -20
    echo ""
    
    echo -e "${YELLOW}【特定进程的树状结构】${NC}"
    echo "命令：pstree -p $$"
    pstree -p $$ 2>/dev/null || echo "（当前 shell 的进程树）"
    echo ""
else
    echo -e "${RED}pstree 未安装，跳过此部分${NC}"
fi

# ------------------------------------------------------------------------------
# 4. 进程查找
# ------------------------------------------------------------------------------
print_header "🔹 进程查找"

echo -e "${YELLOW}【根据名称查找进程】${NC}"
echo "命令：pgrep -l bash"
pgrep -l bash
echo ""

echo -e "${YELLOW}【查找进程的 PID】${NC}"
echo "命令：pidof bash"
pidof bash 2>/dev/null || echo "未找到 bash 进程"
echo ""

echo -e "${YELLOW}【查找并显示完整命令】${NC}"
echo "命令：pgrep -af python"
pgrep -af python 2>/dev/null || echo "未找到 python 进程"
echo ""

# ------------------------------------------------------------------------------
# 5. 进程状态统计
# ------------------------------------------------------------------------------
print_header "🔹 进程状态统计"

echo -e "${YELLOW}【统计各状态进程数】${NC}"
echo "命令：ps aux | awk '{print $8}' | sort | uniq -c"
ps aux | awk 'NR>1 {print $8}' | sort | uniq -c | sort -rn
echo ""

echo -e "${YELLOW}【进程状态说明】${NC}"
cat << 'EOF'
状态  说明
R     运行中或可运行
S     睡眠中（等待事件）
D     不可中断睡眠（等待 I/O）
Z     僵尸进程（已终止但未回收）
T     已停止（跟踪或暂停）
EOF
echo ""

# ------------------------------------------------------------------------------
# 6. 实时监控（非交互式）
# ------------------------------------------------------------------------------
print_header "🔹 实时监控（采样 3 次）"

for i in 1 2 3; do
    echo -e "${YELLOW}【第 $i 次采样】${NC}"
    echo "时间：$(date '+%H:%M:%S')"
    echo "运行进程数：$(ps aux | wc -l)"
    echo "CPU 负载：$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)"
    echo ""
    sleep 2
done

# ------------------------------------------------------------------------------
# 7. 进程资源限制
# ------------------------------------------------------------------------------
print_header "🔹 进程资源限制"

echo -e "${YELLOW}【查看当前 shell 资源限制】${NC}"
echo "命令：ulimit -a"
ulimit -a 2>/dev/null | head -15
echo ""

echo -e "${YELLOW}【查看特定进程的资源限制】${NC}"
echo "命令：cat /proc/$$/limits | head -15"
cat /proc/$$/limits 2>/dev/null | head -15
echo ""

# ------------------------------------------------------------------------------
# 8. 僵尸进程检测
# ------------------------------------------------------------------------------
print_header "🔹 僵尸进程检测"

echo -e "${YELLOW}【查找僵尸进程】${NC}"
echo "命令：ps aux | awk '$8=="Z" {print $0}'"
zombies=$(ps aux | awk '$8=="Z" {print $0}')
if [ -n "$zombies" ]; then
    echo "$zombies"
else
    echo "✅ 未发现僵尸进程"
fi
echo ""

echo -e "${YELLOW}【统计僵尸进程数】${NC}"
zombie_count=$(ps aux | awk '$8=="Z"' | wc -l)
echo "僵尸进程数：$zombie_count"
echo ""

# ------------------------------------------------------------------------------
# 9. 进程性能分析
# ------------------------------------------------------------------------------
print_header "🔹 进程性能分析"

echo -e "${YELLOW}【查看进程的 I/O 统计】${NC}"
if command -v pidstat &> /dev/null; then
    echo "命令：pidstat -d -p $$ 1 2"
    pidstat -d -p $$ 1 2 2>/dev/null | head -20
else
    echo "pidstat 未安装，使用 /proc 文件系统"
    echo "命令：cat /proc/$$/io"
    cat /proc/$$/io 2>/dev/null | head -10
fi
echo ""

echo -e "${YELLOW}【查看进程的内存映射】${NC}"
echo "命令：cat /proc/$$/maps | head -20"
cat /proc/$$/maps 2>/dev/null | head -20
echo ""

# ------------------------------------------------------------------------------
# 10. 实用监控脚本模板
# ------------------------------------------------------------------------------
print_header "🔹 实用监控脚本模板"

cat << 'EOF'
#!/bin/bash
# 进程监控脚本模板

# 监控特定进程
monitor_process() {
    local proc_name=$1
    while true; do
        count=$(pgrep -c "$proc_name")
        if [ $count -eq 0 ]; then
            echo "⚠️  $proc_name 进程已停止！"
            # 可在此添加告警或重启逻辑
        fi
        sleep 5
    done
}

# 记录进程资源使用
log_process_resource() {
    local log_file="/var/log/process_monitor.log"
    while true; do
        echo "=== $(date) ===" >> $log_file
        ps aux --sort=-%cpu | head -10 >> $log_file
        sleep 60
    done
}
EOF

print_header "✅ 进程监控学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}生产环境建议使用 htop、glances 等增强工具"
echo -e "${YELLOW}💡 最佳实践：${NC}定期监控、设置阈值告警、记录历史数据"
echo ""

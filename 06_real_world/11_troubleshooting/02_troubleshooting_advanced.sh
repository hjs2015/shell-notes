#!/bin/bash
# ============================================================================
# 脚本名称：02_troubleshooting_advanced.sh
# 功能描述：故障排查高级 - 系统诊断、性能分析、日志分析、问题定位
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：系统诊断、性能分析、日志分析、问题定位、故障恢复
# 使用方法：bash 02_troubleshooting_advanced.sh
# 依赖命令：top, iostat, vmstat, dmesg, journalctl
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 故障排查高级"

# ------------------------------------------------------------------------------
# 1. 系统性能诊断
# ------------------------------------------------------------------------------
print_header "🔹 系统性能诊断"

echo -e "${YELLOW}【CPU 使用率】${NC}"
echo "命令：top -bn1 | head -10"
top -bn1 | head -10
echo ""

echo -e "${YELLOW}【内存使用】${NC}"
echo "命令：free -h"
free -h
echo ""

echo -e "${YELLOW}【磁盘 I/O】${NC}"
if command -v iostat &> /dev/null; then
    echo "命令：iostat -x 1 2"
    iostat -x 1 2 2>/dev/null | head -20
else
    echo "iostat 未安装（sysstat 包）"
fi
echo ""

echo -e "${YELLOW}【虚拟内存统计】${NC}"
if command -v vmstat &> /dev/null; then
    echo "命令：vmstat 1 3"
    vmstat 1 3 2>/dev/null
else
    echo "vmstat 未安装"
fi
echo ""

# ------------------------------------------------------------------------------
# 2. 进程问题排查
# ------------------------------------------------------------------------------
print_header "🔹 进程问题排查"

echo -e "${YELLOW}【查找僵尸进程】${NC}"
echo "命令：ps aux | awk '$8=="Z"' | head -10"
zombies=$(ps aux | awk '$8=="Z"' | head -10)
if [ -n "$zombies" ]; then
    echo "$zombies"
else
    echo "✅ 无僵尸进程"
fi
echo ""

echo -e "${YELLOW}【查找高 CPU 进程】${NC}"
echo "命令：ps aux --sort=-%cpu | head -10"
ps aux --sort=-%cpu | head -10
echo ""

echo -e "${YELLOW}【查找高内存进程】${NC}"
echo "命令：ps aux --sort=-%mem | head -10"
ps aux --sort=-%mem | head -10
echo ""

echo -e "${YELLOW}【查看进程打开的文件】${NC}"
echo "命令：lsof -p $$ | head -10"
lsof -p $$ 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 3. 磁盘问题排查
# ------------------------------------------------------------------------------
print_header "🔹 磁盘问题排查"

echo -e "${YELLOW}【磁盘使用率】${NC}"
echo "命令：df -h"
df -h | grep -v tmpfs
echo ""

echo -e "${YELLOW}【查找大文件】${NC}"
echo "命令：find /var -type f -size +100M 2>/dev/null | head -10"
find /var -type f -size +100M 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查找 inode 耗尽】${NC}"
echo "命令：df -i"
df -i | grep -v tmpfs
echo ""

echo -e "${YELLOW}【检查磁盘错误】${NC}"
echo "命令：dmesg | grep -i error | tail -10"
dmesg 2>/dev/null | grep -i error | tail -10
echo ""

# ------------------------------------------------------------------------------
# 4. 网络问题排查
# ------------------------------------------------------------------------------
print_header "🔹 网络问题排查"

echo -e "${YELLOW}【网络连接数】${NC}"
echo "命令：ss -s"
ss -s
echo ""

echo -e "${YELLOW}【检查端口监听】${NC}"
echo "命令：ss -tlnp | head -10"
ss -tlnp 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【DNS 解析测试】${NC}"
echo "命令：nslookup www.baidu.com"
nslookup www.baidu.com 2>&1 | head -10
echo ""

echo -e "${YELLOW}【网络连通性】${NC}"
echo "命令：ping -c 3 www.baidu.com"
ping -c 3 www.baidu.com 2>&1 | head -10
echo ""

# ------------------------------------------------------------------------------
# 5. 日志分析
# ------------------------------------------------------------------------------
print_header "🔹 日志分析"

echo -e "${YELLOW}【系统日志（最近 20 行）】${NC}"
echo "命令：journalctl -n 20"
journalctl -n 20 2>/dev/null | tail -20
echo ""

echo -e "${YELLOW}【错误日志】${NC}"
echo "命令：journalctl -p err -n 10"
journalctl -p err -n 10 2>/dev/null | tail -10
echo ""

echo -e "${YELLOW}【内核消息】${NC}"
echo "命令：dmesg | tail -20"
dmesg 2>/dev/null | tail -20
echo ""

echo -e "${YELLOW}【认证日志】${NC}"
if [ -f /var/log/auth.log ]; then
    echo "命令：tail -20 /var/log/auth.log"
    tail -20 /var/log/auth.log
elif [ -f /var/log/secure ]; then
    echo "命令：tail -20 /var/log/secure"
    tail -20 /var/log/secure
else
    echo "未找到认证日志"
fi
echo ""

# ------------------------------------------------------------------------------
# 6. 服务状态检查
# ------------------------------------------------------------------------------
print_header "🔹 服务状态检查"

echo -e "${YELLOW}【systemd 服务状态】${NC}"
echo "命令：systemctl --failed"
systemctl --failed 2>/dev/null
echo ""

echo -e "${YELLOW}【关键服务状态】${NC}"
for service in ssh docker nginx mysql; do
    status=$(systemctl is-active $service 2>/dev/null)
    if [ "$status" == "active" ]; then
        echo -e "✅ $service: ${GREEN}运行中${NC}"
    elif [ "$status" == "inactive" ]; then
        echo -e "⚠️  $service: ${YELLOW}未运行${NC}"
    else
        echo -e "❓ $service: ${RED}$status${NC}"
    fi
done
echo ""

# ------------------------------------------------------------------------------
# 7. 性能瓶颈分析
# ------------------------------------------------------------------------------
print_header "🔹 性能瓶颈分析"

echo -e "${YELLOW}【CPU 负载】${NC}"
echo "命令：uptime"
uptime
echo ""

load=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)
cpu_count=$(nproc)
load_per_cpu=$(echo "$load $cpu_count" | awk '{printf "%.2f", $1/$2}')
echo "每 CPU 负载：$load_per_cpu"
if (( $(echo "$load_per_cpu > 1" | bc -l 2>/dev/null || echo 0) )); then
    echo -e "${RED}⚠️  CPU 负载过高${NC}"
else
    echo -e "${GREEN}✅ CPU 负载正常${NC}"
fi
echo ""

echo -e "${YELLOW}【内存压力】${NC}"
mem_used=$(free | awk 'NR==2 {printf "%.2f", $3/$2 * 100}')
echo "内存使用率：${mem_used}%"
if (( $(echo "$mem_used > 80" | bc -l 2>/dev/null || echo 0) )); then
    echo -e "${RED}⚠️  内存使用率过高${NC}"
else
    echo -e "${GREEN}✅ 内存使用正常${NC}"
fi
echo ""

# ------------------------------------------------------------------------------
# 8. 实用排查脚本
# ------------------------------------------------------------------------------
print_header "🔹 实用排查脚本"

cat << 'EOF'
#!/bin/bash
# 系统健康检查脚本

check_system_health() {
    echo "=== 系统健康检查 ==="
    
    # CPU
    load=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1)
    echo "CPU 负载：$load"
    
    # 内存
    mem=$(free | awk 'NR==2 {printf "%.2f%", $3/$2*100}')
    echo "内存使用：$mem"
    
    # 磁盘
    disk=$(df -h / | awk 'NR==2 {print $5}')
    echo "磁盘使用：$disk"
    
    # 关键服务
    for svc in ssh docker; do
        status=$(systemctl is-active $svc 2>/dev/null)
        echo "$svc: $status"
    done
}

# 故障排查清单
troubleshoot Checklist() {
    echo "=== 故障排查清单 ==="
    echo "1. 检查系统日志：journalctl -xe"
    echo "2. 检查磁盘空间：df -h"
    echo "3. 检查内存使用：free -h"
    echo "4. 检查进程状态：ps aux"
    echo "5. 检查网络连接：ss -tuln"
    echo "6. 检查服务状态：systemctl status"
}
EOF

print_header "✅ 故障排查高级学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "1. 先定位问题范围（CPU/内存/磁盘/网络）"
echo "2. 查看相关日志和指标"
echo "3. 使用排除法定位根本原因"
echo "4. 记录排查过程和解决方案"
echo ""

#!/bin/bash
# ============================================================================
# 脚本名称：02_network_advanced.sh
# 功能描述：网络管理高级 - 端口扫描、网络诊断、流量分析、安全检测
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：网络诊断、端口扫描、流量分析、网络安全
# 使用方法：bash 02_network_advanced.sh
# 依赖命令：netstat, ss, ping, curl, nmap
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 网络管理高级"

# ------------------------------------------------------------------------------
# 1. 网络连接分析
# ------------------------------------------------------------------------------
print_header "🔹 网络连接分析"

echo -e "${YELLOW}【查看所有网络连接】${NC}"
echo "命令：ss -tuln"
ss -tuln | head -20
echo ""

echo -e "${YELLOW}【查看 ESTABLISHED 连接】${NC}"
echo "命令：ss -t state established"
ss -t state established 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查看监听端口】${NC}"
echo "命令：ss -tlnp"
ss -tlnp 2>/dev/null | head -15
echo ""

# ------------------------------------------------------------------------------
# 2. 网络诊断
# ------------------------------------------------------------------------------
print_header "🔹 网络诊断"

echo -e "${YELLOW}【ping 测试】${NC}"
echo "命令：ping -c 3 8.8.8.8"
ping -c 3 8.8.8.8 2>&1 | head -10
echo ""

echo -e "${YELLOW}【traceroute 路由跟踪】${NC}"
if command -v traceroute &> /dev/null; then
    echo "命令：traceroute -m 10 8.8.8.8"
    traceroute -m 10 8.8.8.8 2>&1 | head -10
else
    echo "traceroute 未安装"
fi
echo ""

echo -e "${YELLOW}【DNS 查询】${NC}"
echo "命令：nslookup google.com"
nslookup google.com 2>&1 | head -10
echo ""

# ------------------------------------------------------------------------------
# 3. 端口扫描
# ------------------------------------------------------------------------------
print_header "🔹 端口扫描"

echo -e "${YELLOW}【检查本地端口】${NC}"
echo "命令：ss -tln | grep LISTEN"
ss -tln | grep LISTEN | head -10
echo ""

echo -e "${YELLOW}【检查远程端口（使用 nc）】${NC}"
if command -v nc &> /dev/null; then
    echo "命令：nc -zv localhost 22 80 443"
    nc -zv localhost 22 80 443 2>&1 | head -5
else
    echo "nc 未安装"
fi
echo ""

# ------------------------------------------------------------------------------
# 4. 网络性能测试
# ------------------------------------------------------------------------------
print_header "🔹 网络性能测试"

echo -e "${YELLOW}【下载速度测试】${NC}"
echo "命令：curl -o /dev/null -s -w '速度：%{speed_download} bytes/s\n' http://www.example.com"
curl -o /dev/null -s -w '速度：%{speed_download} bytes/s\n' http://www.example.com 2>&1
echo ""

echo -e "${YELLOW}【连接时间测试】${NC}"
echo "命令：curl -o /dev/null -s -w 'DNS：%{time_namelookup}s\n连接：%{time_connect}s\n总时间：%{time_total}s\n' http://www.example.com"
curl -o /dev/null -s -w 'DNS：%{time_namelookup}s\n连接：%{time_connect}s\n总时间：%{time_total}s\n' http://www.example.com 2>&1
echo ""

# ------------------------------------------------------------------------------
# 5. 网络接口信息
# ------------------------------------------------------------------------------
print_header "🔹 网络接口信息"

echo -e "${YELLOW}【查看网络接口】${NC}"
echo "命令：ip addr show"
ip addr show 2>/dev/null | head -20
echo ""

echo -e "${YELLOW}【查看路由表】${NC}"
echo "命令：ip route show"
ip route show 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查看 ARP 缓存】${NC}"
echo "命令：ip neigh show"
ip neigh show 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 6. 流量统计
# ------------------------------------------------------------------------------
print_header "🔹 流量统计"

echo -e "${YELLOW}【查看网络接口流量】${NC}"
echo "命令：cat /proc/net/dev"
cat /proc/net/dev | head -10
echo ""

echo -e "${YELLOW}【实时网络流量（iftop 替代）】${NC}"
if command -v iftop &> /dev/null; then
    echo "命令：iftop -n -t -s 5"
    iftop -n -t -s 5 2>&1 | head -15
else
    echo "iftop 未安装，使用 netstat 替代"
    echo "命令：netstat -s"
    netstat -s 2>/dev/null | head -20
fi
echo ""

# ------------------------------------------------------------------------------
# 7. 网络安全检测
# ------------------------------------------------------------------------------
print_header "🔹 网络安全检测"

echo -e "${YELLOW}【检查异常连接】${NC}"
echo "命令：ss -tn | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n -r | head -10"
ss -tn 2>/dev/null | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n -r | head -10
echo ""

echo -e "${YELLOW}【检查 SYN_RECV 状态】${NC}"
echo "命令：ss -tn state syn-recv | wc -l"
syn_count=$(ss -tn state syn-recv 2>/dev/null | wc -l)
echo "SYN_RECV 连接数：$syn_count"
if [ $syn_count -gt 100 ]; then
    echo -e "${RED}⚠️  可能存在 SYN 泛洪攻击${NC}"
fi
echo ""

# ------------------------------------------------------------------------------
# 8. 实用网络脚本
# ------------------------------------------------------------------------------
print_header "🔹 实用网络脚本"

cat << 'EOF'
#!/bin/bash
# 网络监控脚本

# 检查网络连通性
check_connectivity() {
    if ping -c 1 8.8.8.8 &> /dev/null; then
        echo "✅ 网络正常"
    else
        echo "❌ 网络中断"
    fi
}

# 监控端口
monitor_port() {
    local port=$1
    if ss -tln | grep -q ":$port "; then
        echo "✅ 端口 $port 正常监听"
    else
        echo "❌ 端口 $port 未监听"
    fi
}

# 网络延迟监控
monitor_latency() {
    local host=$1
    local latency=$(ping -c 1 $host | grep 'time=' | cut -d'=' -f3 | cut -d' ' -f1)
    echo "到 $host 的延迟：${latency}ms"
}
EOF

print_header "✅ 网络管理高级学习完成！"

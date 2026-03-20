#!/bin/bash
# =============================================================================
# 脚本名称：01_troubleshooting_basics.sh
# 功能描述：故障排查基础 - 系统问题诊断方法
# 难度等级：⭐⭐⭐⭐ 高级
# 所属阶段：阶段 7 - 实战项目
# 知识点：
#   - 系统负载分析
#   - 内存问题排查
#   - 磁盘问题排查
#   - 网络问题排查
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "故障排查基础演示"
print_separator

print_color YELLOW "\n【排查 1】系统负载检查"
echo "命令：uptime"
uptime
echo ""
echo "命令：top -bn1 | head -5"
top -bn1 | head -5

print_color YELLOW "\n【排查 2】内存使用情况"
echo "命令：free -h"
free -h
echo ""
echo "命令：vmstat 1 3"
vmstat 1 3

print_color YELLOW "\n【排查 3】磁盘空间检查"
echo "命令：df -h"
df -h
echo ""
echo "命令：du -sh /var/* 2>/dev/null | sort -rh | head -5"
du -sh /var/* 2>/dev/null | sort -rh | head -5

print_color YELLOW "\n【排查 4】进程资源占用"
echo "命令：ps aux --sort=-%mem | head -10"
ps aux --sort=-%mem | head -10
echo ""
echo "命令：ps aux --sort=-%cpu | head -10"
ps aux --sort=-%cpu | head -10

print_color YELLOW "\n【排查 5】网络连接检查"
echo "命令：ss -tuln | grep -E 'LISTEN|ESTAB' | head -10"
ss -tuln | grep -E 'LISTEN|ESTAB' | head -10
echo ""
echo "命令：ping -c 3 8.8.8.8"
ping -c 3 8.8.8.8

print_color YELLOW "\n【排查 6】系统日志检查"
echo "命令：dmesg | tail -20"
dmesg | tail -20
echo ""
echo "命令：journalctl -xe --no-pager | tail -20"
journalctl -xe --no-pager | tail -20

print_color YELLOW "\n【排查 7】常见故障排查流程"
cat << 'EOF'
1. 系统变慢：
   → 检查负载 (uptime, top)
   → 检查内存 (free, vmstat)
   → 检查磁盘 I/O (iostat, iotop)
   → 检查网络 (ss, netstat)

2. 磁盘满：
   → 查看空间 (df -h)
   → 找大文件 (du -sh /*)
   → 清理日志 (/var/log)
   → 清理临时文件 (/tmp)

3. 服务不可用：
   → 检查进程 (ps aux | grep service)
   → 检查端口 (ss -tuln | grep port)
   → 查看日志 (journalctl -u service)
   → 测试连接 (curl/telnet)

4. 网络问题：
   → 检查配置 (ip addr, ip route)
   → 测试连通性 (ping, traceroute)
   → 检查 DNS (nslookup, dig)
   → 检查防火墙 (iptables -L)
EOF

print_color GREEN "\n演示完成！"
print_separator

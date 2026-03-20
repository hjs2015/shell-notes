#!/bin/bash
# =============================================================================
# 脚本名称：01_network_basics.sh
# 功能描述：网络编程基础 - 网络配置与连接测试
# 难度等级：⭐⭐ 初级
# 所属阶段：阶段 6 - 系统编程
# 知识点：
#   - ip 查看网络配置
#   - ping 测试连通性
#   - netstat/ss 查看端口
#   - curl 网络请求
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "网络编程基础演示"
print_separator

print_color YELLOW "\n【示例 1】查看网络接口配置"
echo "命令：ip addr show | head -20"
ip addr show | head -20

print_color YELLOW "\n【示例 2】查看路由表"
echo "命令：ip route"
ip route

print_color YELLOW "\n【示例 3】测试网络连通性（ping）"
echo "命令：ping -c 3 8.8.8.8"
ping -c 3 8.8.8.8

print_color YELLOW "\n【示例 4】查看监听端口（ss）"
echo "命令：ss -tuln | head -10"
ss -tuln | head -10

print_color YELLOW "\n【示例 5】查看网络连接状态"
echo "命令：ss -tun | head -10"
ss -tun | head -10

print_color YELLOW "\n【示例 6】HTTP 请求测试（curl）"
echo "命令：curl -I https://www.baidu.com 2>/dev/null | head -5"
curl -I https://www.baidu.com 2>/dev/null | head -5

print_color YELLOW "\n【示例 7】DNS 查询"
echo "命令：nslookup www.baidu.com 2>/dev/null | head -10 || echo 'nslookup 未安装'"
nslookup www.baidu.com 2>/dev/null | head -10 || echo 'nslookup 未安装'

print_color YELLOW "\n【示例 8】查看网络统计信息"
echo "命令：netstat -s 2>/dev/null | head -20 || ss -s"
netstat -s 2>/dev/null | head -20 || ss -s

print_color GREEN "\n演示完成！"
print_separator

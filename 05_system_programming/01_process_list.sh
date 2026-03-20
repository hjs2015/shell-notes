#!/bin/bash
# =============================================================================
# 脚本名称：01_process_list.sh
# 功能描述：进程管理基础 - 查看和管理系统进程
# 难度等级：⭐⭐ 初级
# 所属阶段：阶段 6 - 系统编程
# 知识点：
#   - ps 查看进程
#   - top 动态查看
#   - pgrep 按名称查找
#   - kill 终止进程
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "进程管理基础演示"
print_separator

print_color YELLOW "\n【示例 1】查看当前终端进程（ps）"
echo "命令：ps"
ps

print_color YELLOW "\n【示例 2】查看所有进程（ps aux）"
echo "命令：ps aux | head -10"
ps aux | head -10

print_color YELLOW "\n【示例 3】查看特定用户进程"
echo "命令：ps -u root | head -5"
ps -u root | head -5

print_color YELLOW "\n【示例 4】按名称查找进程（pgrep）"
echo "命令：pgrep -l bash"
pgrep -l bash | head -5

print_color YELLOW "\n【示例 5】查看进程树（pstree）"
echo "命令：pstree | head -20"
pstree | head -20

print_color YELLOW "\n【示例 6】查看进程资源占用（top 批处理模式）"
echo "命令：top -bn1 | head -10"
top -bn1 | head -10

print_color YELLOW "\n【示例 7】查找并显示进程详细信息"
echo "命令：ps aux | grep 'bash' | grep -v grep"
ps aux | grep 'bash' | grep -v grep | head -5

print_color GREEN "\n演示完成！"
print_separator

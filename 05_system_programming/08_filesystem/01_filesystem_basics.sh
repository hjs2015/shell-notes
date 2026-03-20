#!/bin/bash
# =============================================================================
# 脚本名称：01_filesystem_basics.sh
# 功能描述：文件系统管理 - 磁盘空间、文件查找
# 难度等级：⭐⭐ 初级
# 所属阶段：阶段 6 - 系统编程
# 知识点：
#   - df 查看磁盘空间
#   - du 查看目录大小
#   - find 查找文件
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "文件系统管理演示"
print_separator

print_color YELLOW "\n【示例 1】查看磁盘空间使用情况（df）"
echo "命令：df -h"
df -h

print_color YELLOW "\n【示例 2】查看当前目录大小（du）"
echo "命令：du -sh /tmp"
du -sh /tmp

print_color YELLOW "\n【示例 3】查看目录下各文件夹大小"
echo "命令：du -sh /tmp/* 2>/dev/null | head -10"
du -sh /tmp/* 2>/dev/null | head -10

print_color YELLOW "\n【示例 4】查找特定文件（find）"
echo "命令：find /tmp -name '*.txt' 2>/dev/null | head -5"
find /tmp -name '*.txt' 2>/dev/null | head -5

print_color YELLOW "\n【示例 5】按文件类型查找"
echo "命令：find /tmp -type f 2>/dev/null | head -5"
find /tmp -type f 2>/dev/null | head -5

print_color YELLOW "\n【示例 6】按文件大小查找"
echo "命令：find /tmp -size +1M 2>/dev/null | head -5"
find /tmp -size +1M 2>/dev/null | head -5

print_color YELLOW "\n【示例 7】查找并删除旧文件"
echo "命令：find /tmp -name '*.tmp' -mtime +7 2>/dev/null"
echo "(演示用，不执行删除)"

print_color GREEN "\n演示完成！"
print_separator

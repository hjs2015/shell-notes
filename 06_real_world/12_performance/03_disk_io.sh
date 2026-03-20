#!/bin/bash
# =============================================================================
# 脚本名称：性能监控
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 所属阶段：阶段 7 - 实战项目
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "性能监控演示"; print_separator
echo "=== CPU 使用率 ==="
top -bn1 | head -3
echo -e "\n=== 内存使用 ==="
free -h
echo -e "\n=== 磁盘使用 ==="
df -h /
echo -e "\n=== 进程 Top5 ==="
ps aux --sort=-%mem | head -6
print_color GREEN "演示完成！"

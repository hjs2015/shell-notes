#!/bin/bash
# =============================================================================
# 脚本名称：Shell 初始化与配置
# 难度等级：⭐⭐⭐⭐ 进阶
# 所属阶段：阶段 6 - 系统编程
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "Shell 初始化演示"; print_separator
echo "Shell 类型：$SHELL"
echo "Shell 版本：$BASH_VERSION"
echo "主机名：$HOSTNAME"
echo "用户：$USER"
echo "家目录：$HOME"
echo -e "\nShell 选项："
set -o | head -5
print_color GREEN "演示完成！"

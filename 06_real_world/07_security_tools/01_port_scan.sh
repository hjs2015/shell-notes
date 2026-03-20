#!/bin/bash
# =============================================================================
# 脚本名称：安全工具
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 所属阶段：阶段 7 - 实战项目
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "安全演示"; print_separator
echo "生成安全密码："
cat /dev/urandom | tr -dc 'A-Za-z0-9!@#' | head -c 16
echo -e "\n\n检查开放端口："
netstat -tuln 2>/dev/null | head -5 || echo "需要 root 权限"
echo -e "\n检查系统用户："
cut -d: -f1 /etc/passwd | head -5
print_color GREEN "演示完成！"

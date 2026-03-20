#!/bin/bash
# =============================================================================
# 脚本名称：备份自动化
# 难度等级：⭐⭐⭐⭐⭐ 专家
# 所属阶段：阶段 7 - 实战项目
# 创建时间：2026-03-20
# =============================================================================
GREEN='\033[0;32m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }
print_separator; print_color CYAN "备份演示"; print_separator
SRC="/tmp/backup_test"
DEST="/tmp/backup_dest"
mkdir -p $SRC $DEST
echo "test data" > $SRC/test.txt
echo "源目录："
ls -la $SRC
echo -e "\n执行备份..."
cp -r $SRC/* $DEST/
echo "目标目录："
ls -la $DEST
print_color GREEN "备份完成！"

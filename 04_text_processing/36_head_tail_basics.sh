#!/bin/bash
# =============================================================================
# 脚本名称：01_head_tail_basics.sh
# 功能描述：head/tail 命令 - 查看文件开头和结尾
# 难度等级：⭐ 入门
# 知识点：
#   - head 查看文件开头
#   - tail 查看文件结尾
#   - tail -f 实时跟踪日志
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 创建测试文件
seq 1 20 > /tmp/numbers.txt

print_separator
print_color CYAN "head/tail 命令基础用法演示"
print_separator

print_color YELLOW "\n【示例 1】查看前 10 行（head 默认）"
echo "命令：head /tmp/numbers.txt"
head /tmp/numbers.txt

print_color YELLOW "\n【示例 2】查看前 5 行"
echo "命令：head -n 5 /tmp/numbers.txt"
head -n 5 /tmp/numbers.txt

print_color YELLOW "\n【示例 3】查看最后 10 行（tail 默认）"
echo "命令：tail /tmp/numbers.txt"
tail /tmp/numbers.txt

print_color YELLOW "\n【示例 4】查看最后 5 行"
echo "命令：tail -n 5 /tmp/numbers.txt"
tail -n 5 /tmp/numbers.txt

print_color YELLOW "\n【示例 5】实战：查看系统最新登录"
echo "命令：last -n 5"
last -n 5

print_color YELLOW "\n【示例 6】实战：查看 /var/log 最新日志"
echo "命令：tail -n 10 /var/log/syslog 2>/dev/null || echo '需要 root 权限'"
tail -n 10 /var/log/syslog 2>/dev/null || echo '需要 root 权限'

rm -f /tmp/numbers.txt
print_color GREEN "\n演示完成！"

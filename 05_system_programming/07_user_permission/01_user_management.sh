#!/bin/bash
# =============================================================================
# 脚本名称：01_user_management.sh
# 功能描述：用户与权限管理 - 用户、组、权限操作
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 6 - 系统编程
# 知识点：
#   - id 查看用户信息
#   - groups 查看用户组
#   - chmod 修改权限
#   - chown 修改所有者
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "用户与权限管理演示"
print_separator

print_color YELLOW "\n【示例 1】查看当前用户信息"
echo "命令：id"
id

print_color YELLOW "\n【示例 2】查看当前用户所属组"
echo "命令：groups"
groups

print_color YELLOW "\n【示例 3】查看系统用户列表"
echo "命令：cut -d: -f1 /etc/passwd | head -10"
cut -d: -f1 /etc/passwd | head -10

print_color YELLOW "\n【示例 4】查看系统用户组列表"
echo "命令：cut -d: -f1 /etc/group | head -10"
cut -d: -f1 /etc/group | head -10

print_color YELLOW "\n【示例 5】创建测试文件并查看权限"
touch /tmp/test_permission.txt
echo "命令：ls -l /tmp/test_permission.txt"
ls -l /tmp/test_permission.txt

print_color YELLOW "\n【示例 6】修改文件权限（chmod）"
echo "命令：chmod 755 /tmp/test_permission.txt"
chmod 755 /tmp/test_permission.txt
echo "命令：ls -l /tmp/test_permission.txt"
ls -l /tmp/test_permission.txt

print_color YELLOW "\n【示例 7】权限符号表示法"
echo "命令：chmod u+x,g-w,o=r /tmp/test_permission.txt"
chmod u+x,g-w,o=r /tmp/test_permission.txt 2>/dev/null || echo "需要文件所有者权限"
ls -l /tmp/test_permission.txt

print_color YELLOW "\n【示例 8】常见权限说明"
cat << 'EOF'
755 = rwxr-xr-x (所有者可读写执行，其他人可读执行)
644 = rw-r--r-- (所有者可读写，其他人只读)
700 = rwx------ (只有所有者可读写执行)
600 = rw------- (只有所有者可读写)
EOF

rm -f /tmp/test_permission.txt
print_color GREEN "\n演示完成！"
print_separator

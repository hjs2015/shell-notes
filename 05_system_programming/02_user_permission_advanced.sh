#!/bin/bash
# ============================================================================
# 脚本名称：02_user_permission_advanced.sh
# 功能描述：用户权限管理高级 - ACL、sudo 配置、权限审计
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：ACL 访问控制、sudo 配置、权限审计、安全策略
# 使用方法：sudo bash 02_user_permission_advanced.sh
# 依赖命令：getfacl, setfacl, sudoers, id, groups
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================================================${NC}"
}

# 检查 root 权限
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}⚠️  请使用 sudo 运行此脚本${NC}"
    echo "命令：sudo bash $0"
    exit 1
fi

print_header "📌 用户权限管理高级用法"

# ------------------------------------------------------------------------------
# 1. ACL 访问控制列表
# ------------------------------------------------------------------------------
print_header "🔹 ACL 访问控制列表"

# 创建测试目录和文件
TEST_DIR="/tmp/acl_test"
mkdir -p "$TEST_DIR"
touch "$TEST_DIR/file1.txt"
touch "$TEST_DIR/file2.txt"

echo -e "${YELLOW}【创建测试环境】${NC}"
echo "目录：$TEST_DIR"
echo ""

# 检查是否支持 ACL
if command -v getfacl &> /dev/null; then
    echo -e "${YELLOW}【查看文件当前 ACL】${NC}"
    echo "命令：getfacl $TEST_DIR/file1.txt"
    getfacl "$TEST_DIR/file1.txt" 2>/dev/null
    echo ""
    
    echo -e "${YELLOW}【设置用户 ACL 权限】${NC}"
    echo "命令：setfacl -m u:nobody:rw $TEST_DIR/file1.txt"
    setfacl -m u:nobody:rw "$TEST_DIR/file1.txt" 2>/dev/null && echo "✅ 设置成功" || echo "⚠️ 设置失败"
    echo ""
    
    echo -e "${YELLOW}【设置组 ACL 权限】${NC}"
    echo "命令：setfacl -m g:nogroup:r $TEST_DIR/file2.txt"
    setfacl -m g:nogroup:r "$TEST_DIR/file2.txt" 2>/dev/null && echo "✅ 设置成功" || echo "⚠️ 设置失败"
    echo ""
    
    echo -e "${YELLOW}【查看设置后的 ACL】${NC}"
    echo "命令：getfacl $TEST_DIR/file1.txt"
    getfacl "$TEST_DIR/file1.txt" 2>/dev/null
    echo ""
    
    echo -e "${YELLOW}【删除 ACL 权限】${NC}"
    echo "命令：setfacl -x u:nobody $TEST_DIR/file1.txt"
    setfacl -x u:nobody "$TEST_DIR/file1.txt" 2>/dev/null && echo "✅ 删除成功"
    echo ""
    
    echo -e "${YELLOW}【递归设置 ACL】${NC}"
    echo "命令：setfacl -R -m u:nobody:r $TEST_DIR/"
    setfacl -R -m u:nobody:r "$TEST_DIR/" 2>/dev/null && echo "✅ 递归设置成功"
    echo ""
else
    echo -e "${RED}ACL 工具未安装，请先安装：apt install acl 或 yum install acl${NC}"
fi

# ------------------------------------------------------------------------------
# 2. sudo 配置管理
# ------------------------------------------------------------------------------
print_header "🔹 sudo 配置管理"

echo -e "${YELLOW}【sudoers 文件位置】${NC}"
echo "/etc/sudoers"
echo ""

echo -e "${YELLOW}【sudoers.d 目录】${NC}"
echo "命令：ls -la /etc/sudoers.d/"
ls -la /etc/sudoers.d/ 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查看当前用户 sudo 权限】${NC}"
echo "命令：sudo -l"
sudo -l 2>/dev/null | head -20
echo ""

echo -e "${YELLOW}【sudoers 配置示例】${NC}"
cat << 'EOF'
# 允许用户执行所有命令
username ALL=(ALL) ALL

# 允许用户无需密码执行特定命令
username ALL=(ALL) NOPASSWD: /usr/bin/systemctl, /usr/bin/docker

# 允许组执行所有命令
%groupname ALL=(ALL) ALL

# 限制只能从特定主机执行
username server1.example.com=(ALL) ALL
EOF
echo ""

echo -e "${YELLOW}【visudo 命令】${NC}"
echo "编辑 sudoers 文件必须使用 visudo 命令（语法检查）"
echo "命令：visudo"
echo "     visudo -f /etc/sudoers.d/custom"
echo ""

# ------------------------------------------------------------------------------
# 3. 权限审计
# ------------------------------------------------------------------------------
print_header "🔹 权限审计"

echo -e "${YELLOW}【查找 SUID 文件】${NC}"
echo "命令：find /usr -perm -4000 -type f 2>/dev/null | head -10"
find /usr -perm -4000 -type f 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查找 SGID 文件】${NC}"
echo "命令：find /usr -perm -2000 -type f 2>/dev/null | head -10"
find /usr -perm -2000 -type f 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查找全局可写文件】${NC}"
echo "命令：find /tmp -perm -0002 -type f 2>/dev/null | head -10"
find /tmp -perm -0002 -type f 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查找无主文件】${NC}"
echo "命令：find /home -nouser -o -nogroup 2>/dev/null | head -10"
find /home -nouser -o -nogroup 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 4. 用户和组信息
# ------------------------------------------------------------------------------
print_header "🔹 用户和组信息"

echo -e "${YELLOW}【查看用户详细信息】${NC}"
echo "命令：id root"
id root
echo ""

echo -e "${YELLOW}【查看用户所属组】${NC}"
echo "命令：groups root"
groups root
echo ""

echo -e "${YELLOW}【查看最后登录用户】${NC}"
echo "命令：last | head -10"
last | head -10
echo ""

echo -e "${YELLOW}【查看当前登录用户】${NC}"
echo "命令：who"
who
echo ""

echo -e "${YELLOW}【查看用户登录历史】${NC}"
echo "命令：lastlog | head -10"
lastlog | head -10 2>/dev/null
echo ""

# ------------------------------------------------------------------------------
# 5. 安全策略
# ------------------------------------------------------------------------------
print_header "🔹 安全策略"

echo -e "${YELLOW}【密码策略配置】${NC}"
echo "文件：/etc/login.defs"
grep -E "^PASS_MAX_DAYS|^PASS_MIN_DAYS|^PASS_MIN_LEN" /etc/login.defs 2>/dev/null
echo ""

echo -e "${YELLOW}【查看密码过期信息】${NC}"
echo "命令：chage -l root"
chage -l root 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【锁定/解锁用户】${NC}"
echo "锁定：usermod -L username"
echo "解锁：usermod -U username"
echo ""

# ------------------------------------------------------------------------------
# 6. 实用权限管理脚本
# ------------------------------------------------------------------------------
print_header "🔹 实用权限管理脚本"

cat << 'EOF'
#!/bin/bash
# 批量设置目录权限

set_permissions() {
    local dir=$1
    local owner=$2
    local group=$3
    
    chown -R $owner:$group $dir
    find $dir -type d -exec chmod 755 {} \;
    find $dir -type f -exec chmod 644 {} \;
}

# 审计 SUID/SGID 文件
audit_suid_sgid() {
    echo "=== SUID 文件 ==="
    find / -perm -4000 -type f 2>/dev/null
    
    echo "=== SGID 文件 ==="
    find / -perm -2000 -type f 2>/dev/null
}

# 检查弱权限文件
check_weak_permissions() {
    echo "=== 全局可写文件 ==="
    find / -perm -0002 -type f 2>/dev/null
    
    echo "=== 无主文件 ==="
    find / -nouser -o -nogroup 2>/dev/null
}
EOF

# ------------------------------------------------------------------------------
# 清理测试环境
# ------------------------------------------------------------------------------
print_header "🧹 清理测试环境"
rm -rf "$TEST_DIR"
echo "已删除：$TEST_DIR"

print_header "✅ 用户权限管理高级学习完成！"
echo ""
echo -e "${YELLOW}💡 安全提示：${NC}"
echo "1. 定期审计 SUID/SGID 文件"
echo "2. 最小化 sudo 权限"
echo "3. 使用 visudo 编辑 sudoers"
echo "4. 定期检查全局可写文件"
echo ""

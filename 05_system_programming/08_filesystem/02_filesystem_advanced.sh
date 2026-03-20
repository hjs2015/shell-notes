#!/bin/bash
# ============================================================================
# 脚本名称：02_filesystem_advanced.sh
# 功能描述：文件系统管理高级 - 磁盘配额、inode、高级查找、性能优化
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：磁盘配额、inode 管理、find 高级、文件系统性能
# 使用方法：sudo bash 02_filesystem_advanced.sh
# 依赖命令：find, df, du, stat, ls
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 文件系统管理高级"

# ------------------------------------------------------------------------------
# 1. inode 管理
# ------------------------------------------------------------------------------
print_header "🔹 inode 管理"

echo -e "${YELLOW}【查看磁盘 inode 使用】${NC}"
echo "命令：df -i"
df -i | head -10
echo ""

echo -e "${YELLOW}【查看目录 inode 数量】${NC}"
echo "命令：ls -i /tmp"
ls -i /tmp | head -10
echo ""

echo -e "${YELLOW}【查看文件 inode 信息】${NC}"
echo "命令：stat /etc/passwd"
stat /etc/passwd 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 2. find 高级用法
# ------------------------------------------------------------------------------
print_header "🔹 find 高级用法"

echo -e "${YELLOW}【按时间查找（最近 7 天修改）】${NC}"
echo "命令：find /tmp -type f -mtime -7 | head -10"
find /tmp -type f -mtime -7 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【按大小查找（大于 1MB）】${NC}"
echo "命令：find /var -type f -size +1M 2>/dev/null | head -10"
find /var -type f -size +1M 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【按权限查找】${NC}"
echo "命令：find /etc -type f -perm 644 2>/dev/null | head -10"
find /etc -type f -perm 644 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【按所有者查找】${NC}"
echo "命令：find /home -type f -user root 2>/dev/null | head -10"
find /home -type f -user root 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 3. 查找并执行操作
# ------------------------------------------------------------------------------
print_header "🔹 查找并执行操作"

echo -e "${YELLOW}【查找并删除空文件】${NC}"
echo "命令：find /tmp -type f -empty -exec echo '删除：{}' \\;"
find /tmp -type f -empty -exec echo '删除：{}' \; 2>/dev/null | head -5
echo ""

echo -e "${YELLOW}【查找并修改权限】${NC}"
echo "命令：find /tmp -name '*.sh' -exec echo 'chmod +x {}' \\;"
find /tmp -name '*.sh' -exec echo 'chmod +x {}' \; 2>/dev/null | head -5
echo ""

echo -e "${YELLOW}【查找并统计】${NC}"
echo "命令：find /root/.copaw -name '*.md' | wc -l"
find /root/.copaw -name '*.md' 2>/dev/null | wc -l
echo ""

# ------------------------------------------------------------------------------
# 4. 磁盘空间分析
# ------------------------------------------------------------------------------
print_header "🔹 磁盘空间分析"

echo -e "${YELLOW}【查看各目录大小】${NC}"
echo "命令：du -sh /root/.copaw/*/"
du -sh /root/.copaw/*/ 2>/dev/null | sort -h | tail -10
echo ""

echo -e "${YELLOW}【查找最大的 10 个文件】${NC}"
echo "命令：find /var -type f -exec du -h {} \\; 2>/dev/null | sort -n -r | head -10"
find /var -type f -exec du -h {} \; 2>/dev/null | sort -n -r | head -10
echo ""

echo -e "${YELLOW}【查看挂载点】${NC}"
echo "命令：df -h"
df -h | grep -v tmpfs
echo ""

# ------------------------------------------------------------------------------
# 5. 硬链接和软链接
# ------------------------------------------------------------------------------
print_header "🔹 硬链接和软链接"

echo -e "${YELLOW}【创建软链接】${NC}"
echo "命令：ln -s /etc/passwd /tmp/passwd_link"
ln -sf /etc/passwd /tmp/passwd_link 2>/dev/null && echo "✅ 创建成功" || echo "⚠️ 创建失败"
echo ""

echo -e "${YELLOW}【查找硬链接数大于 1 的文件】${NC}"
echo "命令：find /etc -type f -links +1 2>/dev/null | head -10"
find /etc -type f -links +1 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查看链接信息】${NC}"
echo "命令：ls -li /tmp/passwd_link /etc/passwd"
ls -li /tmp/passwd_link /etc/passwd 2>/dev/null
echo ""

# ------------------------------------------------------------------------------
# 6. 文件系统统计
# ------------------------------------------------------------------------------
print_header "🔹 文件系统统计"

echo -e "${YELLOW}【统计文件类型】${NC}"
echo "命令：find /tmp -type f | sed 's/.*\.//' | sort | uniq -c | sort -n -r | head -10"
find /tmp -type f 2>/dev/null | sed 's/.*\.//' | sort | uniq -c | sort -n -r | head -10
echo ""

echo -e "${YELLOW}【统计各用户文件数】${NC}"
echo "命令：find /home -type f 2>/dev/null | xargs stat -c '%U' | sort | uniq -c"
find /home -type f 2>/dev/null | xargs stat -c '%U' 2>/dev/null | sort | uniq -c | head -10
echo ""

# ------------------------------------------------------------------------------
# 7. 清理临时文件
# ------------------------------------------------------------------------------
print_header "🔹 清理临时文件"

echo -e "${YELLOW}【查找 30 天未访问的文件】${NC}"
echo "命令：find /tmp -type f -atime +30 | head -10"
find /tmp -type f -atime +30 2>/dev/null | head -10
echo ""

echo -e "${YELLOW}【查找缓存文件】${NC}"
echo "命令：find /var/cache -type f -atime +7 2>/dev/null | head -10"
find /var/cache -type f -atime +7 2>/dev/null | head -10
echo ""

# ------------------------------------------------------------------------------
# 8. 实用脚本模板
# ------------------------------------------------------------------------------
print_header "🔹 实用脚本模板"

cat << 'EOF'
#!/bin/bash
# 磁盘空间检查脚本

check_disk_usage() {
    local threshold=80
    local usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ $usage -gt $threshold ]; then
        echo "⚠️  磁盘使用率超过 ${threshold}%：${usage}%"
        # 可在此添加告警逻辑
    else
        echo "✅ 磁盘使用率正常：${usage}%"
    fi
}

# 查找大文件
find_large_files() {
    local size=${1:-100M}
    echo "查找大于 $size 的文件："
    find / -type f -size +$size 2>/dev/null | head -20
}

# 清理旧日志
cleanup_old_logs() {
    local days=${1:-30}
    echo "清理 $days 天前的日志："
    find /var/log -name '*.log' -mtime +$days -exec rm -f {} \;
}
EOF

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/passwd_link
print_example "清理完成" "rm -f /tmp/passwd_link"

print_header "✅ 文件系统管理高级学习完成！"

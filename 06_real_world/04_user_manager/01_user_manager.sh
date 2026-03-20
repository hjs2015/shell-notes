#!/bin/bash
# ============================================================================
# 脚本名称：01_user_manager.sh
# 功能描述：用户管理系统 - 创建/删除/修改用户、批量操作、权限管理
# 难度等级：⭐⭐⭐⭐⭐ 专家级
# 知识点：用户管理、批量操作、权限控制、交互式输入
# 使用方法：bash 01_user_manager.sh
# 依赖命令：useradd, userdel, usermod, passwd, id
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }

check_root() {
    if [ "$EUID" -ne 0 ]; then
        print_error "请使用 root 权限运行此脚本"
        exit 1
    fi
}

print_header "👥 用户管理系统"

# 菜单
show_menu() {
    echo ""
    echo "请选择操作："
    echo "1. 创建单个用户"
    echo "2. 批量创建用户"
    echo "3. 删除用户"
    echo "4. 修改用户信息"
    echo "5. 查看用户详情"
    echo "6. 列出所有用户"
    echo "7. 锁定/解锁用户"
    echo "0. 退出"
    echo ""
}

# 创建单个用户
create_user() {
    print_header "创建单个用户"
    
    read -p "请输入用户名： " username
    read -p "请输入用户全名： " fullname
    read -p "请输入主目录（默认 /home/$username）： " homedir
    homedir=${homedir:-/home/$username}
    read -p "请输入登录 Shell（默认 /bin/bash）： " shell
    shell=${shell:-/bin/bash}
    
    if id "$username" &>/dev/null; then
        print_error "用户已存在：$username"
        return 1
    fi
    
    useradd -c "$fullname" -d "$homedir" -s "$shell" -m "$username"
    if [ $? -eq 0 ]; then
        print_success "用户创建成功：$username"
        
        read -p "是否设置密码？(y/n): " setpwd
        if [ "$setpwd" = "y" ]; then
            passwd "$username"
        fi
    else
        print_error "用户创建失败：$username"
        return 1
    fi
}

# 批量创建用户
batch_create_users() {
    print_header "批量创建用户"
    
    read -p "请输入用户列表文件（每行一个用户名）： " userfile
    
    if [ ! -f "$userfile" ]; then
        print_error "文件不存在：$userfile"
        return 1
    fi
    
    local count=0
    local success=0
    local failed=0
    
    while IFS= read -r username; do
        [[ -z "$username" || "$username" =~ ^# ]] && continue
        ((count++))
        
        if id "$username" &>/dev/null; then
            print_warning "用户已存在，跳过：$username"
            ((failed++))
            continue
        fi
        
        useradd -m "$username" 2>/dev/null
        if [ $? -eq 0 ]; then
            print_success "创建成功：$username"
            ((success++))
        else
            print_error "创建失败：$username"
            ((failed++))
        fi
    done < "$userfile"
    
    echo ""
    echo "批量创建完成："
    echo "  总计：$count"
    echo "  成功：$success"
    echo "  失败：$failed"
}

# 删除用户
delete_user() {
    print_header "删除用户"
    
    read -p "请输入要删除的用户名： " username
    
    if ! id "$username" &>/dev/null; then
        print_error "用户不存在：$username"
        return 1
    fi
    
    read -p "是否同时删除主目录？(y/n): " remove_home
    
    if [ "$remove_home" = "y" ]; then
        userdel -r "$username"
    else
        userdel "$username"
    fi
    
    if [ $? -eq 0 ]; then
        print_success "用户删除成功：$username"
    else
        print_error "用户删除失败：$username"
    fi
}

# 修改用户信息
modify_user() {
    print_header "修改用户信息"
    
    read -p "请输入用户名： " username
    
    if ! id "$username" &>/dev/null; then
        print_error "用户不存在：$username"
        return 1
    fi
    
    echo "当前用户信息："
    id "$username"
    
    echo ""
    echo "请选择要修改的内容："
    echo "1. 修改用户名"
    echo "2. 修改主目录"
    echo "3. 修改 Shell"
    echo "4. 修改用户组"
    echo "5. 锁定账户"
    echo "6. 解锁账户"
    read -p "请选择（1-6）： " choice
    
    case $choice in
        1)
            read -p "请输入新用户名： " newname
            usermod -l "$newname" "$username"
            print_success "用户名已修改：$username → $newname"
            ;;
        2)
            read -p "请输入新主目录： " newhome
            usermod -d "$newhome" -m "$username"
            print_success "主目录已修改：$newhome"
            ;;
        3)
            read -p "请输入新 Shell： " newshell
            usermod -s "$newshell" "$username"
            print_success "Shell 已修改：$newshell"
            ;;
        4)
            read -p "请输入新主组： " newgroup
            usermod -g "$newgroup" "$username"
            print_success "主组已修改：$newgroup"
            ;;
        5)
            passwd -l "$username"
            print_success "账户已锁定：$username"
            ;;
        6)
            passwd -u "$username"
            print_success "账户已解锁：$username"
            ;;
        *)
            print_error "无效选择"
            ;;
    esac
}

# 查看用户详情
show_user_info() {
    print_header "查看用户详情"
    
    read -p "请输入用户名： " username
    
    if ! id "$username" &>/dev/null; then
        print_error "用户不存在：$username"
        return 1
    fi
    
    echo ""
    echo "=== 用户基本信息 ==="
    id "$username"
    
    echo ""
    echo "=== 密码状态 ==="
    passwd -S "$username" 2>/dev/null || chage -l "$username"
    
    echo ""
    echo "=== 最后登录 ==="
    lastlog -u "$username" 2>/dev/null || echo "无登录记录"
    
    echo ""
    echo "=== 所属组 ==="
    groups "$username"
}

# 列出所有用户
list_users() {
    print_header "系统所有用户"
    
    echo ""
    printf "%-20s %-10s %-30s\n" "用户名" "UID" "主目录"
    echo "----------------------------------------------------------------------------"
    
    while IFS=: read -r username _ uid _ _ homedir _; do
        if [ "$uid" -ge 1000 ] || [ "$username" = "root" ]; then
            printf "%-20s %-10s %-30s\n" "$username" "$uid" "$homedir"
        fi
    done < /etc/passwd
    
    echo ""
    echo "总用户数：$(wc -l < /etc/passwd)"
    echo "普通用户：$(awk -F: '$3 >= 1000 && $3 < 65534 {count++} END {print count}' /etc/passwd)"
}

# 锁定/解锁用户
lock_unlock_user() {
    print_header "锁定/解锁用户"
    
    read -p "请输入用户名： " username
    
    if ! id "$username" &>/dev/null; then
        print_error "用户不存在：$username"
        return 1
    fi
    
    # 检查当前状态
    if passwd -S "$username" 2>/dev/null | grep -q "L"; then
        status="已锁定"
    else
        status="正常"
    fi
    
    echo "当前状态：$status"
    
    if [ "$status" = "已锁定" ]; then
        read -p "是否解锁？(y/n): " action
        if [ "$action" = "y" ]; then
            passwd -u "$username"
            print_success "账户已解锁"
        fi
    else
        read -p "是否锁定？(y/n): " action
        if [ "$action" = "y" ]; then
            passwd -l "$username"
            print_success "账户已锁定"
        fi
    fi
}

# 主循环
check_root

while true; do
    show_menu
    read -p "请选择操作（0-7）： " choice
    
    case $choice in
        1) create_user ;;
        2) batch_create_users ;;
        3) delete_user ;;
        4) modify_user ;;
        5) show_user_info ;;
        6) list_users ;;
        7) lock_unlock_user ;;
        0)
            print_success "退出系统"
            exit 0
            ;;
        *)
            print_error "无效选择，请重新输入"
            ;;
    esac
    
    echo ""
    read -p "按回车键继续..."
done

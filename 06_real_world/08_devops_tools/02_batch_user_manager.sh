#!/bin/bash
# =============================================================================
# 脚本名称：02_batch_user_manager.sh
# 功能描述：批量用户管理 - 创建、删除、管理多个用户
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - useradd/userdel 用户管理
#   - groupadd 组管理
#   - passwd 密码设置
#   - 文件读取（while read）
#   - 随机密码生成
#   - 日志记录
# 使用方法：
#   chmod +x 02_batch_user_manager.sh
#   sudo ./02_batch_user_manager.sh create users.txt  # 批量创建
#   sudo ./02_batch_user_manager.sh delete users.txt # 批量删除
#   sudo ./02_batch_user_manager.sh list             # 列出用户
# 参数说明：
#   $1 - 操作类型：create, delete, list
#   $2 - 用户列表文件（create/delete 时需要）
# 示例文件 users.txt：
#   zhangsan
#   lisi
#   wangwu
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 日志文件
LOG_FILE="/var/log/user_manager.log"

# 记录日志
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
}

# 生成随机密码
generate_password() {
    cat /dev/urandom | tr -dc 'A-Za-z0-9!@#$%' | head -c 12
}

# 创建用户
create_user() {
    local username=$1
    local password=$(generate_password)
    
    # 检查用户是否已存在
    if id "$username" &>/dev/null; then
        echo -e "${YELLOW}用户 $username 已存在，跳过${NC}"
        log "SKIP: 用户 $username 已存在"
        return 1
    fi
    
    # 创建用户
    useradd -m -s /bin/bash "$username"
    
    # 设置密码
    echo "$username:$password" | chpasswd
    
    # 设置密码永不过期
    chage -M -1 "$username"
    
    echo -e "${GREEN}✓ 创建用户：$username (密码：$password)${NC}"
    log "CREATE: 用户 $username 创建成功"
    
    # 保存密码到文件
    echo "$username:$password" >> ./created_users_passwords.txt
}

# 删除用户
delete_user() {
    local username=$1
    
    # 检查用户是否存在
    if ! id "$username" &>/dev/null; then
        echo -e "${YELLOW}用户 $username 不存在，跳过${NC}"
        log "SKIP: 用户 $username 不存在"
        return 1
    fi
    
    # 删除用户及其家目录
    userdel -r "$username"
    
    echo -e "${GREEN}✓ 删除用户：$username${NC}"
    log "DELETE: 用户 $username 删除成功"
}

# 列出指定用户
list_users() {
    echo -e "${GREEN}=== 系统用户列表 ===${NC}"
    
    if [ -f "$1" ]; then
        echo -e "${YELLOW}检查文件中的用户：${NC}"
        while read -r username; do
            # 跳过空行和注释
            [[ -z "$username" || "$username" =~ ^# ]] && continue
            
            if id "$username" &>/dev/null; then
                echo -e "${GREEN}✓ $username - 存在${NC}"
            else
                echo -e "${RED}✗ $username - 不存在${NC}"
            fi
        done < "$1"
    else
        echo "用法：$0 list <用户列表文件>"
    fi
}

# 显示用法
usage() {
    echo "用法：$0 <操作> [用户列表文件]"
    echo ""
    echo "操作:"
    echo "  create <文件>  - 批量创建用户"
    echo "  delete <文件>  - 批量删除用户"
    echo "  list <文件>    - 检查用户是否存在"
    echo ""
    echo "示例:"
    echo "  $0 create users.txt"
    echo "  $0 delete users.txt"
    echo "  $0 list users.txt"
}

# 主函数
main() {
    # 检查是否 root 用户
    if [ $EUID -ne 0 ]; then
        echo -e "${RED}错误：需要 root 权限运行${NC}"
        echo "请使用：sudo $0 $@"
        exit 1
    fi
    
    # 检查参数
    if [ $# -lt 1 ]; then
        usage
        exit 1
    fi
    
    local action=$1
    local user_file=$2
    
    case $action in
        create)
            if [ ! -f "$user_file" ]; then
                echo -e "${RED}错误：文件 $user_file 不存在${NC}"
                exit 1
            fi
            
            echo -e "${GREEN}开始批量创建用户...${NC}"
            log "=== 开始批量创建用户 ==="
            
            while read -r username; do
                # 跳过空行和注释
                [[ -z "$username" || "$username" =~ ^# ]] && continue
                create_user "$username"
            done < "$user_file"
            
            echo -e "${GREEN}创建完成！密码已保存到：./created_users_passwords.txt${NC}"
            log "=== 批量创建用户完成 ==="
            ;;
            
        delete)
            if [ ! -f "$user_file" ]; then
                echo -e "${RED}错误：文件 $user_file 不存在${NC}"
                exit 1
            fi
            
            echo -e "${YELLOW}警告：即将删除以下用户：${NC}"
            cat "$user_file"
            read -p "确认删除？(y/n): " confirm
            
            if [ "$confirm" != "y" ]; then
                echo "操作已取消"
                exit 0
            fi
            
            echo -e "${GREEN}开始批量删除用户...${NC}"
            log "=== 开始批量删除用户 ==="
            
            while read -r username; do
                [[ -z "$username" || "$username" =~ ^# ]] && continue
                delete_user "$username"
            done < "$user_file"
            
            echo -e "${GREEN}删除完成！${NC}"
            log "=== 批量删除用户完成 ==="
            ;;
            
        list)
            list_users "$user_file"
            ;;
            
        *)
            echo -e "${RED}未知操作：$action${NC}"
            usage
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"

# 说明：
# 1. 支持批量创建和删除用户
# 2. 自动生成随机密码
# 3. 记录操作日志
# 4. 有确认机制防止误删
# 5. 支持检查用户是否存在

# 安全提示：
# 1. 密码文件要妥善保管
# 2. 删除操作要谨慎
# 3. 建议先测试再生产使用

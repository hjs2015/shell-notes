#!/bin/bash
#===============================================================================
# 脚本名称：11_command_history.sh
# 功能描述：演示 Shell 命令历史记忆功能及高级用法
# 难度等级：★☆☆☆☆ (初级)
# 知识点：
#   - history 命令查看历史
#   - !n 执行第 n 条历史命令
#   - !string 执行最近以 string 开头的命令
#   - !$ 引用最后一个参数
#   - !! 执行上一条命令
#   - ^R 搜索历史 (交互式)
#   - history -c 清空历史
# 使用方法：
#   chmod +x 11_command_history.sh
#   ./11_command_history.sh
# 参考来源：cnblogs Shell 指南 2.1 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 命令历史记忆功能"
    print_separator
    echo
    
    print_title "1. history 命令 - 查看历史"
    echo "  查看最近 10 条历史:"
    echo "    history 10"
    history 10 | sed 's/^/    /'
    echo
    echo "  查看历史总数:"
    echo "    history | wc -l"
    history | wc -l | sed 's/^/    /'
    echo
    
    print_title "2. !n - 执行第 n 条历史命令"
    echo "  示例：!123 执行第 123 条历史命令"
    echo "  用法：先 history 查看编号，然后 !编号 执行"
    echo
    
    print_title "3. !string - 执行最近以 string 开头的命令"
    echo "  示例：!ls 执行最近一条以 ls 开头的命令"
    echo "  示例：!git 执行最近一条以 git 开头的命令"
    echo
    
    print_title "4. !$ - 引用最后一个参数"
    echo "  示例:"
    echo "    mkdir /tmp/test"
    echo "    cd !$    # 等价于 cd /tmp/test"
    echo
    
    print_title "5. !! - 执行上一条命令"
    echo "  示例：需要 sudo 权限时"
    echo "    cat /etc/shadow"
    echo "    # 提示权限不足"
    echo "    sudo !!  # 等价于 sudo cat /etc/shadow"
    echo
    
    print_title "6. ^R - 搜索历史 (交互式)"
    echo "  用法：在终端按 Ctrl+R，然后输入关键词搜索"
    echo "  示例：(reverse-i-search)\`git': git status"
    echo
    
    print_title "7. 其他快捷方式"
    echo "  !#      - 执行当前行的所有命令"
    echo "  !-n     - 执行倒数第 n 条命令"
    echo "  !?:string?  - 执行最近包含 string 的命令"
    echo
    
    print_title "8. 配置历史"
    echo "  在 ~/.bashrc 中配置:"
    echo "    HISTSIZE=10000        # 历史命令数量"
    echo "    HISTFILESIZE=20000    # 历史文件大小"
    echo "    HISTTIMEFORMAT='%F %T '  # 显示时间戳"
    echo "    HISTCONTROL=ignoredups  # 忽略重复命令"
    echo
    
    print_separator
}

main "$@"

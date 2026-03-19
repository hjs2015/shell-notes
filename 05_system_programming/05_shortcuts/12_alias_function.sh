#!/bin/bash
#===============================================================================
# 脚本名称：12_alias_function.sh
# 功能描述：演示 Shell 别名功能的定义、使用和配置
# 难度等级：★☆☆☆☆ (初级)
# 知识点：
#   - alias 查看别名
#   - alias name='command' 定义别名
#   - unalias name 删除别名
#   - 临时别名与永久别名
#   - 别名优先级
#   - \command 忽略别名
# 使用方法：
#   chmod +x 12_alias_function.sh
#   ./12_alias_function.sh
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
    printf "${YELLOW}%-70s${NC}\n" "Shell 别名功能详解"
    print_separator
    echo
    
    print_title "1. alias 命令 - 查看当前别名"
    echo "  查看所有别名:"
    echo "    alias"
    echo "  常用别名示例:"
    alias | grep -E "^(alias ll|alias la|alias grep|alias rm)" | head -5 | sed 's/^/    /'
    echo
    
    print_title "2. 定义别名"
    echo "  临时别名 (当前会话有效):"
    echo "    alias ll='ls -alF'"
    echo "    alias la='ls -A'"
    echo "    alias h='history'"
    echo
    
    # 创建临时别名演示
    alias ll='ls -alF'
    alias h='history'
    print_info "已创建临时别名：ll='ls -alF', h='history'"
    echo
    
    print_title "3. 使用别名"
    echo "  直接使用别名:"
    echo "    ll /etc/hosts"
    ll /etc/hosts 2>/dev/null | head -3 | sed 's/^/    /'
    echo
    
    print_title "4. unalias 命令 - 删除别名"
    echo "  删除单个别名:"
    echo "    unalias ll"
    echo
    echo "  删除所有别名:"
    echo "    unalias -a"
    echo
    
    print_title "5. 永久别名配置"
    echo "  在 ~/.bashrc 中添加:"
    echo "    # 常用别名"
    echo "    alias ll='ls -alF'"
    echo "    alias la='ls -A'"
    echo "    alias grep='grep --color=auto'"
    echo "    alias rm='rm -i'        # 删除前确认"
    echo "    alias cp='cp -i'        # 覆盖前确认"
    echo "    alias mv='mv -i'        # 覆盖前确认"
    echo "    alias ..='cd ..'"
    echo "    alias ...='cd ../..'"
    echo
    echo "  使配置生效:"
    echo "    source ~/.bashrc"
    echo
    
    print_title "6. 别名优先级"
    echo "  优先级顺序：别名 > 函数 > 内置命令 > 外部命令"
    echo
    echo "  示例：如果定义了 alias ls='ls --color=auto'"
    echo "  执行 ls 时，会使用带颜色的 ls"
    echo
    
    print_title "7. 忽略别名"
    echo "  使用 \\命令 忽略别名:"
    echo "    \\ls    # 使用原始 ls 命令，不使用别名"
    echo
    echo "  使用 command 命令:"
    echo "    command ls    # 同样忽略别名"
    echo
    
    print_title "8. 查看命令类型"
    echo "  type 命令可以查看命令类型:"
    echo "    type ls"
    type ls 2>&1 | sed 's/^/    /'
    echo
    echo "    type ll"
    type ll 2>&1 | sed 's/^/    /'
    echo
    
    print_title "9. 实用别名推荐"
    printf "${YELLOW}%-30s %s${NC}\n" "别名" "说明"
    printf "%-30s %s\n" "------------------------------" "------------------"
    printf "%-30s %s\n" "alias ll='ls -alF'" "详细列表"
    printf "%-30s %s\n" "alias la='ls -A'" "显示所有文件 (不含. ..)"
    printf "%-30s %s\n" "alias grep='grep --color=auto'" "高亮匹配"
    printf "%-30s %s\n" "alias rm='rm -i'" "删除前确认"
    printf "%-30s %s\n" "alias cp='cp -i'" "覆盖前确认"
    printf "%-30s %s\n" "alias mv='mv -i'" "覆盖前确认"
    printf "%-30s %s\n" "alias ..='cd ..'" "返回上级"
    printf "%-30s %s\n" "alias ...='cd ../..'" "返回上两级"
    printf "%-30s %s\n" "alias cls='clear'" "清屏"
    printf "%-30s %s\n" "alias h='history'" "查看历史"
    printf "%-30s %s\n" "alias df='df -h'" "人类可读磁盘"
    printf "%-30s %s\n" "alias du='du -h'" "人类可读目录"
    printf "%-30s %s\n" "alias top='htop'" "更好的 top"
    printf "%-30s %s\n" "alias ping='ping -c 4'" "ping 4 次"
    echo
    
    print_separator
    print_info "总结:"
    echo "  ✅ alias - 查看/定义别名"
    echo "  ✅ unalias - 删除别名"
    echo "  ✅ 临时别名：当前会话有效"
    echo "  ✅ 永久别名：写入 ~/.bashrc"
    echo "  ✅ \\command - 忽略别名"
    echo "  ✅ type - 查看命令类型"
    print_separator
}

main "$@"

#!/bin/bash
#===============================================================================
# 脚本名称：10_shell_initialization.sh
# 功能描述：演示 Shell 登录初始化文件及其加载顺序
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - 系统级初始化文件：/etc/profile, /etc/bashrc
#   - 用户级初始化文件：~/.bash_profile, ~/.bashrc, ~/.bash_logout
#   - Login Shell 与 Non-Login Shell 的区别
#   - su 与 su - 的区别
#   - 初始化文件加载顺序
# 使用方法：
#   chmod +x 10_shell_initialization.sh
#   ./10_shell_initialization.sh
# 示例输出：
#   【系统级初始化文件】
#   /etc/profile - 系统级配置，所有用户生效
#   /etc/bashrc - 系统级 bash 配置
#   【用户级初始化文件】
#   ~/.bash_profile - 登录时加载
#   ~/.bashrc - 每次打开终端加载
#   ~/.bash_logout - 登出时执行
#   【su vs su -】
#   su user - 半切换，不加载用户配置
#   su - user - 全切换，加载用户配置
# 参考来源：cnblogs Shell 指南 2.1 节
#===============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 打印分隔线
print_separator() {
    printf "${BLUE}===============================================================================${NC}\n"
}

# 打印标题
print_title() {
    printf "${YELLOW}【%s】${NC}\n" "$1"
}

# 打印信息
print_info() {
    printf "${GREEN}%s${NC}\n" "$1"
}

# 打印文件内容预览
print_file_preview() {
    local file=$1
    local desc=$2
    
    if [ -f "$file" ]; then
        printf "${CYAN}%-35s${NC} %s\n" "$file" "$desc"
        if [ -s "$file" ]; then
            echo "  前 3 行预览:"
            head -3 "$file" | sed 's/^/    /'
        else
            echo "  (空文件)"
        fi
    else
        printf "${RED}%-35s${NC} %s (不存在)\n" "$file" "$desc"
    fi
    echo
}

#===============================================================================
# 演示 1: 系统级初始化文件
#===============================================================================
show_system_files() {
    print_title "系统级初始化文件 (对所有用户生效)"
    echo
    
    print_file_preview "/etc/profile" "系统级登录配置"
    print_file_preview "/etc/bashrc" "系统级 bash 配置"
    print_file_preview "/etc/bash.bashrc" "备用系统级配置 (某些发行版)"
    
    print_info "说明:"
    echo "  - /etc/profile: 系统级登录时加载，设置环境变量、PATH 等"
    echo "  - /etc/bashrc: 系统级每次打开 bash 时加载，设置提示符、别名等"
    echo "  - 这些文件需要 root 权限修改"
    echo
}

#===============================================================================
# 演示 2: 用户级初始化文件
#===============================================================================
show_user_files() {
    print_title "用户级初始化文件 (仅对当前用户生效)"
    echo
    
    print_file_preview "$HOME/.bash_profile" "用户登录时加载"
    print_file_preview "$HOME/.bashrc" "每次打开终端加载"
    print_file_preview "$HOME/.bash_logout" "登出时执行"
    print_file_preview "$HOME/.profile" "备用登录配置 (某些系统)"
    
    print_info "说明:"
    echo "  - ~/.bash_profile: 登录 shell 时加载一次"
    echo "  - ~/.bashrc: 每次打开新终端都加载"
    echo "  - ~/.bash_logout: 退出登录时执行 (清理临时文件等)"
    echo "  - 通常在 ~/.bash_profile 中 source ~/.bashrc"
    echo
}

#===============================================================================
# 演示 3: 加载顺序
#===============================================================================
show_load_order() {
    print_title "初始化文件加载顺序"
    echo
    
    print_info "Login Shell (登录 shell) 加载顺序:"
    echo "  1. /etc/profile (系统级)"
    echo "  2. ~/.bash_profile (用户级，优先级最高)"
    echo "  3. ~/.bash_login (如果~/.bash_profile 不存在)"
    echo "  4. ~/.profile (如果上面两个都不存在)"
    echo "  5. ~/.bashrc (通常在~/.bash_profile 中被 source)"
    echo "  6. /etc/bashrc (在~/.bashrc 中被 source)"
    echo
    
    print_info "Non-Login Shell (非登录 shell) 加载顺序:"
    echo "  1. ~/.bashrc (用户级)"
    echo "  2. /etc/bashrc (系统级)"
    echo
    
    print_info "如何判断是否为 Login Shell:"
    echo "  shopt -q login_shell && echo '是登录 shell' || echo '不是登录 shell'"
    
    if shopt -q login_shell; then
        print_info "✅ 当前是 Login Shell"
    else
        print_info "❌ 当前不是 Login Shell"
    fi
    echo
}

#===============================================================================
# 演示 4: su vs su -
#===============================================================================
show_su_difference() {
    print_title "su 与 su - 的区别"
    echo
    
    print_info "su username (半切换):"
    echo "  - 切换到用户，但不加载用户的登录配置"
    echo "  - 保留当前环境变量 (PATH 等)"
    echo "  - 工作目录不变"
    echo "  - 触发：/etc/bashrc, ~/.bashrc"
    echo
    
    print_info "su - username (全切换):"
    echo "  - 完全切换到用户，加载用户的所有配置"
    echo "  - 使用用户的环境变量"
    echo "  - 工作目录切换到用户家目录"
    echo "  - 触发：/etc/profile, /etc/bashrc, ~/.bash_profile, ~/.bashrc"
    echo
    
    print_info "实际例子:"
    echo "  # 当前是 root 用户"
    echo "  [root@server ~]# echo \$PATH"
    echo "  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin"
    echo
    echo "  # 半切换 (保留 root 的 PATH)"
    echo "  [root@server ~]# su testuser"
    echo "  [testuser@server root]# echo \$PATH"
    echo "  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin  # 还是 root 的!"
    echo
    echo "  # 全切换 (使用 testuser 的 PATH)"
    echo "  [root@server ~]# su - testuser"
    echo "  [testuser@server ~]# echo \$PATH"
    echo "  /usr/local/bin:/bin:/usr/bin:/home/testuser/bin  # testuser 的 PATH"
    echo
    
    print_info "最佳实践:"
    echo "  ✅ 始终使用 'su - username' 进行用户切换"
    echo "  ❌ 避免使用 'su username' (可能导致环境变量混乱)"
    echo
}

#===============================================================================
# 演示 5: 如何触发不同类型的 shell
#===============================================================================
show_shell_types() {
    print_title "如何触发不同类型的 Shell"
    echo
    
    print_info "Login Shell (登录 shell):"
    echo "  1. 通过 SSH 远程登录"
    echo "  2. 在终端按 Ctrl+Alt+F1~F6 切换到虚拟控制台"
    echo "  3. 使用 'su - username' 切换用户"
    echo "  4. 使用 'bash -l' 或 'bash --login' 启动"
    echo
    
    print_info "Non-Login Shell (非登录 shell):"
    echo "  1. 打开图形界面下的终端窗口"
    echo "  2. 在 shell 中直接运行 'bash'"
    echo "  3. 使用 'su username' (不带-) 切换用户"
    echo "  4. 执行脚本时 (#!/bin/bash)"
    echo
    
    print_info "交互式 vs 非交互式:"
    echo "  - 交互式：可以输入命令 (终端)"
    echo "  - 非交互式：执行脚本，不能输入命令"
    echo
    
    print_info "检测命令:"
    echo "  # 检查是否为 login shell"
    echo "  shopt -q login_shell && echo 'Login' || echo 'Non-login'"
    echo
    echo "  # 检查是否为交互式 shell"
    echo "  [[ \$- == *i* ]] && echo 'Interactive' || echo 'Non-interactive'"
    echo
}

#===============================================================================
# 演示 6: 实际应用示例
#===============================================================================
show_practical_examples() {
    print_title "实际应用示例"
    echo
    
    print_info "示例 1: 在~/.bashrc 中添加自定义别名"
    echo "  # 编辑 ~/.bashrc"
    echo "  vim ~/.bashrc"
    echo
    echo "  # 添加以下内容"
    echo "  alias ll='ls -alF'"
    echo "  alias la='ls -A'"
    echo "  alias grep='grep --color=auto'"
    echo
    echo "  # 使配置生效"
    echo "  source ~/.bashrc"
    echo
    
    print_info "示例 2: 在~/.bash_profile 中设置环境变量"
    echo "  # 编辑 ~/.bash_profile"
    echo "  vim ~/.bash_profile"
    echo
    echo "  # 添加以下内容"
    echo "  export JAVA_HOME=/usr/lib/jvm/java-11"
    echo "  export PATH=\$JAVA_HOME/bin:\$PATH"
    echo
    echo "  # 使配置生效 (需要 login shell)"
    echo "  source ~/.bash_profile"
    echo "  # 或"
    echo "  bash -l"
    echo
    
    print_info "示例 3: 在~/.bash_logout 中清理临时文件"
    echo "  # 编辑 ~/.bash_logout"
    echo "  vim ~/.bash_logout"
    echo
    echo "  # 添加以下内容"
    echo "  rm -rf /tmp/\$USER-*"
    echo "  echo '临时文件已清理'"
    echo
    
    print_info "示例 4: 在脚本中加载用户配置"
    echo "  #!/bin/bash"
    echo "  # 如果需要用户的环境变量"
    echo "  source ~/.bashrc"
    echo "  # 或"
    echo "  source /etc/profile"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 初始化文件详解"
    print_separator
    echo
    
    show_system_files
    show_user_files
    show_load_order
    show_su_difference
    show_shell_types
    show_practical_examples
    
    print_separator
    print_info "总结:"
    echo "  ✅ /etc/profile - 系统级登录配置"
    echo "  ✅ /etc/bashrc - 系统级 bash 配置"
    echo "  ✅ ~/.bash_profile - 用户级登录配置 (优先级最高)"
    echo "  ✅ ~/.bashrc - 用户级每次终端配置"
    echo "  ✅ ~/.bash_logout - 用户登出配置"
    echo "  ✅ su - user - 完全切换，加载用户配置"
    echo "  ✅ su user - 半切换，不加载用户配置"
    print_separator
}

# 调用主函数
main "$@"

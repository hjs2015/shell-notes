#!/bin/bash
#===============================================================================
# 脚本名称：13_grep_advanced.sh
# 功能描述：演示 grep 命令的高级用法
# 难度等级：★★★☆☆ (中高级)
# 知识点：
#   - 正则表达式匹配
#   - 多模式匹配
#   - 上下文显示
#   - 递归搜索
#   - 排除模式
# 使用方法：
#   chmod +x 13_grep_advanced.sh
#   ./13_grep_advanced.sh
# 参考来源：cnblogs Shell 指南 2.8 节
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
    printf "${YELLOW}%-70s${NC}\n" "grep 高级用法"
    print_separator
    echo
    
    print_title "1. 基本选项"
    printf "${YELLOW}%-20s %s${NC}\n" "选项" "说明"
    printf "%-20s %s\n" "--------------------" "------------------"
    printf "%-20s %s\n" "-i" "忽略大小写"
    printf "%-20s %s\n" "-v" "反向匹配 (排除)"
    printf "%-20s %s\n" "-n" "显示行号"
    printf "%-20s %s\n" "-c" "统计匹配行数"
    printf "%-20s %s\n" "-l" "只显示文件名"
    printf "%-20s %s\n" "-L" "显示不匹配的文件"
    printf "%-20s %s\n" "-h" "不显示文件名"
    printf "%-20s %s\n" "-H" "显示文件名"
    echo
    
    print_title "2. 正则表达式"
    printf "${YELLOW}%-20s %-30s %s${NC}\n" "模式" "示例" "说明"
    printf "%-20s %-30s %s\n" "--------------------" "------------------------------" "------------------"
    printf "%-20s %-30s %s\n" "^pattern" "grep \"^error\"" "行首匹配"
    printf "%-20s %-30s %s\n" "pattern\$" "grep \"error\$\"" "行尾匹配"
    printf "%-20s %-30s %s\n" "." "grep \"a.c\"" "任意单个字符"
    printf "%-20s %-30s %s\n" "*" "grep \"ab*c\"" "前字符 0 或多次"
    printf "%-20s %-30s %s\n" ".*" "grep \"a.*b\"" "任意字符 0 或多次"
    printf "%-20s %-30s %s\n" "[...]" "grep \"[ae]rror\"" "字符集合"
    printf "%-20s %-30s %s\n" "[^...]" "grep \"[^e]rror\"" "排除字符"
    printf "%-20s %-30s %s\n" "\\{n\\}" "grep \"a\\{3\\}\"" "精确 n 次"
    printf "%-20s %-30s %s\n" "\\{n,\\}" "grep \"a\\{3,\\}\"" "至少 n 次"
    printf "%-20s %-30s %s\n" "\\{n,m\\}" "grep \"a\\{2,4\\}\"" "n 到 m 次"
    echo
    
    print_title "3. 扩展正则 (-E 或 egrep)"
    printf "${YELLOW}%-20s %-30s %s${NC}\n" "模式" "示例" "说明"
    printf "%-20s %-30s %s\n" "--------------------" "------------------------------" "------------------"
    printf "%-20s %-30s %s\n" "+" "grep -E \"a+\"" "1 次或多次"
    printf "%-20s %-30s %s\n" "?" "grep -E \"colou?r\"" "0 或 1 次"
    printf "%-20s %-30s %s\n" "|" "grep -E \"error|warn\"" "或"
    printf "%-20s %-30s %s\n" "()" "grep -E \"(ab)+\"" "分组"
    printf "%-20s %-30s %s\n" "{}" "grep -E \"a{3}\"" "重复次数"
    echo
    
    print_title "4. 上下文显示"
    printf "${YELLOW}%-20s %s${NC}\n" "选项" "说明"
    printf "%-20s %s\n" "--------------------" "------------------"
    printf "%-20s %s\n" "-A n" "显示匹配后 n 行"
    printf "%-20s %s\n" "-B n" "显示匹配前 n 行"
    printf "%-20s %s\n" "-C n" "显示前后各 n 行"
    echo
    echo "示例:"
    echo "  grep -A 3 \"error\" logfile.log    # 显示错误及后 3 行"
    echo "  grep -B 2 \"error\" logfile.log    # 显示错误及前 2 行"
    echo "  grep -C 2 \"error\" logfile.log    # 显示错误及前后各 2 行"
    echo
    
    print_title "5. 递归搜索"
    echo "  grep -r \"pattern\" /path/to/dir     # 递归搜索目录"
    echo "  grep -R \"pattern\" /path/to/dir     # 同上 (跟随符号链接)"
    echo "  grep -r --include=\"*.py\" \"def\" . # 只搜索.py 文件"
    echo "  grep -r --exclude=\"*.log\" \"error\" . # 排除.log 文件"
    echo "  grep -r --exclude-dir=.git \"TODO\" . # 排除.git 目录"
    echo
    
    print_title "6. 多模式匹配"
    echo "  grep -e \"pattern1\" -e \"pattern2\" file  # 多个模式"
    echo "  grep -E \"pattern1|pattern2\" file         # 扩展正则"
    echo "  grep -f patterns.txt file                  # 从文件读取模式"
    echo
    
    print_title "7. 颜色高亮"
    echo "  grep --color=auto \"pattern\" file    # 自动高亮"
    echo "  grep --color=always \"pattern\" file  # 始终高亮"
    echo "  export GREP_OPTIONS='--color=auto'    # 永久设置"
    echo
    
    print_title "8. 实际应用"
    echo "  场景 1: 查找错误日志"
    echo "    grep -i \"error\\|exception\\|fail\" /var/log/*.log"
    echo
    echo "  场景 2: 统计代码行数"
    echo "    grep -c \"\" *.py    # 统计每个文件的行数"
    echo
    echo "  场景 3: 查找函数定义"
    echo "    grep -n \"^def \" *.py    # 查找 Python 函数"
    echo "    grep -n \"^function \" *.sh    # 查找 Shell 函数"
    echo
    echo "  场景 4: 查找 IP 地址"
    echo "    grep -E \"[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\" logfile"
    echo
    echo "  场景 5: 查找邮箱地址"
    echo "    grep -E \"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\" file"
    echo
    
    print_separator
    print_info "总结:"
    echo "  ✅ -i - 忽略大小写"
    echo "  ✅ -v - 反向匹配"
    echo "  ✅ -n - 显示行号"
    echo "  ✅ -c - 统计行数"
    echo "  ✅ -r - 递归搜索"
    echo "  ✅ -E - 扩展正则"
    echo "  ✅ -A/-B/-C - 上下文显示"
    echo "  ✅ --include/--exclude - 文件过滤"
    print_separator
}

main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：read 命令进阶用法脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：read 超时、隐藏输入、自定义提示符、读取多变量、读取文件
# 功能描述：演示 read 命令的各种高级用法和选项
# 使用方法：bash 18_read_command_advanced.sh
# 创建时间：2026-03-20
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_basic_read() {
    print_separator
    print_color GREEN "【演示 1】基本输入"
    print_separator
    echo -n "请输入您的名字："
    read name
    print_color GREEN "您好，$name！"
    echo ""
}

demo_timeout() {
    print_separator
    print_color GREEN "【演示 2】超时读取（-t）"
    print_separator
    echo "请在 5 秒内输入（超时自动继续）："
    if read -t 5 -p "倒计时开始：" input; then
        print_color GREEN "您输入了：$input"
    else
        print_color YELLOW "⚠ 超时，使用默认值"
        input="timeout"
    fi
    echo "最终值：$input"
    echo ""
}

demo_hidden_input() {
    print_separator
    print_color GREEN "【演示 3】隐藏输入（-s）"
    print_separator
    echo "请输入密码（不显示）："
    read -s password
    echo ""
    print_color GREEN "密码已接收（长度：${#password}）"
    echo ""
}

demo_custom_prompt() {
    print_separator
    print_color GREEN "【演示 4】自定义提示符（-p）"
    print_separator
    read -p "请输入年龄：" age
    print_color GREEN "年龄：$age"
    echo ""
}

demo_multiple_vars() {
    print_separator
    print_color GREEN "【演示 5】读取多变量"
    print_separator
    echo "请输入 姓 名（空格分隔）："
    read first last
    print_color GREEN "姓：$first, 名：$last"
    echo ""
}

demo_read_file() {
    print_separator
    print_color GREEN "【演示 6】读取文件"
    print_separator
    echo "读取 /etc/hosts 前 3 行："
    local count=0
    while read line; do
        echo "  $line"
        ((count++))
        [[ $count -ge 3 ]] && break
    done < /etc/hosts
    echo ""
}

main() {
    print_separator
    print_color CYAN "read 命令进阶演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -b: 基本 -t: 超时 -s: 隐藏 -p: 提示 -m: 多变量 -f: 文件"; exit 0 ;;
        -b) demo_basic_read ;;
        -t) demo_timeout ;;
        -s) demo_hidden_input ;;
        -p) demo_custom_prompt ;;
        -m) demo_multiple_vars ;;
        -f) demo_read_file ;;
        *) demo_basic_read; demo_timeout; demo_hidden_input; demo_custom_prompt; demo_multiple_vars; demo_read_file ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

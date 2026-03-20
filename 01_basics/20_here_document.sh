#!/bin/bash
# =============================================================================
# 脚本名称：Here Document 多行输入脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：here document、here string、变量展开、命令替换、嵌套
# 功能描述：演示 here document 的各种用法和技巧
# 使用方法：bash 20_here_document.sh
# 创建时间：2026-03-20
# =============================================================================

GREEN='\033[0;32m'
NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

demo_basic_here_doc() {
    print_separator
    print_color GREEN "【演示 1】基本 Here Document"
    print_separator
    
    cat << EOF
这是一个多行文本块
可以包含多行内容
直到遇到 EOF 标记
EOF
    echo ""
}

demo_variable_expansion() {
    print_separator
    print_color GREEN "【演示 2】变量展开"
    print_separator
    
    local name="Alice"
    local age=25
    
    echo "带变量展开（EOF）："
    cat << EOF
姓名：$name
年龄：$age
EOF
    echo ""
    
    echo "不带变量展开（'EOF'）："
    cat << 'EOF'
姓名：$name
年龄：$age
EOF
    echo ""
}

demo_command_substitution() {
    print_separator
    print_color GREEN "【演示 3】命令替换"
    print_separator
    
    cat << EOF
当前日期：$(date +%Y-%m-%d)
当前用户：$(whoami)
工作目录：$(pwd)
EOF
    echo ""
}

demo_here_string() {
    print_separator
    print_color GREEN "【演示 4】Here String（<<<）"
    print_separator
    
    echo "读取字符串："
    read line <<< "Hello World"
    echo "读取的内容：$line"
    echo ""
    
    echo "传递给命令："
    wc -w <<< "one two three four"
    echo ""
}

demo_nested() {
    print_separator
    print_color GREEN "【演示 5】嵌套 Here Document"
    print_separator
    
    cat << OUTER
外层文档
$(cat << INNER
内层文档
可以嵌套使用
INNER
)
外层文档结束
OUTER
    echo ""
}

main() {
    print_separator
    print_color CYAN "Here Document 演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [选项]"; echo "  -b: 基本 -v: 变量 -c: 命令 -s: here string -n: 嵌套"; exit 0 ;;
        -b) demo_basic_here_doc ;;
        -v) demo_variable_expansion ;;
        -c) demo_command_substitution ;;
        -s) demo_here_string ;;
        -n) demo_nested ;;
        *) demo_basic_here_doc; demo_variable_expansion; demo_command_substitution; demo_here_string; demo_nested ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

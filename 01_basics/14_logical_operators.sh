#!/bin/bash
# =============================================================================
# 脚本名称：逻辑运算符详解脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：&&、||、!、and、or、not、短路求值、条件组合
# 功能描述：演示 Shell 中逻辑运算符的使用方法和技巧
# 使用方法：bash 16_logical_operators.sh
# 创建时间：2026-03-20
# =============================================================================

RED='\033[0;32m'
NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

# 演示 AND 运算
demo_and() {
    print_separator
    print_color GREEN "【演示 1】AND 运算（&&）"
    print_separator
    
    echo "规则：两边都为真，结果才为真"
    echo ""
    
    # 命令链
    echo "命令链示例："
    echo "  cd /tmp && echo '进入成功'"
    cd /tmp && print_color GREEN "  ✓ 进入成功"
    echo ""
    
    echo "失败示例（目录不存在）："
    echo "  cd /nonexistent && echo '不会执行'"
    cd /nonexistent 2>/dev/null && echo "  ✗ 不会执行" || print_color RED "  ✓ 确实没执行"
    echo ""
}

# 演示 OR 运算
demo_or() {
    print_separator
    print_color GREEN "【演示 2】OR 运算（||）"
    print_separator
    
    echo "规则：只要一边为真，结果就为真"
    echo ""
    
    echo "默认值示例："
    echo "  value=\$EXISTING || value='default'"
    local value=$NONEXISTENT || value='default'
    echo "  结果：value=$value"
    echo ""
    
    echo "错误处理示例："
    echo "  command_exists || echo '未安装'"
    false || print_color YELLOW "  ⚠ 命令执行失败"
    echo ""
}

# 演示 NOT 运算
demo_not() {
    print_separator
    print_color GREEN "【演示 3】NOT 运算（!）"
    print_separator
    
    echo "规则：取反，真变假，假变真"
    echo ""
    
    # 文件不存在检查
    echo "检查文件不存在："
    echo "  ! -f /nonexistent_file"
    if [[ ! -f /nonexistent_file ]]; then
        print_color GREEN "  ✓ 文件确实不存在"
    fi
    echo ""
    
    # 命令取反
    echo "命令取反："
    echo "  ! false → 真"
    ! false && print_color GREEN "  ✓ 结果为真"
    echo ""
}

# 演示短路求值
demo_short_circuit() {
    print_separator
    print_color GREEN "【演示 4】短路求值"
    print_separator
    
    echo "AND 短路：第一个为假，后面不执行"
    echo "  false && echo '不会输出'"
    false && echo "  不会输出"
    echo ""
    
    echo "OR 短路：第一个为真，后面不执行"
    echo "  true || echo '不会输出'"
    true || echo "  不会输出"
    echo ""
    
    echo "实用技巧：条件执行"
    echo "  mkdir -p /tmp/test_dir && echo '创建成功'"
    mkdir -p /tmp/test_dir && print_color GREEN "  ✓ 创建成功"
    echo ""
}

# 演示组合使用
demo_combination() {
    print_separator
    print_color GREEN "【演示 5】组合使用"
    print_separator
    
    echo "复杂条件："
    echo "  [[ -d /tmp ]] && echo '目录存在' || echo '目录不存在'"
    [[ -d /tmp ]] && print_color GREEN "  ✓ 目录存在" || print_color RED "  ✗ 目录不存在"
    echo ""
    
    echo "多条件组合："
    echo "  [[ 1 -eq 1 ]] && [[ 2 -eq 2 ]] && echo '都为真'"
    [[ 1 -eq 1 ]] && [[ 2 -eq 2 ]] && print_color GREEN "  ✓ 都为真"
    echo ""
}

main() {
    print_separator
    print_color CYAN "逻辑运算符演示"
    print_separator
    
    case "${1:-}" in
        -h|--help) echo "用法：$0 [-h] [-a] [-o] [-n] [-s] [-c]"; exit 0 ;;
        -a) demo_and ;;
        -o) demo_or ;;
        -n) demo_not ;;
        -s) demo_short_circuit ;;
        -c) demo_combination ;;
        *) demo_and; demo_or; demo_not; demo_short_circuit; demo_combination ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

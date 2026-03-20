#!/bin/bash
# =============================================================================
# 脚本名称：变量类型声明与操作脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：declare/typeset、变量类型、只读变量、数组声明、属性查看
# 功能描述：演示 Shell 变量的类型声明、属性设置和类型转换
# 使用方法：bash 13_variable_type_declaration.sh
# 输出示例：
#   ========================================
#   变量类型声明演示
#   ========================================
#   整数类型：num=42
#   只读变量：readonly_var=constant
#   数组类型：arr=(1 2 3)
#   ...
# 创建时间：2026-03-20
# 最后更新：2026-03-20
# =============================================================================

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() {
    echo -e "${!1}${2}${NC}"
}

print_separator() {
    echo "========================================"
}

# =============================================================================
# 演示 1：declare 命令基本用法
# =============================================================================
demo_declare_basics() {
    print_separator
    print_color GREEN "【演示 1】declare 命令基本用法"
    print_separator
    
    # 声明整数变量
    declare -i num=42
    echo "整数变量：num=$num"
    echo "类型：$(declare -p num | grep -o 'declare -[a-z]*')"
    
    # 声明只读变量
    declare -r readonly_var="constant_value"
    echo -e "\n只读变量：readonly_var=$readonly_var"
    echo "尝试修改只读变量："
    readonly_var="new_value" 2>&1 || print_color RED "  ✗ 修改失败（预期行为）"
    
    # 声明小写转换变量
    declare -l lower_var="HELLO WORLD"
    echo -e "\n小写转换：lower_var=$lower_var"
    
    # 声明大写转换变量
    declare -u upper_var="hello world"
    echo "大写转换：upper_var=$upper_var"
    
    # 声明数组
    declare -a arr=(1 2 3 4 5)
    echo -e "\n数组变量：arr=(${arr[*]})"
    
    # 声明关联数组（Bash 4.0+）
    declare -A assoc_arr
    assoc_arr[name]="Alice"
    assoc_arr[age]="25"
    assoc_arr[city]="Beijing"
    echo -e "\n关联数组："
    for key in "${!assoc_arr[@]}"; do
        echo "  $key: ${assoc_arr[$key]}"
    done
    
    echo ""
}

# =============================================================================
# 演示 2：查看变量属性
# =============================================================================
demo_view_attributes() {
    print_separator
    print_color GREEN "【演示 2】查看变量属性"
    print_separator
    
    # 创建不同类型的变量
    declare -i int_var=100
    declare -r const_var="immutable"
    declare -l lower="TEST"
    declare -a array=(a b c)
    
    echo "使用 declare -p 查看变量属性："
    echo ""
    
    declare -p int_var 2>/dev/null && echo ""
    declare -p const_var 2>/dev/null && echo ""
    declare -p lower 2>/dev/null && echo ""
    declare -p array 2>/dev/null && echo ""
    
    echo "属性说明："
    echo "  -i: 整数（integer）"
    echo "  -r: 只读（readonly）"
    echo "  -l: 小写（lowercase）"
    echo "  -u: 大写（uppercase）"
    echo "  -a: 索引数组（array）"
    echo "  -A: 关联数组（associative array）"
    echo "  -x: 导出为环境变量（export）"
    echo ""
}

# =============================================================================
# 演示 3：类型转换实验
# =============================================================================
demo_type_conversion() {
    print_separator
    print_color GREEN "【演示 3】类型转换实验"
    print_separator
    
    # 字符串转整数
    str_num="123"
    declare -i int_num=$str_num
    echo "字符串转整数："
    echo "  原始：str_num='$str_num'（字符串）"
    echo "  转换：int_num=$int_num（整数）"
    echo "  计算：int_num + 10 = $((int_num + 10))"
    echo ""
    
    # 整数转字符串
    int_val=456
    str_val="$int_val"
    echo "整数转字符串："
    echo "  原始：int_val=$int_val（整数）"
    echo "  转换：str_val='$str_val'（字符串）"
    echo "  拼接：str_val + 'abc' = '${str_val}abc'"
    echo ""
    
    # 自动类型转换
    declare -i auto_num
    auto_num="789"
    echo "自动类型转换："
    echo "  auto_num='789' → auto_num=$auto_num"
    echo "  auto_num + 111 = $((auto_num + 111))"
    echo ""
}

# =============================================================================
# 演示 4：变量作用域
# =============================================================================
demo_variable_scope() {
    print_separator
    print_color GREEN "【演示 4】变量作用域"
    print_separator
    
    # 全局变量
    global_var="I am global"
    
    # 函数内变量
    test_function() {
        local local_var="I am local"
        global_var="Modified in function"
        echo "函数内部："
        echo "  local_var=$local_var"
        echo "  global_var=$global_var"
    }
    
    echo "调用函数前："
    echo "  global_var=$global_var"
    echo ""
    
    test_function
    echo ""
    
    echo "调用函数后："
    echo "  global_var=$global_var"
    echo "  local_var=${local_var:-未定义（局部变量）}"
    echo ""
}

# =============================================================================
# 演示 5：特殊变量属性
# =============================================================================
demo_special_attributes() {
    print_separator
    print_color GREEN "【演示 5】特殊变量属性"
    print_separator
    
    # 导出变量
    export EXPORTED_VAR="I am exported"
    echo "导出变量："
    echo "  EXPORTED_VAR=$EXPORTED_VAR"
    echo "  子进程可见：$(bash -c 'echo $EXPORTED_VAR')"
    echo ""
    
    # 带默认值的变量
    declare var_with_default
    echo "未赋值的变量："
    echo "  var_with_default='${var_with_default}'"
    echo "  使用默认值：\${var_with_default:-'default'} = '${var_with_default:-'default'}'"
    echo ""
    
    # 数值属性实验
    declare -i calc_var
    calc_var="10 + 20"
    echo "数值属性自动计算："
    echo "  calc_var='10 + 20' → calc_var=$calc_var"
    echo ""
}

# =============================================================================
# 演示 6：常见错误与注意事项
# =============================================================================
demo_common_errors() {
    print_separator
    print_color GREEN "【演示 6】常见错误与注意事项"
    print_separator
    
    echo "错误 1: 修改只读变量"
    echo "  declare -r CONST=100"
    echo "  CONST=200  # ✗ 报错：readonly variable"
    echo ""
    
    echo "错误 2: 整数变量赋非数值"
    echo "  declare -i NUM=abc"
    echo "  echo \$NUM  # 输出：0（转换失败）"
    declare -i test_num=abc
    echo "  实际测试：test_num=$test_num"
    echo ""
    
    echo "错误 3: 关联数组需要 Bash 4.0+"
    if [[ -v BASH_VERSINFO[0] ]] && [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
        echo "  ✓ 当前 Bash 版本支持关联数组"
    else
        echo "  ⚠ 当前 Bash 版本不支持关联数组"
    fi
    echo ""
    
    echo "注意事项："
    echo "  1. declare 在函数内默认创建局部变量"
    echo "  2. 使用 declare -g 可创建全局变量（Bash 4.2+）"
    echo "  3. -r 只读属性一旦设置不可移除"
    echo "  4. 数值变量赋非数值会转换为 0"
    echo ""
}

# =============================================================================
# 总结表格
# =============================================================================
print_summary_table() {
    print_separator
    print_color GREEN "变量类型声明总结表"
    print_separator
    
    printf "%-15s %-10s %-20s %-15s\n" "选项" "属性" "用途" "示例"
    printf "%-15s %-10s %-20s %-15s\n" "----" "----" "----" "----"
    printf "%-15s %-10s %-20s %-15s\n" "-i" "integer" "整数变量" "declare -i n=10"
    printf "%-15s %-10s %-20s %-15s\n" "-r" "readonly" "只读变量" "declare -r PI=3.14"
    printf "%-15s %-10s %-20s %-15s\n" "-l" "lowercase" "自动转小写" "declare -l name=ABC"
    printf "%-15s %-10s %-20s %-15s\n" "-u" "uppercase" "自动转大写" "declare -u name=abc"
    printf "%-15s %-10s %-20s %-15s\n" "-a" "array" "索引数组" "declare -a arr=(1 2)"
    printf "%-15s %-10s %-20s %-15s\n" "-A" "associative" "关联数组" "declare -A dict"
    printf "%-15s %-10s %-20s %-15s\n" "-x" "export" "环境变量" "declare -x PATH"
    printf "%-15s %-10s %-20s %-15s\n" "-p" "print" "查看属性" "declare -p var"
    echo ""
}

# =============================================================================
# 主程序入口
# =============================================================================
main() {
    print_separator
    print_color CYAN "变量类型声明与操作演示"
    print_separator
    echo ""
    
    case "${1:-}" in
        -h|--help)
            echo "用法：$0 [选项]"
            echo ""
            echo "选项："
            echo "  -h, --help      显示帮助信息"
            echo "  -a, --all       运行所有演示（默认）"
            echo "  -d, --declare   仅演示 declare 基本用法"
            echo "  -v, --view      仅演示查看属性"
            echo "  -t, --type      仅演示类型转换"
            echo "  -s, --scope     仅演示变量作用域"
            echo "  -S, --special   仅演示特殊属性"
            echo "  -e, --errors    仅演示常见错误"
            echo ""
            exit 0
            ;;
        -d|--declare)
            demo_declare_basics
            ;;
        -v|--view)
            demo_view_attributes
            ;;
        -t|--type)
            demo_type_conversion
            ;;
        -s|--scope)
            demo_variable_scope
            ;;
        -S|--special)
            demo_special_attributes
            ;;
        -e|--errors)
            demo_common_errors
            ;;
        -a|--all|"")
            demo_declare_basics
            demo_view_attributes
            demo_type_conversion
            demo_variable_scope
            demo_special_attributes
            demo_common_errors
            print_summary_table
            ;;
        *)
            echo "未知选项：$1"
            exit 1
            ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

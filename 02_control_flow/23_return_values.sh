#!/bin/bash
#===============================================================================
# 脚本名称：04_return_values.sh
# 功能描述：演示 Shell 函数返回值的深入用法
# 难度等级：★★★☆☆ (中高级)
# 知识点：
#   - return 返回值 (0-255)
#   - echo 返回字符串
#   - 命令替换获取返回值
#   - 返回多个值
#   - 全局变量返回值
# 使用方法：
#   chmod +x 04_return_values.sh
#   ./04_return_values.sh
# 参考来源：cnblogs Shell 指南 2.6 节
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
# 示例 1: return 返回值
#===============================================================================
example_return() {
    print_title "示例 1: return 返回值 (0-255)"
    echo
    echo "示例代码:"
    echo "  check_age() {"
    echo "    if [ \$1 -ge 18 ]"
    echo "    then"
    echo "      return 0  # 成功"
    echo "    else"
    echo "      return 1  # 失败"
    echo "    fi"
    echo "  }"
    echo
    check_age() {
        if [ $1 -ge 18 ]; then
            return 0
        else
            return 1
        fi
    }
    
    check_age 20
    echo "  check_age 20 -> 返回值：$?"
    
    check_age 15
    echo "  check_age 15 -> 返回值：$?"
    echo
    print_info "说明:"
    echo "  ✅ return 0 表示成功"
    echo "  ✅ return 非 0 表示失败"
    echo "  ✅ 只能返回 0-255 的整数"
    echo
}

#===============================================================================
# 示例 2: echo 返回字符串
#===============================================================================
example_echo() {
    print_title "示例 2: echo 返回字符串"
    echo
    echo "示例代码:"
    echo "  get_status() {"
    echo "    echo \"success\""
    echo "  }"
    echo "  result=\$(get_status)"
    echo "  echo \"\$result\""
    echo
    get_status() {
        echo "success"
    }
    result=$(get_status)
    printf "  返回值：%s\n" "$result"
    echo
}

#===============================================================================
# 示例 3: 命令替换
#===============================================================================
example_command_substitution() {
    print_title "示例 3: 命令替换获取返回值"
    echo
    echo "示例代码:"
    echo "  get_user_info() {"
    echo "    echo \"name:John\""
    echo "    echo \"age:25\""
    echo "    echo \"city:NYC\""
    echo "  }"
    echo "  info=\$(get_user_info)"
    echo
    get_user_info() {
        echo "name:John"
        echo "age:25"
        echo "city:NYC"
    }
    info=$(get_user_info)
    print_info "输出:"
    echo "$info" | sed 's/^/  /'
    echo
}

#===============================================================================
# 示例 4: 返回多个值
#===============================================================================
example_multiple() {
    print_title "示例 4: 返回多个值"
    echo
    echo "方法 1: 用分隔符分隔"
    echo "  get_coords() {"
    echo "    echo \"10,20,30\""
    echo "  }"
    echo "  result=\$(get_coords)"
    echo "  IFS=',' read -r x y z <<< \"\$result\""
    echo
    get_coords() {
        echo "10,20,30"
    }
    result=$(get_coords)
    IFS=',' read -r x y z <<< "$result"
    printf "  x=%s, y=%s, z=%s\n" "$x" "$y" "$z"
    echo
    echo "方法 2: 多行输出"
    echo "  get_point() {"
    echo "    echo 10"
    echo "    echo 20"
    echo "    echo 30"
    echo "  }"
    echo "  mapfile -t coords < <(get_point)"
    echo
    get_point() {
        echo 10
        echo 20
        echo 30
    }
    mapfile -t coords < <(get_point)
    printf "  coords[0]=%s, coords[1]=%s, coords[2]=%s\n" "${coords[0]}" "${coords[1]}" "${coords[2]}"
    echo
}

#===============================================================================
# 示例 5: 全局变量返回值
#===============================================================================
example_global() {
    print_title "示例 5: 全局变量返回值"
    echo
    echo "示例代码:"
    echo "  result=\"\""
    echo "  calculate() {"
    echo "    result=\$(( \$1 + \$2 ))"
    echo "  }"
    echo "  calculate 10 20"
    echo "  echo \"\$result\""
    echo
    result=""
    calculate() {
        result=$(( $1 + $2 ))
    }
    calculate 10 20
    printf "  结果：%s\n" "$result"
    echo
    print_info "说明:"
    echo "  ✅ 简单但不推荐 (污染全局命名空间)"
    echo "  ✅ 适合脚本内部使用"
    echo
}

#===============================================================================
# 示例 6: 实际应用
#===============================================================================
example_practical() {
    print_title "示例 6: 实际应用场景"
    echo
    echo "场景 1: 检查命令是否存在"
    echo "  command_exists() {"
    echo "    command -v \"\$1\" &>/dev/null"
    echo "    return \$?"
    echo "  }"
    echo
    echo "场景 2: 获取系统信息"
    echo "  get_os_info() {"
    echo "    echo \"\$(uname -s) \$(uname -r)\""
    echo "  }"
    echo "  os_info=\$(get_os_info)"
    echo
    echo "场景 3: 验证输入"
    echo "  validate_email() {"
    echo "    local email=\$1"
    echo "    if [[ \"\$email\" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}\$ ]]"
    echo "    then"
    echo "      return 0"
    echo "    else"
    echo "      return 1"
    echo "    fi"
    echo "  }"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 函数返回值深入"
    print_separator
    echo
    
    example_return
    example_echo
    example_command_substitution
    example_multiple
    example_global
    example_practical
    
    print_separator
    print_info "总结:"
    echo "  ✅ return - 返回整数 (0-255)"
    echo "  ✅ echo - 返回字符串"
    echo "  ✅ \$(func) - 命令替换获取输出"
    echo "  ✅ 分隔符 - 返回多个值"
    echo "  ✅ 全局变量 - 不推荐但可用"
    echo "  ✅ 最佳实践：简单状态用 return，数据用 echo"
    print_separator
}

main "$@"

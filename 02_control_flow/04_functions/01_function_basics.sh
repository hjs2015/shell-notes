#!/bin/bash
#===============================================================================
# 脚本名称：01_function_basics.sh
# 功能描述：演示 Shell 函数的定义和调用
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - 函数定义语法
#   - 函数调用方法
#   - 函数参数传递
#   - 局部变量 (local)
#   - 返回值 (return)
# 使用方法：
#   chmod +x 01_function_basics.sh
#   ./01_function_basics.sh
# 示例输出：
#   【函数定义】
#   Hello, World!
#   【函数调用】
#   欢迎，黄金生!
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
# 示例 1: 基本函数定义
#===============================================================================
example_basic() {
    print_title "示例 1: 基本函数定义"
    echo
    echo "定义语法 1 (推荐):"
    echo "  function_name() {"
    echo "    # 函数体"
    echo "    echo \"Hello\""
    echo "  }"
    echo
    echo "定义语法 2 (兼容 ksh):"
    echo "  function function_name {"
    echo "    # 函数体"
    echo "  }"
    echo
    echo "调用方法:"
    echo "  function_name  # 直接调用"
    echo
    print_info "演示:"
    # 定义函数
    greet() {
        echo "  Hello, World!"
    }
    # 调用函数
    greet
    echo
}

#===============================================================================
# 示例 2: 函数参数传递
#===============================================================================
example_parameters() {
    print_title "示例 2: 函数参数传递"
    echo
    echo "函数内部使用 \$1, \$2, \$3... 访问参数"
    echo
    echo "示例代码:"
    echo "  greet() {"
    echo "    echo \"欢迎，\$1!\""
    echo "    echo \"你的年龄是：\$2\""
    echo "  }"
    echo "  greet \"黄金生\" 25"
    echo
    print_info "演示:"
    greet() {
        printf "  欢迎，%s!\n" "$1"
        printf "  你的年龄是：%s\n" "$2"
    }
    greet "黄金生" 25
    echo
}

#===============================================================================
# 示例 3: 函数返回值
#===============================================================================
example_return() {
    print_title "示例 3: 函数返回值"
    echo
    echo "方法 1: return (返回整数 0-255)"
    echo "  check_age() {"
    echo "    if [ \$1 -ge 18 ]"
    echo "    then"
    echo "      return 0  # 成功"
    echo "    else"
    echo "      return 1  # 失败"
    echo "    fi"
    echo "  }"
    echo
    echo "方法 2: echo (返回字符串)"
    echo "  get_status() {"
    echo "    echo \"success\""
    echo "  }"
    echo
    print_info "演示 return:"
    check_age() {
        if [ $1 -ge 18 ]; then
            return 0
        else
            return 1
        fi
    }
    
    check_age 20
    if [ $? -eq 0 ]; then
        echo "  ✅ 年龄 >= 18"
    fi
    
    check_age 15
    if [ $? -ne 0 ]; then
        echo "  ❌ 年龄 < 18"
    fi
    echo
}

#===============================================================================
# 示例 4: 局部变量
#===============================================================================
example_local_vars() {
    print_title "示例 4: 局部变量 (local)"
    echo
    echo "使用 local 关键字定义局部变量"
    echo
    echo "示例代码:"
    echo "  my_func() {"
    echo "    local var=\"local value\""
    echo "    echo \"函数内：\$var\""
    echo "  }"
    echo "  var=\"global value\""
    echo "  my_func"
    echo "  echo \"函数外：\$var\""
    echo
    print_info "演示:"
    my_func() {
        local var="local value"
        printf "  函数内：%s\n" "$var"
    }
    var="global value"
    my_func
    printf "  函数外：%s\n" "$var"
    echo
    echo
    print_info "说明:"
    echo "  ✅ local 变量只在函数内有效"
    echo "  ✅ 避免污染全局命名空间"
    echo "  ✅ 推荐：函数内所有变量都用 local"
    echo
}

#===============================================================================
# 示例 5: 获取所有参数
#===============================================================================
example_all_params() {
    print_title "示例 5: 获取所有参数"
    echo
    echo "特殊变量:"
    echo "  \$#  - 参数个数"
    echo "  \$*  - 所有参数 (一个单词)"
    echo "  \$@  - 所有参数 (多个单词，推荐)"
    echo
    echo "示例代码:"
    echo "  show_args() {"
    echo "    echo \"参数个数：\$#\""
    echo "    echo \"所有参数：\$@\""
    echo "    for arg in \"\$@\""
    echo "    do"
    echo "      echo \"  - \$arg\""
    echo "    done"
    echo "  }"
    echo
    print_info "演示:"
    show_args() {
        printf "  参数个数：%d\n" $#
        printf "  所有参数：%s\n" "$*"
        echo "  逐个参数:"
        for arg in "$@"
        do
            printf "    - %s\n" "$arg"
        done
    }
    show_args "arg1" "arg2" "arg3"
    echo
}

#===============================================================================
# 示例 6: 实用函数示例
#===============================================================================
example_practical() {
    print_title "示例 6: 实用函数示例"
    echo
    echo "函数 1: 打印分隔线"
    echo "  print_line() {"
    echo "    printf '%60s\\n' | tr ' ' '\$1'"
    echo "  }"
    echo "  print_line \"=\""
    echo
    echo "函数 2: 日志输出"
    echo "  log() {"
    echo "    local level=\$1"
    echo "    local msg=\$2"
    echo "    echo \"[\$(date '+%Y-%m-%d %H:%M:%S')] [\$level] \$msg\""
    echo "  }"
    echo "  log \"INFO\" \"程序启动\""
    echo
    echo "函数 3: 检查命令是否存在"
    echo "  command_exists() {"
    echo "    command -v \"\$1\" &>/dev/null"
    echo "  }"
    echo "  if command_exists git"
    echo "  then"
    echo "    echo \"Git 已安装\""
    echo "  fi"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 函数基础"
    print_separator
    echo
    
    example_basic
    example_parameters
    example_return
    example_local_vars
    example_all_params
    example_practical
    
    print_separator
    print_info "总结:"
    echo "  ✅ 定义：function_name() { ... }"
    echo "  ✅ 调用：function_name"
    echo "  ✅ 参数：\$1, \$2, \$3..."
    echo "  ✅ 参数个数：\$#"
    echo "  ✅ 所有参数：\$@ (推荐) 或 \$*"
    echo "  ✅ 返回值：return (0-255)"
    echo "  ✅ 局部变量：local var=value"
    echo "  ✅ 最佳实践：函数内所有变量都用 local"
    print_separator
}

# 调用主函数
main "$@"

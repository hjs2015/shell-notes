#!/bin/bash
#===============================================================================
# 脚本名称：05_break_continue.sh
# 功能描述：演示 Shell 循环控制命令 break 和 continue
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - break 退出循环
#   - break n 退出 n 层循环
#   - continue 跳过本次迭代
#   - continue n 跳过 n 层循环的本次迭代
# 使用方法：
#   chmod +x 05_break_continue.sh
#   ./05_break_continue.sh
# 参考来源：cnblogs Shell 指南 2.5 节
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
# 示例 1: break 退出循环
#===============================================================================
example_break() {
    print_title "示例 1: break 退出循环"
    echo
    echo "示例代码:"
    echo "  for i in 1 2 3 4 5"
    echo "  do"
    echo "    if [ \$i -eq 3 ]"
    echo "    then"
    echo "      echo \"遇到 3，退出循环\""
    echo "      break"
    echo "    fi"
    echo "    echo \"\$i\""
    echo "  done"
    echo
    print_info "输出:"
    for i in 1 2 3 4 5
    do
        if [ $i -eq 3 ]
        then
            echo "  遇到 3，退出循环"
            break
        fi
        printf "  %d\n" $i
    done
    echo
}

#===============================================================================
# 示例 2: break n 退出多层循环
#===============================================================================
example_break_n() {
    print_title "示例 2: break n 退出多层循环"
    echo
    echo "示例代码:"
    echo "  for i in 1 2 3"
    echo "  do"
    echo "    for j in 1 2 3"
    echo "    do"
    echo "      if [ \$j -eq 2 ]"
    echo "      then"
    echo "        echo \"退出两层循环\""
    echo "        break 2"
    echo "      fi"
    echo "      echo \"i=\$i, j=\$j\""
    echo "    done"
    echo "  done"
    echo
    print_info "输出:"
    for i in 1 2 3
    do
        for j in 1 2 3
        do
            if [ $j -eq 2 ]
            then
                echo "  退出两层循环"
                break 2
            fi
            printf "  i=%d, j=%d\n" $i $j
        done
    done
    echo
}

#===============================================================================
# 示例 3: continue 跳过本次迭代
#===============================================================================
example_continue() {
    print_title "示例 3: continue 跳过本次迭代"
    echo
    echo "示例代码:"
    echo "  for i in 1 2 3 4 5"
    echo "  do"
    echo "    if [ \$i -eq 3 ]"
    echo "    then"
    echo "      echo \"跳过 3\""
    echo "      continue"
    echo "    fi"
    echo "    echo \"\$i\""
    echo "  done"
    echo
    print_info "输出:"
    for i in 1 2 3 4 5
    do
        if [ $i -eq 3 ]
        then
            echo "  跳过 3"
            continue
        fi
        printf "  %d\n" $i
    done
    echo
}

#===============================================================================
# 示例 4: 实际应用场景
#===============================================================================
example_practical() {
    print_title "示例 4: 实际应用场景"
    echo
    echo "场景 1: 处理文件，跳过空行"
    echo "  while read line"
    echo "  do"
    echo "    [ -z \"\$line\" ] && continue"
    echo "    echo \"处理：\$line\""
    echo "  done < file.txt"
    echo
    echo "场景 2: 查找目标，找到即退出"
    echo "  for file in /etc/*"
    echo "  do"
    echo "    [ \"\$(basename \$file)\" = \"passwd\" ] && break"
    echo "    echo \"检查：\$file\""
    echo "  done"
    echo
    echo "场景 3: 批量处理，错误时跳过"
    echo "  for url in \"\${urls[@]}\""
    echo "  do"
    echo "    if ! curl -s \"\$url\" &>/dev/null"
    echo "    then"
    echo "      echo \"失败：\$url\""
    echo "      continue"
    echo "    fi"
    echo "    echo \"成功：\$url\""
    echo "  done"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell 循环控制：break 和 continue"
    print_separator
    echo
    
    example_break
    example_break_n
    example_continue
    example_practical
    
    print_separator
    print_info "总结:"
    echo "  ✅ break - 退出当前循环"
    echo "  ✅ break n - 退出 n 层循环"
    echo "  ✅ continue - 跳过本次迭代"
    echo "  ✅ continue n - 跳过 n 层循环的本次迭代"
    echo "  ✅ 应用场景：错误处理、条件跳过、提前退出"
    print_separator
}

main "$@"

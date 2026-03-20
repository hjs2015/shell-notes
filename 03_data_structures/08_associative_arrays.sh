#!/bin/bash
#===============================================================================
# 脚本名称：16_associative_arrays.sh
# 功能描述：演示 Bash 关联数组 (字典) 的用法
# 难度等级：★★★☆☆ (中高级)
# 知识点：
#   - 关联数组声明
#   - 键值对操作
#   - 遍历关联数组
#   - 删除元素
#   - 实际应用场景
# 使用方法：
#   chmod +x 16_associative_arrays.sh
#   ./16_associative_arrays.sh
# 参考来源：cnblogs Shell 指南 2.7 节
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
# 示例 1: 声明关联数组
#===============================================================================
example_declare() {
    print_title "示例 1: 声明关联数组"
    echo
    echo "语法：declare -A array_name"
    echo
    echo "示例代码:"
    echo "  declare -A colors"
    echo "  colors[red]=\"#FF0000\""
    echo "  colors[green]=\"#00FF00\""
    echo "  colors[blue]=\"#0000FF\""
    echo
    declare -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    colors[blue]="#0000FF"
    print_info "创建成功!"
    echo
}

#===============================================================================
# 示例 2: 访问元素
#===============================================================================
example_access() {
    print_title "示例 2: 访问元素"
    echo
    declare -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    colors[blue]="#0000FF"
    
    echo "示例代码:"
    echo "  echo \"\${colors[red]}\""
    echo "  echo \"\${colors[green]}\""
    echo
    print_info "输出:"
    printf "  红色：%s\n" "${colors[red]}"
    printf "  绿色：%s\n" "${colors[green]}"
    printf "  蓝色：%s\n" "${colors[blue]}"
    echo
}

#===============================================================================
# 示例 3: 遍历关联数组
#===============================================================================
example_iterate() {
    print_title "示例 3: 遍历关联数组"
    echo
    declare -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    colors[blue]="#0000FF"
    
    echo "方法 1: 遍历所有键"
    echo "  for key in \"\${!colors[@]}\""
    echo "  do"
    echo "    echo \"\$key: \${colors[\$key]}\""
    echo "  done"
    echo
    print_info "输出:"
    for key in "${!colors[@]}"
    do
        printf "  %s: %s\n" "$key" "${colors[$key]}"
    done
    echo
    echo "方法 2: 同时获取键和值"
    echo "  for key in \"\${!colors[@]}\""
    echo "  do"
    echo "    value=\"\${colors[\$key]}\""
    echo "    printf \"%-10s %s\\n\" \"\$key\" \"\$value\""
    echo "  done"
    echo
}

#===============================================================================
# 示例 4: 添加和删除元素
#===============================================================================
example_modify() {
    print_title "示例 4: 添加和删除元素"
    echo
    declare -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    
    echo "添加元素:"
    echo "  colors[yellow]=\"#FFFF00\""
    colors[yellow]="#FFFF00"
    printf "  添加后：%s\n" "${colors[yellow]}"
    echo
    echo "删除元素:"
    echo "  unset colors[green]"
    unset colors[green]
    echo "  删除后 green 存在吗？${colors[green]:-不存在}"
    echo
    echo "清空整个数组:"
    echo "  unset colors"
    echo
}

#===============================================================================
# 示例 5: 实用应用场景
#===============================================================================
example_practical() {
    print_title "示例 5: 实用应用场景"
    echo
    echo "场景 1: 配置映射"
    echo "  declare -A config"
    echo "  config[host]=\"localhost\""
    echo "  config[port]=\"8080\""
    echo "  config[debug]=\"true\""
    echo
    echo "场景 2: 计数器"
    echo "  declare -A count"
    echo "  for word in apple banana apple orange banana apple"
    echo "  do"
    echo "    ((count[\$word]++))"
    echo "  done"
    echo
    declare -A count
    for word in apple banana apple orange banana apple
    do
        ((count[$word]++))
    done
    print_info "单词统计:"
    for word in "${!count[@]}"
    do
        printf "  %-10s %d 次\n" "$word" "${count[$word]}"
    done
    echo
    echo "场景 3: 缓存字典"
    echo "  declare -A cache"
    echo "  cache[user_1]='{\"name\":\"John\"}'"
    echo "  cache[user_2]='{\"name\":\"Jane\"}'"
    echo
}

#===============================================================================
# 示例 6: 关联数组 vs 索引数组
#===============================================================================
example_comparison() {
    print_title "示例 6: 关联数组 vs 索引数组"
    echo
    printf "${YELLOW}%-20s %-20s %-20s${NC}\n" "特性" "索引数组" "关联数组"
    printf "%-20s %-20s %-20s\n" "--------------------" "--------------------" "--------------------"
    printf "%-20s %-20s %-20s\n" "声明" "arr=()" "declare -A arr"
    printf "%-20s %-20s %-20s\n" "索引" "数字 (0,1,2...)" "字符串 (key)"
    printf "%-20s %-20s %-20s\n" "访问" "\${arr[0]}" "\${arr[key]}"
    printf "%-20s %-20s %-20s\n" "遍历" "\${arr[@]}" "\${!arr[@]}"
    printf "%-20s %-20s %-20s\n" "Bash 版本" "所有版本" "Bash 4.0+"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Bash 关联数组 (字典)"
    print_separator
    echo
    
    example_declare
    example_access
    example_iterate
    example_modify
    example_practical
    example_comparison
    
    print_separator
    print_info "总结:"
    echo "  ✅ declare -A - 声明关联数组"
    echo "  ✅ array[key]=value - 赋值"
    echo "  ✅ \${array[key]} - 访问"
    echo "  ✅ \${!array[@]} - 所有键"
    echo "  ✅ \${array[@]} - 所有值"
    echo "  ✅ unset array[key] - 删除元素"
    echo "  ✅ 适用场景：配置映射、计数器、缓存"
    echo "  ⚠️  需要 Bash 4.0+"
    print_separator
}

main "$@"

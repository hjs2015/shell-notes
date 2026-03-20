#!/bin/bash
#===============================================================================
# 脚本名称：04_until_loop.sh
# 功能描述：演示 Shell until 循环的用法
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - until 循环语法结构
#   - until 与 while 的区别
#   - until 实际应用场景
#   - 循环控制 (break, continue)
# 使用方法：
#   chmod +x 04_until_loop.sh
#   ./04_until_loop.sh
# 示例输出：
#   【until 循环示例】
#   计数：1
#   计数：2
#   ...
#   计数：10
#   循环结束
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
# 示例 1: 基本的 until 循环
#===============================================================================
example_basic() {
    print_title "示例 1: 基本的 until 循环"
    echo
    echo "语法结构:"
    echo "  until 条件测试"
    echo "  do"
    echo "    循环体"
    echo "  done"
    echo
    echo "说明：当条件测试为假时执行循环，为真时退出"
    echo
    echo "示例代码:"
    echo "  count=1"
    echo "  until [ \$count -gt 10 ]"
    echo "  do"
    echo "    echo \"计数：\$count\""
    echo "    ((count++))"
    echo "  done"
    echo
    echo "输出:"
    count=1
    until [ $count -gt 10 ]
    do
        printf "  计数：%d\n" $count
        ((count++))
    done
    echo
}

#===============================================================================
# 示例 2: until 与 while 的对比
#===============================================================================
example_comparison() {
    print_title "示例 2: until 与 while 的对比"
    echo
    print_info "while 循环 (条件为真时执行):"
    echo "  i=1"
    echo "  while [ \$i -le 5 ]"
    echo "  do"
    echo "    echo \$i"
    echo "    ((i++))"
    echo "  done"
    echo
    echo "输出:"
    i=1
    while [ $i -le 5 ]
    do
        printf "  %d " $i
        ((i++))
    done
    echo
    echo
    print_info "until 循环 (条件为假时执行):"
    echo "  i=1"
    echo "  until [ \$i -gt 5 ]"
    echo "  do"
    echo "    echo \$i"
    echo "    ((i++))"
    echo "  done"
    echo
    echo "输出:"
    i=1
    until [ $i -gt 5 ]
    do
        printf "  %d " $i
        ((i++))
    done
    echo
    echo
    print_info "结论:"
    echo "  - while [ 条件为真 ] -> 执行循环"
    echo "  - until [ 条件为假 ] -> 执行循环"
    echo "  - until 等价于 while ! (条件的反面)"
    echo
}

#===============================================================================
# 示例 3: 等待服务启动
#===============================================================================
example_wait_service() {
    print_title "示例 3: 等待服务启动 (实际应用场景)"
    echo
    echo "场景：等待某个服务或文件就绪"
    echo
    echo "示例代码:"
    echo "  max_attempts=10"
    echo "  attempt=1"
    echo "  until [ -f /tmp/service_ready ] || [ \$attempt -ge \$max_attempts ]"
    echo "  do"
    echo "    echo \"等待服务就绪... (尝试 \$attempt/\$max_attempts)\""
    echo "    sleep 2"
    echo "    ((attempt++))"
    echo "  done"
    echo
    echo "模拟输出:"
    max_attempts=5
    attempt=1
    until [ $attempt -ge $max_attempts ]
    do
        printf "  等待服务就绪... (尝试 %d/%d)\n" $attempt $max_attempts
        sleep 0.5
        ((attempt++))
    done
    echo "  ⏰ 达到最大尝试次数"
    echo
}

#===============================================================================
# 示例 4: 用户输入验证
#===============================================================================
example_input_validation() {
    print_title "示例 4: 用户输入验证"
    echo
    echo "场景：要求用户输入有效值，直到输入正确"
    echo
    echo "示例代码:"
    echo "  valid_input=\"\""
    echo "  until [ -n \"\$valid_input\" ]"
    echo "  do"
    echo "    read -p \"请输入非空字符串：\" valid_input"
    echo "    if [ -z \"\$valid_input\" ]"
    echo "    then"
    echo "      echo \"❌ 输入不能为空，请重试\""
    echo "    fi"
    echo "  done"
    echo "  echo \"✅ 输入有效：\$valid_input\""
    echo
    echo "注意：此示例需要交互，演示跳过实际执行"
    echo
}

#===============================================================================
# 示例 5: 自动重试机制
#===============================================================================
example_retry() {
    print_title "示例 5: 自动重试机制"
    echo
    echo "场景：网络请求失败后自动重试"
    echo
    echo "示例代码:"
    echo "  max_retries=3"
    echo "  retry=0"
    echo "  success=false"
    echo "  "
    echo "  until \$success || [ \$retry -ge \$max_retries ]"
    echo "  do"
    echo "    ((retry++))"
    echo "    echo \"尝试 \$retry/\$max_retries...\""
    echo "    if curl -s https://example.com &>/dev/null"
    echo "    then"
    echo "      success=true"
    echo "      echo \"✅ 请求成功\""
    echo "    else"
    echo "      echo \"❌ 请求失败，2 秒后重试\""
    echo "      sleep 2"
    echo "    fi"
    echo "  done"
    echo
}

#===============================================================================
# 示例 6: 倒计时器
#===============================================================================
example_countdown() {
    print_title "示例 6: 倒计时器"
    echo
    echo "示例代码:"
    echo "  seconds=10"
    echo "  until [ \$seconds -eq 0 ]"
    echo "  do"
    echo "    echo \"剩余 \$seconds 秒\""
    echo "    sleep 1"
    echo "    ((seconds--))"
    echo "  done"
    echo "  echo \"时间到!\""
    echo
    echo "输出:"
    seconds=5  # 演示用 5 秒
    until [ $seconds -eq 0 ]
    do
        printf "  剩余 %d 秒\n" $seconds
        sleep 0.5
        ((seconds--))
    done
    echo "  🎉 时间到!"
    echo
}

#===============================================================================
# 主函数
#===============================================================================
main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "Shell until 循环详解"
    print_separator
    echo
    
    example_basic
    example_comparison
    example_wait_service
    example_input_validation
    example_retry
    example_countdown
    
    print_separator
    print_info "总结:"
    echo "  ✅ until 循环：条件为假时执行，为真时退出"
    echo "  ✅ 与 while 相反：while 条件为真时执行"
    echo "  ✅ 适用场景:"
    echo "     - 等待服务/文件就绪"
    echo "     - 用户输入验证"
    echo "     - 自动重试机制"
    echo "     - 倒计时器"
    echo "  ✅ 可以配合 break 和 continue 使用"
    print_separator
}

# 调用主函数
main "$@"

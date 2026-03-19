#!/bin/bash
#===============================================================================
# 脚本名称：13_job_control.sh
# 功能描述：演示 Shell 前后台作业控制
# 难度等级：★★☆☆☆ (中级)
# 知识点：
#   - & 后台运行
#   - jobs 查看作业
#   - fg %n 前台运行
#   - bg %n 后台运行
#   - Ctrl+Z 暂停作业
#   - Ctrl+C 终止作业
#   - kill %n 终止作业
#   - nohup 退出终端继续运行
#   - screen 多会话管理
# 使用方法：
#   chmod +x 13_job_control.sh
#   ./13_job_control.sh
# 参考来源：cnblogs Shell 指南 2.1 节
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
    printf "${YELLOW}%-70s${NC}\n" "Shell 前后台作业控制"
    print_separator
    echo
    
    print_title "1. & - 后台运行"
    echo "  语法：command &"
    echo "  示例:"
    echo "    sleep 300 &"
    echo "    [1] 12345  # [作业号] PID"
    echo
    echo "  说明:"
    echo "  - & 放在命令后面，表示后台运行"
    echo "  - 后台作业仍然关联终端"
    echo "  - 退出终端，后台作业会终止"
    echo
    
    print_title "2. jobs - 查看作业"
    echo "  查看所有作业:"
    echo "    jobs"
    echo
    echo "  查看详细信息:"
    echo "    jobs -l  # 显示 PID"
    echo
    echo "  输出示例:"
    echo "    [1]+  Running  sleep 300 &"
    echo "    [2]-  Stopped  vim"
    echo
    
    print_title "3. Ctrl+Z - 暂停前台作业"
    echo "  用法：在前台运行时按 Ctrl+Z"
    echo "  示例:"
    echo "    vim file.txt"
    echo "    ^Z  # 按 Ctrl+Z"
    echo "    [1]+  Stopped  vim file.txt"
    echo
    echo "  暂停后可以使用:"
    echo "    bg %1  # 后台继续"
    echo "    fg %1  # 前台继续"
    echo
    
    print_title "4. fg - 前台运行"
    echo "  语法：fg [%作业号]"
    echo "  示例:"
    echo "    fg      # 恢复最后一个作业"
    echo "    fg %1   # 恢复作业 1"
    echo
    
    print_title "5. bg - 后台运行"
    echo "  语法：bg [%作业号]"
    echo "  示例:"
    echo "    bg      # 后台运行最后一个作业"
    echo "    bg %2   # 后台运行作业 2"
    echo
    
    print_title "6. kill - 终止作业"
    echo "  语法：kill [%作业号] 或 kill PID"
    echo "  示例:"
    echo "    kill %1     # 终止作业 1"
    echo "    kill %2     # 终止作业 2"
    echo "    kill -9 %1  # 强制终止"
    echo
    
    print_title "7. Ctrl+C - 终止前台作业"
    echo "  用法：在前台运行时按 Ctrl+C"
    echo "  示例:"
    echo "    ping google.com"
    echo "    ^C  # 按 Ctrl+C 终止"
    echo
    
    print_title "8. nohup - 退出终端继续运行"
    echo "  语法：nohup command [args] &"
    echo "  示例:"
    echo "    nohup sleep 600 &"
    echo "    nohup python app.py &"
    echo
    echo "  说明:"
    echo "  - nohup 忽略挂起信号"
    echo "  - 输出默认保存到 nohup.out"
    echo "  - 推荐：nohup command &>/dev/null &"
    echo
    
    print_title "9. screen - 多会话管理【强烈推荐】"
    echo "  安装：yum install -y screen"
    echo
    echo "  常用命令:"
    echo "    screen -S name     # 创建命名会话"
    echo "    screen -ls         # 列出所有会话"
    echo "    screen -r name     # 恢复会话"
    echo "    screen -d name     # 分离会话"
    echo "    Ctrl+A, D          # 快捷键分离"
    echo "    exit               # 退出会话"
    echo
    
    print_title "10. 作业控制流程图"
    echo "  启动作业:"
    echo "    command          # 前台运行"
    echo "    command &        # 后台运行"
    echo "    nohup command &  # 退出终端继续"
    echo "    screen command   # 会话管理"
    echo
    echo "  控制作业:"
    echo "    Ctrl+Z  -> 暂停"
    echo "    Ctrl+C  -> 终止"
    echo "    jobs    -> 查看"
    echo "    fg %n   -> 前台"
    echo "    bg %n   -> 后台"
    echo "    kill %n -> 终止"
    echo
    
    print_title "11. 实际应用场景"
    echo "  场景 1: 运行长时间任务"
    echo "    # 使用 nohup"
    echo "    nohup python train.py &>/dev/null &"
    echo
    echo "  场景 2: 交互式任务需要暂停"
    echo "    # 使用 screen"
    echo "    screen -S training"
    echo "    python train.py"
    echo "    # Ctrl+A, D 分离"
    echo "    # 稍后 screen -r training 恢复"
    echo
    echo "  场景 3: 临时暂停编辑"
    echo "    # vim 中按 Ctrl+Z"
    echo "    # 处理其他事情"
    echo "    # fg 恢复编辑"
    echo
    
    print_separator
    print_info "总结:"
    echo "  ✅ &  - 后台运行"
    echo "  ✅ jobs - 查看作业"
    echo "  ✅ fg - 前台运行"
    echo "  ✅ bg - 后台运行"
    echo "  ✅ Ctrl+Z - 暂停"
    echo "  ✅ Ctrl+C - 终止"
    echo "  ✅ kill %n - 终止作业"
    echo "  ✅ nohup - 退出终端继续"
    echo "  ✅ screen - 会话管理 (最强大)"
    print_separator
}

main "$@"

#!/bin/bash
# =============================================================================
# 脚本名称：01_system_info_check.sh
# 功能描述：系统信息检查 - 收集服务器基本信息
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - uname 系统信息
#   - hostname 主机名
#   - uptime 运行时间
#   - free 内存信息
#   - df 磁盘信息
#   - 颜色输出
# 使用方法：
#   chmod +x 01_system_info_check.sh
#   ./01_system_info_check.sh
# 应用场景：
#   - 新服务器初始化检查
#   - 系统巡检
#   - 故障排查信息收集
# =============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印分隔线
print_line() {
    echo -e "${BLUE}========================================${NC}"
}

# 打印标题
print_title() {
    echo -e "${GREEN}【$1】${NC}"
}

# 主函数
main() {
    clear
    
    print_line
    echo -e "${GREEN}       系统信息检查报告${NC}"
    print_line
    echo ""
    
    # 1. 系统基本信息
    print_title "系统基本信息"
    echo "操作系统：$(uname -s)"
    echo "内核版本：$(uname -r)"
    echo "系统架构：$(uname -m)"
    echo "主机名称：$(hostname)"
    echo ""
    
    # 2. 运行时间
    print_title "系统运行时间"
    uptime
    echo ""
    
    # 3. CPU 信息
    print_title "CPU 信息"
    echo "CPU 核心数：$(nproc)"
    echo "CPU 型号：$(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
    echo ""
    
    # 4. 内存信息
    print_title "内存使用情况"
    free -h
    echo ""
    
    # 5. 磁盘信息
    print_title "磁盘使用情况"
    df -h | grep -E '^/dev|Filesystem'
    echo ""
    
    # 6. 网络信息
    print_title "网络接口信息"
    ip addr | grep -E 'inet |^[0-9]+:' | head -20
    echo ""
    
    # 7. 当前用户
    print_title "用户信息"
    echo "当前用户：$(whoami)"
    echo "登录用户：$(who | wc -l) 人"
    echo ""
    
    # 8. 进程数量
    print_title "进程统计"
    echo "总进程数：$(ps aux | wc -l)"
    echo "运行中进程：$(ps aux | awk '$8 ~ /R/' | wc -l)"
    echo ""
    
    print_line
    echo -e "${GREEN}检查完成！${NC}"
    print_line
}

# 执行主函数
main

# 说明：
# 1. 使用颜色输出让信息更清晰
# 2. 函数封装提高代码复用性
# 3. 适合快速了解服务器状态
# 4. 可以添加到日常巡检脚本中

# 扩展：
# 1. 可以添加日志记录功能
# 2. 可以输出到 HTML 报告
# 3. 可以添加邮件发送功能
# 4. 可以添加到 crontab 定时执行

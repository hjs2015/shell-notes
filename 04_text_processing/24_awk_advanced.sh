#!/bin/bash
#===============================================================================
# 脚本名称：15_awk_advanced.sh
# 功能描述：演示 awk 命令的高级用法
# 难度等级：★★★☆☆ (中高级)
#===============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_title() { printf "${YELLOW}【%s】${NC}\n" "$1"; }
print_separator() { printf "${BLUE}===============================================================================${NC}\n"; }

main() {
    print_separator
    printf "${YELLOW}%-70s${NC}\n" "awk 高级用法"
    print_separator
    echo
    
    print_title "1. 内置变量"
    echo "  \$0      - 整行内容"
    echo "  \$1,\$2..  - 第 1,2..个字段"
    echo "  NF       - 字段数"
    echo "  NR       - 行号"
    echo "  FNR      - 文件内行号"
    echo "  FS       - 输入分隔符 (默认空格)"
    echo "  OFS      - 输出分隔符 (默认空格)"
    echo "  RS       - 输入记录分隔符 (默认换行)"
    echo "  ORS      - 输出记录分隔符 (默认换行)"
    echo
    
    print_title "2. 基本用法"
    echo "  awk '{print \$1}' file           # 打印第 1 列"
    echo "  awk -F: '{print \$1}' /etc/passwd # 指定分隔符"
    echo "  awk 'NR==5' file                 # 打印第 5 行"
    echo "  awk 'NR>5 && NR<10' file         # 打印 6-9 行"
    echo
    
    print_title "3. 条件过滤"
    echo "  awk '\$1 > 100' file             # 第 1 列>100"
    echo "  awk '\$3 == \"error\"' file      # 第 3 列=error"
    echo "  awk '/pattern/' file             # 匹配 pattern"
    echo "  awk '!/pattern/' file            # 不匹配 pattern"
    echo
    
    print_title "4. 格式化输出"
    echo "  awk '{printf \"%-10s %5d\\n\", \$1, \$2}' file"
    echo "  awk 'BEGIN{OFS=\"|\"} {print \$1,\$2}' file"
    echo
    
    print_title "5. BEGIN 和 END"
    echo "  awk 'BEGIN{print \"Header\"} {print} END{print \"Footer\"}' file"
    echo "  awk 'END{print NR}' file         # 打印总行数"
    echo "  awk '{sum+=\$1} END{print sum}' file  # 求和"
    echo
    
    print_title "6. 数组"
    echo "  awk '{count[\$1]++} END{for(k in count) print k,count[k]}' file"
    echo
    
    print_title "7. 内置函数"
    echo "  length(\$0)      - 字符串长度"
    echo "  substr(\$0,1,5)  - 子字符串"
    echo "  index(\$0,\"abc\") - 查找位置"
    echo "  tolower(\$0)     - 转小写"
    echo "  toupper(\$0)     - 转大写"
    echo "  split(\$0,arr,\":\") - 分割字符串"
    echo "  system(\"ls\")   - 执行系统命令"
    echo
    
    print_title "8. 实际应用"
    echo "  场景 1: 统计文件大小"
    echo "    ls -l | awk '{sum+=\$5} END{print sum}'"
    echo
    echo "  场景 2: 提取特定列"
    echo "    ps aux | awk '{print \$1,\$2,\$11}'"
    echo
    echo "  场景 3: 计算平均值"
    echo "    awk '{sum+=\$1; count++} END{print sum/count}' scores.txt"
    echo
    echo "  场景 4: 去重"
    echo "    awk '!seen[\$0]++' file"
    echo
    
    print_separator
}

main "$@"

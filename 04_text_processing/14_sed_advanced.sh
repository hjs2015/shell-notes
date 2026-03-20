#!/bin/bash
#===============================================================================
# 脚本名称：14_sed_advanced.sh
# 功能描述：演示 sed 命令的高级用法
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
    printf "${YELLOW}%-70s${NC}\n" "sed 高级用法"
    print_separator
    echo
    
    print_title "1. 替换操作"
    echo "  sed 's/old/new/' file        # 替换每行第一个"
    echo "  sed 's/old/new/g' file       # 全局替换"
    echo "  sed 's/old/new/gi' file      # 忽略大小写"
    echo "  sed '2s/old/new/' file       # 只替换第 2 行"
    echo "  sed '2,5s/old/new/' file     # 替换 2-5 行"
    echo
    
    print_title "2. 删除操作"
    echo "  sed '/pattern/d' file        # 删除匹配行"
    echo "  sed '/pattern/!d' file       # 删除不匹配行"
    echo "  sed '2d' file                # 删除第 2 行"
    echo "  sed '2,5d' file              # 删除 2-5 行"
    echo "  sed '\$d' file               # 删除最后一行"
    echo
    
    print_title "3. 打印操作"
    echo "  sed -n '5p' file             # 打印第 5 行"
    echo "  sed -n '5,10p' file          # 打印 5-10 行"
    echo "  sed -n '/pattern/p' file     # 打印匹配行"
    echo "  sed -n '5,/pattern/p' file   # 从第 5 行到匹配行"
    echo
    
    print_title "4. 插入和追加"
    echo "  sed '3i\\新行' file          # 在第 3 行前插入"
    echo "  sed '3a\\新行' file          # 在第 3 行后追加"
    echo "  sed '/pattern/i\\新行' file  # 在匹配行前插入"
    echo "  sed '/pattern/a\\新行' file  # 在匹配行后追加"
    echo
    
    print_title "5. 读取文件"
    echo "  sed '3r file2' file1         # 将 file2 读入到第 3 行后"
    echo "  sed '/pattern/r file2' file1 # 读入到匹配行后"
    echo
    
    print_title "6. 写入文件"
    echo "  sed -n 'w output' file       # 所有行写入 output"
    echo "  sed -n '/pattern/w output' file  # 匹配行写入 output"
    echo
    
    print_title "7. 多个命令"
    echo "  sed -e 's/a/b/' -e 's/c/d/' file"
    echo "  sed 's/a/b/; s/c/d/' file"
    echo
    
    print_title "8. 实际应用场景"
    echo "  场景 1: 删除空行"
    echo "    sed '/^\$/d' file"
    echo
    echo "  场景 2: 删除行首空格"
    echo "    sed 's/^[[:space:]]*//' file"
    echo
    echo "  场景 3: 删除行尾空格"
    echo "    sed 's/[[:space:]]*\$//' file"
    echo
    echo "  场景 4: 在每行前添加前缀"
    echo "    sed 's/^/PREFIX: /' file"
    echo
    echo "  场景 5: 提取 IP 地址"
    echo "    sed -n 's/.*\\([0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\).*/\\1/p' file"
    echo
    
    print_separator
}

main "$@"

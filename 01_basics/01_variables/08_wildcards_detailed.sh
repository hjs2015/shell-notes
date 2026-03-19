#!/bin/bash
#===============================================================================
# 脚本名称：08_wildcards_detailed.sh
# 功能描述：演示 Shell 通配符的详细用法
# 难度等级：★☆☆☆☆ (初级)
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
    printf "${YELLOW}%-70s${NC}\n" "Shell 通配符详解"
    print_separator
    echo
    
    print_title "1. 基本通配符"
    echo "  *       - 匹配 0 个或多个字符"
    echo "  ?       - 匹配单个字符"
    echo "  [...]   - 匹配括号内任一字符"
    echo "  [^...]  - 匹配不在括号内的字符"
    echo "  [a-z]   - 匹配范围内的字符"
    echo
    
    print_title "2. 示例"
    echo "  *.txt      - 所有.txt 文件"
    echo "  file?.txt  - file1.txt, fileA.txt 等"
    echo "  [abc]*     - 以 a,b 或 c 开头的文件"
    echo "  [0-9]*     - 以数字开头的文件"
    echo "  [!0-9]*    - 不以数字开头的文件"
    echo
    
    print_title "3. 大括号展开"
    echo "  file{1,2,3}.txt  - file1.txt file2.txt file3.txt"
    echo "  {a..z}           - a b c ... z"
    echo "  {1..10}          - 1 2 3 ... 10"
    echo "  file{1..5}.txt   - file1.txt ... file5.txt"
    echo
    
    print_title "4. 实际应用"
    echo "  cp *.bak backup/        # 备份所有.bak 文件"
    echo "  rm file?.tmp            # 删除 file1.tmp, fileA.tmp 等"
    echo "  ls [A-Z]*               # 列出大写字母开头的文件"
    echo
    
    print_separator
}

main "$@"

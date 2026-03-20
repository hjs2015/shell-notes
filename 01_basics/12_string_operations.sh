#!/bin/bash
# =============================================================================
# 脚本名称：字符串操作进阶脚本
# 难度等级：⭐⭐ 基础
# 所属阶段：阶段 2 - 基础篇（01_basics/）
# 知识点：字符串长度、截取、替换、删除、大小写转换、模式匹配
# 功能描述：演示 Shell 中各种字符串操作技巧和方法
# 使用方法：bash 14_string_operations.sh
# 输出示例：
#   ========================================
#   字符串操作演示
#   ========================================
#   原始字符串：Hello World
#   字符串长度：11
#   截取前 5 个字符：Hello
#   替换 World→Shell：Hello Shell
#   ...
# 创建时间：2026-03-20
# 最后更新：2026-03-20
# =============================================================================

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_color() {
    echo -e "${!1}${2}${NC}"
}

print_separator() {
    echo "========================================"
}

# 测试字符串
TEST_STR="Hello, Shell World! 2026"

# =============================================================================
# 演示 1：字符串长度
# =============================================================================
demo_string_length() {
    print_separator
    print_color GREEN "【演示 1】字符串长度"
    print_separator
    
    local str="$TEST_STR"
    
    echo "原始字符串：'$str'"
    echo ""
    
    # 方法 1：${#var}
    echo "方法 1: \${#str}"
    echo "  长度：${#str}"
    echo ""
    
    # 方法 2：expr length
    echo "方法 2: expr length \"\$str\""
    echo "  长度：$(expr length "$str")"
    echo ""
    
    # 方法 3：wc -c（包含换行符）
    echo "方法 3: echo -n \"\$str\" | wc -c"
    echo "  长度：$(echo -n "$str" | wc -c)"
    echo ""
    
    # 方法 4：awk
    echo "方法 4: awk '{print length}'"
    echo "  长度：$(echo "$str" | awk '{print length}')"
    echo ""
}

# =============================================================================
# 演示 2：字符串截取（子字符串）
# =============================================================================
demo_substring() {
    print_separator
    print_color GREEN "【演示 2】字符串截取（子字符串）"
    print_separator
    
    local str="$TEST_STR"
    echo "原始字符串：'$str'"
    echo "索引位置：0123456789..."
    echo ""
    
    # 从位置 0 开始，取 5 个字符
    echo "从位置 0 取 5 个字符：\${str:0:5}"
    echo "  结果：'${str:0:5}'"
    echo ""
    
    # 从位置 7 开始，取 5 个字符
    echo "从位置 7 取 5 个字符：\${str:7:5}"
    echo "  结果：'${str:7:5}'"
    echo ""
    
    # 从位置 7 开始到结尾
    echo "从位置 7 到结尾：\${str:7}"
    echo "  结果：'${str:7}'"
    echo ""
    
    # 从末尾开始计数
    echo "从末尾第 7 个字符到结尾：\${str: -7}"
    echo "  结果：'${str: -7}'"
    echo ""
    
    # 负数长度（Bash 4.2+）
    echo "从位置 0 开始，排除最后 7 个：\${str:0:-7}"
    echo "  结果：'${str:0:-7}'"
    echo ""
}

# =============================================================================
# 演示 3：字符串替换
# =============================================================================
demo_replace() {
    print_separator
    print_color GREEN "【演示 3】字符串替换"
    print_separator
    
    local str="bash is great, bash is powerful"
    echo "原始字符串：'$str'"
    echo ""
    
    # 替换第一个匹配
    echo "替换第一个 'bash'→'Shell'：\${str/bash/Shell}"
    echo "  结果：'${str/bash/Shell}'"
    echo ""
    
    # 替换所有匹配
    echo "替换所有 'bash'→'Shell'：\${str//bash/Shell}"
    echo "  结果：'${str//bash/Shell}'"
    echo ""
    
    # 从开头替换
    echo "从开头替换 'bash'→'Shell'：\${str/#bash/Shell}"
    echo "  结果：'${str/#bash/Shell}'"
    echo ""
    
    # 从结尾替换
    local str2="hello world world"
    echo "原始字符串：'$str2'"
    echo "从结尾替换 'world'→'Shell'：\${str2/%world/Shell}"
    echo "  结果：'${str2/%world/Shell}'"
    echo ""
}

# =============================================================================
# 演示 4：字符串删除（模式匹配）
# =============================================================================
demo_delete() {
    print_separator
    print_color GREEN "【演示 4】字符串删除（模式匹配）"
    print_separator
    
    local str="/home/user/documents/file.txt"
    echo "原始字符串：'$str'"
    echo ""
    
    # 删除最短前缀匹配
    echo "删除最短前缀 '*/'：\${str#*/}"
    echo "  结果：'${str#*/}'"
    echo ""
    
    # 删除最长前缀匹配
    echo "删除最长前缀 '*/'：\${str##*/}"
    echo "  结果：'${str##*/}'（basename 效果）"
    echo ""
    
    # 删除最短后缀匹配
    echo "删除最短后缀 '.*'：\${str%.*}"
    echo "  结果：'${str%.*}'（去掉扩展名）"
    echo ""
    
    # 删除最长后缀匹配
    local str2="/home/user/archive.tar.gz"
    echo "原始字符串：'$str2'"
    echo "删除最长后缀 '.*'：\${str2%%.*}"
    echo "  结果：'${str2%%.*}'"
    echo ""
}

# =============================================================================
# 演示 5：大小写转换
# =============================================================================
demo_case_conversion() {
    print_separator
    print_color GREEN "【演示 5】大小写转换"
    print_separator
    
    local upper="HELLO WORLD"
    local lower="hello world"
    local mixed="HeLLo WoRLd"
    
    echo "大写转小写："
    echo "  原始：'$upper'"
    echo "  方法 1: \${var,,} → '${upper,,}'"
    echo "  方法 2: \${var,}（首字母） → '${upper,}'"
    echo ""
    
    echo "小写转大写："
    echo "  原始：'$lower'"
    echo "  方法 1: \${var^^} → '${lower^^}'"
    echo "  方法 2: \${var^}（首字母） → '${lower^}'"
    echo ""
    
    echo "大小写互换（Bash 4.0+）："
    echo "  原始：'$mixed'"
    echo "  方法：\${var~~} → '${mixed~~}'"
    echo ""
}

# =============================================================================
# 演示 6：字符串拼接
# =============================================================================
demo_concatenation() {
    print_separator
    print_color GREEN "【演示 6】字符串拼接"
    print_separator
    
    local str1="Hello"
    local str2="World"
    
    echo "字符串 1: '$str1'"
    echo "字符串 2: '$str2'"
    echo ""
    
    # 直接拼接
    echo "直接拼接：\$str1\$str2"
    echo "  结果：'$str1$str2'"
    echo ""
    
    # 带空格拼接
    echo "带空格拼接：\"\$str1 \$str2\""
    echo "  结果：'$str1 $str2'"
    echo ""
    
    # 使用变量
    local result="${str1}, ${str2}!"
    echo "使用变量：result=\"\${str1}, \${str2}!\""
    echo "  结果：'$result'"
    echo ""
    
    # 追加到变量
    local text="Hello"
    text+=" World"
    text+="!"
    echo "追加操作：text+=' World' → '$text'"
    echo ""
}

# =============================================================================
# 演示 7：字符串比较
# =============================================================================
demo_comparison() {
    print_separator
    print_color GREEN "【演示 7】字符串比较"
    print_separator
    
    local str1="abc"
    local str2="ABC"
    local str3="abc"
    
    echo "字符串 1: '$str1'"
    echo "字符串 2: '$str2'"
    echo "字符串 3: '$str3'"
    echo ""
    
    # 相等比较
    echo "相等比较（==）："
    [[ "$str1" == "$str3" ]] && echo "  ✓ '\$str1' == '\$str3'" || echo "  ✗ '\$str1' != '\$str3'"
    [[ "$str1" == "$str2" ]] && echo "  ✓ '\$str1' == '\$str2'" || echo "  ✗ '\$str1' != '\$str2'"
    echo ""
    
    # 不等比较
    echo "不等比较（!=）："
    [[ "$str1" != "$str2" ]] && echo "  ✓ '\$str1' != '\$str2'" || echo "  ✗ '\$str1' == '\$str2'"
    echo ""
    
    # 空字符串检查
    local empty=""
    echo "空字符串检查："
    [[ -z "$empty" ]] && echo "  ✓ 变量为空（-z）" || echo "  ✗ 变量不为空"
    [[ -n "$str1" ]] && echo "  ✓ 变量不为空（-n）" || echo "  ✗ 变量为空"
    echo ""
    
    # 模式匹配
    echo "模式匹配："
    [[ "$str1" == a* ]] && echo "  ✓ '\$str1' 以 'a' 开头" || echo "  ✗ '\$str1' 不以 'a' 开头"
    [[ "$str1" == *c ]] && echo "  ✓ '\$str1' 以 'c' 结尾" || echo "  ✗ '\$str1' 不以 'c' 结尾"
    [[ "$str1" == *b* ]] && echo "  ✓ '\$str1' 包含 'b'" || echo "  ✗ '\$str1' 不包含 'b'"
    echo ""
}

# =============================================================================
# 演示 8：实用技巧
# =============================================================================
demo_practical_tips() {
    print_separator
    print_color GREEN "【演示 8】实用技巧"
    print_separator
    
    # 提取文件名
    local filepath="/home/user/documents/report.pdf"
    echo "文件路径：'$filepath'"
    echo "  文件名：'${filepath##*/}'"
    echo "  目录名：'${filepath%/*}'"
    echo "  不带扩展名：'${filepath%.*}'"
    echo "  扩展名：'${filepath##*.}'"
    echo ""
    
    # 去除首尾空格
    local spaced="  hello world  "
    echo "带空格字符串：'$spaced'"
    # 使用 extglob（需要 shopt -s extglob）
    shopt -s extglob
    local trimmed="${spaced##+([[:space:]])}"
    trimmed="${trimmed%%+([[:space:]])}"
    echo "去除首尾空格：'$trimmed'"
    shopt -u extglob
    echo ""
    
    # 替换路径分隔符
    local unix_path="/home/user/file.txt"
    echo "Unix 路径：'$unix_path'"
    echo "Windows 路径：'${unix_path//\//\\}'"
    echo ""
    
    # 统计字符出现次数
    local text="hello world, hello bash"
    echo "文本：'$text'"
    local count="${text//[^o]}"
    echo "字符 'o' 出现次数：${#count}"
    echo ""
}

# =============================================================================
# 总结表格
# =============================================================================
print_summary_table() {
    print_separator
    print_color GREEN "字符串操作总结表"
    print_separator
    
    echo "常用操作速查："
    echo ""
    printf "%-20s %-25s %-15s\n" "操作" "语法" "示例"
    printf "%-20s %-25s %-15s\n" "----" "----" "----"
    printf "%-20s %-25s %-15s\n" "长度" "\${#var}" "\${#str}"
    printf "%-20s %-25s %-15s\n" "截取" "\${var:pos:len}" "\${str:0:5}"
    printf "%-20s %-25s %-15s\n" "替换第一个" "\${var/old/new}" "\${str/a/b}"
    printf "%-20s %-25s %-15s\n" "替换所有" "\${var//old/new}" "\${str//a/b}"
    printf "%-20s %-25s %-15s\n" "删除前缀（短）" "\${var#pattern}" "\${str#*/}"
    printf "%-20s %-25s %-15s\n" "删除前缀（长）" "\${var##pattern}" "\${str##*/}"
    printf "%-20s %-25s %-15s\n" "删除后缀（短）" "\${var%pattern}" "\${str%.*}"
    printf "%-20s %-25s %-15s\n" "删除后缀（长）" "\${var%%pattern}" "\${str%%.*}"
    printf "%-20s %-25s %-15s\n" "转小写" "\${var,,}" "\${str,,}"
    printf "%-20s %-25s %-15s\n" "转大写" "\${var^^}" "\${str^^}"
    echo ""
}

# =============================================================================
# 主程序入口
# =============================================================================
main() {
    print_separator
    print_color CYAN "字符串操作进阶演示"
    print_separator
    echo ""
    
    case "${1:-}" in
        -h|--help)
            echo "用法：$0 [选项]"
            echo ""
            echo "选项："
            echo "  -h, --help      显示帮助信息"
            echo "  -a, --all       运行所有演示（默认）"
            echo "  -l, --length    仅演示字符串长度"
            echo "  -s, --substring 仅演示字符串截取"
            echo "  -r, --replace   仅演示字符串替换"
            echo "  -d, --delete    仅演示字符串删除"
            echo "  -c, --case      仅演示大小写转换"
            echo "  -C, --concat    仅演示字符串拼接"
            echo "  -p, --compare   仅演示字符串比较"
            echo "  -t, --tips      仅演示实用技巧"
            echo ""
            exit 0
            ;;
        -l|--length)
            demo_string_length
            ;;
        -s|--substring)
            demo_substring
            ;;
        -r|--replace)
            demo_replace
            ;;
        -d|--delete)
            demo_delete
            ;;
        -c|--case)
            demo_case_conversion
            ;;
        -C|--concat)
            demo_concatenation
            ;;
        -p|--compare)
            demo_comparison
            ;;
        -t|--tips)
            demo_practical_tips
            ;;
        -a|--all|"")
            demo_string_length
            demo_substring
            demo_replace
            demo_delete
            demo_case_conversion
            demo_concatenation
            demo_comparison
            demo_practical_tips
            print_summary_table
            ;;
        *)
            echo "未知选项：$1"
            exit 1
            ;;
    esac
    
    print_separator
    print_color GREEN "演示完成！"
    print_separator
}

main "$@"

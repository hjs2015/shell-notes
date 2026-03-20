#!/bin/bash
# ============================================================================
# 脚本名称：01_paste_basics.sh
# 功能描述：paste 命令基础用法 - 合并文件的行
# 难度等级：⭐⭐⭐ 中级
# 知识点：paste 命令、行合并、分隔符、并行处理
# 使用方法：bash 01_paste_basics.sh
# 依赖命令：paste, echo, cat
# ============================================================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印标题
print_header() {
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================================================${NC}"
}

# 打印示例
print_example() {
    echo -e "${YELLOW}【示例】${NC}$1"
    echo -e "${GREEN}$2${NC}"
}

# 打印输出
print_output() {
    echo -e "${GREEN}$1${NC}"
}

print_header "📌 paste 命令基础用法 - 合并文件的行"

# ------------------------------------------------------------------------------
# 1. paste 命令简介
# ------------------------------------------------------------------------------
print_example "paste 命令作用" "将多个文件的行按列合并，默认用制表符分隔"

# ------------------------------------------------------------------------------
# 2. 创建测试文件
# ------------------------------------------------------------------------------
print_header "📝 创建测试文件"

# 创建文件 1：姓名
cat > /tmp/names.txt << 'EOF'
张三
李四
王五
赵六
EOF
print_example "创建文件 names.txt" "cat > /tmp/names.txt"

# 创建文件 2：年龄
cat > /tmp/ages.txt << 'EOF'
25
30
28
35
EOF
print_example "创建文件 ages.txt" "cat > /tmp/ages.txt"

# 创建文件 3：城市
cat > /tmp/cities.txt << 'EOF'
北京
上海
广州
深圳
EOF
print_example "创建文件 cities.txt" "cat > /tmp/cities.txt"

# ------------------------------------------------------------------------------
# 3. 基础用法：合并两个文件
# ------------------------------------------------------------------------------
print_header "🔹 用法 1：合并两个文件"

print_example "合并姓名和年龄" "paste /tmp/names.txt /tmp/ages.txt"
output=$(paste /tmp/names.txt /tmp/ages.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 4. 合并多个文件
# ------------------------------------------------------------------------------
print_header "🔹 用法 2：合并多个文件"

print_example "合并姓名、年龄、城市" "paste /tmp/names.txt /tmp/ages.txt /tmp/cities.txt"
output=$(paste /tmp/names.txt /tmp/ages.txt /tmp/cities.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 5. 自定义分隔符
# ------------------------------------------------------------------------------
print_header "🔹 用法 3：自定义分隔符 (-d 选项)"

print_example "使用逗号分隔" "paste -d ',' /tmp/names.txt /tmp/ages.txt"
output=$(paste -d ',' /tmp/names.txt /tmp/ages.txt)
print_output "$output"

print_example "使用冒号分隔" "paste -d ':' /tmp/names.txt /tmp/ages.txt"
output=$(paste -d ':' /tmp/names.txt /tmp/ages.txt)
print_output "$output"

print_example "使用多个分隔符（循环使用）" "paste -d ',|:' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt"
output=$(paste -d ',|:' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 6. 合并单文件的多行到一行 (-s 选项)
# ------------------------------------------------------------------------------
print_header "🔹 用法 4：串行合并 (-s 选项)"

print_example "将多行合并为一行（默认制表符）" "paste -s /tmp/names.txt"
output=$(paste -s /tmp/names.txt)
print_output "$output"

print_example "将多行合并为一行（自定义分隔符）" "paste -s -d ',' /tmp/names.txt"
output=$(paste -s -d ',' /tmp/names.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 7. 指定每行的列数
# ------------------------------------------------------------------------------
print_header "🔹 用法 5：指定每行的列数 (-n 选项)"

print_example "每 2 个名字一行" "paste -s -n 2 -d ',' /tmp/names.txt"
output=$(paste -s -n 2 -d ',' /tmp/names.txt)
print_output "$output"

print_example "每 3 个名字一行" "paste -s -n 3 -d ',' /tmp/names.txt"
output=$(paste -s -n 3 -d ',' /tmp/names.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 8. 实战案例：生成 CSV 文件
# ------------------------------------------------------------------------------
print_header "🔹 实战案例：生成 CSV 文件"

print_example "生成员工信息 CSV" "paste -d ',' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt > /tmp/employees.csv"
paste -d ',' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt > /tmp/employees.csv
print_output "生成的 CSV 文件内容："
cat /tmp/employees.csv | while read line; do echo "  $line"; done

# ------------------------------------------------------------------------------
# 9. 实战案例：合并命令输出
# ------------------------------------------------------------------------------
print_header "🔹 实战案例：合并命令输出"

print_example "合并两个命令的输出" "paste <(ls /tmp/*.txt | head -3) <(wc -l /tmp/*.txt | head -3)"
output=$(paste <(ls /tmp/*.txt 2>/dev/null | head -3) <(wc -l /tmp/*.txt 2>/dev/null | head -3))
print_output "$output"

# ------------------------------------------------------------------------------
# 10. 常用选项总结
# ------------------------------------------------------------------------------
print_header "📊 paste 常用选项总结"

cat << 'EOF'
选项          说明                  示例
-d DELIM      指定分隔符            paste -d ',' file1 file2
-s            串行合并（多行变一行） paste -s file
-n NUM        每行显示的列数         paste -s -n 2 file
              默认分隔符是制表符
EOF

# ------------------------------------------------------------------------------
# 清理测试文件
# ------------------------------------------------------------------------------
print_header "🧹 清理测试文件"
rm -f /tmp/names.txt /tmp/ages.txt /tmp/cities.txt /tmp/employees.txt
print_example "清理完成" "rm -f /tmp/names.txt /tmp/ages.txt /tmp/cities.txt /tmp/employees.txt"

print_header "✅ paste 命令基础学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}paste 适合合并结构化数据，常与 cut/sort/uniq 配合使用"
echo ""

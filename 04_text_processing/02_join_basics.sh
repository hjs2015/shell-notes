#!/bin/bash
# ============================================================================
# 脚本名称：02_join_basics.sh
# 功能描述：join 命令基础用法 - 基于关键字段合并文件
# 难度等级：⭐⭐⭐⭐ 中高级
# 知识点：join 命令、字段匹配、排序要求、数据库式连接
# 使用方法：bash 02_join_basics.sh
# 依赖命令：join, sort, cat
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

print_header "📌 join 命令基础用法 - 基于关键字段合并文件"

# ------------------------------------------------------------------------------
# 1. join 命令简介
# ------------------------------------------------------------------------------
print_example "join 命令作用" "基于共同字段（类似数据库 JOIN）合并两个文件"
print_example "重要前提" "两个文件必须按连接字段排序！"

# ------------------------------------------------------------------------------
# 2. 创建测试文件
# ------------------------------------------------------------------------------
print_header "📝 创建测试文件"

# 创建文件 1：员工 ID 和姓名（已排序）
cat > /tmp/employees.txt << 'EOF'
001 张三
002 李四
003 王五
004 赵六
005 钱七
EOF
print_example "创建员工文件" "cat > /tmp/employees.txt"

# 创建文件 2：员工 ID 和部门（已排序）
cat > /tmp/departments.txt << 'EOF'
001 技术部
002 销售部
003 市场部
004 财务部
006 人事部
EOF
print_example "创建部门文件" "cat > /tmp/departments.txt"

# 创建文件 3：员工 ID 和工资（已排序）
cat > /tmp/salaries.txt << 'EOF'
001 15000
002 12000
003 13000
004 18000
005 16000
EOF
print_example "创建工资文件" "cat > /tmp/salaries.txt"

# ------------------------------------------------------------------------------
# 3. 基础用法：内连接（只显示匹配的行）
# ------------------------------------------------------------------------------
print_header "🔹 用法 1：内连接（默认）"

print_example "员工 + 部门（只显示匹配的员工）" "join /tmp/employees.txt /tmp/departments.txt"
output=$(join /tmp/employees.txt /tmp/departments.txt)
print_output "$output"
echo ""
echo -e "${RED}注意：${NC}005 钱七和 006 人事部没有匹配，不会显示"

# ------------------------------------------------------------------------------
# 4. 左外连接（显示左文件所有行）
# ------------------------------------------------------------------------------
print_header "🔹 用法 2：左外连接 (-a 1)"

print_example "显示所有员工，即使没有部门" "join -a 1 /tmp/employees.txt /tmp/departments.txt"
output=$(join -a 1 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"
echo ""
echo -e "${GREEN}显示：${NC}005 钱七（没有部门信息）"

# ------------------------------------------------------------------------------
# 5. 右外连接（显示右文件所有行）
# ------------------------------------------------------------------------------
print_header "🔹 用法 3：右外连接 (-a 2)"

print_example "显示所有部门，即使没有员工" "join -a 2 /tmp/employees.txt /tmp/departments.txt"
output=$(join -a 2 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"
echo ""
echo -e "${GREEN}显示：${NC}006 人事部（没有员工）"

# ------------------------------------------------------------------------------
# 6. 全外连接（显示所有行）
# ------------------------------------------------------------------------------
print_header "🔹 用法 4：全外连接 (-a 1 -a 2)"

print_example "显示所有员工和部门" "join -a 1 -a 2 /tmp/employees.txt /tmp/departments.txt"
output=$(join -a 1 -a 2 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 7. 指定连接字段 (-1 和 -2 选项)
# ------------------------------------------------------------------------------
print_header "🔹 用法 5：指定连接字段"

# 创建不同格式的文件
cat > /tmp/emp_id.txt << 'EOF'
张三 001
李四 002
王五 003
EOF

cat > /tmp/dept_id.txt << 'EOF'
001 技术部
002 销售部
003 市场部
EOF

print_example "员工文件（姓名在前，ID 在后）" "cat /tmp/emp_id.txt"
print_example "部门文件（ID 在前，部门在后）" "cat /tmp/dept_id.txt"
print_example "按不同字段连接" "join -1 2 -2 1 /tmp/emp_id.txt /tmp/dept_id.txt"
output=$(join -1 2 -2 1 /tmp/emp_id.txt /tmp/dept_id.txt)
print_output "$output"
echo ""
echo -e "${YELLOW}说明：${NC}-1 2 表示第一个文件的第 2 列，-2 1 表示第二个文件的第 1 列"

# ------------------------------------------------------------------------------
# 8. 自定义输出格式 (-o 选项)
# ------------------------------------------------------------------------------
print_header "🔹 用法 6：自定义输出格式"

print_example "只输出姓名和部门" "join -o 1.1,2.2 /tmp/employees.txt /tmp/departments.txt"
output=$(join -o 1.1,2.2 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"

print_example "指定字段顺序和分隔符" "join -t ',' -o 1.1,1.2,2.2 /tmp/employees.txt /tmp/departments.txt"
output=$(join -t ',' -o 1.1,1.2,2.2 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 9. 自定义分隔符 (-t 选项)
# ------------------------------------------------------------------------------
print_header "🔹 用法 7：自定义分隔符"

# 创建 CSV 格式文件
cat > /tmp/emp.csv << 'EOF'
001,张三，25
002,李四，30
003,王五，28
EOF

cat > /tmp/dept.csv << 'EOF'
001，技术部
002，销售部
003，市场部
EOF

print_example "CSV 格式员工文件" "cat /tmp/emp.csv"
print_example "CSV 格式部门文件" "cat /tmp/dept.csv"
print_example "使用逗号分隔符连接" "join -t ',' /tmp/emp.csv /tmp/dept.csv"
output=$(join -t ',' /tmp/emp.csv /tmp/dept.csv)
print_output "$output"

# ------------------------------------------------------------------------------
# 10. 实战案例：生成完整员工信息
# ------------------------------------------------------------------------------
print_header "🔹 实战案例：生成完整员工信息"

print_example "员工 + 部门 + 工资" "join /tmp/employees.txt /tmp/departments.txt | join - /tmp/salaries.txt"
output=$(join /tmp/employees.txt /tmp/departments.txt | join - /tmp/salaries.txt)
print_output "$output"
echo ""
echo "格式：ID 姓名 部门 工资"

# ------------------------------------------------------------------------------
# 11. 未匹配行处理 (-e 选项)
# ------------------------------------------------------------------------------
print_header "🔹 用法 8：填充未匹配字段"

print_example "用'未知'填充未匹配字段" "join -a 1 -e '未知' -o 1.1,1.2,2.2 /tmp/employees.txt /tmp/departments.txt"
output=$(join -a 1 -e '未知' -o 1.1,1.2,2.2 /tmp/employees.txt /tmp/departments.txt)
print_output "$output"

# ------------------------------------------------------------------------------
# 12. 重要注意事项
# ------------------------------------------------------------------------------
print_header "⚠️ 重要注意事项"

cat << 'EOF'
1. 排序要求：两个文件必须按连接字段排序！
   错误示例：join file1.txt file2.txt（未排序）
   正确示例：join <(sort file1.txt) <(sort file2.txt)

2. 默认分隔符：空白字符（空格或制表符）
   使用 -t 选项可自定义分隔符

3. 连接字段：默认是两个文件的第 1 列
   使用 -1 和 -2 选项可指定不同列

4. 输出格式：默认输出连接字段 + 两个文件的剩余字段
   使用 -o 选项可自定义输出字段
EOF

# ------------------------------------------------------------------------------
# 13. join vs paste 对比
# ------------------------------------------------------------------------------
print_header "📊 join vs paste 对比"

cat << 'EOF'
命令    连接方式          排序要求    适用场景
join    基于关键字段      必须排序    数据库式连接、关联查询
paste   按行位置合并      无需排序    简单列合并、并行处理
EOF

# ------------------------------------------------------------------------------
# 清理测试文件
# ------------------------------------------------------------------------------
print_header "🧹 清理测试文件"
rm -f /tmp/employees.txt /tmp/departments.txt /tmp/salaries.txt
rm -f /tmp/emp_id.txt /tmp/dept_id.txt
rm -f /tmp/emp.csv /tmp/dept.csv
print_example "清理完成" "rm -f /tmp/*.txt /tmp/*.csv"

print_header "✅ join 命令基础学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}join 是强大的数据关联工具，适合处理结构化数据"
echo -e "${YELLOW}💡 练习：${NC}尝试对未排序的文件先排序再连接"
echo ""

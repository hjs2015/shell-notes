#!/bin/bash
# ============================================================================
# 脚本名称：03_paste_join_advanced.sh
# 功能描述：paste/join 命令高级用法 - 文件合并、字段连接、数据关联
# 难度等级：⭐⭐⭐⭐ 专家级
# 知识点：paste 命令、join 命令、文件合并、字段连接、数据关联
# 使用方法：bash 03_paste_join_advanced.sh
# 依赖命令：paste, join, sort, cut
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() { echo -e "${BLUE}============================================================================${NC}"; echo -e "${BLUE}$1${NC}"; echo -e "${BLUE}============================================================================${NC}"; }
print_example() { echo -e "${YELLOW}【示例】${NC}$1"; echo -e "${GREEN}$2${NC}"; }
print_output() { echo -e "${GREEN}$1${NC}"; }

print_header "📌 paste/join 命令高级用法"

# ------------------------------------------------------------------------------
# 1. paste 命令高级用法
# ------------------------------------------------------------------------------
print_header "🔹 paste 命令高级用法"

cat << 'EOF'
paste 命令用于将多个文件的行合并到一行，用分隔符分隔。

基本语法：
  paste [选项] 文件1 文件2 ...

常用选项：
  -d 分隔符    指定分隔符（默认是制表符）
  -s           串行合并（将每个文件的行合并为一行）
  -            从标准输入读取
EOF
echo ""

# 示例 1：多文件横向合并
print_example "【示例 1】多文件横向合并" "paste file1.txt file2.txt file3.txt"

echo -e "创建测试文件："
echo -e "张三\n李四\n王五" > /tmp/names.txt
echo -e "25\n30\n28" > /tmp/ages.txt
echo -e "北京\n上海\n广州" > /tmp/cities.txt

echo -e "${YELLOW}【文件内容】${NC}"
echo "names.txt: $(cat /tmp/names.txt | tr '\n' ',')"
echo "ages.txt: $(cat /tmp/ages.txt | tr '\n' ',')"
echo "cities.txt: $(cat /tmp/cities.txt | tr '\n' ',')"
echo ""

echo -e "${YELLOW}【合并结果】${NC}"
echo "命令：paste /tmp/names.txt /tmp/ages.txt /tmp/cities.txt"
paste /tmp/names.txt /tmp/ages.txt /tmp/cities.txt
echo ""

# 示例 2：自定义分隔符
print_example "【示例 2】自定义分隔符" "paste -d ',' file1.txt file2.txt"

echo -e "${YELLOW}【逗号分隔】${NC}"
echo "命令：paste -d ',' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt"
paste -d ',' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt
echo ""

echo -e "${YELLOW}【冒号分隔】${NC}"
echo "命令：paste -d ':' /tmp/names.txt /tmp/ages.txt"
paste -d ':' /tmp/names.txt /tmp/ages.txt
echo ""

# 示例 3：串行合并
print_example "【示例 3】串行合并" "paste -s file.txt"

echo -e "${YELLOW}【串行合并单个文件】${NC}"
echo "命令：paste -s /tmp/names.txt"
paste -s /tmp/names.txt
echo ""

echo -e "${YELLOW}【串行合并 + 自定义分隔符】${NC}"
echo "命令：paste -s -d ',' /tmp/names.txt"
paste -s -d ',' /tmp/names.txt
echo ""

# 示例 4：循环使用分隔符
print_example "【示例 4】循环使用分隔符" "paste -d ',:;' file1.txt file2.txt file3.txt"

echo -e "${YELLOW}【循环分隔符】${NC}"
echo "命令：paste -d ',:;' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt"
paste -d ',:;' /tmp/names.txt /tmp/ages.txt /tmp/cities.txt
echo ""
echo "说明：第一个分隔符用逗号，第二个用冒号，第三个用分号，然后循环"
echo ""

# 示例 5：与标准输入配合
print_example "【示例 5】与标准输入配合" "paste - file.txt"

echo -e "${YELLOW}【从标准输入读取】${NC}"
echo "命令：echo -e 'A\\nB\\nC' | paste - /tmp/names.txt"
echo -e 'A\nB\nC' | paste - /tmp/names.txt
echo ""

# ------------------------------------------------------------------------------
# 2. join 命令高级用法
# ------------------------------------------------------------------------------
print_header "🔹 join 命令高级用法"

cat << 'EOF'
join 命令用于将两个文件中指定字段相同的行连接起来。

基本语法：
  join [选项] 文件 1 文件 2

重要前提：
  两个文件必须按照连接字段排序（使用 sort 命令）

常用选项：
  -1 FIELD     指定第一个文件的连接字段
  -2 FIELD     指定第二个文件的连接字段
  -t CHAR      指定字段分隔符
  -a FILENUM   输出不匹配的行（1 或 2）
  -o FORMAT    自定义输出格式
  -v FILENUM   只输出不匹配的行
EOF
echo ""

# 示例 1：基本连接
print_example "【示例 1】基本连接" "join file1.txt file2.txt"

echo -e "创建测试文件（已排序）："
echo -e "101 张三\n102 李四\n103 王五" > /tmp/students.txt
echo -e "101 90\n102 85\n104 88" > /tmp/scores.txt

echo -e "${YELLOW}【文件内容】${NC}"
echo "students.txt:"
cat /tmp/students.txt
echo ""
echo "scores.txt:"
cat /tmp/scores.txt
echo ""

echo -e "${YELLOW}【连接结果】${NC}"
echo "命令：join /tmp/students.txt /tmp/scores.txt"
join /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：只输出学号匹配的行（101 和 102），103 和 104 被过滤"
echo ""

# 示例 2：指定连接字段
print_example "【示例 2】指定连接字段" "join -1 2 -2 1 file1.txt file2.txt"

echo -e "创建测试文件（不同字段顺序）："
echo -e "张三 101\n李四 102\n王五 103" > /tmp/students2.txt
echo -e "101 90\n102 85\n104 88" > /tmp/scores2.txt

echo -e "${YELLOW}【文件内容】${NC}"
echo "students2.txt（姓名在前，学号在后）:"
cat /tmp/students2.txt
echo ""
echo "scores2.txt（学号在前，分数在后）:"
cat /tmp/scores2.txt
echo ""

echo -e "${YELLOW}【按不同字段连接】${NC}"
echo "命令：join -1 2 -2 1 /tmp/students2.txt /tmp/scores2.txt"
join -1 2 -2 1 /tmp/students2.txt /tmp/scores2.txt
echo ""

# 示例 3：指定分隔符
print_example "【示例 3】指定分隔符" "join -t ',' file1.txt file2.txt"

echo -e "创建 CSV 格式文件："
echo -e "101，张三，25\n102，李四，30\n103，王五，28" | sort -t ',' -k1 > /tmp/data1.csv
echo -e "101,90\n102,85\n104,88" | sort -t ',' -k1 > /tmp/data2.csv

echo -e "${YELLOW}【CSV 文件连接】${NC}"
echo "命令：join -t ',' /tmp/data1.csv /tmp/data2.csv"
join -t ',' /tmp/data1.csv /tmp/data2.csv
echo ""

# 示例 4：输出不匹配的行
print_example "【示例 4】输出不匹配的行" "join -a 1 file1.txt file2.txt"

echo -e "${YELLOW}【输出文件 1 所有行（包括不匹配的）】${NC}"
echo "命令：join -a 1 /tmp/students.txt /tmp/scores.txt"
join -a 1 /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：103 学号在 scores.txt 中没有匹配，但也输出了"
echo ""

echo -e "${YELLOW}【输出文件 2 所有行（包括不匹配的）】${NC}"
echo "命令：join -a 2 /tmp/students.txt /tmp/scores.txt"
join -a 2 /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：104 学号在 students.txt 中没有匹配，但也输出了"
echo ""

# 示例 5：只输出不匹配的行
print_example "【示例 5】只输出不匹配的行" "join -v 1 file1.txt file2.txt"

echo -e "${YELLOW}【只输出文件 1 不匹配的行】${NC}"
echo "命令：join -v 1 /tmp/students.txt /tmp/scores.txt"
join -v 1 /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：只输出 103（在 scores.txt 中没有匹配）"
echo ""

echo -e "${YELLOW}【只输出文件 2 不匹配的行】${NC}"
echo "命令：join -v 2 /tmp/students.txt /tmp/scores.txt"
join -v 2 /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：只输出 104（在 students.txt 中没有匹配）"
echo ""

# 示例 6：自定义输出格式
print_example "【示例 6】自定义输出格式" "join -o 1.1,1.2,2.2 file1.txt file2.txt"

echo -e "${YELLOW}【自定义输出字段】${NC}"
echo "命令：join -o 1.1,1.2,2.2 /tmp/students.txt /tmp/scores.txt"
join -o 1.1,1.2,2.2 /tmp/students.txt /tmp/scores.txt
echo ""
echo "说明：输出格式为：学号、姓名、分数（去掉重复的学号）"
echo ""

# ------------------------------------------------------------------------------
# 3. 实战案例
# ------------------------------------------------------------------------------
print_header "🔹 实战案例"

# 案例 1：合并员工信息
print_example "【案例 1】合并员工信息" "生成员工完整档案"

echo -e "创建员工数据："
echo -e "E001 张三\nE002 李四\nE003 王五\nE004 赵六" | sort > /tmp/employees.txt
echo -e "E001 技术部\nE002 销售部\nE003 人事部\nE005 财务部" | sort > /tmp/departments.txt
echo -e "E001 15000\nE002 12000\nE003 10000\nE004 13000" | sort > /tmp/salaries.txt

echo -e "${YELLOW}【原始数据】${NC}"
echo "employees.txt（员工 ID 姓名）:"
cat /tmp/employees.txt
echo ""
echo "departments.txt（部门信息）:"
cat /tmp/departments.txt
echo ""
echo "salaries.txt（薪资信息）:"
cat /tmp/salaries.txt
echo ""

echo -e "${YELLOW}【合并员工 + 部门】${NC}"
echo "命令：join /tmp/employees.txt /tmp/departments.txt"
join /tmp/employees.txt /tmp/departments.txt
echo ""

echo -e "${YELLOW}【完整员工档案（多步合并）】${NC}"
echo "命令：join /tmp/employees.txt /tmp/departments.txt | join - /tmp/salaries.txt"
join /tmp/employees.txt /tmp/departments.txt | join - /tmp/salaries.txt
echo ""

# 案例 2：日志关联分析
print_example "【案例 2】日志关联分析" "关联用户日志和订单日志"

echo -e "创建日志数据："
echo -e "U001 2026-03-21 10:00 登录\nU002 2026-03-21 10:05 登录\nU003 2026-03-21 10:10 登录" | sort > /tmp/login.log
echo -e "U001 2026-03-21 10:30 下单\nU002 2026-03-21 10:35 下单\nU004 2026-03-21 10:40 下单" | sort > /tmp/order.log

echo -e "${YELLOW}【登录日志】${NC}"
cat /tmp/login.log
echo ""
echo "订单日志："
cat /tmp/order.log
echo ""

echo -e "${YELLOW}【关联分析（登录且下单的用户）】${NC}"
echo "命令：join /tmp/login.log /tmp/order.log"
join /tmp/login.log /tmp/order.log
echo ""

echo -e "${YELLOW}【查找登录但未下单的用户】${NC}"
echo "命令：join -v 1 /tmp/login.log /tmp/order.log"
join -v 1 /tmp/login.log /tmp/order.log
echo ""

# 案例 3：数据报表生成
print_example "【案例 3】数据报表生成" "生成销售报表"

echo -e "创建销售数据："
echo -e "P001 手机\nP002 电脑\nP003 平板\nP004 手表" | sort > /tmp/products.txt
echo -e "P001 100\nP002 50\nP003 80\nP004 120" | sort > /tmp/sales.txt
echo -e "P001 2999\nP002 5999\nP003 1999\nP004 999" | sort > /tmp/prices.txt

echo -e "${YELLOW}【生成完整销售报表】${NC}"
echo "命令：join /tmp/products.txt /tmp/sales.txt | join - /tmp/prices.txt"
join /tmp/products.txt /tmp/sales.txt | join - /tmp/prices.txt
echo ""

echo -e "${YELLOW}【格式化输出（产品、销量、单价）】${NC}"
echo "命令：join /tmp/products.txt /tmp/sales.txt | join - /tmp/prices.txt | awk '{printf \"%-10s 销量：%3d 单价：%5d\\n\", $2, $3, $4}'"
join /tmp/products.txt /tmp/sales.txt | join - /tmp/prices.txt | awk '{printf "%-10s 销量：%3d 单价：%5d\n", $2, $3, $4}'
echo ""

# ------------------------------------------------------------------------------
# 4. 性能优化技巧
# ------------------------------------------------------------------------------
print_header "🔹 性能优化技巧"

cat << 'EOF'
1. 大数据集预处理：
   - 使用 sort 先排序（join 要求输入已排序）
   - 对于大文件，使用 sort -S 50% 限制内存使用

2. 字段选择优化：
   - 使用 -o 选项只输出需要的字段
   - 减少后续处理的数据量

3. 管道组合：
   - join 可以多次管道组合处理多文件
   - 使用临时文件避免重复排序

4. 内存优化：
   - 对于超大文件，使用 join 的 --buffer-size 选项
   - 考虑使用数据库替代（如 SQLite）
EOF
echo ""

# ------------------------------------------------------------------------------
# 5. 常见错误
# ------------------------------------------------------------------------------
print_header "🔹 常见错误"

cat << 'EOF'
❌ 错误 1：文件未排序
  错误信息：join: 输入不是已排序的
  解决方案：先使用 sort 命令排序

❌ 错误 2：分隔符不匹配
  错误信息：连接结果为空
  解决方案：使用 -t 指定正确的分隔符

❌ 错误 3：字段编号错误
  错误信息：join: 无效的字段编号
  解决方案：检查字段编号是否正确（从 1 开始）

❌ 错误 4：编码问题
  错误信息：乱码或连接失败
  解决方案：确保文件编码一致（UTF-8）
EOF
echo ""

# ------------------------------------------------------------------------------
# 清理
# ------------------------------------------------------------------------------
print_header "🧹 清理"
rm -f /tmp/*.txt /tmp/*.log /tmp/*.csv
print_example "清理完成" "rm -f /tmp/*.txt /tmp/*.log /tmp/*.csv"

print_header "✅ paste/join 命令高级用法学习完成！"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "1. paste 用于横向合并文件行"
echo "2. join 用于基于字段连接两个文件"
echo "3. join 前必须使用 sort 排序"
echo "4. 使用 -a/-v 处理不匹配的行"
echo "5. 使用 -o 自定义输出格式"
echo ""

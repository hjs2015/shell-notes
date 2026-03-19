#!/bin/bash
# =============================================================================
# 脚本：12_awk_basics.sh
# 功能：演示 awk 文本处理
# 难度：⭐⭐⭐⭐
# 知识点：
#   - awk 基础语法
#   - 字段操作
#   - 条件过滤
#   - 内置变量
#   - 统计计算
# 使用方法：
#   ./12_awk_basics.sh
# =============================================================================

echo "=========================================="
echo "【1】awk 基础"
echo "=========================================="

echo "awk 是强大的文本分析工具"
echo "按行处理，自动分割字段"
echo ""
echo "基本语法：awk [选项] '程序' 文件"

echo ""
echo "=========================================="
echo "【2】创建测试文件"
echo "=========================================="

cat > /tmp/awk_test.txt << 'EOF'
张三 25 北京 5000
李四 30 上海 8000
王五 28 广州 6000
赵六 35 深圳 10000
钱七 22 杭州 4500
EOF

echo "测试文件内容（姓名 年龄 城市 薪资）："
cat /tmp/awk_test.txt

echo ""
echo "=========================================="
echo "【3】字段操作"
echo "=========================================="

echo "示例 1：打印第 1 列（姓名）"
echo "命令：awk '{print $1}' /tmp/awk_test.txt"
awk '{print $1}' /tmp/awk_test.txt

echo ""
echo "示例 2：打印第 1 列和第 3 列"
echo "命令：awk '{print $1, $3}' /tmp/awk_test.txt"
awk '{print $1, $3}' /tmp/awk_test.txt

echo ""
echo "示例 3：打印所有字段"
echo "命令：awk '{print $0}' /tmp/awk_test.txt"
awk '{print $0}' /tmp/awk_test.txt

echo ""
echo "=========================================="
echo "【4】内置变量"
echo "=========================================="

echo "示例 4：打印行号和内容"
echo "命令：awk '{print NR, $0}' /tmp/awk_test.txt"
awk '{print NR, $0}' /tmp/awk_test.txt

echo ""
echo "示例 5：打印字段数"
echo "命令：awk '{print NF, $0}' /tmp/awk_test.txt"
awk '{print NF, $0}' /tmp/awk_test.txt

echo ""
echo "示例 6：使用自定义分隔符"
echo "192.168.1.1" | awk -F. '{print $1, $2, $3, $4}'

echo ""
echo "=========================================="
echo "【5】条件过滤"
echo "=========================================="

echo "示例 7：年龄大于 25 的"
echo "命令：awk '$2 > 25 {print $1, $2}' /tmp/awk_test.txt"
awk '$2 > 25 {print $1, $2}' /tmp/awk_test.txt

echo ""
echo "示例 8：薪资大于 6000 的"
echo "命令：awk '$4 > 6000 {print $1, $4}' /tmp/awk_test.txt"
awk '$4 > 6000 {print $1, $4}' /tmp/awk_test.txt

echo ""
echo "示例 9：城市是北京的"
echo "命令：awk '$3 == "北京" {print $0}' /tmp/awk_test.txt"
awk '$3 == "北京" {print $0}' /tmp/awk_test.txt

echo ""
echo "示例 10：复合条件"
echo "命令：awk '$2 > 25 && $4 > 6000 {print $1}' /tmp/awk_test.txt"
awk '$2 > 25 && $4 > 6000 {print $1}' /tmp/awk_test.txt

echo ""
echo "=========================================="
echo "【6】统计计算"
echo "=========================================="

echo "示例 11：统计总人数"
echo "命令：awk 'END {print NR}' /tmp/awk_test.txt"
awk 'END {print NR}' /tmp/awk_test.txt

echo ""
echo "示例 12：计算平均薪资"
echo "命令：awk '{sum+=$4} END {print sum/NR}' /tmp/awk_test.txt"
awk '{sum+=$4} END {print sum/NR}' /tmp/awk_test.txt

echo ""
echo "示例 13：计算总薪资"
echo "命令：awk '{sum+=$4} END {print sum}' /tmp/awk_test.txt"
awk '{sum+=$4} END {print sum}' /tmp/awk_test.txt

echo ""
echo "示例 14：找出最高薪资"
echo "命令：awk 'BEGIN{max=0} {if($4>max) max=$4} END {print max}' /tmp/awk_test.txt"
awk 'BEGIN{max=0} {if($4>max) max=$4} END {print max}' /tmp/awk_test.txt

echo ""
echo "=========================================="
echo "【7】实战技巧"
echo "=========================================="

echo "技巧 1：格式化输出"
awk '{printf "%-10s %3d %6d\n", $1, $2, $4}' /tmp/awk_test.txt

echo ""
echo "技巧 2：添加表头"
echo -e "姓名 年龄 薪资\n$(awk '{printf "%s %d %d\n", $1, $2, $4}' /tmp/awk_test.txt)"

echo ""
echo "技巧 3：统计各城市人数"
awk '{city[$3]++} END {for(c in city) print c, city[c]}' /tmp/awk_test.txt

echo ""
echo "技巧 4：提取进程信息"
echo "ps aux | awk 'NR==1 || $3 > 1.0'"
ps aux | awk 'NR==1 || $3 > 1.0' | head -5

echo ""
echo "技巧 5：处理 CSV 文件"
echo "name,age,city,salary" > /tmp/test.csv
echo "张三，25，北京，5000" >> /tmp/test.csv
echo "李四，30，上海，8000" >> /tmp/test.csv
awk -F, 'NR>1 {print $1, "薪资："$4}' /tmp/test.csv

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

# 清理
rm -f /tmp/awk_test.txt /tmp/test.csv 2>/dev/null

#!/bin/bash
# =============================================================================
# 脚本名称：02_multiplication_table.sh
# 功能描述：打印 99 乘法表
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - 嵌套 for 循环
#   - echo -n 不换行输出
#   - $[i*j] 算术运算
# 使用方法：
#   chmod +x 02_multiplication_table.sh
#   ./02_multiplication_table.sh
# =============================================================================

# 外层循环：i 从 1 到 9
for i in `seq 9`
do
	# 内层循环：j 从 1 到 i
	for j in `seq $i`
	do
		# 输出乘法公式，不换行
		# -e 启用转义字符，\t 是制表符
		echo -ne "$j*$i=$[$i*j]\t"
	done
	# 每行结束后换行
	echo
done

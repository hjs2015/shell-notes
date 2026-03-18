#!/bin/bash
# =============================================================================
# 脚本名称：09_nested_loop_pattern.sh
# 功能描述：嵌套循环打印图案
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - 嵌套 for 循环
#   - echo -n 不换行输出
#   - seq 5 -1 1 倒序序列
#   - for ((i=1;i<=5;i++)) C 语言风格 for 循环
#   - if-elif-else 多分支判断
#   - -o 逻辑或
# 使用方法：
#   chmod +x 09_nested_loop_pattern.sh
#   ./09_nested_loop_pattern.sh
# =============================================================================

# 图案 1：直角三角形（数字）
# 输出：
# 1
# 12
# 123
# 1234
# 12345
for i in 1 2 3 4 5
do
	for j in `seq $i`
	do
		echo -n $j
	done
	echo  # 换行
done

echo ""

# 图案 2：直角三角形（星号）
# 输出：
# *
# **
# ***
# ****
# *****
for i in `seq 5`
do
	for j in `seq $i`
	do
		echo -n "*"
	done
	echo
done

echo ""

# 图案 3：倒直角三角形（数字）
# 输出：
# 54321
# 5432
# 543
# 54
# 5
for i in 5 4 3 2 1
do
	for j in `seq 5 -1 $i`
	do
		echo -n $j
	done
	echo
done

echo ""

# 图案 4：倒直角三角形（C 语言风格）
# 输出：
# 5
# 54
# 543
# 5432
# 54321
for i in `seq 5`
do
	for ((j=5;j>=$[6-$i];j--))
	do
		echo -n $j
	done
	echo
done

echo ""

# 图案 5：空心三角形（星号）
# 输出：
# *
# **
# * *
# *  *
# *****
for i in `seq 5`
do
	for j in `seq $i`
	do
		if [ $i -eq 5 ]; then
			# 最后一行，输出实心
			echo -n "*"
		elif [ $j -eq 1 -o $j -eq $i ]; then
			# 第一列或最后一列，输出星号
			echo -n "*"
		else
			# 中间部分，输出空格
			echo -n " "
		fi
	done
	echo
done

# 说明：
# 1. 嵌套循环：外层控制行数，内层控制每行的内容
# 2. echo -n 不换行输出，让字符在同一行显示
# 3. seq 5 -1 1 生成倒序序列：5 4 3 2 1
# 4. for ((i=1;i<=5;i++)) 是 C 语言风格的 for 循环
# 5. -o 表示逻辑或（or），只要有一个条件为真即可

# 扩展练习：
# 1. 打印等腰三角形
# 2. 打印菱形
# 3. 打印九九乘法表

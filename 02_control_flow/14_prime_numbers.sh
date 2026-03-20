#!/bin/bash
# =============================================================================
# 脚本名称：12_prime_numbers.sh
# 功能描述：求 1000 以内的所有质数（素数）
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - 嵌套 for 循环
#   - 质数的定义和判断方法
#   - break 退出内层循环
#   - elif 多条件判断
# 使用方法：
#   chmod +x 12_prime_numbers.sh
#   ./12_prime_numbers.sh
# 什么是质数？
#   质数（素数）是只能被 1 和它本身整除的大于 1 的自然数
#   例如：2, 3, 5, 7, 11, 13, 17, 19, 23...
#   1 不是质数，2 是最小的质数
# =============================================================================

# 输出 2（2 是最小的质数）
echo -n "2 "

# 从 3 遍历到 1000
for num in `seq 3 1000`
do
	# 内层循环：从 2 遍历到 num-1
	# 检查 num 是否能被这些数整除
	for i in `seq 2 $[$num-1]`
	do
		# 如果 num 能被 i 整除（余数为 0），说明不是质数
		if [ $[$num%$i] -eq 0 ]; then
			break  # 退出内层循环，检查下一个数
		
		# 如果 i 已经等于 num-1，说明前面的数都不能整除 num
		# 那么 num 就是质数
		elif [ $i -eq $[$num-1] ]; then
			echo -n "$num "  # 输出质数
		fi
	done
done

echo  # 换行

# 说明：
# 1. 质数判断方法：用 2 到 num-1 的所有数去除 num
# 2. 如果有任何一个数能整除 num，则 num 不是质数
# 3. 如果所有数都不能整除 num，则 num 是质数
# 4. 优化：其实只需要检查到 sqrt(num) 即可，不需要检查到 num-1

# 优化版本（更快）：
# for num in `seq 3 1000`; do
#     is_prime=1
#     for i in `seq 2 $(($num/2))`; do
#         if [ $[$num%$i] -eq 0 ]; then
#             is_prime=0
#             break
#         fi
#     done
#     [ $is_prime -eq 1 ] && echo -n "$num "
# done

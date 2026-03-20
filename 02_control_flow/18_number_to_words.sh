#!/bin/bash
# =============================================================================
# 脚本名称：08_number_to_words.sh
# 功能描述：数字转英文单词 - 将整数的每位数字转换为英文
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - read -p 读取用户输入
#   - wc -L 获取字符串长度
#   - seq $length 生成序列
#   - cut -c$i 提取第 i 个字符
#   - case 语句多分支
#   - echo -n 不换行输出
# 使用方法：
#   chmod +x 08_number_to_words.sh
#   ./08_number_to_words.sh
# 示例：
#   输入：123
#   输出：one two three
# =============================================================================

# 提示用户输入整数
read -p "输入一个整数:" num

# 获取数字的长度（位数）
# wc -L 返回字符串的长度（字符数）
length=`echo $num |wc -L`

# 遍历每一位数字
for i in `seq $length`
do
	# 提取第 i 位数字
	# cut -c$i 提取第 i 个字符
	n=`echo $num |cut -c$i`

	# 根据数字显示对应的英文单词
	case "$n" in 
		0 ) echo -n "zero " ;;
		1 ) echo -n "one " ;;
		2 ) echo -n "two " ;;
		3 ) echo -n "three " ;;
		4 ) echo -n "four "  ;;
		5 ) echo -n "five " ;;
		6 ) echo -n "six " ;;
		7 ) echo -n "seven " ;;
		8 ) echo -n "eight " ;;
		9 ) echo -n "nine " ;;
		* ) 
			# 不是数字，清屏并提示错误
			clear
			echo "你输入的不是一个整数"
			exit 1
	esac
done

# 显示换行
echo

# 说明：
# 1. wc -L 获取字符串长度（最大行宽）
# 2. for 循环遍历每一位数字
# 3. cut -c$i 提取第 i 个字符
# 4. case 语句将数字映射到英文单词
# 5. echo -n 不换行输出，让单词在同一行
# 6. * 匹配非数字字符，提示错误

# 示例输出：
# 输入：123
# 输出：one two three 
#
# 输入：9876
# 输出：nine eight seven six 

# 扩展练习：
# 1. 支持负数（添加负号处理）
# 2. 支持小数（添加小数点处理）
# 3. 支持大数字（千、百、十等）

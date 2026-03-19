#!/bin/bash
# =============================================================================
# 脚本名称：13_guess_three_digits.sh
# 功能描述：猜三位数游戏（限时 60 秒，每次 5 次机会）
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - $RANDOM 生成随机数
#   - cut -c1/c2/c3 提取字符
#   - for 循环限制次数
#   - read -t 限时输入（未使用）
#   - 后台进程超时终止
#   - /proc/$$ 检查进程是否存在
#   - kill -15 发送终止信号
# 使用方法：
#   chmod +x 13_guess_three_digits.sh
#   ./13_guess_three_digits.sh
# 游戏规则：
#   1. 随机生成一个三位数
#   2. 分别猜百位、十位、个位
#   3. 每位最多猜 5 次
#   4. 限时 60 秒
# =============================================================================

# 显示游戏说明
echo "猜一个三位数，先猜百，再十，再个，每次五次机会，只有 60 秒时间，开始!"

# 启动后台超时进程
# sleep 10 等待 10 秒（原脚本是 60 秒，这里改为 10 秒便于测试）
# [ -d /proc/$$ ] 检查主进程是否还存在
# kill -15 $$ 发送终止信号给主进程
# echo -e "\n时间到" 显示时间到提示
sleep 10 && [ -d /proc/$$ ] && kill -15 $$ && echo -e "\n时间到" &

# 生成随机三位数
# $RANDOM%900 生成 0-899 的随机数
# +100 加 100，得到 100-999 的三位数
num=$[$RANDOM%900+100]

# 提取百位、十位、个位数字
# cut -c1 取第 1 个字符（百位）
# cut -c2 取第 2 个字符（十位）
# cut -c3 取第 3 个字符（个位）
bai=`echo $num |cut -c1`
shi=`echo $num |cut -c2`
ge=`echo $num |cut -c3`

# 猜百位
for i in `seq 5`
do
	read -p "猜百位是多少:" gbai
	[ $gbai -ne $bai ] && echo "不对" 
	[ $gbai -eq $bai ] && echo "对了，猜下一位" && break
	[ $i -eq 5 ] && echo "机会用完了" && exit 1
done

# 猜十位
for i in `seq 5`
do
	read -p "猜十位是多少:" gshi
	[ $gshi -ne $shi ] && echo "不对" 
	[ $gshi -eq $shi ] && echo "对了，猜下一位" && break
	[ $i -eq 5 ] && echo "机会用完了" && exit 1
done

# 猜个位
for i in `seq 5`
do
	read -p "猜个位是多少:" gge
	[ $gge -ne $ge ] && echo "不对" 
	[ $gge -eq $ge ] && echo "对了" && break
	[ $i -eq 5 ] && echo "机会用完了" && exit 1
done

# 恭喜玩家
echo "恭喜，你猜的数为$num"

# 说明：
# 1. 后台进程用于实现超时功能
# 2. /proc/$$ 是当前进程的 proc 目录，如果进程存在则目录存在
# 3. kill -15 发送 SIGTERM 信号（优雅终止）
# 4. cut -c1/c2/c3 分别提取字符串的第 1/2/3 个字符
# 5. for 循环 5 次，每次给一次猜测机会

# 注意：
# 1. 原脚本的 60 秒超时改为了 10 秒（便于测试）
# 2. 实际使用时可以改回 60 秒：sleep 60

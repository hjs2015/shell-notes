#!/bin/bash
# =============================================================================
# 脚本名称：17_lucky_draw.sh
# 功能描述：幸运抽奖 - 从手机号中抽取幸运观众
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - cat file | wc -l 统计行数
#   - $RANDOM%$line+1 随机行号
#   - head -n | tail -1 提取指定行
#   - ${var:0:3} 字符串截取
#   - sed -i 编辑文件
#   - grep 查找内容
# 使用方法：
#   chmod +x 17_lucky_draw.sh
#   ./17_lucky_draw.sh
# 前提条件：需要先有 phonenum.txt 文件（可用 16_generate_phone_numbers.sh 生成）
# =============================================================================

# ==================== 第一种抽法：可重复抽取 ====================
# 抽取 5 次，每次随机选一个手机号
# 同一个手机号可能被多次抽中
for i in `seq 5`
do
	# 统计总行数
	line=`cat phonenum.txt|wc -l`
	
	# 生成随机行号（1 到 line 之间）
	luckline=$[$RANDOM%$line+1]
	
	# 提取指定行的内容
	# head -$luckline 取前 luckline 行
	# tail -1 取最后一行（即第 luckline 行）
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	
	# 显示幸运观众手机号（中间 4 位用*代替）
	# ${luckynum:0:3} 取前 3 位
	# ${luckynum:7:4} 取第 8 位开始的 4 位
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

# ==================== 第二种抽法：抽取后删除 ====================
# 抽取 5 次，每次抽中后从文件中删除
# 同一个手机号不会被重复抽中
# 注意：这个脚本有 bug，$luckline 在 sed 中不会被替换
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	# sed -i '/$luckline/d' phonenum.txt  # 这行有 bug，应该用变量替换
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

# ==================== 第三种抽法：去重抽取 ====================
# 抽取 5 次，检查是否已抽中过
# 如果已抽中，重新抽取
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	
	# 检查是否已抽中过
	grep $luckynum /tmp/luckynum.txt &> /dev/null
	if [ $? -eq 0 ]; then
		$i=$[$i-1]  # 回退计数器
		continue   # 跳过本次
	fi
	
	# 记录已抽中的号码
	echo $luckynum >> /tmp/luckynum.txt
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

# ==================== 第四种抽法：抽取后删除（修正版）====================
# 抽取 5 次，每次抽中后从文件中删除该号码
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	
	# 从文件中删除已抽中的号码
	sed -i "/$luckynum/d" phonenum.txt
	
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

# 说明：
# 1. wc -l 统计文件行数
# 2. head -n | tail -1 是提取第 n 行的经典方法
# 3. ${var:start:length} 是字符串截取
# 4. sed -i '/pattern/d' 删除匹配的行
# 5. grep 检查是否已存在

# 注意：
# 1. 第二种方法有 bug，$luckline 在单引号中不会被替换
# 2. 实际使用建议用第四种方法
# 3. 需要 phonenum.txt 文件（用 16_generate_phone_numbers.sh 生成）

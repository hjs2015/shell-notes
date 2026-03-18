#!/bin/bash

echo "猜一个三位数，先猜百，再十，再个，每次五次机会，只有60秒时间,开始!"

sleep 10 && [  -d /proc/$$ ] && kill -15 $$ && echo -e "\n时间到"  &

num=$[$RANDOM%900+100]

bai=`echo $num |cut -c1`
shi=`echo $num |cut -c2`
ge=`echo $num |cut -c3`

for i in `seq 5`
do
	read -p "猜百位是多少:" gbai
	[ $gbai -ne $bai ] && echo "不对" 
	[ $gbai -eq $bai ] && echo "对了，猜下一位" && break
	[ $i -eq 5 ] && echo "机会用完了" && exit 1
done
for i in `seq 5`
do
	read -p "猜shi位是多少:" gshi
	[ $gshi -ne $shi ] && echo "不对" 
	[ $gshi -eq $shi ] && echo "对了，猜下一位" && break
	[ $i -eq 5 ] && echo "机会用完了"  && exit 1
done
for i in `seq 5`
do
	read -p "猜个位是多少:" gge
	[ $gge -ne $ge ] && echo "不对" 
	[ $gge -eq $ge ] && echo "对了" && break
	[ $i -eq 5 ] && echo "机会用完了"  && exit 1
done

echo "恭喜，你猜的数为$num"

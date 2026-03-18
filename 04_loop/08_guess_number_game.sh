#!/bin/bash

echo "猜一个1-100的整数,猜对砸蛋:" 

num=$[$RANDOM%100+1]

while true
do
	read -p "请猜:" gnum
        if [ $gnum -gt $num ];then
		echo "大了"
	elif [ $gnum -lt $num ];then
		echo "小了"
	else	
		echo "对了"
		break
	fi
done


echo "砸蛋"

#!/bin/bash

read -p "输入一个正整数:"  num

[ $num -eq 1 ] && echo "$num不是质数"
[ $num -eq 2 ] && echo "$num是质数"


for i in `seq 2 $[$num-1]`
do
	if [ $[$num%$i] -eq 0 ];then
		echo "$num不是质数"
		break
	fi
	if [ $i -eq $[$num-1] ];then
		echo "$num是质数"
	fi
done

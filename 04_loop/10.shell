#!/bin/bash

read -p "输入一个目录:" dir

if [ ! -d $dir ];then
	echo "不是目录或不存在，重新输入"
	sh $0
	exit 1
fi

for i in `find $dir -type l`
do
	[ ! -e $i ] && echo "$i是死链接"
done 

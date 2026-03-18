#!/bin/bash

read -p "输入一个目录:" dir

if [ ! -d $dir ];then
	echo "不是目录,重试"
	sh $0
	exit 1
fi


finddeadlink() {
for i in $1/*
do
	if [ -L $i -a ! -e $i ];then
		echo "$i是死链接"
	elif [ -d $i ];then
		finddeadlink $i
	fi		 
done
}

finddeadlink $dir

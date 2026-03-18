#!/bin/bash

read -p "input a file:" file

if [ ! -e $file ];then
	echo "$file is not exist"
#	exit 1		#直接退出shell	
	sh $0		#再次执行本脚本，相当于是产生一个子进程	
	exit 1		#这里的退出是退出父进程
fi
[ -r $file ] && echo "当前用户对其可读" || echo "当前用户对其不可读"
[ -w $file ] && echo "当前用户对其可写" || echo "当前用户对其不可写"
[ -x $file ] && echo "当前用户对其执行" || echo "当前用户对其不可执行"

#!/bin/bash

while true
do
	count=0
	rdate -s 192.168.2.9 &> /dev/null
	if [ $? -ne 0 ];then
		echo "failed" | mail -s "rdate mail" root
#		count=0      #如果要求连续100次成功才发送成功信息，那么失败一次我们也计数器清0
	else
		count+=1
		if [ count -eq 100 ];then
		 	echo "success" | mail -s "rdate mail" root
			count=0
		fi
	fi	
	 
	sleep 30
done

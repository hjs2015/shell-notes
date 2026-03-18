#!/bin/bash


read -p "input a ip:" ip

ping -c 1 $ip &> /dev/null

if [ $? -ne 0 ];then
	echo "$ip is not ok"
else
	echo "$ip is ok"
fi

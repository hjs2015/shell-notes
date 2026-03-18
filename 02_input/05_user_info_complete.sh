#!/bin/bash

read -p "input your name:" name

while true
do
	echo "1-男"
	echo "2-女"
	read -p "input your sex(1 or 2):" sex
	if [ $sex -ne 1 -a  $sex -ne 2 ];then
		echo "性别选择有误!,重试"
		continue
	else
		break
	fi
done

read -n 2 -p "input your age:" age
echo

echo $age |grep [^0-9] &> /dev/null

if [ $? -eq 0 ];then
	echo "年龄不是纯数字,重试"
	exit 2
fi

if [ $sex -eq 1 -a $age -lt 18 ];then
	echo "$name boy"
elif [ $sex -eq 1 -a $age -ge 18 ];then
	echo "$name man"
elif [ $sex -eq 2 -a $age -lt 18 ];then
	echo "$name girl"
else
	echo "$name woman"
fi	


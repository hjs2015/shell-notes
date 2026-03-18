#!/bin/bash

#read  -p "输入你的密码:" password
#
#length=`echo $password |wc -L`
#echo $password |grep ^[0-9] &> /dev/null
#
#if [ $? -eq 0 ];then
#	echo "密码不能以数字开头"
#	exit 1
#fi
#if [ $length -lt 8 ];then
#	echo "密码长度不够"
#	exit 2
#fi 
#echo $password |grep [^a-Z] &> /dev/null
#if [ $? -ne 0 ];then
#	echo "密码是纯字母,不符合"
#	exit 3
#fi



#read -s -p "请输入你要设置的密码： " passwd

#a=`echo $passwd |wc -L`
#b=`echo $passwd |grep '^[0-9]'`
#echo 

#if [ $a -lt 8 ];then
#        echo "密码太短，不安全。"
#elif [ -z $b ];then
#        echo "设置成功。"
#else
#        echo "密码开头不能为数字"
#fi


#!/bin/sh
read  -p "please input the password:" password
echo
if [ `expr length "$password"` -lt 8 ];then
	echo "it can not less then 8"
	exit 1
elif [[ $password =~ ^[0-9] ]];then
	echo "the password can not begin with a number"
	exit 2
elif [[ $password =~ ^[a-zA-Z]*$ ]];then
	echo "the password are all chr,it is illegal"
fi


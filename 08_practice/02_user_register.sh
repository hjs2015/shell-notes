#!/bin/bash

echo "用户注册@_@"
read -p "用户名:" name

grep ^$name: register_user.txt &>/dev/null

if [ $? -eq 0 ];then
	echo "此用户已经被注册，重试"
	sh $0
	exit 1
fi

getchar() {
stty cbreak -echo
dd if=/dev/tty bs=1 count=1 2> /dev/null
stty -cbreak echo
}

echo -n "请输入你的密码:"

while true
do
        char=`getchar`
        if [ -z $char ]; then
                echo
                break
        fi
        password1="$password1$char"
        echo -n "*"
done

if [ `expr length "$password1"` -lt 8 ];then
       echo "密码长度需要至少8位"
       exit 2
elif [[ $password1 =~ ^[0-9] ]];then
       echo "密码不能以数字开头"
       exit 3
elif [[ $password1 =~ ^[a-zA-Z]*$ ]];then
       echo "密码不能为纯字母"
       exit 4	
fi

echo -n "请再次输入你的密码:"

while true
do
        char=`getchar`
        if [ -z $char ]; then
                echo
                break
        fi
        password2="$password2$char"
        echo -n "*"
done


echo
if [ $password1 != $password2 ];then
	echo "两次密码输入不一致"
	exit 5
fi

echo $name:$password1 >> register_user.txt 
echo "注册成功!"

#!/bin/bash

echo "用户登录@_@"

read -p "用户名:" name

grep ^$name: register_user.txt &>/dev/null

if [ $? -eq 1 ];then
        echo "此用户还未注册，重试"
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
        password2="$password2$char"
        echo -n "*"
done



password1=`grep ^$name: register_user.txt |cut -d":" -f2`

if [ $password1 != $password2 ];then
        echo "密码输入错误"
        exit 2
fi

num1=$[$RANDOM%10]$[$RANDOM%10]$[$RANDOM%10]$[$RANDOM%10]
echo "验证码为:" $num1
read -t 10 -p "请10秒内输入验证码:" num2
	
if [ $num1 -eq $num2 ];then
		echo "登录成功"
else
		echo "验证码有误"
fi


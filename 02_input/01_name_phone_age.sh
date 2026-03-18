#!/bin/bash

read -p "输入你的名字:" name

echo "你好,$name"

#getchar() {
#stty cbreak -echo
#dd if=/dev/tty bs=1 count=1 2> /dev/null
#stty -cbreak echo
#}


#echo -n "请输入你的手机号:"

#while true
#do
#        char=`getchar`
#        if [ -z $char ]; then
#                echo
#                break
#        fi
#        num="$num$char"
#        echo -n "*"
#done


read -s -p "输入你的手机号:" num
echo
echo "你的手机号尾数为${num:7:4}" 


read -n 2 -p "输入你的年龄:" age
echo
echo "你$age岁了"


read -t 3 -p "214＋234＋46-12=?" result
echo
echo "@_@"





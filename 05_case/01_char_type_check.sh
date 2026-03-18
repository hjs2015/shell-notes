#!/bin/bash

read -n 1 -p "input a char:" char
echo

#case "$char" in
#	[[:upper:]] )
#		echo "大写字母"
#		;;
#	[[:lower:]] )
#		echo "小写字母"
#		;;
#	[0-9] )
#		echo "数字"
#		;;
#	* )
#		echo "其它"
#esac


if [[ $char =~ [A-Z] ]];then
	echo "大写字母"
elif [[ $char =~ [a-z] ]];then
	echo "小写字母"
elif [[ $char =~ [0-9] ]];then
	echo "数字"
else
	echo "其它"
fi

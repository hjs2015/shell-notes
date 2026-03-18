#!/bin/bash

read -p "input a file:" file

#ls $file &> /dev/null
#if [ $? -eq 0 ];then
if [ -e $file ];then
	echo "$file exist"
else
	echo "$file not exist"
fi

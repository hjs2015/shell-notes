#!/bin/bash

#方法一
#read -p "input a file:" file
#
#if [ -L $file -a ! -e $file ];then
#	echo "$file is a dead link"
#else
#	echo "$file is not a dead link"
#
#fi

#方法二:

read -p "input a file:" file

if [ ! -L $file ];then
	echo "$file is not a link file"
	sh $0
	exit 1
fi 

sourcefile=$(readlink -f $file)

if [ ! -e $sourcefile ];then
	echo "$file is a dead link"
else
	echo "$file is not a dead link"
fi

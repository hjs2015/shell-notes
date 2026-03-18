#!/bin/bash

read -p "input a file:" file

if [ ! -e $file ];then
	echo "$file is not exist" 
	exit 88
elif [ -L $file ];then
	echo "$file is a symblic link file"	
elif [ -d $file ];then
	echo "$file is a directory"	
elif [ -S $file ];then
	echo "$file is a socket file"	
elif [ -p $file ];then
	echo "$file is a pipe file"	
elif [ -c $file ];then
	echo "$file is a character file"	
elif [ -b $file ];then
	echo "$file is a block file"	
else
	echo "$file is a regular file"	
fi

#!/bin/bash

groupadd class
for (( i=1;i<11;i++ ))
do
	useradd -G class student$i
#	echo 123 | passwd --stdin student$i &> /dev/null
	passwd student$i <<EOF &> /dev/null
123
123
EOF
done

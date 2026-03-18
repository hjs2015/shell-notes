#!/bin/bash

echo -n "2 "

for num in `seq 3 1000`
do
	for i in `seq 2 $[$num-1]`
	do
		if [ $[$num%$i] -eq 0 ];then
			break
		elif [ $i -eq $[$num-1] ];then
			echo -n "$num "
		fi
	done
done


#read -p "input your number:" num

#for (( i=1;i<=$num;i++  ))
#do
#        for (( b=1;b<=$i;b++ ))
#        do
#                if [ $[$i%$b] -eq 0 ];then
#                        let c++;
#                fi
#        done
#        [ $c -eq 2 ] && echo -n -e "$i "
#        c=0
#               echo $c
#done
#echo 


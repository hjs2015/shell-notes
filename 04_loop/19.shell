#!/bin/bash

#第一种抽法
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

#第二种抽法
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	sed -i '/$luckline/d' phonenum.txt 
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

#第三种抽法
for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	grep $luckynum /tmp/luckynum.txt &> /dev/null
	if [ $? -eq 0 ];then
		$i=$[$i-1]
		continue
	fi
	echo $luckynum >> /tmp/luckynum.txt
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

for i in `seq 5`
do
	line=`cat phonenum.txt|wc -l`
	luckline=$[$RANDOM%$line+1]
	luckynum=`cat phonenum.txt |head -$luckline |tail -1`
	sed -i '/$luckynum/d' phonenum.txt
	echo "幸运观众手机号为${luckynum:0:3}****${luckynum:7:4}"
done

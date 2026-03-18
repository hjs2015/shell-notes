#!/bin/bash

for i in 1 2 3 4 5
do
	for j in `seq $i`
	do
		echo -n $j
	done
	echo
done



for i in `seq 5`
do
	for j in `seq $i`
	do
		echo -n "*"
	done
	echo
done


for i in 5 4 3 2 1
do
	for j in `seq 5 -1 $i`
	do
		echo -n $j
	done
	echo
done

for i in `seq 5`
do
        for ((j=5;j>=$[6-$i];j--))
        do
                echo -n $j
        done
        echo
done


for i in `seq 5`
do
	for j in `seq $i`
	do
		if [ $i -eq 5 ];then
			echo -n "*"
		elif [ $j -eq 1 -o $j -eq $i ];then
			echo -n "*"
		else
			echo -n " "
		fi
	done
	echo
done


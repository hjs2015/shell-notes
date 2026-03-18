#!/bin/bash

#for i in 1 2 3 4 5
#for ((i=1;i<=5;i++))
#for i in `seq 5`
for i in {1..5}
do
	echo -n $i
done
echo


#for ((i=1;i<=100;i+=2))
#for i in `seq 1 2 100`
for i in {1..100..2}
do
	echo -n $i
done
echo

for i in /etc/*
do
	echo $i
done

for i in `find /etc/ -type f`
do
	echo $i
done


find /etc/ -type f | while read i
do
	echo $i
done

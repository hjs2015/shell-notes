#!/bin/bash

sum=0
for i in `seq 1 2 100`
do
	sum=$[$sum+$i]
done
echo $sum

sum=0
for i in `seq 100`
do
	[ $[$i%2] -eq 1 ]  && sum=$[$sum+$i]
done
echo $sum

sum=0
for i in `seq 100`
do
	[ $[$i%2] -eq 0 ] && continue
	 sum=$[$sum+$i]
done
echo $sum

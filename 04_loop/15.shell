#!/bin/bash

rm /tmp/conf -rf
mkdir /tmp/conf -p

#下在这条命令执行后，拷过去的文件数比find查找的文件数要少一些，就是因为有相同的文件名的文件.
find /etc/ -name "*.conf" -exec cp {} /tmp/conf \;
cd /tmp/conf
rename .conf .html *

#下面的方法换成awk截取也可以
#for i in `find /etc/ -name "*.conf"`
#do
#        a=${i##*/}
#        b=${a%.*}
#        cp $i /tmp/conf/$b.html 
#done


#for i in `find /etc/ -name "*.conf"|awk -F/ '{print $NF}' |awk -F".conf" '{print $1}'`
#do
#        cp $i /tmp/conf/$b.html 
#done

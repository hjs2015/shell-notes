#!/bin/bash

goal=`date +%s -d 20180101`

while true
do
        now=`date +%s`
	if [ $[$goal-$now] -eq 0 ];then
		break
	fi
        day=$[($goal-$now)/86400]
        hour=$[($goal-$now)%86400/3600]
        minute=$[($goal-$now)%3600/60]
        second=$[($goal-$now)%60]
	clear
        echo "离2018年还有$day天:$hour时:$minute分:$second秒"
        sleep 1
done

echo "2018年元旦快乐!!!"

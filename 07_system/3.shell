#!/bin/bash

year=`date -d "-1 days" +%Y`
month=`date -d "-1 days" +%m`
day=`date -d "-1 days" +%d`


mkdir /backup/$year/$month/ -p

mv /var/log/aaa.log /backup/$year/$month/$year-$month-$day.aaa.log
touch /var/log/aaa.log
kill -HUP `cat /var/run/xxx.pid`
echo "succeed" | mail -s "$year-$month-$day log rotated"  user1
logger -t "日志轮转" "成功了@-@"

#!/bin/bash
# =============================================================================
# 脚本名称：01_log_rotation.sh
# 功能描述：日志轮转脚本 - 每天备份前一天的日志
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - date -d "-1 days" 计算昨天的日期
#   - date +%Y/%m/%d 格式化日期
#   - mkdir -p 递归创建目录
#   - mv 移动文件
#   - touch 创建空文件
#   - kill -HUP 发送挂起信号（重启服务）
#   - mail 发送邮件
#   - logger 记录系统日志
# 使用方法：
#   chmod +x 01_log_rotation.sh
#   ./01_log_rotation.sh
# 应用场景：
#   每天凌晨执行，将前一天的日志归档到备份目录
#   防止日志文件无限增长占满磁盘
# =============================================================================

# 获取昨天的日期
# date -d "-1 days" 表示昨天的日期
# +%Y 四位年份，+%m 两位月份，+%d 两位日期
year=`date -d "-1 days" +%Y`
month=`date -d "-1 days" +%m`
day=`date -d "-1 days" +%d`

# 创建备份目录（按年月分级）
# -p 参数表示如果父目录不存在也一并创建
mkdir /backup/$year/$month/ -p

# 移动日志文件到备份目录
# 将当前日志文件移动到按日期命名的备份文件
mv /var/log/aaa.log /backup/$year/$month/$year-$month-$day.aaa.log

# 创建新的空日志文件
# 这样服务可以继续写入新的日志
touch /var/log/aaa.log

# 通知服务重新打开日志文件
# kill -HUP 发送挂起信号，让服务重新读取配置和日志文件
# `cat /var/run/xxx.pid` 读取服务的进程 ID
kill -HUP `cat /var/run/xxx.pid`

# 发送成功通知邮件
# echo "内容" | mail -s "主题" 收件人
echo "succeed" | mail -s "$year-$month-$day log rotated"  user1

# 记录到系统日志
# logger -t "标签" "消息"
# 可以通过 journalctl 或 /var/log/syslog 查看
logger -t "日志轮转" "成功了@-@"

# 说明：
# 1. 日志轮转（log rotation）是系统管理的常见任务
# 2. 目的是防止日志文件无限增长
# 3. 通常会配合 cron 定时任务每天执行
# 4. 实际生产中可以使用 logrotate 工具（更专业）
# 5. 注意：需要替换 /var/log/aaa.log 为实际的日志文件路径

# 扩展：使用 cron 每天凌晨 2 点执行
# 0 2 * * * /path/to/01_log_rotation.sh

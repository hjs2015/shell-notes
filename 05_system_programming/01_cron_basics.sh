#!/bin/bash
# =============================================================================
# 脚本名称：01_cron_basics.sh
# 功能描述：定时任务管理 - crontab 配置与使用
# 难度等级：⭐⭐⭐ 中级
# 所属阶段：阶段 6 - 系统编程
# 知识点：
#   - crontab -l 查看任务
#   - crontab -e 编辑任务
#   - crontab 格式说明
# =============================================================================

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
print_color() { echo -e "${!1}${2}${NC}"; }
print_separator() { echo "========================================"; }

print_separator
print_color CYAN "定时任务管理演示"
print_separator

print_color YELLOW "\n【示例 1】查看当前 crontab 任务"
echo "命令：crontab -l"
crontab -l 2>&1 || echo "当前用户没有 crontab 任务"

print_color YELLOW "\n【示例 2】查看系统级定时任务"
echo "命令：ls -la /etc/cron.d/ 2>/dev/null | head -10"
ls -la /etc/cron.d/ 2>/dev/null | head -10

print_color YELLOW "\n【示例 3】查看每日任务"
echo "命令：ls -la /etc/cron.daily/ 2>/dev/null"
ls -la /etc/cron.daily/ 2>/dev/null

print_color YELLOW "\n【示例 4】crontab 格式说明"
cat << 'EOF'
crontab 格式：
* * * * * command
│ │ │ │ │
│ │ │ │ └─ 星期 (0-7，0 和 7 都代表周日)
│ │ │ └─── 月份 (1-12)
│ │ └───── 日期 (1-31)
│ └─────── 小时 (0-23)
└───────── 分钟 (0-59)

常用示例：
*/5 * * * *     每 5 分钟执行
0 * * * *       每小时整点执行
0 0 * * *       每天午夜执行
0 0 * * 0       每周日凌晨执行
0 0 1 * *       每月 1 日执行
EOF

print_color YELLOW "\n【示例 5】创建测试 crontab 任务（演示用）"
cat << 'EOF'
# 备份示例（不实际添加）
# 0 2 * * * /path/to/backup.sh

# 日志清理示例
# 0 3 * * * find /var/log -name '*.log' -mtime +30 -delete

# 监控示例
# */10 * * * * /path/to/monitor.sh
EOF

print_color YELLOW "\n【示例 6】crontab 环境变量说明"
cat << 'EOF'
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=admin@example.com
EOF

print_color GREEN "\n演示完成！"
print_separator

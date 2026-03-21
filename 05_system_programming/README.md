# 📚 阶段 6：系统编程 (System Programming)

> **学习第 43-58 天** | 难度：⭐⭐⭐⭐ | **43 个脚本** | 预计 25-30 小时

---

## 📋 目录

- [简介](#简介)
- [脚本清单](#脚本清单)
  - [Shell 基础（01-07）](#shell-基础 01-07)
  - [变量和 Shell（08-13）](#变量和 shell08-13)
  - [作业控制（14-18）](#作业控制 14-18)
  - [信号处理（19-24）](#信号处理 19-24)
  - [进程管理（25-30）](#进程管理 25-30)
  - [高级主题（31-43）](#高级主题 31-43)
- [16 天学习计划](#16-天学习计划)
- [核心知识点详解](#核心知识点详解)
  - [进程和作业控制](#进程和作业控制)
  - [信号处理](#信号处理)
  - [文件系统](#文件系统)
  - [网络操作](#网络操作)
  - [Cron 定时任务](#cron-定时任务)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 简介

掌握 Linux 系统编程核心技能，包括进程管理、信号处理、文件系统、网络操作等。

**学完你能做什么**：
- ✅ 编写系统管理脚本
- ✅ 控制进程和后台作业
- ✅ 处理信号和异常
- ✅ 管理文件和权限
- ✅ 配置定时任务
- ✅ 编写网络脚本

**预计时间**：16 天，每天 1-2 小时

---

## 📁 脚本清单

### Shell 基础（01-07）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [01_cron_basics.sh](01_cron_basics.sh) | Cron 基础 | ⭐⭐⭐ | 20 分钟 | 定时任务 |
| [02_filesystem_basics.sh](02_filesystem_basics.sh) | 文件系统基础 | ⭐⭐⭐ | 25 分钟 | 文件操作 |
| [03_log_rotation.sh](03_log_rotation.sh) | 日志轮转 | ⭐⭐⭐⭐ | 30 分钟 | 日志管理 |
| [04_network_basics.sh](04_network_basics.sh) | 网络基础 | ⭐⭐⭐ | 20 分钟 | 网络命令 |
| [05_process_list.sh](05_process_list.sh) | 进程列表 | ⭐⭐ | 15 分钟 | ps 命令 |
| [06_return_code_and_logic.sh](06_return_code_and_logic.sh) | 返回值和逻辑 | ⭐⭐⭐ | 20 分钟 | 退出码 |
| [07_user_management.sh](07_user_management.sh) | 用户管理 | ⭐⭐⭐ | 25 分钟 | 用户操作 |

### 变量和 Shell（08-13）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [08_boolean_and_special_vars.sh](08_boolean_and_special_vars.sh) | 布尔和特殊变量 | ⭐⭐⭐ | 20 分钟 | 特殊变量 |
| [09_filesystem_advanced.sh](09_filesystem_advanced.sh) | 文件系统高级 | ⭐⭐⭐⭐ | 30 分钟 | 高级操作 |
| [10_network_advanced.sh](10_network_advanced.sh) | 网络高级 | ⭐⭐⭐⭐ | 30 分钟 | 网络编程 |
| [11_process_monitor.sh](11_process_monitor.sh) | 进程监控 | ⭐⭐⭐⭐ | 30 分钟 | 监控进程 |
| [12_user_permission_advanced.sh](12_user_permission_advanced.sh) | 权限高级 | ⭐⭐⭐⭐ | 30 分钟 | 权限管理 |
| [13_redirection_and_pipe.sh](13_redirection_and_pipe.sh) | 重定向和管道 | ⭐⭐⭐ | 25 分钟 | 输入输出 |

### 作业控制（14-18）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [14_bg_fg.sh](14_bg_fg.sh) | 前后台切换 | ⭐⭐⭐ | 20 分钟 | bg/fg |
| [15_parallel_exec.sh](15_parallel_exec.sh) | 并行执行 | ⭐⭐⭐⭐ | 30 分钟 | 并发执行 |
| [16_quick_cmd.sh](16_quick_cmd.sh) | 快速命令 | ⭐⭐ | 15 分钟 | 快捷键 |
| [17_shell_variables.sh](17_shell_variables.sh) | Shell 变量 | ⭐⭐⭐ | 20 分钟 | 环境变量 |
| [18_signal_list.sh](18_signal_list.sh) | 信号列表 | ⭐⭐ | 15 分钟 | 信号类型 |

### 信号处理（19-24）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [19_alias_func.sh](19_alias_func.sh) | 别名和函数 | ⭐⭐ | 15 分钟 | alias/function |
| [20_jobs_list.sh](20_jobs_list.sh) | 作业列表 | ⭐⭐ | 15 分钟 | jobs 命令 |
| [21_shell_options.sh](21_shell_options.sh) | Shell 选项 | ⭐⭐⭐ | 20 分钟 | set 选项 |
| [22_signal_catch.sh](22_signal_catch.sh) | 信号捕获 | ⭐⭐⭐⭐ | 30 分钟 | trap 命令 |
| [23_wait_all.sh](23_wait_all.sh) | 等待所有 | ⭐⭐⭐ | 25 分钟 | wait 命令 |
| [24_concurrency_control.sh](24_concurrency_control.sh) | 并发控制 | ⭐⭐⭐⭐ | 30 分钟 | 限流并发 |

### 进程管理（25-30）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [25_disown.sh](25_disown.sh) | disown 用法 | ⭐⭐⭐ | 20 分钟 | disown |
| [26_history.sh](26_history.sh) | 命令历史 | ⭐⭐ | 15 分钟 | history |
| [27_mutex_lock.sh](27_mutex_lock.sh) | 互斥锁 | ⭐⭐⭐⭐ | 30 分钟 | 文件锁 |
| [28_shell_builtins.sh](28_shell_builtins.sh) | Shell 内建 | ⭐⭐⭐ | 20 分钟 | 内建命令 |
| [29_signal_ignore.sh](29_signal_ignore.sh) | 忽略信号 | ⭐⭐⭐⭐ | 25 分钟 | 忽略信号 |
| [30_globbing.sh](30_globbing.sh) | 通配符展开 | ⭐⭐⭐ | 20 分钟 | 通配符 |

### 高级主题（31-43）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [31_noohup.sh](31_noohup.sh) | nohup 用法 | ⭐⭐⭐ | 20 分钟 | nohup |
| [32_semaphore.sh](32_semaphore.sh) | 信号量 | ⭐⭐⭐⭐ | 30 分钟 | 并发控制 |
| [33_shell_env.sh](33_shell_env.sh) | Shell 环境 | ⭐⭐⭐ | 20 分钟 | 环境配置 |
| [34_signal_custom.sh](34_signal_custom.sh) | 自定义信号 | ⭐⭐⭐⭐ | 30 分钟 | 自定义处理 |
| [35_brace_expand.sh](35_brace_expand.sh) | 大括号展开 | ⭐⭐⭐ | 20 分钟 | 大括号 |
| [36_pid_management.sh](36_pid_management.sh) | PID 管理 | ⭐⭐⭐⭐ | 30 分钟 | 进程 ID |
| [37_producer_consumer.sh](37_producer_consumer.sh) | 生产者消费者 | ⭐⭐⭐⭐⭐ | 35 分钟 | 并发模式 |
| [38_shell_initialization.sh](38_shell_initialization.sh) | Shell 初始化 | ⭐⭐⭐ | 25 分钟 | 启动文件 |
| [39_shell_profile.sh](39_shell_profile.sh) | Shell 配置 | ⭐⭐⭐ | 25 分钟 | 配置文件 |
| [40_signal_cleanup.sh](40_signal_cleanup.sh) | 信号清理 | ⭐⭐⭐⭐ | 30 分钟 | 清理资源 |
| [41_command_history.sh](41_command_history.sh) | 命令历史 | ⭐⭐ | 15 分钟 | 历史管理 |
| [42_alias_function.sh](42_alias_function.sh) | 别名函数 | ⭐⭐ | 15 分钟 | 别名技巧 |
| [43_job_control.sh](43_job_control.sh) | 作业控制 | ⭐⭐⭐ | 25 分钟 | 作业管理 |

---

## 📅 16 天学习计划

### 第 43-44 天：Shell 基础（7 个脚本，3 小时）

**学习内容**：
- 01_cron_basics.sh - Cron 基础
- 02_filesystem_basics.sh - 文件系统基础
- 03_log_rotation.sh - 日志轮转
- 04_network_basics.sh - 网络基础
- 05_process_list.sh - 进程列表
- 06_return_code_and_logic.sh - 返回值和逻辑
- 07_user_management.sh - 用户管理

**目标**：掌握系统管理基础

---

### 第 45-46 天：变量和 Shell（6 个脚本，3 小时）

**学习内容**：
- 08_boolean_and_special_vars.sh - 布尔和特殊变量
- 09_filesystem_advanced.sh - 文件系统高级
- 10_network_advanced.sh - 网络高级
- 11_process_monitor.sh - 进程监控
- 12_user_permission_advanced.sh - 权限高级
- 13_redirection_and_pipe.sh - 重定向和管道

**目标**：深入理解 Shell 机制

---

### 第 47-48 天：作业控制（5 个脚本，2.5 小时）

**学习内容**：
- 14_bg_fg.sh - 前后台切换
- 15_parallel_exec.sh - 并行执行
- 16_quick_cmd.sh - 快速命令
- 17_shell_variables.sh - Shell 变量
- 18_signal_list.sh - 信号列表

**目标**：掌握作业控制

---

### 第 49-51 天：信号处理（6 个脚本，3.5 小时）

**学习内容**：
- 19_alias_func.sh - 别名和函数
- 20_jobs_list.sh - 作业列表
- 21_shell_options.sh - Shell 选项
- 22_signal_catch.sh - 信号捕获
- 23_wait_all.sh - 等待所有
- 24_concurrency_control.sh - 并发控制

**目标**：学会信号处理

---

### 第 52-54 天：进程管理（6 个脚本，3.5 小时）

**学习内容**：
- 25_disown.sh - disown 用法
- 26_history.sh - 命令历史
- 27_mutex_lock.sh - 互斥锁
- 28_shell_builtins.sh - Shell 内建
- 29_signal_ignore.sh - 忽略信号
- 30_globbing.sh - 通配符展开

**目标**：掌握进程管理

---

### 第 55-58 天：高级主题（13 个脚本，5 小时）

**学习内容**：
- 31_noohup.sh - nohup 用法
- 32_semaphore.sh - 信号量
- 33_shell_env.sh - Shell 环境
- 34_signal_custom.sh - 自定义信号
- 35_brace_expand.sh - 大括号展开
- 36_pid_management.sh - PID 管理
- 37_producer_consumer.sh - 生产者消费者
- 38_shell_initialization.sh - Shell 初始化
- 39_shell_profile.sh - Shell 配置
- 40_signal_cleanup.sh - 信号清理
- 41_command_history.sh - 命令历史
- 42_alias_function.sh - 别名函数
- 43_job_control.sh - 作业控制

**目标**：掌握高级系统编程

---

## 🔍 核心知识点详解

### 进程和作业控制

**进程查看**：
```bash
#!/bin/bash
# 查看进程
ps aux                     # 所有进程
ps -ef                     # 完整格式
ps -u $USER                # 当前用户进程
ps aux | grep nginx        # 查找特定进程

# 动态查看
top                        # 实时进程
htop                       # 增强版 top（需安装）
```

**作业控制**：
```bash
#!/bin/bash
# 后台运行
long_command &             # 后台执行
jobs                       # 查看作业列表
jobs -l                    # 显示 PID

# 前后台切换
Ctrl+Z                     # 挂起当前作业
bg                         # 后台继续
fg                         # 前台运行
fg %1                      # 切换到作业 1

# 脱离终端
nohup command &            # 退出终端继续运行
disown %1                  # 从作业列表移除
```

**进程管理**：
```bash
#!/bin/bash
# 终止进程
kill PID                   # 发送 SIGTERM
kill -9 PID                # 强制终止（SIGKILL）
killall process_name       # 按名称终止
pkill pattern              # 按模式终止

# 等待进程
sleep 5                    # 等待 5 秒
wait                       # 等待所有后台作业
wait PID                   # 等待特定进程
```

---

### 信号处理

**信号类型**：
```bash
#!/bin/bash
# 查看信号列表
kill -l

# 常用信号
# 1  SIGHUP   挂起
# 2  SIGINT   中断（Ctrl+C）
# 9  SIGKILL  强制终止
# 15 SIGTERM  终止（默认）
# 18 SIGCONT  继续
# 19 SIGSTOP  停止
```

**捕获信号**：
```bash
#!/bin/bash
# trap 捕获信号
trap 'echo "收到中断信号"; exit 1' INT
trap 'echo "收到终止信号"; exit 1' TERM
trap 'echo "收到挂起信号"; exit 1' HUP

# 清理资源
cleanup() {
    echo "清理临时文件..."
    rm -f /tmp/temp_*
    exit 0
}
trap cleanup EXIT INT TERM

# 忽略信号
trap '' INT                  # 忽略 Ctrl+C
```

**实战应用**：
```bash
#!/bin/bash
# 优雅退出脚本
running=true

cleanup() {
    echo "正在关闭..."
    running=false
    # 清理资源
    rm -f /var/run/myscript.pid
    exit 0
}

trap cleanup SIGINT SIGTERM

echo $$ > /var/run/myscript.pid

while $running; do
    echo "运行中..."
    sleep 5
done
```

---

### 文件系统

**文件操作**：
```bash
#!/bin/bash
# 文件测试
[ -f file ]                  # 普通文件
[ -d dir ]                   # 目录
[ -L link ]                  # 符号链接
[ -r file ]                  # 可读
[ -w file ]                  # 可写
[ -x file ]                  # 可执行
[ -s file ]                  # 非空
[ -e path ]                  # 存在

# 文件查找
find /path -name "*.txt"     # 按名称
find /path -mtime -7         # 7 天内修改
find /path -size +100M       # 大于 100M
find /path -perm 755         # 权限 755
```

**权限管理**：
```bash
#!/bin/bash
# 修改权限
chmod 755 file               # rwxr-xr-x
chmod +x file                # 添加执行权限
chmod -R 755 dir             # 递归修改

# 修改所有者
chown user:group file
chown -R user:group dir

# 特殊权限
chmod u+s file               # SetUID
chmod g+s dir                # SetGID
chmod +t dir                 # Sticky bit
```

**日志轮转**：
```bash
#!/bin/bash
# 简单日志轮转
LOG_FILE="/var/log/app.log"
MAX_SIZE=10485760  # 10MB

if [ $(stat -c%s "$LOG_FILE") -gt $MAX_SIZE ]; then
    mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d)"
    touch "$LOG_FILE"
    # 删除 7 天前的日志
    find /var/log -name "app.log.*" -mtime +7 -delete
fi
```

---

### 网络操作

**网络命令**：
```bash
#!/bin/bash
# 网络检测
ping -c 4 google.com         # Ping 测试
curl -I https://example.com  # HTTP 头
wget url                     # 下载文件
netstat -tuln                # 监听端口
ss -tuln                     # 替代 netstat

# DNS 查询
nslookup domain.com
dig domain.com
host domain.com
```

**端口检查**：
```bash
#!/bin/bash
# 检查端口是否开放
check_port() {
    local host=$1
    local port=$2
    
    if timeout 2 bash -c "cat < /dev/null > /dev/tcp/$host/$port" 2>/dev/null; then
        echo "$host:$port 开放"
        return 0
    else
        echo "$host:$port 关闭"
        return 1
    fi
}

check_port "localhost" 80
```

**网络监控**：
```bash
#!/bin/bash
# 监控网站可用性
URL="https://example.com"
LOG="/var/log/monitor.log"

while true; do
    if curl -sf "$URL" > /dev/null; then
        echo "$(date): OK" >> "$LOG"
    else
        echo "$(date): FAIL" >> "$LOG"
        # 发送告警
        # mail -s "网站宕机" admin@example.com < "$LOG"
    fi
    sleep 60
done
```

---

### Cron 定时任务

**Cron 格式**：
```bash
# ┌───── 分钟 (0-59)
# │ ┌───── 小时 (0-23)
# │ │ ┌───── 日期 (1-31)
# │ │ │ ┌───── 月份 (1-12)
# │ │ │ │ ┌───── 星期 (0-7，0 和 7 都是周日)
# │ │ │ │ │
# * * * * * 命令
```

**常见配置**：
```bash
# 每分钟
* * * * * /path/to/script.sh

# 每天凌晨 2 点
0 2 * * * /path/to/script.sh

# 每周一上午 9 点
0 9 * * 1 /path/to/script.sh

# 每月 1 号
0 0 1 * * /path/to/script.sh

# 每 15 分钟
*/15 * * * * /path/to/script.sh

# 工作日每天 9 点
0 9 * * 1-5 /path/to/script.sh
```

**Cron 管理**：
```bash
#!/bin/bash
# 编辑 crontab
crontab -e

# 查看 crontab
crontab -l

# 删除 crontab
crontab -r

# 从文件加载
crontab /path/to/cronfile
```

**实战应用**：
```bash
#!/bin/bash
# /etc/cron.daily/backup
# 每天备份数据库

BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d)

mysqldump -u root -p'password' --all-databases > "$BACKUP_DIR/all-$DATE.sql"

# 删除 30 天前的备份
find "$BACKUP_DIR" -name "*.sql" -mtime +30 -delete
```

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. Cron 环境变量问题

**错误**：
```bash
# crontab 中
0 2 * * * /path/to/script.sh  # ❌ 可能找不到命令
```

**正确**：
```bash
# crontab 中
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 2 * * * /path/to/script.sh  # ✅ 或使用绝对路径
```

---

### 2. 后台进程被终端杀死

**错误**：
```bash
./long_task.sh &  # ❌ 关闭终端后进程会被杀死
```

**正确**：
```bash
nohup ./long_task.sh &  # ✅ 忽略挂起信号
# 或
screen -S task
./long_task.sh
Ctrl+A D  # 分离会话
```

---

### 3. trap 未清理资源

**错误**：
```bash
#!/bin/bash
trap 'exit 1' INT  # ❌ 未清理临时文件
# ... 代码 ...
```

**正确**：
```bash
#!/bin/bash
cleanup() {
    rm -f /tmp/temp_*
    exit 1
}
trap cleanup INT TERM  # ✅ 清理后退出
```

---

### 4. kill 错进程

**错误**：
```bash
kill $(ps aux | grep process | awk '{print $2}')  # ❌ 可能杀死 grep 自己
```

**正确**：
```bash
pkill -f process_name  # ✅ 按名称杀死
# 或
pgrep process_name | xargs kill  # ✅ 先查找再杀死
```

---

### 5. 文件锁未释放

**错误**：
```bash
#!/bin/bash
LOCK_FILE="/tmp/script.lock"
if [ -f "$LOCK_FILE" ]; then  # ❌ 脚本崩溃后锁文件残留
    echo "已在运行"
    exit 1
fi
touch "$LOCK_FILE"
```

**正确**：
```bash
#!/bin/bash
LOCK_FILE="/tmp/script.lock"
cleanup() {
    rm -f "$LOCK_FILE"
}
trap cleanup EXIT

if [ -f "$LOCK_FILE" ]; then
    echo "已在运行"
    exit 1
fi
touch "$LOCK_FILE"
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: 如何让脚本开机自启？

**方法**：
```bash
# 方法 1：systemd（推荐）
sudo systemctl enable myservice

# 方法 2：rc.local
echo "/path/to/script.sh &" >> /etc/rc.local

# 方法 3：crontab
@reboot /path/to/script.sh
```

---

### Q2: 如何查看进程占用资源？

**方法**：
```bash
# CPU 和内存
ps aux --sort=-%cpu | head -10  # CPU Top10
ps aux --sort=-%mem | head -10  # 内存 Top10

# 实时监控
top
htop

# 进程详情
ps -p PID -o pid,ppid,user,%cpu,%mem,cmd
```

---

### Q3: 如何限制并发数量？

**方法**：
```bash
#!/bin/bash
MAX_JOBS=4

for i in {1..10}; do
    {
        process_item $i
    } &
    
    # 限制并发数
    if [ $(jobs -r -p | wc -l) -ge $MAX_JOBS ]; then
        wait -n  # 等待一个完成
    fi
done

wait  # 等待所有完成
```

---

### Q4: 如何优雅地停止脚本？

**方法**：
```bash
#!/bin/bash
PID_FILE="/var/run/myscript.pid"

cleanup() {
    echo "正在停止..."
    rm -f "$PID_FILE"
    exit 0
}

trap cleanup SIGINT SIGTERM

echo $$ > "$PID_FILE"

while true; do
    # 主逻辑
    sleep 1
done
```

---

### Q5: Cron 任务不执行怎么办？

**排查**：
```bash
# 1. 检查 cron 服务
systemctl status cron      # Debian/Ubuntu
systemctl status crond     # CentOS/RHEL

# 2. 查看 cron 日志
grep CRON /var/log/syslog  # Debian/Ubuntu
grep CRON /var/log/cron    # CentOS/RHEL

# 3. 检查环境变量
crontab -l
# 添加 PATH

# 4. 测试脚本
bash -x /path/to/script.sh  # 调试模式
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 查看和管理进程
- [ ] 控制后台作业
- [ ] 捕获和处理信号
- [ ] 管理文件和权限
- [ ] 配置 Cron 定时任务
- [ ] 编写网络监控脚本
- [ ] 使用文件锁防止并发
- [ ] 优雅地启动和停止脚本
- [ ] 避免常见陷阱

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[06_real_world/](../06_real_world/)** - 实战项目篇（第 59-90 天）

你将学习：
- 64 个实战项目
- 系统管理工具
- 网络工具
- Docker 和 CI/CD
- 故障排查

---

## 💡 小贴士

1. **Cron 用绝对路径** - 避免找不到命令
2. **后台用 nohup** - 防止终端关闭杀死进程
3. **trap 清理资源** - 确保临时文件被清理
4. **文件锁防并发** - 防止脚本重复运行
5. **信号优雅退出** - 保存状态后退出
6. **日志记录** - 重要操作记录到日志

---

## 📚 参考资源

- [进程管理详解](https://www.gnu.org/software/bash/manual/html_node/Job-Control.html)
- [信号处理指南](https://www.gnu.org/software/bash/manual/html_node/Trap.html)
- [Cron 教程](https://man7.org/linux/man-pages/man5/crontab.5.html)
- [快速参考手册](../SHELL_GUIDE_BASE.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-脚本清单) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)

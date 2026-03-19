# 🚀 DevOps 运维实战脚本

> 来自生产环境的自动化运维脚本集合

---

## 📋 目录

- [系统信息检查](#01_system_info_checksh-系统信息检查)
- [批量用户管理](#02_batch_user_managersh-批量用户管理)
- [服务监控](#03_service_monitorsh-服务监控)
- [日志清理](#04_log_cleanersh-日志清理)
- [备份自动化](#05_backup_automationsh-备份自动化)
- [服务器巡检](#06_server_inspectionsh-服务器全面巡检)
- [项目文件巡检](#07_project_checksh-项目文件巡检)
- [安全审计](#08_security_auditsh-服务器安全审计)
- [网络诊断](#09_network_diagnosissh-网络诊断)
- [性能监控](#10_performance_monitorsh-性能监控)
- [每日巡检](#11_daily_inspectionsh-每日自动巡检) 🆕
- [自动化部署](#12_auto_deploysh-自动化部署) 🆕
- [安全加固](#13_security_hardening.sh-服务器安全加固) 🆕

---

## 01_system_info_check.sh - 系统信息检查

**难度**: ⭐⭐⭐  
**用途**: 快速收集服务器基本信息

### 功能特点

- ✅ 系统基本信息（OS、内核、架构）
- ✅ 运行时间和负载
- ✅ CPU 信息（核心数、型号）
- ✅ 内存使用情况
- ✅ 磁盘使用情况
- ✅ 网络接口信息
- ✅ 用户和进程统计
- ✅ 彩色输出，清晰易读

### 使用方法

```bash
chmod +x 01_system_info_check.sh
./01_system_info_check.sh
```

### 示例输出

```
========================================
       系统信息检查报告
========================================

【系统基本信息】
操作系统：Linux
内核版本：5.4.0-42-generic
系统架构：x86_64
主机名称：web-server-01

【系统运行时间】
 10:30:45 up 30 days,  2:15,  1 user,  load average: 0.52, 0.48, 0.44

【CPU 信息】
CPU 核心数：8
CPU 型号：Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz

【内存使用情况】
              total        used        free      shared  buff/cache   available
Mem:           15Gi       8.2Gi       4.1Gi       256Mi       3.2Gi       6.5Gi
Swap:         2.0Gi          0B       2.0Gi

【磁盘使用情况】
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   28G   20G  59% /
/dev/sdb1       500G  120G  380G  24% /data

【网络接口信息】
1: lo: <LOOPBACK,UP,LOWER_UP>
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP>
    inet 192.168.1.100/24 brd 192.168.1.255 scope global eth0

【用户信息】
当前用户：root
登录用户：1 人

【进程统计】
总进程数：156
运行中进程：2

========================================
检查完成！
========================================
```

### 应用场景

- 新服务器初始化检查
- 日常系统巡检
- 故障排查信息收集
- 交接班检查

---

## 02_batch_user_manager.sh - 批量用户管理

**难度**: ⭐⭐⭐⭐  
**用途**: 批量创建、删除、管理用户

### 功能特点

- ✅ 批量创建用户
- ✅ 批量删除用户（带确认）
- ✅ 自动生成随机密码
- ✅ 密码永不过期
- ✅ 操作日志记录
- ✅ 密码文件保存
- ✅ 用户存在性检查

### 使用方法

```bash
# 准备用户列表文件
cat > users.txt << EOF
zhangsan
lisi
wangwu
# 这是注释，会被跳过
zhaoliu
EOF

# 批量创建用户
sudo ./02_batch_user_manager.sh create users.txt

# 批量删除用户（需要确认）
sudo ./02_batch_user_manager.sh delete users.txt

# 检查用户是否存在
sudo ./02_batch_user_manager.sh list users.txt
```

### 示例输出

```
开始批量创建用户...
✓ 创建用户：zhangsan (密码：Abc123!@#xyz)
✓ 创建用户：lisi (密码：Def456$%^uvw)
用户 wangwu 已存在，跳过
✓ 创建用户：zhaoliu (密码：Ghi789&*rst)

创建完成！密码已保存到：./created_users_passwords.txt
```

### 生成的密码文件

```
zhangsan:Abc123!@#xyz
lisi:Def456$%^uvw
zhaoliu:Ghi789&*rst
```

### 应用场景

- 新员工入职批量开户
- 毕业季批量删除
- 培训班学员管理
- 临时用户管理

---

## 03_service_monitor.sh - 服务监控

**难度**: ⭐⭐⭐⭐  
**用途**: 监控关键服务状态并自动重启

### 功能特点

- ✅ 自动监控服务状态
- ✅ 服务异常自动重启
- ✅ 邮件通知
- ✅ 自定义监控列表
- ✅ 详细日志记录
- ✅ 支持添加/移除监控

### 使用方法

```bash
# 执行服务检查
sudo ./03_service_monitor.sh

# 添加监控服务
sudo ./03_service_monitor.sh --add nginx

# 移除监控服务
sudo ./03_service_monitor.sh --remove apache2

# 列出监控列表
sudo ./03_service_monitor.sh --list
```

### 配置监控服务

编辑 `/etc/service_monitor.conf`:

```
sshd
nginx
mysql
redis
docker
```

### 配置定时任务

```bash
crontab -e

# 每 5 分钟检查一次
*/5 * * * * /path/to/03_service_monitor.sh
```

### 示例输出

```
========================================
       服务监控检查报告
========================================

✓ sshd - 运行中
✓ cron - 运行中
✗ nginx - 已停止
✓ mysql - 运行中

发现 1 个服务异常：
正在重启服务：nginx
✓ nginx 重启成功

========================================
```

### 应用场景

- 关键服务高可用保障
- 夜间自动故障恢复
- 减少运维值班压力

---

## 04_log_cleaner.sh - 日志清理

**难度**: ⭐⭐⭐  
**用途**: 清理过期日志文件，释放磁盘空间

### 功能特点

- ✅ 清理过期日志
- ✅ 模拟运行（不删除）
- ✅ 压缩旧日志
- ✅ 磁盘使用统计
- ✅ 多目录支持
- ✅ 清理空目录

### 使用方法

```bash
# 清理 30 天前的日志
sudo ./04_log_cleaner.sh

# 清理 7 天前的日志
sudo ./04_log_cleaner.sh 7

# 模拟清理（不删除文件）
sudo ./04_log_cleaner.sh 30 --dry-run

# 清理并压缩
sudo ./04_log_cleaner.sh 7 --compress

# 查看磁盘使用情况
sudo ./04_log_cleaner.sh --disk
```

### 示例输出

```
========================================
       磁盘使用情况
========================================

Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   48G  2.0G  96% /

日志目录大小：
  /var/log: 15G
  /var/log/nginx: 8.2G
  /var/log/mysql: 3.5G

========================================
       日志清理报告
========================================

保留天数：30 天
模式：实际清理

查找模式：*.log
  ✓ 已删除：/var/log/nginx/access.log.1 (2.1G)
  ✓ 已删除：/var/log/mysql/slow.log (1.5G)

查找模式：*.gz
  ✓ 已删除：/var/log/syslog.1.gz (500M)

清理空目录：
  ✓ 完成

========================================
       清理统计
========================================
  扫描文件数：45
  删除文件数：38
  释放空间：12G

========================================
```

### 配置定时任务

```bash
crontab -e

# 每天凌晨 2 点清理 30 天前的日志，并压缩 7 天前的日志
0 2 * * * /path/to/04_log_cleaner.sh 30 --compress
```

### 应用场景

- 磁盘空间告警处理
- 定期日志维护
- 日志归档前清理

---

## 05_backup_automation.sh - 备份自动化

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 完整的备份解决方案

### 功能特点

- ✅ 数据库备份（MySQL）
- ✅ 文件系统备份
- ✅ 系统配置备份
- ✅ 完整性校验（MD5）
- ✅ 备份轮换（日/周/月）
- ✅ 远程同步（rsync）
- ✅ 详细统计

### 配置说明

编辑脚本中的配置区域：

```bash
# 备份目录
BACKUP_DIR="/backup"

# 数据库配置
DB_USER="root"
DB_PASSWORD=""  # 建议写入 ~/.my.cnf
DATABASES=("mysql" "information_schema")

# 要备份的文件
FILES_TO_BACKUP=(
    "/etc"
    "/home"
    "/var/www"
)

# 备份保留策略
DAILY_RETAIN=7      # 日备份保留 7 天
WEEKLY_RETAIN=4     # 周备份保留 4 周
MONTHLY_RETAIN=12   # 月备份保留 12 个月
```

### 使用方法

```bash
# 完整备份
sudo ./05_backup_automation.sh

# 只备份数据库
sudo ./05_backup_automation.sh --database

# 只备份文件
sudo ./05_backup_automation.sh --files

# 查看备份统计
sudo ./05_backup_automation.sh --stats

# 执行备份轮换
sudo ./05_backup_automation.sh --rotate
```

### 示例输出

```
========================================
       备份数据库
========================================

  备份数据库：mysql ... ✓ 完成
  备份数据库：information_schema ... ✓ 完成

========================================
       备份文件系统
========================================

  备份目标：
    - /etc
    - /home
    - /var/www

  创建压缩包 ... ✓ 完成 (2.5G)

========================================
       备份系统配置
========================================

  ✓ 系统配置已保存

========================================
       计算校验和
========================================

  ✓ 校验和已计算

========================================
       备份轮换
========================================

  清理 7 天前的日备份...
  清理 4 周前的周备份...
  清理 12 月前的月备份...
  ✓ 轮换完成

========================================
       备份统计
========================================

  备份目录：/backup
  总大小：156G
  日备份数量：7
  周备份数量：4
  月备份数量：12

========================================
```

### 配置定时任务

```bash
crontab -e

# 每天凌晨 2 点完整备份
0 2 * * * /path/to/05_backup_automation.sh

# 每周日凌晨 3 点执行备份轮换
0 3 * * 0 /path/to/05_backup_automation.sh --rotate
```

### 备份目录结构

```
/backup/
├── daily/
│   ├── 20260318/
│   │   ├── mysql_20260318_020000.sql.gz
│   │   ├── files_20260318_020000.tar.gz
│   │   ├── backup_config_20260318.txt
│   │   └── CHECKSUMS.md5
│   └── ...
├── weekly/
├── monthly/
└── backup.log
```

### 恢复数据

```bash
# 1. 查看备份文件
ls -lh /backup/daily/

# 2. 恢复数据库
gunzip < mysql_20260318_020000.sql.gz | mysql -u root -p

# 3. 恢复文件
tar -xzf files_20260318_020000.tar.gz -C /
```

### 应用场景

- 日常数据备份
- 灾难恢复准备
- 合规性要求
- 迁移前备份

---

## 📊 脚本对比

| 脚本 | 难度 | 执行时间 | 风险等级 | 推荐频率 |
|------|------|----------|----------|----------|
| 系统信息检查 | ⭐⭐⭐ | < 1 秒 | 无风险 | 每天 |
| 批量用户管理 | ⭐⭐⭐⭐ | 视数量 | 中风险 | 按需 |
| 服务监控 | ⭐⭐⭐⭐ | < 5 秒 | 低风险 | 每 5 分钟 |
| 日志清理 | ⭐⭐⭐ | 视大小 | 中风险 | 每周 |
| 备份自动化 | ⭐⭐⭐⭐⭐ | 视数据量 | 低风险 | 每天 |

---

## 🔧 最佳实践

### 1. 测试环境先行

所有脚本在生产环境使用前，先在测试环境验证。

### 2. 备份重要数据

执行删除、修改操作前，先备份重要数据。

### 3. 记录操作日志

所有脚本都有日志记录功能，便于问题追溯。

### 4. 定期演练恢复

备份脚本要定期测试恢复流程，确保备份可用。

### 5. 权限最小化

使用最小必要权限运行脚本，避免使用 root（如可能）。

---

## 06_server_inspection.sh - 服务器全面巡检 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 全面检测服务器状态，生成巡检报告

### 功能特点

- ✅ **函数化组织** - 11 个独立检测函数
- ✅ **格式化输出** - printf 表格对齐
- ✅ **彩色显示** - 红/黄/绿/蓝四色
- ✅ **11 项全面检测**:
  - IP 地址检测（内网/外网）
  - 系统信息检测（版本/内核/负载）
  - 磁盘使用检测（使用率告警）
  - 网络连接检测（连接统计）
  - 端口监听检测（进程关联）
  - 防火墙规则检测（多工具支持）
  - 进程检测（CPU 使用排行）
  - 服务状态检测（关键服务）
  - 文件修改检测（24 小时内）
  - 登录日志检测（成功/失败）

### 使用方法

```bash
# 运行巡检
./06_server_inspection.sh

# 保存到文件
./06_server_inspection.sh > inspection_$(date +%Y%m%d_%H%M%S).txt
```

### 输出示例

```
========================================
       服务器全面巡检报告
========================================
检测时间：2026-03-19 08:43:35
主机名：copaw
========================================

【IP 地址检测】
------------------------------------
外网 IP: 116.24.66.121
内网 IP: 10.128.0.109
主机名：copaw

【系统信息检测】
------------------------------------
系统版本：Ubuntu 24.04.3 LTS
内核版本：6.8.0-106-generic
运行时间：up 23 hours, 24 minutes
系统负载：0.02, 0.04, 0.00
CPU 核心：4 核
内存使用：214Mi / 7.8Gi

【磁盘使用检测】
------------------------------------
文件系统              大小          已用             使用率     
------------------------------------
/dev/mapper/...       61G           29G              50%        
/dev/sda2             2.0G          197M             11%        

【网络连接检测】
------------------------------------
协议               本地地址         远程地址            状态         
------------------------------------
tcp                10.128.0.109:22  10.128.2.65:64626  ESTABLISHED    

连接统计:
  ESTABLISHED: 11
  TIME_WAIT: 3
  LISTEN: 19

【防火墙规则检测】
------------------------------------
防火墙状态：运行中
放行的端口:
  - 80/tcp
  - 443/tcp
...
```

### 技术亮点

1. **函数化编程**
   ```bash
   ip_check() { ... }
   system_info_check() { ... }
   disk_check() { ... }
   ```

2. **格式化输出**
   ```bash
   printf "%-20s %-15s %-25s %-15s\n" "协议" "本地地址" "远程地址" "状态"
   ```

3. **彩色显示**
   ```bash
   echo -e "${RED}警告${NC}"
   echo -e "${GREEN}正常${NC}"
   ```

4. **系统兼容**
   ```bash
   if [[ -f /etc/redhat-release ]]; then
       # CentOS
   elif [[ -f /etc/lsb-release ]]; then
       # Ubuntu
   fi
   ```

### 适用场景

- ✅ 日常服务器巡检
- ✅ 故障排查前检查
- ✅ 交接班记录
- ✅ 性能优化参考
- ✅ 安全审计准备

---

## 07_project_check.sh - 项目文件巡检 🆕

**难度**: ⭐⭐⭐⭐  
**用途**: 统计项目文件、检测最近修改、分析代码量

### 功能特点

- ✅ **项目概览统计** - 文件数、代码行数、目录大小
- ✅ **24/7 天修改检测** - 追踪最近变更
- ✅ **代码文件统计** - 按语言分类（PHP/JS/Python/Java/Go）
- ✅ **大文件检测** - 找出占用空间的大文件
- ✅ **空目录检测** - 清理无用目录
- ✅ **配置文件检测** - 查找常见配置文件
- ✅ **权限检测** - 检查脚本执行权限和 777 危险权限
- ✅ **自动排除** - 跳过 logs、cache、node_modules 等临时目录

### 使用方法

```bash
# 检测默认目录（/home/wwwroot）
sudo ./07_project_check.sh

# 检测指定目录
sudo ./07_project_check.sh /var/www

# 查看帮助
./07_project_check.sh --help
```

### 应用场景

- ✅ 项目交接前的文件统计
- ✅ 代码库规模评估
- ✅ 清理大文件和空目录
- ✅ 检查配置文件安全
- ✅ 追踪最近代码变更

---

## 08_security_audit.sh - 服务器安全审计 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 全面检查服务器安全配置，发现安全隐患

### 功能特点

- ✅ **用户账户审计** - UID 0 用户、空密码用户
- ✅ **sudo 配置审计** - sudoers 语法检查
- ✅ **SSH 配置审计** - root 登录、密码认证
- ✅ **防火墙审计** - firewalld/ufw/iptables 状态
- ✅ **文件权限审计** - 敏感文件权限检查
- ✅ **日志审计** - 失败登录尝试检测
- ✅ **异常进程检测** - 可疑进程发现
- ✅ **生成审计报告** - 保存详细结果

### 使用方法

```bash
# 执行安全审计（需要 root 权限）
sudo ./08_security_audit.sh

# 保存审计报告
sudo ./08_security_audit.sh > security_audit_$(date +%Y%m%d_%H%M%S).txt
```

### 应用场景

- ✅ 定期安全巡检
- ✅ 合规性检查
- ✅ 入侵检测
- ✅ 安全加固前评估

---

## 09_network_diagnosis.sh - 网络诊断 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 全面网络诊断，排查网络问题

### 功能特点

- ✅ **网络接口信息** - IP、MAC、状态
- ✅ **网关和路由** - 路由表、ARP 缓存
- ✅ **DNS 配置** - DNS 服务器、解析测试
- ✅ **连通性测试** - Ping 测试、丢包率
- ✅ **延迟测试** - 到常用网站延迟
- ✅ **路由追踪** - traceroute 路径
- ✅ **端口扫描** - 服务端口检测
- ✅ **带宽测试** - 下载速度测试
- ✅ **连接统计** - TCP 连接状态
- ✅ **故障诊断** - 自动检测问题

### 使用方法

```bash
# 诊断到默认目标（8.8.8.8）
sudo ./09_network_diagnosis.sh

# 诊断到指定目标
sudo ./09_network_diagnosis.sh www.baidu.com

# 查看帮助
./09_network_diagnosis.sh --help
```

### 应用场景

- ✅ 网络故障排查
- ✅ 网络性能测试
- ✅ 新服务器网络验证
- ✅ 网络连接问题分析

---

## 10_performance_monitor.sh - 性能监控 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 实时监控系统性能，发现性能瓶颈

### 功能特点

- ✅ **CPU 监控** - 总使用率、每核心、系统负载
- ✅ **内存监控** - 物理内存、交换空间
- ✅ **磁盘监控** - 磁盘空间、inode、IO
- ✅ **网络监控** - 接口流量、连接数
- ✅ **进程监控** - 资源占用 TOP
- ✅ **进度条显示** - 直观可视化
- ✅ **告警阈值** - 超限告警
- ✅ **实时监控** - 可设置间隔
- ✅ **日志记录** - 历史数据

### 使用方法

```bash
# 实时监控（默认 2 秒间隔）
./10_performance_monitor.sh

# 自定义间隔（5 秒）
./10_performance_monitor.sh -i 5

# 启用日志记录
./10_performance_monitor.sh -l

# 单次监控（不循环）
./10_performance_monitor.sh -o
```

### 应用场景

- ✅ 性能瓶颈分析
- ✅ 系统资源监控
- ✅ 故障排查参考
- ✅ 容量规划
- ✅ 性能优化验证

---

## 📊 脚本对比

| 脚本 | 难度 | 执行时间 | 风险等级 | 推荐频率 |
|------|------|----------|----------|----------|
| 01_system_info_check | ⭐⭐⭐ | < 1 秒 | 无风险 | 每天 |
| 02_batch_user_manager | ⭐⭐⭐⭐ | 视数量 | 中风险 | 按需 |
| 03_service_monitor | ⭐⭐⭐⭐ | < 5 秒 | 低风险 | 每 5 分钟 |
| 04_log_cleaner | ⭐⭐⭐ | 视大小 | 中风险 | 每周 |
| 05_backup_automation | ⭐⭐⭐⭐⭐ | 视数据量 | 低风险 | 每天 |
| 06_server_inspection | ⭐⭐⭐⭐⭐ | < 10 秒 | 无风险 | 每天 |
| 07_project_check | ⭐⭐⭐⭐ | 视大小 | 无风险 | 每周 |
| 08_security_audit | ⭐⭐⭐⭐⭐ | < 30 秒 | 无风险 | 每周 |
| 09_network_diagnosis | ⭐⭐⭐⭐⭐ | < 60 秒 | 无风险 | 按需 |
| 10_performance_monitor | ⭐⭐⭐⭐⭐ | 持续 | 无风险 | 持续 |

---

## 🔧 最佳实践

### 1. 测试环境先行

所有脚本在生产环境使用前，先在测试环境验证。

### 2. 备份重要数据

执行删除、修改操作前，先备份重要数据。

### 3. 记录操作日志

所有脚本都有日志记录功能，便于问题追溯。

### 4. 定期演练恢复

备份脚本要定期测试恢复流程，确保备份可用。

### 5. 权限最小化

使用最小必要权限运行脚本，避免使用 root（如可能）。

### 6. 组合使用脚本

日常巡检可以组合使用：

```bash
# 每日巡检脚本
#!/bin/bash
./06_server_inspection.sh > inspection_$(date +%Y%m%d).txt
./07_project_check.sh >> inspection_$(date +%Y%m%d).txt
./10_performance_monitor.sh -o >> inspection_$(date +%Y%m%d).txt
```

### 7. 自动化定时任务

```bash
crontab -e

# 每天早上 8 点服务器巡检
0 8 * * * /path/to/06_server_inspection.sh > /var/log/inspection/daily_$(date +\%Y\%m\%d).txt

# 每周日凌晨 2 点安全审计
0 2 * * 0 /path/to/08_security_audit.sh > /var/log/security/weekly_$(date +\%Y\%m\%d).txt

# 每分钟性能监控记录
* * * * * /path/to/10_performance_monitor.sh -o -l
```

---

## 11_daily_inspection.sh - 每日自动巡检 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 组合多个检查脚本，生成综合巡检报告

### 功能特点

- ✅ **系统信息摘要** - 负载、内存、磁盘快速概览
- ✅ **服务状态检查** - 关键服务运行状态
- ✅ **安全状态检查** - 失败登录、异常端口、危险权限
- ✅ **备份状态检查** - 备份目录、文件大小、更新情况
- ✅ **日志状态检查** - 日志大小、错误日志统计
- ✅ **性能摘要** - CPU、内存、磁盘 IO、网络连接
- ✅ **生成综合报告** - 自动汇总所有检查结果
- ✅ **支持邮件发送** - 可配置邮件通知

### 使用方法

```bash
# 生成巡检报告
./11_daily_inspection.sh

# 保存到文件
./11_daily_inspection.sh -o /var/log/inspection/daily_$(date +%Y%m%d).txt

# 发送邮件
./11_daily_inspection.sh -e admin@example.com

# 组合使用
./11_daily_inspection.sh -o report.txt -e admin@example.com
```

### 配置定时任务

```bash
crontab -e

# 每天早上 8 点执行巡检
0 8 * * * /path/to/11_daily_inspection.sh -o /var/log/inspection/daily_$(date +\%Y\%m\%d).txt
```

### 应用场景

- ✅ 每日自动巡检
- ✅ 交接班报告
- ✅ 运维日报
- ✅ 系统健康检查

---

## 12_auto_deploy.sh - 自动化部署 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 支持多环境、版本回滚、健康检查的自动化部署

### 功能特点

- ✅ **多环境支持** - dev/staging/production
- ✅ **Git 集成** - 自动拉取指定分支
- ✅ **版本备份** - 部署前自动备份当前版本
- ✅ **版本回滚** - 一键回滚到上一版本
- ✅ **智能构建** - 自动检测并执行构建脚本
- ✅ **数据库迁移** - Laravel/Django自动迁移
- ✅ **服务重启** - 自动重启相关服务
- ✅ **健康检查** - 部署后自动健康检查
- ✅ **零停机部署** - 支持滚动更新

### 使用方法

```bash
# 部署到生产环境
sudo ./12_auto_deploy.sh -e production

# 部署指定分支到测试环境
sudo ./12_auto_deploy.sh -e staging -b develop

# 回滚生产环境
sudo ./12_auto_deploy.sh --rollback -e production

# 查看部署状态
sudo ./12_auto_deploy.sh --status

# 执行健康检查
sudo ./12_auto_deploy.sh --health-check -e production
```

### 部署流程

1. 检查依赖和 Git 仓库
2. 拉取最新代码
3. 备份当前版本
4. 同步文件到部署目录
5. 设置文件权限
6. 执行构建（npm/composer/pip）
7. 数据库迁移
8. 重启服务
9. 健康检查

### 配置示例

```bash
# 编辑脚本配置区域
DEPLOY_USER="www-data"
DEPLOY_GROUP="www-data"
DEPLOY_BASE="/var/www"
BACKUP_BASE="/backup/deploy"
```

### 应用场景

- ✅ 生产环境部署
- ✅ 测试环境部署
- ✅ 紧急回滚
- ✅ CI/CD 集成

---

## 13_security_hardening.sh - 服务器安全加固 🆕

**难度**: ⭐⭐⭐⭐⭐  
**用途**: 自动化安全配置，提升服务器安全性

### 功能特点

- ✅ **SSH 安全加固** - 禁止 root、禁用密码、修改端口
- ✅ **防火墙配置** - firewalld/ufw/iptables自动配置
- ✅ **用户安全加固** - 空密码检查、UID 0 检查、密码策略
- ✅ **文件系统安全** - 777 权限修复、SUID/SGID 检查
- ✅ **系统参数优化** - 网络安全、内核参数
- ✅ **日志配置** - 日志服务、日志轮转、日志保护
- ✅ **安全检查报告** - 生成详细安全报告
- ✅ **配置备份** - 加固前自动备份配置
- ✅ **可逆操作** - 支持从备份恢复

### 使用方法

```bash
# 交互式加固
sudo ./13_security_hardening.sh

# 自动加固（无需确认）
sudo ./13_security_hardening.sh --auto

# 检查当前配置
sudo ./13_security_hardening.sh --check
```

### 加固项目

**SSH 加固**:
- 禁止 root 登录
- 禁用密码认证（使用密钥）
- 启用公钥认证
- 修改 SSH 端口
- 限制允许登录的用户
- 设置空闲超时
- 禁用 X11 转发

**防火墙配置**:
- 启用防火墙
- 设置默认策略
- 开放必要端口（22/80/443）

**用户安全**:
- 检查空密码用户
- 检查 UID 0 用户
- 设置密码策略（90 天过期）
- 锁定系统账户

**文件系统**:
- 修复 777 权限文件
- 检查 SUID/SGID 文件
- 设置关键文件权限
- 配置 umask

**系统参数**:
- TCP SYN cookies
- ICMP 配置
- 反向路径过滤
- 日志记录可疑数据包

### 安全建议

加固后建议：
1. 测试 SSH 连接（不要关闭当前会话）
2. 验证防火墙规则
3. 检查服务正常运行
4. 保存备份配置
5. 定期运行安全检查

### 应用场景

- ✅ 新服务器初始化
- ✅ 安全合规检查
- ✅ 安全加固审计
- ✅ 渗透测试前准备

---

## 📊 脚本对比

| 脚本 | 难度 | 执行时间 | 风险等级 | 推荐频率 |
|------|------|----------|----------|----------|
| 01_system_info_check | ⭐⭐⭐ | < 1 秒 | 无风险 | 每天 |
| 02_batch_user_manager | ⭐⭐⭐⭐ | 视数量 | 中风险 | 按需 |
| 03_service_monitor | ⭐⭐⭐⭐ | < 5 秒 | 低风险 | 每 5 分钟 |
| 04_log_cleaner | ⭐⭐⭐ | 视大小 | 中风险 | 每周 |
| 05_backup_automation | ⭐⭐⭐⭐⭐ | 视数据量 | 低风险 | 每天 |
| 06_server_inspection | ⭐⭐⭐⭐⭐ | < 10 秒 | 无风险 | 每天 |
| 07_project_check | ⭐⭐⭐⭐ | 视大小 | 无风险 | 每周 |
| 08_security_audit | ⭐⭐⭐⭐⭐ | < 30 秒 | 无风险 | 每周 |
| 09_network_diagnosis | ⭐⭐⭐⭐⭐ | < 60 秒 | 无风险 | 按需 |
| 10_performance_monitor | ⭐⭐⭐⭐⭐ | 持续 | 无风险 | 持续 |
| 11_daily_inspection | ⭐⭐⭐⭐⭐ | < 30 秒 | 无风险 | 每天 |
| 12_auto_deploy | ⭐⭐⭐⭐⭐ | 视项目 | 中风险 | 按需 |
| 13_security_hardening | ⭐⭐⭐⭐⭐ | < 5 分钟 | 中风险 | 按需 |

---

## 🔧 最佳实践

### 1. 测试环境先行

所有脚本在生产环境使用前，先在测试环境验证。

### 2. 备份重要数据

执行删除、修改操作前，先备份重要数据。

### 3. 记录操作日志

所有脚本都有日志记录功能，便于问题追溯。

### 4. 定期演练恢复

备份脚本要定期测试恢复流程，确保备份可用。

### 5. 权限最小化

使用最小必要权限运行脚本，避免使用 root（如可能）。

### 6. 组合使用脚本

日常巡检可以组合使用：

```bash
# 每日巡检脚本
#!/bin/bash
./11_daily_inspection.sh -o /var/log/inspection/daily_$(date +%Y%m%d).txt
```

### 7. 自动化定时任务

```bash
crontab -e

# 每天早上 8 点服务器巡检
0 8 * * * /path/to/11_daily_inspection.sh -o /var/log/inspection/daily_$(date +\%Y\%m\%d).txt

# 每周日凌晨 2 点安全审计
0 2 * * 0 /path/to/08_security_audit.sh > /var/log/security/weekly_$(date +\%Y\%m\%d).txt

# 每分钟性能监控记录
* * * * * /path/to/10_performance_monitor.sh -o -l

# 安全加固（新服务器）
# 手动执行一次即可
sudo /path/to/13_security_hardening.sh --auto
```

---

## 📚 扩展阅读

- [Linux 系统管理](https://linuxcommand.org/)
- [Bash 编程指南](https://bashguide.readthedocs.io/)
- [DevOps 最佳实践](https://www.atlassian.com/devops)
- [absonggit/test - 参考仓库](https://github.com/absonggit/test)

---

**最后更新**: 2026-03-19  
**维护者**: hjs2015

**参考来源**: absonggit/test 仓库的 check.sh 和 check_k8s.sh 脚本

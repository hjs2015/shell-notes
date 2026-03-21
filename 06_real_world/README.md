# 🚀 实战项目 (Real World Projects)

> **学习第 59-90 天** | 难度：⭐⭐⭐⭐⭐ | **64 个实战项目** | 预计 40-50 小时

---

## 📋 目录

- [概述](#概述)
- [项目清单](#项目清单)
  - [核心运维（28 个脚本）](#核心运维 28 个脚本)
  - [部署与网络（20 个脚本）](#部署与网络 20 个脚本)
  - [现代运维（16 个脚本）](#现代运维 16 个脚本)
- [32 天学习计划](#32-天学习计划)
- [重点脚本推荐](#重点脚本推荐)
- [核心知识点详解](#核心知识点详解)
  - [系统监控](#系统监控)
  - [备份自动化](#备份自动化)
  - [日志分析](#日志分析)
  - [用户管理](#用户管理)
  - [部署脚本](#部署脚本)
  - [Docker 和 CI/CD](#docker-和 cicd)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [毕业项目](#毕业项目)
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 概述

实战项目是 Shell 脚本学习的最终阶段，将前面学到的所有知识应用到真实运维场景中。

**学完你能做什么**：
- ✅ 编写生产级运维脚本
- ✅ 自动化日常运维任务
- ✅ 监控系统健康状态
- ✅ 快速排查故障
- ✅ 部署和管理应用
- ✅ 使用 Docker 和 CI/CD

**预计时间**：32 天，每天 1-2 小时

---

## 📁 项目清单

### 核心运维（28 个脚本）

| 目录 | 难度 | 项目 | 脚本数 | 核心技能 |
|------|------|------|:---:|----------|
| [01_system_monitor/](01_system_monitor/) | ⭐⭐⭐⭐ | 系统监控 | 8 个 | CPU/内存/磁盘监控 |
| [02_backup_automation/](02_backup_automation/) | ⭐⭐⭐⭐ | 备份自动化 | 6 个 | 定时备份/轮转 |
| [03_log_analyzer/](03_log_analyzer/) | ⭐⭐⭐⭐ | 日志分析 | 8 个 | 日志解析/统计 |
| [04_user_manager/](04_user_manager/) | ⭐⭐⭐ | 用户管理 | 6 个 | 用户/权限管理 |

### 部署与网络（20 个脚本）

| 目录 | 难度 | 项目 | 脚本数 | 核心技能 |
|------|------|------|:---:|----------|
| [05_deploy_script/](05_deploy_script/) | ⭐⭐⭐⭐ | 部署脚本 | 6 个 | 应用部署 |
| [06_network_tools/](06_network_tools/) | ⭐⭐⭐⭐ | 网络工具 | 6 个 | 网络检测 |
| [07_security_tools/](07_security_tools/) | ⭐⭐⭐⭐⭐ | 安全工具 | 4 个 | 安全扫描 |
| [08_devops_tools/](08_devops_tools/) | ⭐⭐⭐⭐⭐ | DevOps 工具 | 4 个 | 自动化运维 |

### 现代运维（16 个脚本）

| 目录 | 难度 | 项目 | 脚本数 | 核心技能 |
|------|------|------|:---:|----------|
| [09_container_docker/](09_container_docker/) | ⭐⭐⭐⭐ | Docker 容器 | 3 个 | 容器管理 |
| [10_cicd_pipeline/](10_cicd_pipeline/) | ⭐⭐⭐⭐⭐ | CI/CD 流水线 | 3 个 | 持续集成 |
| [11_troubleshooting/](11_troubleshooting/) | ⭐⭐⭐⭐⭐ | 故障排查 | 3 个 | 问题诊断 |
| [12_shell_library/](12_shell_library/) | ⭐⭐⭐⭐⭐ | Shell 函数库 | 4 个 | 代码复用 |

---

## 📅 32 天学习计划

### 第 59-65 天：核心运维（28 个脚本，10 小时）

**学习内容**：
- 01_system_monitor/ - 系统监控（8 个脚本）
- 02_backup_automation/ - 备份自动化（6 个脚本）
- 03_log_analyzer/ - 日志分析（8 个脚本）
- 04_user_manager/ - 用户管理（6 个脚本）

**目标**：掌握日常运维核心技能

---

### 第 66-75 天：部署与网络（20 个脚本，8 小时）

**学习内容**：
- 05_deploy_script/ - 部署脚本（6 个脚本）
- 06_network_tools/ - 网络工具（6 个脚本）
- 07_security_tools/ - 安全工具（4 个脚本）
- 08_devops_tools/ - DevOps 工具（4 个脚本）

**目标**：学会部署和网络管理

---

### 第 76-90 天：现代运维（16 个脚本，6 小时）

**学习内容**：
- 09_container_docker/ - Docker 容器（3 个脚本）
- 10_cicd_pipeline/ - CI/CD 流水线（3 个脚本）
- 11_troubleshooting/ - 故障排查（3 个脚本）
- 12_shell_library/ - Shell 函数库（4 个脚本）

**目标**：掌握现代运维工具

---

## 🎯 重点脚本推荐

### 新手必做（⭐⭐⭐）

| 脚本 | 项目 | 技能 | 时间 |
|------|------|------|------|
| [04_user_manager/01_user_manager.sh](04_user_manager/01_user_manager.sh) | 用户管理系统 | 用户/组管理 | 30 分钟 |
| [01_system_monitor/01_cpu_monitor.sh](01_system_monitor/01_cpu_monitor.sh) | CPU 监控 | 系统监控 | 20 分钟 |
| [02_backup_automation/01_backup_files.sh](02_backup_automation/01_backup_files.sh) | 文件备份 | 备份策略 | 25 分钟 |

---

### 进阶提升（⭐⭐⭐⭐）

| 脚本 | 项目 | 技能 | 时间 |
|------|------|------|------|
| [03_log_analyzer/01_analyze_access_log.sh](03_log_analyzer/01_analyze_access_log.sh) | 日志分析 | awk/grep | 40 分钟 |
| [06_network_tools/01_network_tools.sh](06_network_tools/01_network_tools.sh) | 网络工具集 | 网络检测 | 35 分钟 |
| [09_container_docker/02_docker_compose.sh](09_container_docker/02_docker_compose.sh) | Docker Compose | 容器编排 | 30 分钟 |

---

### 专家挑战（⭐⭐⭐⭐⭐）

| 脚本 | 项目 | 技能 | 时间 |
|------|------|------|------|
| [10_cicd_pipeline/03_cicd_jenkins.sh](10_cicd_pipeline/03_cicd_jenkins.sh) | Jenkins CI/CD | 持续集成 | 50 分钟 |
| [11_troubleshooting/03_troubleshooting_network.sh](11_troubleshooting/03_troubleshooting_network.sh) | 网络故障排查 | 问题诊断 | 45 分钟 |
| [12_shell_library/04_test_utils.sh](12_shell_library/04_test_utils.sh) | 单元测试框架 | 代码测试 | 40 分钟 |

---

## 🔍 核心知识点详解

### 系统监控

**CPU 监控**：
```bash
#!/bin/bash
# 获取 CPU 使用率
get_cpu_usage() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "$cpu_usage"
}

# 监控并告警
THRESHOLD=80
cpu=$(get_cpu_usage)

if (( $(echo "$cpu > $THRESHOLD" | bc -l) )); then
    echo "警告：CPU 使用率过高 ($cpu%)" | mail -s "CPU 告警" admin@example.com
fi
```

**内存监控**：
```bash
#!/bin/bash
# 获取内存使用率
get_mem_usage() {
    local mem_info=$(free | grep Mem)
    local total=$(echo $mem_info | awk '{print $2}')
    local used=$(echo $mem_info | awk '{print $3}')
    local usage=$((used * 100 / total))
    echo "$usage"
}

# 监控内存
mem=$(get_mem_usage)
echo "内存使用率：$mem%"
```

**磁盘监控**：
```bash
#!/bin/bash
# 检查磁盘使用率
check_disk() {
    local mount_point=$1
    local threshold=$2
    
    local usage=$(df -h "$mount_point" | tail -1 | awk '{print $5}' | cut -d'%' -f1)
    
    if [ $usage -gt $threshold ]; then
        echo "警告：$mount_point 磁盘使用率 $usage%"
        return 1
    fi
    return 0
}

check_disk "/" 80
```

**综合监控脚本**：
```bash
#!/bin/bash
# 系统健康检查
echo "=== 系统健康检查 ==="
echo "时间：$(date)"
echo

# CPU
echo "【CPU】"
top -bn1 | grep "Cpu(s)" | awk '{printf "使用率：%.1f%%\n", $2}'
echo

# 内存
echo "【内存】"
free -h | grep -E "^Mem"
echo

# 磁盘
echo "【磁盘】"
df -h | grep -E "^/dev"
echo

# 负载
echo "【负载】"
uptime
```

---

### 备份自动化

**文件备份**：
```bash
#!/bin/bash
# 带时间戳的备份
SOURCE_DIR="/data"
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/data_$DATE.tar.gz"

# 创建备份
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# 验证备份
if [ $? -eq 0 ]; then
    echo "备份成功：$BACKUP_FILE"
    # 计算大小
    ls -lh "$BACKUP_FILE" | awk '{print "大小："$5}'
else
    echo "备份失败"
    exit 1
fi
```

**备份轮转**：
```bash
#!/bin/bash
# 保留最近 7 天的备份
BACKUP_DIR="/backup"
DAYS_TO_KEEP=7

# 删除旧备份
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$DAYS_TO_KEEP -delete

echo "已删除 $DAYS_TO_KEEP 天前的备份"
```

**数据库备份**：
```bash
#!/bin/bash
# MySQL 备份
DB_USER="root"
DB_PASS="password"
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d)

# 备份所有数据库
mysqldump -u"$DB_USER" -p"$DB_PASS" --all-databases > "$BACKUP_DIR/all_$DATE.sql"

# 压缩
gzip "$BACKUP_DIR/all_$DATE.sql"

# 删除 30 天前的备份
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +30 -delete
```

---

### 日志分析

**访问日志分析**：
```bash
#!/bin/bash
# 分析 Nginx/Apache 访问日志
LOG_FILE="/var/log/nginx/access.log"

echo "=== 访问日志分析 ==="
echo

# Top 10 IP
echo "【Top 10 访问 IP】"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo

# Top 10 请求 URL
echo "【Top 10 请求 URL】"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -10
echo

# HTTP 状态码统计
echo "【HTTP 状态码】"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
echo

# 每小时访问量
echo "【每小时访问量】"
awk -F: '{print $2}' "$LOG_FILE" | cut -d' ' -f1 | sort | uniq -c
```

**错误日志分析**：
```bash
#!/bin/bash
# 分析错误日志
LOG_FILE="/var/log/nginx/error.log"

echo "=== 错误日志分析 ==="
echo

# 错误级别统计
echo "【错误级别】"
grep -oE "\[(error|warn|notice|info|debug)\]" "$LOG_FILE" | sort | uniq -c | sort -rn
echo

# 最新错误
echo "【最新 10 条错误】"
tail -20 "$LOG_FILE"
```

---

### 用户管理

**批量创建用户**：
```bash
#!/bin/bash
# 从文件批量创建用户
USER_FILE="users.txt"

while IFS=: read -r username password group; do
    # 创建用户
    useradd -m -g "$group" "$username"
    
    # 设置密码
    echo "$username:$password" | chpasswd
    
    # 设置过期时间
    chage -E 2026-12-31 "$username"
    
    echo "创建用户：$username"
done < "$USER_FILE"
```

**用户审计**：
```bash
#!/bin/bash
# 用户审计报告
echo "=== 用户审计报告 ==="
echo "生成时间：$(date)"
echo

# 最后登录用户
echo "【最近登录用户】"
last | head -10
echo

# 空密码用户
echo "【空密码用户】"
awk -F: '($2 == "") {print $1}' /etc/shadow
echo

# sudo 用户
echo "【sudo 用户】"
grep sudo /etc/group
```

---

### 部署脚本

**应用部署**：
```bash
#!/bin/bash
# 自动化部署脚本
APP_NAME="myapp"
APP_DIR="/opt/$APP_NAME"
BACKUP_DIR="/backup/$APP_NAME"
DATE=$(date +%Y%m%d_%H%M%S)

# 停止服务
systemctl stop "$APP_NAME"

# 备份当前版本
if [ -d "$APP_DIR" ]; then
    mv "$APP_DIR" "$BACKUP_DIR/$DATE"
fi

# 部署新版本
mkdir -p "$APP_DIR"
tar -xzf new_version.tar.gz -C "$APP_DIR"

# 启动服务
systemctl start "$APP_NAME"

# 健康检查
sleep 5
if systemctl is-active --quiet "$APP_NAME"; then
    echo "部署成功"
else
    echo "部署失败，回滚..."
    systemctl stop "$APP_NAME"
    rm -rf "$APP_DIR"
    mv "$BACKUP_DIR/$DATE" "$APP_DIR"
    systemctl start "$APP_NAME"
    exit 1
fi
```

---

### Docker 和 CI/CD

**Docker 容器管理**：
```bash
#!/bin/bash
# Docker 容器清理
echo "=== Docker 清理 ==="

# 停止所有容器
docker stop $(docker ps -aq)

# 删除所有容器
docker rm $(docker ps -aq)

# 删除所有镜像
docker rmi $(docker images -q)

# 删除悬空镜像
docker image prune -f

echo "清理完成"
```

**CI/CD 脚本**：
```bash
#!/bin/bash
# Jenkins 部署脚本
set -e

echo "=== CI/CD 部署 ==="

# 拉取代码
git pull origin main

# 安装依赖
npm install

# 运行测试
npm test

# 构建
npm run build

# 部署
pm2 restart myapp

echo "部署完成"
```

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. 备份未验证

**错误**：
```bash
tar -czf backup.tar.gz /data  # ❌ 未验证备份是否成功
```

**正确**：
```bash
tar -czf backup.tar.gz /data
if [ $? -eq 0 ] && [ -f backup.tar.gz ]; then  # ✅ 验证
    echo "备份成功"
    tar -tzf backup.tar.gz > /dev/null  # 验证完整性
else
    echo "备份失败"
    exit 1
fi
```

---

### 2. 监控脚本无日志

**错误**：
```bash
#!/bin/bash
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
if [ $cpu -gt 80 ]; then
    echo "CPU 过高"  # ❌ 只输出到终端
fi
```

**正确**：
```bash
#!/bin/bash
LOG_FILE="/var/log/monitor.log"
cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
if [ $cpu -gt 80 ]; then
    echo "$(date): CPU 过高 ($cpu%)" >> "$LOG_FILE"  # ✅ 记录日志
    echo "CPU 过高" | mail -s "告警" admin@example.com
fi
```

---

### 3. 部署无回滚

**错误**：
```bash
rm -rf /opt/app  # ❌ 直接删除，无法回滚
cp -r new_app /opt/app
```

**正确**：
```bash
# ✅ 先备份
mv /opt/app /backup/app_$(date +%Y%m%d_%H%M%S)
# 再部署
cp -r new_app /opt/app
# 失败时回滚
```

---

### 4. 日志分析未处理大文件

**错误**：
```bash
cat /var/log/large.log | grep "error"  # ❌ 大文件会内存溢出
```

**正确**：
```bash
grep "error" /var/log/large.log  # ✅ grep 直接读取
# 或
tail -10000 /var/log/large.log | grep "error"  # ✅ 只看最近
```

---

### 5. Docker 未清理资源

**错误**：
```bash
docker run app  # ❌ 容器停止后残留
```

**正确**：
```bash
docker run --rm app  # ✅ 自动删除
# 或定期清理
docker container prune -f
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: 如何选择备份策略？

**建议**：
```bash
# 完整备份（每周）
tar -czf full_backup.tar.gz /data

# 增量备份（每天）
tar -czf增量_backup.tar.gz -N "last_backup_date" /data

# 差异备份（每天）
tar -czf diff_backup.tar.gz --newer-mtime "last_full_backup" /data
```

**3-2-1 原则**：
- 3 份副本
- 2 种介质
- 1 份异地

---

### Q2: 监控脚本如何避免重复运行？

**方法**：
```bash
#!/bin/bash
LOCK_FILE="/var/run/monitor.lock"

if [ -f "$LOCK_FILE" ]; then
    echo "已在运行"
    exit 1
fi

touch "$LOCK_FILE"
trap "rm -f $LOCK_FILE" EXIT

# 监控逻辑
```

---

### Q3: 日志轮转如何实现？

**方法**：
```bash
#!/bin/bash
LOG_FILE="/var/log/app.log"
MAX_SIZE=10485760  # 10MB

if [ $(stat -c%s "$LOG_FILE") -gt $MAX_SIZE ]; then
    mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d)"
    touch "$LOG_FILE"
    # 通知应用重新打开日志
    kill -HUP $(cat /var/run/app.pid)
fi
```

---

### Q4: 部署脚本如何保证原子性？

**方法**：
```bash
#!/bin/bash
# 符号链接切换（原子操作）
CURRENT="/opt/app/current"
NEW_VERSION="/opt/app/v1.2.3"

# 部署到新版本目录
# ...

# 原子切换
ln -sfn "$NEW_VERSION" "$CURRENT"

# 重启服务
systemctl restart app
```

---

### Q5: 如何调试生产脚本？

**方法**：
```bash
# 1. 添加日志
exec > >(tee -a /var/log/script.log) 2>&1

# 2. 开启调试
set -x

# 3. 保留现场
trap 'echo "错误发生在 $LINENO"; exit 1' ERR

# 4. 测试环境先验证
bash -n script.sh  # 语法检查
bash -x script.sh  # 调试运行
```

---

## 🏆 毕业项目

完成以下项目作为毕业考核：

### 项目 1：综合监控系统（第 85 天）

**要求**：
- 监控 CPU、内存、磁盘、网络
- 超过阈值发送邮件告警
- 记录历史数据
- Web 界面展示（可选）

**交付**：
- 监控脚本
- 配置文件
- 使用文档

---

### 项目 2：自动化备份系统（第 87 天）

**要求**：
- 定时备份文件和数据库
- 备份轮转（保留 7 天）
- 备份验证
- 恢复测试

**交付**：
- 备份脚本
- Cron 配置
- 恢复流程文档

---

### 项目 3：CI/CD 流水线（第 90 天）

**要求**：
- Git 提交触发构建
- 自动运行测试
- 自动部署到测试环境
- 手动部署到生产环境

**交付**：
- Jenkins/GitLab CI 配置
- 部署脚本
- 流程图

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 编写系统监控脚本
- [ ] 实现自动化备份
- [ ] 分析日志文件
- [ ] 管理用户和权限
- [ ] 部署应用程序
- [ ] 使用 Docker 容器
- [ ] 配置 CI/CD 流水线
- [ ] 排查系统故障
- [ ] 编写可复用的函数库
- [ ] 避免常见陷阱

---

## 🎓 下一步

恭喜你完成 Shell 编程完全教程！🎉

**继续提升**：
- 📚 学习 Python 进行更复杂的自动化
- 🐳 深入学习 Docker 和 Kubernetes
- ☁️ 学习云平台（AWS/Azure/阿里云）
- 🔧 学习配置管理工具（Ansible/Puppet）
- 📊 学习监控工具（Prometheus/Grafana）

---

## 💡 小贴士

1. **生产脚本先测试** - 在测试环境充分测试
2. **添加日志** - 所有重要操作记录日志
3. **错误处理** - 用 `set -e` 和 `trap` 处理错误
4. **备份验证** - 定期测试备份恢复
5. **文档齐全** - 脚本和使用文档都要有
6. **版本控制** - 用 Git 管理脚本版本
7. **代码审查** - 重要脚本让同事审查
8. **持续改进** - 根据反馈优化脚本

---

## 📚 参考资源

- [Linux 运维实战](https://www.linux.org/)
- [Docker 文档](https://docs.docker.com/)
- [Jenkins 文档](https://www.jenkins.io/doc/)
- [快速参考手册](../SHELL_GUIDE_BASE.md)
- [完整学习指南](../SHELL_GUIDE.md)

---

**祝你成为 Shell 编程高手！** 🚀

[查看项目清单](#-项目清单) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)

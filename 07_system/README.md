# 🖥️ 系统管理 (System Administration)

> 学习系统管理脚本：信息收集、用户管理、服务监控

**难度**: ⭐⭐⭐⭐  
**脚本数**: 1 个  
**建议学时**: 1 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_system_info.sh](./01_system_info.sh) | ⭐⭐⭐⭐ | 系统信息收集 | 125 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 收集系统基本信息
- ✅ 查看硬件配置
- ✅ 监控系统资源
- ✅ 生成系统报告
- ✅ 整合多个命令输出

---

## 📚 知识点

### 1. 系统信息命令

```bash
# 操作系统信息
uname -a              # 所有信息
uname -r              # 内核版本
uname -m              # 架构
cat /etc/os-release   # 发行版信息
hostnamectl           # 主机信息

# 运行时间
uptime                # 运行时间和负载
who -b                # 系统启动时间

# CPU 信息
lscpu                 # CPU 详细信息
cat /proc/cpuinfo     # CPU 原始信息
nproc                 # 核心数

# 内存信息
free -h               # 内存使用
cat /proc/meminfo     # 内存详细信息

# 磁盘信息
df -h                 # 磁盘空间
lsblk                 # 块设备
fdisk -l              # 分区表

# 网络信息
ip addr               # IP 地址
ip route              # 路由表
ss -tulpn             # 监听端口
```

### 2. 格式化输出

```bash
# 使用 column 对齐
ps aux | column -t

# 使用 printf 格式化
printf "%-20s %10s\n" "项目" "值"

# 使用 column 显示 CSV
cat data.csv | column -t -s,
```

### 3. 信息收集技巧

```bash
# 捕获命令输出
os_version=$(uname -r)

# 条件执行
command -v docker && echo "Docker 已安装" || echo "Docker 未安装"

# 错误处理
result=$(some_command 2>&1) || echo "命令失败：$result"
```

---

## 💻 示例代码

### 完整示例：系统信息检查

```bash
#!/bin/bash
# 文件名：01_system_info.sh
# 功能：收集并显示系统信息
# 难度：⭐⭐⭐⭐

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印标题
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}       $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# 打印项目
print_item() {
    printf "${GREEN}%-20s${NC} %s\n" "$1:" "$2"
}

# 主函数
main() {
    clear
    print_header "系统信息检查报告"
    
    # 系统基本信息
    print_header "系统基本信息"
    print_item "操作系统" "$(uname -s)"
    print_item "内核版本" "$(uname -r)"
    print_item "系统架构" "$(uname -m)"
    print_item "主机名称" "$(hostname)"
    print_item "发行版" "$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
    
    # 运行时间
    print_header "系统运行时间"
    print_item "运行时间" "$(uptime -p)"
    print_item "负载" "$(uptime | awk -F'load average:' '{print $2}')"
    
    # CPU 信息
    print_header "CPU 信息"
    print_item "CPU 核心数" "$(nproc)"
    print_item "CPU 型号" "$(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
    
    # 内存信息
    print_header "内存使用情况"
    free -h | grep -E "Mem|Swap"
    
    # 磁盘信息
    print_header "磁盘使用情况"
    df -h | grep -E "Filesystem|/dev/"
    
    # 网络信息
    print_header "网络接口"
    ip -br addr show | grep -v lo
    
    print_header "检查完成"
}

# 执行
main
```

**运行**:
```bash
chmod +x 01_system_info.sh
./01_system_info.sh
```

**输出**:
```
========================================
       系统信息检查报告
========================================

========================================
       系统基本信息
========================================
操作系统：           Linux
内核版本：           5.4.0-42-generic
系统架构：           x86_64
主机名称：           web-server-01
发行版：             Ubuntu 20.04.2 LTS

========================================
       系统运行时间
========================================
运行时间：           up 30 days, 2:15
负载：                0.52, 0.48, 0.44

========================================
       CPU 信息
========================================
CPU 核心数：           8
CPU 型号：            Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz

========================================
       内存使用情况
========================================
              total        used        free
Mem:           15Gi       8.2Gi       4.1Gi
Swap:         2.0Gi          0B       2.0Gi

========================================
       磁盘使用情况
========================================
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   28G   20G  59% /
/dev/sdb1       500G  120G  380G  24% /data

========================================
       网络接口
========================================
eth0             UP    192.168.1.100/24

========================================
       检查完成
========================================
```

---

## 🔧 练习任务

### 任务 1: 服务状态检查

创建一个脚本，检查关键服务状态：

**参考**:
```bash
#!/bin/bash
services=("sshd" "nginx" "mysql" "docker")

echo "=== 服务状态检查 ==="
for service in "${services[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "✓ $service - 运行中"
    else
        echo "✗ $service - 已停止"
    fi
done
```

### 任务 2: 磁盘空间告警

创建一个脚本，监控磁盘空间：

**参考**:
```bash
#!/bin/bash
threshold=80

echo "=== 磁盘空间检查 ==="
df -h | grep -E "Filesystem|/dev/" | while read line; do
    usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
    if [ "$usage" -gt "$threshold" ] 2>/dev/null; then
        echo "⚠️  警告：$line (使用率：${usage}%)"
    else
        echo "✓ $line"
    fi
done
```

---

## 📝 最佳实践

### 1. 使用函数组织代码

```bash
✅ check_cpu() {
       # CPU 检查逻辑
   }
   
   check_memory() {
       # 内存检查逻辑
   }
   
   main() {
       check_cpu
       check_memory
   }

❌ # 所有代码写在一起
```

### 2. 添加颜色输出

```bash
✅ RED='\033[0;31m'
   GREEN='\033[0;32m'
   echo -e "${GREEN}成功${NC}"

❌ echo "成功"  # 单调
```

### 3. 错误处理

```bash
✅ result=$(command 2>&1) || {
       echo "错误：$result"
       exit 1
   }

❌ command  # 可能失败但继续执行
```

### 4. 使用有意义的变量名

```bash
✅ disk_usage_threshold=80

❌ threshold=80  # 不够明确
```

---

## 📖 扩展阅读

- [Linux 系统监控命令](https://www.tecmint.com/linux-system-performance-monitoring-tools/)
- [Bash 脚本最佳实践](https://google.github.io/styleguide/shellguide.html)
- [系统管理脚本集合](https://github.com/awesome-linux/awesome-linux)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **08_practice/** - 综合练习
2. **09_devops/** - DevOps 实战应用

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

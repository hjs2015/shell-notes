# 📖 Shell 编程快速参考

> **226 个脚本实战提炼** | 常用命令、语法和技巧速查表

---

## 📋 目录

- [脚本标准结构](#脚本标准结构) 🆕
- [基础语法](#基础语法)
- [变量操作](#变量操作)
- [运算符](#运算符)
- [条件判断](#条件判断)
- [循环结构](#循环结构)
- [函数](#函数)
- [文件操作](#文件操作)
- [文本处理](#文本处理)
- [系统命令](#系统命令)
- [调试技巧](#调试技巧)
- [实战模式](#实战模式) 🆕

---

## 📜 脚本标准结构 🆕

### 完整模板

```bash
#!/bin/bash
# =============================================================================
# 脚本名称：script_name.sh
# 功能描述：一句话说明脚本功能
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - 知识点 1
#   - 知识点 2
# 使用方法：
#   chmod +x script_name.sh
#   ./script_name.sh
# =============================================================================

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'  # No Color

# 辅助函数
print_color() {
    echo -e "${!1}${2}${NC}"
}

print_separator() {
    echo "========================================"
}

# 主逻辑
print_separator
print_color CYAN "脚本名称"
print_separator

# 业务代码...

print_color GREEN "完成！"
```

### 头部注释规范

```bash
# =============================================================================
# 脚本名称：backup_files.sh
# 功能描述：自动备份指定目录到备份位置
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - 变量定义与使用
#   - 条件判断
#   - 文件操作
# 使用方法：
#   chmod +x backup_files.sh
#   ./backup_files.sh
# =============================================================================
```

---

## 🔤 基础语法

### Shebang

```bash
#!/bin/bash          # 使用 bash
#!/bin/sh            # 使用 sh
#!/usr/bin/env bash  # 使用环境变量中的 bash（推荐）
```

### 执行脚本

```bash
chmod +x script.sh   # 添加执行权限
./script.sh          # 执行脚本
bash script.sh       # 使用 bash 执行
source script.sh     # 在当前 shell 执行
. script.sh          # source 的简写
```

### 注释

```bash
# 单行注释

: '
多行注释
多行注释
'

<< 'EOF'
多行注释
多行注释
EOF
```

---

## 📦 变量操作

### 定义变量

```bash
name="John"          # 字符串
age=25               # 数字
pi=3.14              # 浮点数
is_valid=true        # 布尔值
```

### 使用变量

```bash
echo $name           # John
echo ${name}         # John（推荐）
echo "${name}"       # John（推荐，避免空格问题）
```

### 特殊变量

| 变量 | 说明 | 示例 |
|------|------|------|
| `$0` | 脚本名 | `./script.sh` |
| `$1` ~ `$9` | 位置参数 | `./script.sh arg1 arg2` |
| `$#` | 参数个数 | `2` |
| `$@` | 所有参数 | `arg1 arg2` |
| `$*` | 所有参数（单个字符串） | `arg1 arg2` |
| `$?` | 上个命令返回值 | `0` 表示成功 |
| `$$` | 当前进程 ID | `12345` |
| `$!` | 后台进程 ID | `12346` |
| `$RANDOM` | 随机数 | `0-32767` |
| `$HOME` | 用户家目录 | `/home/user` |
| `$PWD` | 当前目录 | `/home/user/project` |

### 字符串操作

```bash
str="Hello World"

# 长度
echo ${#str}              # 11

# 截取
echo ${str:0:5}           # Hello
echo ${str:6}             # World

# 替换
echo ${str/World/Earth}   # Hello Earth
echo ${str//o/0}          # H0ll0 W0rld

# 删除
echo ${str#H*}            # ello World（删除最短匹配）
echo ${str##H*}           # d（删除最长匹配）
echo ${str%W*}            # Hello（从后删除最短匹配）
echo ${str%%W*}           # Hello（从后删除最长匹配）
```

### 数组

```bash
# 定义数组
arr=(apple banana cherry)
arr[0]="apple"
arr[1]="banana"

# 访问元素
echo ${arr[0]}            # apple
echo ${arr[@]}            # apple banana cherry（所有元素）
echo ${#arr[@]}           # 3（数组长度）
echo ${!arr[@]}           # 0 1 2（所有索引）
```

---

## ➕ 运算符

### 算术运算

```bash
# 方法 1: $[]
a=10
b=3
echo $[a + b]             # 13
echo $[a - b]             # 7
echo $[a * b]             # 30
echo $[a / b]             # 3
echo $[a % b]             # 1

# 方法 2: $(())
echo $((a + b))           # 13

# 方法 3: let
let c=a+b
echo $c                   # 13

# 方法 4: expr
echo `expr $a + $b`       # 13
```

### 逻辑运算

```bash
# AND (与)
[ condition1 ] && [ condition2 ]
condition1 && condition2

# OR (或)
[ condition1 ] || [ condition2 ]
condition1 || condition2

# NOT (非)
! [ condition ]
[ ! condition ]
```

---

## 🔍 条件判断

### if 语句

```bash
# 基本格式
if [ condition ]; then
    command
elif [ condition ]; then
    command
else
    command
fi

# 示例
if [ $age -ge 18 ]; then
    echo "成年人"
else
    echo "未成年人"
fi
```

### 文件测试

| 操作符 | 说明 |
|--------|------|
| `[ -f file ]` | 文件存在且是普通文件 |
| `[ -d file ]` | 文件存在且是目录 |
| `[ -e file ]` | 文件存在 |
| `[ -r file ]` | 文件可读 |
| `[ -w file ]` | 文件可写 |
| `[ -x file ]` | 文件可执行 |
| `[ -s file ]` | 文件存在且大小大于 0 |
| `[ -L file ]` | 文件是符号链接 |

### 字符串比较

| 操作符 | 说明 |
|--------|------|
| `[ "$a" = "$b" ]` | 相等 |
| `[ "$a" != "$b" ]` | 不相等 |
| `[ -z "$str" ]` | 字符串为空 |
| `[ -n "$str" ]` | 字符串非空 |

### 数字比较

| 操作符 | 说明 |
|--------|------|
| `[ $a -eq $b ]` | 相等 (equal) |
| `[ $a -ne $b ]` | 不相等 (not equal) |
| `[ $a -gt $b ]` | 大于 (greater than) |
| `[ $a -ge $b ]` | 大于等于 |
| `[ $a -lt $b ]` | 小于 (less than) |
| `[ $a -le $b ]` | 小于等于 |

### case 语句

```bash
case $variable in
    pattern1)
        command
        ;;
    pattern2)
        command
        ;;
    *)
        # 默认
        command
        ;;
esac

# 示例
case $day in
    Mon|Tue|Wed|Thu|Fri)
        echo "工作日"
        ;;
    Sat|Sun)
        echo "周末"
        ;;
    *)
        echo "无效输入"
        ;;
esac
```

---

## 🔄 循环结构

### for 循环

```bash
# 遍历列表
for item in apple banana cherry; do
    echo $item
done

# 使用范围
for i in {1..5}; do
    echo $i
done

# 使用 seq
for i in $(seq 1 10); do
    echo $i
done

# C 语言风格
for ((i=0; i<5; i++)); do
    echo $i
done

# 遍历文件
for file in *.txt; do
    echo $file
done
```

### while 循环

```bash
# 基本格式
while [ condition ]; do
    command
done

# 示例
count=1
while [ $count -le 5 ]; do
    echo $count
    ((count++))
done

# 读取文件
while read line; do
    echo $line
done < file.txt

# 无限循环
while true; do
    command
    sleep 1
done
```

### until 循环

```bash
# 条件为假时执行
until [ condition ]; do
    command
done

# 示例
count=1
until [ $count -gt 5 ]; do
    echo $count
    ((count++))
done
```

### 循环控制

```bash
break      # 退出循环
continue   # 跳过本次循环
exit N     # 退出脚本，返回状态码 N
```

---

## 📐 函数

### 定义函数

```bash
# 方法 1
function_name() {
    command
}

# 方法 2
function function_name {
    command
}
```

### 调用函数

```bash
function_name           # 调用
function_name arg1 arg2 # 带参数
```

### 函数参数

```bash
my_function() {
    echo "第一个参数：$1"
    echo "第二个参数：$2"
    echo "所有参数：$@"
    echo "参数个数：\`$#\`"
}

my_function hello world
```

### 返回值

```bash
my_function() {
    return 0      # 返回状态码（0-255）
}

my_function() {
    echo "result" # 返回字符串（通过 stdout）
}

# 获取返回值
result=$(my_function)
status=$?
```

### 局部变量

```bash
my_function() {
    local var="local value"
    echo $var
}
```

---

## 📁 文件操作

### 创建/删除

```bash
touch file.txt          # 创建空文件
mkdir directory         # 创建目录
mkdir -p a/b/c          # 递归创建目录
rm file.txt             # 删除文件
rm -r directory         # 递归删除目录
rm -f file.txt          # 强制删除
```

### 复制/移动

```bash
cp file1 file2          # 复制文件
cp -r dir1 dir2         # 复制目录
mv file1 file2          # 移动/重命名
```

### 读取文件

```bash
cat file.txt            # 显示全部内容
head -n 10 file.txt     # 显示前 10 行
tail -n 10 file.txt     # 显示后 10 行
less file.txt           # 分页查看
more file.txt           # 分页查看
```

### 文件重定向

```bash
command > file.txt      # 覆盖输出
command >> file.txt     # 追加输出
command < file.txt      # 从文件输入
command 2> error.log    # 错误输出
command > out 2>&1      # 所有输出
command &> all.log      # 所有输出（bash 4+）
```

---

## 📝 文本处理

### grep

```bash
grep "pattern" file.txt         # 搜索
grep -i "pattern" file.txt      # 忽略大小写
grep -r "pattern" dir/          # 递归搜索
grep -v "pattern" file.txt      # 反向匹配
grep -n "pattern" file.txt      # 显示行号
grep -c "pattern" file.txt      # 计数
```

### awk

```bash
# 提取字段
awk -F: '{print $1}' /etc/passwd

# 条件过滤
awk -F: '$3 > 1000 {print $1}' /etc/passwd

# 计算
awk '{sum+=$1} END {print sum}' numbers.txt

# 内置变量
NF    # 字段数
NR    # 行号
FS    # 输入字段分隔符
OFS   # 输出字段分隔符
```

### sed

```bash
# 替换
sed 's/old/new/' file.txt           # 替换第一个
sed 's/old/new/g' file.txt          # 替换全部

# 删除
sed '2d' file.txt                   # 删除第 2 行
sed '2,5d' file.txt                 # 删除 2-5 行

# 插入
sed '2i\new line' file.txt          # 在第 2 行前插入
sed '2a\new line' file.txt          # 在第 2 行后插入
```

### cut

```bash
cut -d: -f1 /etc/passwd             # 以:分隔，取第 1 列
cut -c1-5 file.txt                  # 取 1-5 字符
```

### sort

```bash
sort file.txt                       # 排序
sort -r file.txt                    # 降序
sort -n file.txt                    # 数字排序
sort -u file.txt                    # 去重
```

### uniq

```bash
uniq file.txt                       # 去重（需先排序）
uniq -c file.txt                    # 计数
uniq -d file.txt                    # 只显示重复的
```

---

## 🖥️ 系统命令

### 进程管理

```bash
ps aux                  # 显示所有进程
top                     # 实时进程监控
htop                    # 增强版 top
kill PID                # 终止进程
kill -9 PID             # 强制终止
pkill name              # 按名称终止进程
```

### 磁盘管理

```bash
df -h                   # 磁盘空间
du -sh directory        # 目录大小
ls -lh                  # 文件列表（人类可读）
```

### 网络

```bash
ping host               # 测试连通性
ifconfig                # 网络接口
ip addr                 # IP 地址（新版）
netstat -tulpn          # 网络连接
ss -tulpn               # 网络连接（新版）
curl URL                # HTTP 请求
wget URL                # 下载文件
```

### 系统信息

```bash
uname -a                # 系统信息
hostname                # 主机名
whoami                  # 当前用户
uptime                  # 运行时间
free -h                 # 内存使用
```

---

## 🐛 调试技巧

### 调试选项

```bash
bash -n script.sh       # 语法检查
bash -x script.sh       # 跟踪执行
bash -v script.sh       # 显示输入
```

### 脚本内调试

```bash
#!/bin/bash
set -x      # 开启调试
# 代码...
set +x      # 关闭调试

set -e      # 遇到错误立即退出
set -u      # 使用未定义变量时报错
set -o pipefail  # 管道中任何命令失败则整个管道失败
```

### 日志输出

```bash
# 输出到 stderr
echo "Error message" >&2

# 带时间戳
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Message"

# 颜色输出
echo -e "\033[31m红色\033[0m"
echo -e "\033[32m绿色\033[0m"
echo -e "\033[33m黄色\033[0m"
```

---

## 🎯 实战模式 🆕

### 1. 颜色输出模式

```bash
#!/bin/bash
# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'  # No Color

# 辅助函数
print_color() {
    echo -e "${!1}${2}${NC}"
}

print_separator() {
    echo "========================================"
}

# 使用示例
print_separator
print_color CYAN "标题"
print_separator
print_color GREEN "成功消息"
print_color RED "错误消息"
print_color YELLOW "警告消息"
```

### 2. 错误处理模式

```bash
#!/bin/bash
set -e  # 遇到错误立即退出
set -u  # 使用未定义变量时报错
set -o pipefail  # 管道中任何命令失败则整个管道失败

# 错误处理函数
error_exit() {
    echo -e "\033[31m错误：$1\033[0m" >&2
    exit 1
}

# 使用示例
command || error_exit "命令执行失败"
[ -f file.txt ] || error_exit "文件不存在"
```

### 3. 参数验证模式

```bash
#!/bin/bash

# 检查参数个数
if [ $# -lt 1 ]; then
    echo "用法：$0 <参数>"
    exit 1
fi

# 检查文件是否存在
if [ ! -f "$1" ]; then
    echo "错误：文件 '$1' 不存在"
    exit 1
fi

# 检查是否为目录
if [ ! -d "$1" ]; then
    echo "错误：'$1' 不是目录"
    exit 1
fi
```

### 4. 交互式输入模式

```bash
#!/bin/bash

# 基本输入
read -p "请输入用户名：" username
echo "你好，$username"

# 带默认值
read -p "请输入端口 [8080]: " port
port=${port:-8080}  # 如果为空，使用默认值

# 隐藏输入（密码）
read -sp "请输入密码：" password
echo

# 限时输入
read -t 10 -p "10 秒内输入：" input
```

### 5. 网络检查模式

```bash
#!/bin/bash

# Ping 检查
ping_check() {
    if ping -c 1 $1 &> /dev/null; then
        echo "$1 可达"
        return 0
    else
        echo "$1 不可达"
        return 1
    fi
}

# 端口检查
port_check() {
    if nc -z $1 $2 &> /dev/null; then
        echo "$1:$2 端口开放"
        return 0
    else
        echo "$1:$2 端口关闭"
        return 1
    fi
}

# URL 检查
url_check() {
    if curl -s --head "$1" | head -n 1 | grep -q "200"; then
        echo "$1 可访问"
        return 0
    else
        echo "$1 不可访问"
        return 1
    fi
}
```

### 6. 备份模式

```bash
#!/bin/bash

# 变量定义
SOURCE="/path/to/source"
DEST="/path/to/backup"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${DATE}.tar.gz"

# 创建备份目录
mkdir -p $DEST

# 执行备份
tar -czf $DEST/$BACKUP_NAME $SOURCE

# 验证备份
if [ -f $DEST/$BACKUP_NAME ]; then
    echo "备份成功：$DEST/$BACKUP_NAME"
else
    echo "备份失败"
    exit 1
fi
```

### 7. 日志记录模式

```bash
#!/bin/bash

# 日志文件
LOG_FILE="/var/log/script.log"

# 日志函数
log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1" | tee -a $LOG_FILE
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1" | tee -a $LOG_FILE >&2
}

log_warn() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARN] $1" | tee -a $LOG_FILE
}

# 使用示例
log_info "脚本开始执行"
log_info "处理中..."
log_warn "这是一个警告"
log_error "发生错误"
log_info "脚本执行完成"
```

### 8. 性能监控模式

```bash
#!/bin/bash

echo "=== CPU 使用率 ==="
top -bn1 | head -3

echo -e "\n=== 内存使用 ==="
free -h

echo -e "\n=== 磁盘使用 ==="
df -h /

echo -e "\n=== 进程 Top5 ==="
ps aux --sort=-%mem | head -6
```

---

## 📚 更多资源

- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)
- [本仓库 226 个脚本示例](https://github.com/hjs2015/shell-notes)

---

**最后更新**: 2026-03-21  
**基于**: 226 个实战脚本提炼  
**仓库**: https://github.com/hjs2015/shell-notes

[返回顶部](#-shell-编程快速参考)

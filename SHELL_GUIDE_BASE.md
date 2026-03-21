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

### 9. 系统检查模式

```bash
#!/bin/bash
# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo "错误：$1 未安装"
        exit 1
    fi
}

# 检查磁盘空间
check_disk() {
    local usage=$(df $1 | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ $usage -gt 90 ]; then
        echo "警告：$1 磁盘使用率超过 90%"
        return 1
    fi
}

# 检查服务状态
check_service() {
    if systemctl is-active --quiet $1; then
        echo "$1 服务运行正常"
    else
        echo "$1 服务未运行"
        return 1
    fi
}

# 使用示例
check_command docker
check_command kubectl
check_disk /
check_service nginx
```

### 10. 批量处理模式

```bash
#!/bin/bash
# 批量重命名文件
for file in *.txt; do
    mv "$file" "backup_${file}"
done

# 批量修改权限
find ./scripts -name "*.sh" -exec chmod +x {} \;

# 批量创建目录
for i in {1..10}; do
    mkdir -p "project_$i"
done

# 批量删除空目录
find . -type d -empty -delete
```

### 11. 字符串处理模式

```bash
#!/bin/bash
str="Hello-World-2026"

# 截取
echo ${str:0:5}      # Hello（前 5 个字符）
echo ${str:6:5}      # World（从 6 开始 5 个字符）
echo ${str: -4}      # 2026（最后 4 个字符）

# 替换
echo ${str/-/ }      # Hello World-2026（替换第一个）
echo ${str//-/ }     # Hello World 2026（替换全部）

# 删除
echo ${str#*-}       # World-2026（删除最短前缀）
echo ${str##*-}      # 2026（删除最长前缀）
echo ${str%-*}       # Hello-World（删除最短后缀）
echo ${str%%-*}      # Hello（删除最长后缀）

# 大小写转换
echo ${str^^}        # HELLO-WORLD-2026（转大写）
echo ${str,,}        # hello-world-2026（转小写）

# 长度
echo ${#str}         # 16（字符串长度）
```

### 12. 数组操作模式

```bash
#!/bin/bash
# 定义数组
arr=(apple banana cherry)
arr2=([0]="red" [1]="green" [2]="yellow")

# 读取元素
echo ${arr[0]}       # apple
echo ${arr[@]}       # apple banana cherry（所有元素）
echo ${#arr[@]}      # 3（数组长度）
echo ${!arr[@]}      # 0 1 2（所有索引）

# 添加元素
arr+=(date)          # 末尾添加
arr[10]="elderberry" # 指定位置添加

# 删除元素
unset arr[1]         # 删除索引 1 的元素

# 遍历数组
for fruit in "${arr[@]}"; do
    echo "水果：$fruit"
done

# 数组切片
echo ${arr[@]:1:2}   # banana cherry（从 1 开始 2 个）
```

### 13. 数学计算模式

```bash
#!/bin/bash
# 整数运算
a=10; b=3
echo $((a + b))      # 13
echo $((a - b))      # 7
echo $((a * b))      # 30
echo $((a / b))      # 3
echo $((a % b))      # 1
echo $((a ** b))     # 1000（幂运算）

# 自增自减
((a++))              # a = 11
((b--))              # b = 2

# 比较运算
((a > b)) && echo "a 大于 b"

# 使用 expr
expr 10 + 5          # 15
expr 10 \* 5         # 50（* 需要转义）

# 使用 bc（支持小数）
echo "scale=2; 10 / 3" | bc    # 3.33
echo "sqrt(16)" | bc           # 4
```

### 14. 日期时间模式

```bash
#!/bin/bash
# 当前时间
date                   # 完整日期时间
date +%Y-%m-%d         # 2026-03-21
date +%H:%M:%S         # 10:30:45
date +%s               # 时间戳

# 格式化输出
date +"%Y 年%m 月%d 日 %H 时%M 分%S 秒"

# 计算时间
yesterday=$(date -d "yesterday" +%Y-%m-%d)
tomorrow=$(date -d "tomorrow" +%Y-%m-%d)
last_week=$(date -d "1 week ago" +%Y-%m-%d)
next_month=$(date -d "1 month" +%Y-%m-%d)

# 时间戳转换
timestamp=$(date +%s)
date -d @$timestamp    # 从时间戳转换回日期

# 计算时间差
start=$(date +%s)
# ... 执行操作 ...
end=$(date +%s)
echo "耗时：$((end - start)) 秒"
```

### 15. 配置文件读取模式

```bash
#!/bin/bash
# 读取 INI 风格配置
CONFIG_FILE="config.ini"

get_config() {
    local section=$1
    local key=$2
    awk -F= -v s="[$section]" -v k="$key" '
        $0 ~ s {in_section=1; next}
        /^\[/ {in_section=0}
        in_section && $1 == k {print $2}
    ' $CONFIG_FILE
}

# 使用示例
db_host=$(get_config "database" "host")
db_port=$(get_config "database" "port")

# 读取环境变量文件
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi
```

### 16. 并发执行模式

```bash
#!/bin/bash
# 后台执行
for i in {1..5}; do
    sleep 1 &
    echo "启动任务 $i"
done
wait  # 等待所有后台任务完成
echo "所有任务完成"

# 限制并发数
max_jobs=3
for i in {1..10}; do
    while [ $(jobs -r | wc -l) -ge $max_jobs ]; do
        sleep 0.1
    done
    (
        echo "任务 $i 开始"
        sleep 2
        echo "任务 $i 完成"
    ) &
done
wait

# 使用 xargs 并行
cat urls.txt | xargs -P 4 -I {} curl -O {}
```

### 17. 捕获信号模式

```bash
#!/bin/bash
# 清理函数
cleanup() {
    echo "正在清理..."
    rm -f /tmp/temp_*
    exit 0
}

# 捕获信号
trap cleanup SIGINT SIGTERM  # Ctrl+C 或 kill

# 忽略信号
trap '' SIGTSTP  # 忽略 Ctrl+Z

# 自定义处理
handle_signal() {
    echo "收到信号，保存状态..."
    # 保存状态代码
}
trap handle_signal USR1

# 主循环
while true; do
    echo "运行中..."
    sleep 5
done
```

### 18. 菜单交互模式

```bash
#!/bin/bash
show_menu() {
    echo "=========================="
    echo "       主菜单"
    echo "=========================="
    echo "1. 启动服务"
    echo "2. 停止服务"
    echo "3. 查看状态"
    echo "4. 退出"
    echo "=========================="
}

while true; do
    show_menu
    read -p "请选择 [1-4]: " choice
    case $choice in
        1) echo "启动服务...";;
        2) echo "停止服务...";;
        3) echo "查看状态...";;
        4) echo "退出"; exit 0;;
        *) echo "无效选择";;
    esac
done
```

---

## 📚 附录 A：Pure Bash Bible 精选 🆕

> **参考来源**: https://github.com/dylanaraps/pure-bash-bible  
> **作者**: dylanaraps (neofetch 作者)  
> **说明**: 以下是纯 Bash 内置功能实现，无需外部命令依赖，性能更优

### A.1 字符串处理

#### 去除首尾空白

```bash
trim_string() {
    # Usage: trim_string "   example   string    "
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

# 示例
$ trim_string "    Hello,  World    "
Hello,  World
```

#### 压缩所有空白

```bash
trim_all() {
    # Usage: trim_all "   example   string    "
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}

# 示例
$ trim_all "    Hello,    World    "
Hello, World
```

#### 正则匹配

```bash
regex() {
    # Usage: regex "string" "regex"
    [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

# 示例：验证十六进制颜色
$ regex "#FFFFFF" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
#FFFFFF

# 示例：验证邮箱
$ regex "user@example.com" '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
user@example.com
```

#### 字符串分割

```bash
split() {
   # Usage: split "string" "delimiter"
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

# 示例
$ split "apples,oranges,pears" ","
apples
oranges
pears

$ split "hello---world---my" "---"
hello
world
my
```

#### URL 编解码

```bash
# URL 编码
urlencode() {
    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9.~_-])
                printf '%s' "$_"
            ;;
            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

# URL 解码
urldecode() {
    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}

# 示例
$ urlencode "https://github.com/dylanaraps/pure-bash-bible"
https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible

$ urldecode "https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible"
https://github.com/dylanaraps/pure-bash-bible
```

### A.2 数组操作

#### 反转数组

```bash
reverse_array() {
    # Usage: reverse_array "array"
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

# 示例
$ reverse_array 1 2 3 4 5
5
4
3
2
1

$ arr=(red blue green)
$ reverse_array "${arr[@]}"
green
blue
red
```

#### 数组去重

```bash
remove_array_dups() {
    # Usage: remove_array_dups "array"
    declare -A tmp_array

    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done

    printf '%s\n' "${!tmp_array[@]}"
}

# 示例
$ remove_array_dups 1 1 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 5
1
2
3
4
5

$ arr=(red red green blue blue)
$ remove_array_dups "${arr[@]}"
red
green
blue
```

#### 随机数组元素

```bash
random_array_element() {
    # Usage: random_array_element "array"
    local arr=("$@")
    printf '%s\n' "${arr[RANDOM % $#]}"
}

# 示例
$ array=(red green blue yellow brown)
$ random_array_element "${array[@]}"
yellow
```

#### 循环遍历数组

```bash
arr=(a b c d)

cycle() {
    printf '%s ' "${arr[${i:=0}]}"
    ((i=i>=${#arr[@]}-1?0:++i))
}

# 每次调用打印下一个元素，到末尾后从头开始
$ cycle; cycle; cycle; cycle; cycle
a b c d a
```

### A.3 文件处理

#### 读文件到字符串

```bash
# 替代 cat 命令
file_data="$(<"file")"
```

#### 读文件到数组

```bash
# Bash 4+
mapfile -t file_data < "file"

# Bash <4 (保留空行)
while read -r line; do
    file_data+=("$line")
done < "file"
```

#### 获取前 N 行

```bash
head() {
    # Usage: head "n" "file"
    mapfile -tn "$1" line < "$2"
    printf '%s\n' "${line[@]}"
}

# 示例
$ head 2 ~/.bashrc
# Prompt
PS1='➜ '
```

#### 获取后 N 行

```bash
tail() {
    # Usage: tail "n" "file"
    mapfile -tn 0 line < "$2"
    printf '%s\n' "${line[@]: -$1}"
}

# 示例
$ tail 2 ~/.bashrc
# Enable tmux.
# [[ -z "$TMUX"  ]] && exec tmux
```

#### 统计行数

```bash
# Bash 4+
lines() {
    mapfile -tn 0 lines < "$1"
    printf '%s\n' "${#lines[@]}"
}

# Bash 3 (内存更优)
lines_loop() {
    count=0
    while IFS= read -r _; do
        ((count++))
    done < "$1"
    printf '%s\n' "$count"
}

# 示例
$ lines ~/.bashrc
48
```

#### 创建空文件

```bash
# 替代 touch 命令
>file
:>file
echo -n >file
printf '' >file
```

#### 提取标记间内容

```bash
extract() {
    # Usage: extract file "opening marker" "closing marker"
    while IFS=$'\n' read -r line; do
        [[ $extract && $line != "$3" ]] &&
            printf '%s\n' "$line"

        [[ $line == "$2" ]] && extract=1
        [[ $line == "$3" ]] && extract=
    done < "$1"
}

# 示例：提取 Markdown 代码块
$ extract ~/projects/pure-bash/README.md '```sh' '```'
```

### A.4 文件路径

#### 获取目录名

```bash
dirname() {
    # Usage: dirname "path"
    local tmp=${1:-.}

    [[ $tmp != *[!/]* ]] && {
        printf '/\n'
        return
    }

    tmp=${tmp%%"${tmp##*[!/]}"}

    [[ $tmp != */* ]] && {
        printf '.\n'
        return
    }

    tmp=${tmp%/*}
    tmp=${tmp%%"${tmp##*[!/]}"}

    printf '%s\n' "${tmp:-/}"
}

# 示例
$ dirname ~/Pictures/Wallpapers/1.jpg
/home/black/Pictures/Wallpapers

$ dirname ~/Pictures/Downloads/
/home/black/Pictures
```

#### 获取文件名

```bash
basename() {
    # Usage: basename "path" ["suffix"]
    local tmp

    tmp=${1%"${1##*[!/]}"}
    tmp=${tmp##*/}
    tmp=${tmp%"${2/"$tmp"}"}

    printf '%s\n' "${tmp:-/}"
}

# 示例
$ basename ~/Pictures/Wallpapers/1.jpg
1.jpg

$ basename ~/Pictures/Wallpapers/1.jpg .jpg
1

$ basename ~/Pictures/Downloads/
Downloads
```

### A.5 变量高级用法

#### 间接引用

```bash
# 方法 1：使用 ! 操作符
hello_world="value"
var="world"
ref="hello_$var"
printf '%s\n' "${!ref}"  # value

# 方法 2：使用 nameref (bash 4.3+)
hello_world="value"
var="world"
declare -n ref=hello_$var
printf '%s\n' "$ref"  # value
```

#### 动态命名变量

```bash
var="world"
declare "hello_$var=value"
printf '%s\n' "$hello_world"  # value
```

### A.6 颜色与格式

#### ANSI 转义码

```bash
# 文本颜色
echo -e "\e[38;5;196m 红色文字 \e[0m"      # 256 色
echo -e "\e[38;2;255;0;0m RGB 红色 \e[0m"  # RGB 真彩色

# 文本属性
echo -e "\e[1m 粗体 \e[0m"      # 粗体
echo -e "\e[3m 斜体 \e[0m"      # 斜体
echo -e "\e[4m 下划线 \e[0m"    # 下划线
echo -e "\e[5m 闪烁 \e[0m"      # 闪烁
echo -e "\e[7m 反色 \e[0m"      # 反色
echo -e "\e[9m 删除线 \e[0m"    # 删除线

# 光标移动
echo -e "\e[10;20H"             # 移动到第 10 行第 20 列
echo -e "\e[H"                  # 移动到首页 (0,0)
echo -e "\e[2A"                 # 上移 2 行
echo -e "\e[2B"                 # 下移 2 行
echo -e "\e[2C"                 # 右移 2 列
echo -e "\e[2D"                 # 左移 2 列

# 擦除
echo -e "\e[K"                  # 清除到行尾
echo -e "\e[2J"                 # 清屏
echo -e "\e[2J\e[H"             # 清屏并归位
```

### A.7 参数扩展速查

| 操作符 | 说明 | 示例 |
|--------|------|------|
| `${!VAR}` | 间接访问 | `${!ref}` |
| `${VAR#PATTERN}` | 删除最短开头匹配 | `${str#H*}` |
| `${VAR##PATTERN}` | 删除最长开头匹配 | `${str##H*}` |
| `${VAR%PATTERN}` | 删除最短结尾匹配 | `${str%W*}` |
| `${VAR%%PATTERN}` | 删除最长结尾匹配 | `${str%%W*}` |
| `${VAR/PATTERN/REPLACE}` | 替换第一个 | `${str/o/O}` |
| `${VAR//PATTERN/REPLACE}` | 替换所有 | `${str//o/O}` |
| `${#VAR}` | 字符串长度 | `${#str}` |
| `${#ARR[@]}` | 数组长度 | `${#arr[@]}` |
| `${VAR:OFFSET}` | 从 OFFSET 开始 | `${str:5}` |
| `${VAR:OFFSET:LENGTH}` | 子字符串 | `${str:0:5}` |
| `${VAR: -OFFSET}` | 最后 N 个字符 | `${str: -5}` |
| `${VAR^}` | 首字母大写 | `${str^}` |
| `${VAR^^}` | 全部大写 | `${str^^}` |
| `${VAR,}` | 首字母小写 | `${str,}` |
| `${VAR,,}` | 全部小写 | `${str,,}` |
| `${VAR:-STRING}` | 空则用 STRING | `${var:-default}` |
| `${VAR:=STRING}` | 空则设为 STRING | `${var:=default}` |
| `${VAR:+STRING}` | 非空则用 STRING | `${var:+present}` |
| `${VAR:?STRING}` | 空则报错 | `${var:?error}` |

### A.8 大括号扩展

```bash
# 数字范围
echo {1..100}              # 1 2 3 ... 100
echo {01..100}             # 001 002 ... 100 (补零)
echo {1..10..2}            # 1 3 5 7 9 (增量)

# 字母范围
echo {a..z}                # a b c ... z
echo {A..Z}                # A B C ... Z

# 嵌套
echo {A..Z}{0..9}          # A0 A1 ... Z9

# 字符串列表
echo {apples,oranges,pears}
rm -rf ~/Downloads/{Movies,Music,ISOS}
```

### A.9 算术与逻辑

#### 简化语法

```bash
# 简单计算
((var=1+2))

# 自增自减
((var++))
((var--))
((var+=1))
((var-=1))

# 使用变量
((var=var2*arr[2]))
```

#### 三元运算

```bash
# var = var2 > var ? var2 : var
((var=var2>var?var2:var))
```

### A.10 陷阱 (Traps)

```bash
# 退出时清理
trap 'printf \e[2J\e[H\e[m' EXIT

# 忽略中断 (Ctrl+C)
trap '' INT

# 窗口大小调整
trap 'redraw_ui' SIGWINCH

# 命令前执行
trap 'echo "即将执行: $BASH_COMMAND"' DEBUG

# 函数返回后
trap 'echo "函数完成"' RETURN
```

### A.11 内部变量

| 变量 | 说明 |
|------|------|
| `$BASH` | bash 二进制路径 |
| `$BASH_VERSION` | bash 版本字符串 |
| `${BASH_VERSINFO[@]}` | bash 版本数组 |
| `$HOSTNAME` | 主机名 |
| `$HOSTTYPE` | 系统架构 |
| `$OSTYPE` | 操作系统类型 |
| `$PWD` | 当前工作目录 |
| `$SECONDS` | 脚本运行秒数 |
| `$RANDOM` | 随机数 (0-32767) |
| `$FUNCNAME` | 当前函数名 |
| `$EDITOR` | 用户首选编辑器 |

### A.12 终端信息

#### 获取终端尺寸

```bash
get_term_size() {
    shopt -s checkwinsize; (:;:)
    printf '%s\n' "$LINES $COLUMNS"
}

# 示例
$ get_term_size
15 55
```

#### 获取光标位置

```bash
get_cursor_pos() {
    IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
    printf '%s\n' "$x $y"
}

# 示例
$ get_cursor_pos
1 8
```

### A.13 颜色转换

#### 十六进制转 RGB

```bash
hex_to_rgb() {
    # Usage: hex_to_rgb "#FFFFFF"
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

# 示例
$ hex_to_rgb "#FFFFFF"
255 255 255
```

#### RGB 转十六进制

```bash
rgb_to_hex() {
    # Usage: rgb_to_hex "r" "g" "b"
    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

# 示例
$ rgb_to_hex "255" "255" "255"
#FFFFFF
```

### A.14 代码高尔夫

#### 短 for 循环

```bash
# 极简风格
for((;i++<10;)){ echo "$i";}

# 未文档化方法
for i in {1..10};{ echo "$i";}
```

#### 无限循环

```bash
# 普通方法
while :; do echo hi; done

# 更短方法
for((;;)){ echo hi;}
```

#### 短函数声明

```bash
# 普通方法
f(){ echo hi;}

# 使用子 shell
f()(echo hi)

# 使用算术
f()(($1))

# 使用测试/循环
f()if true; then echo "$1"; fi
f()for i in "$@"; do echo "$i"; done
```

#### 短 if 语法

```bash
# 单行
[[ $var == hello ]] && echo hi || echo bye

# 多行 (无 else)
[[ $var == hello ]] && {
    echo hi
    # ...
}
```

#### case 设置变量

```bash
# 使用 : 避免重复 variable=
case "$OSTYPE" in
    "darwin"*)
        : "MacOS"
    ;;
    "linux"*)
        : "Linux"
    ;;
    *)
        printf '%s\n' "Unknown OS" >&2
        exit 1
    ;;
esac

os="$_"  # 最后设置变量
```

### A.15 其他技巧

#### 替代 sleep

```bash
# Bash 4+
read_sleep() {
    read -rt "$1" <> <(:) || :
}

# 示例
read_sleep 1
read_sleep 0.1
read_sleep 30
```

#### 检查命令是否存在

```bash
# 三种方法
type -p executable_name &>/dev/null
hash executable_name &>/dev/null
command -v executable_name &>/dev/null

# 示例
if type -p convert &>/dev/null; then
    echo "ImageMagick 已安装"
else
    echo "ImageMagick 未安装"
    exit 1
fi
```

#### 日期格式化 (Bash 4+)

```bash
date() {
    # Usage: date "format"
    printf "%($1)T\\n" "-1"
}

# 示例
$ date "%a %d %b - %l:%M %p"
Fri 15 Jun - 10:00 AM

# 直接使用 printf
printf '%(%Y-%m-%d %H:%M:%S)T\n' '-1'
```

#### UUID 生成

```bash
uuid() {
    C="89ab"
    for ((N=0;N<16;++N)); do
        B="$((RANDOM%256))"
        case "$N" in
            6)  printf '4%x' "$((B%16))" ;;
            8)  printf '%c%x' "${C:$RANDOM%${#C}:1}" "$((B%16))" ;;
            3|5|7|9)
                printf '%02x-' "$B"
            ;;
            *)
                printf '%02x' "$B"
            ;;
        esac
    done
    printf '\n'
}

# 示例
$ uuid
d5b6c731-1310-4c24-9fe3-55d556d44374
```

#### 进度条

```bash
bar() {
    # Usage: bar 1 10
    #            ^----- Elapsed Percentage (0-100)
    #               ^-- Total length in chars
    ((elapsed=$1*$2/100))
    printf -v prog  "%${elapsed}s"
    printf -v total "%$(($2-elapsed))s"
    printf '%s\r' "[${prog// /-}${total}]"
}

# 使用示例
for ((i=0;i<=100;i++)); do
    (:;:) && (:;:) && (:;:)  # 微睡眠
    bar "$i" "10"
done
printf '\n'
```

#### 获取函数列表

```bash
get_functions() {
    IFS=$'\n' read -d "" -ra functions < <(declare -F)
    printf '%s\n' "${functions[@]//declare -f }"
}
```

#### 绕过别名和函数

```bash
# 绕过别名
\ls  # 使用原始命令而非别名

# 绕过函数
command ls  # 使用原始命令而非函数
```

#### 后台运行

```bash
bkr() {
    (nohup "$@" &>/dev/null &)
}

# 示例
bkr ./some_script.sh  # 后台运行，忽略输出
```

---

## 📚 更多资源

- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)
- [Pure Bash Bible](https://github.com/dylanaraps/pure-bash-bible) ⭐ 27,000+
- [本仓库 231 个脚本示例](https://github.com/hjs2015/shell-notes)

---

**最后更新**: 2026-03-21  
**基于**: 231 个实战脚本提炼 + Pure Bash Bible 精选  
**仓库**: https://github.com/hjs2015/shell-notes  
**参考**: https://github.com/dylanaraps/pure-bash-bible

[返回顶部](#-shell-编程快速参考)

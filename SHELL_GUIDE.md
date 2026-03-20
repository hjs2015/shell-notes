# 📚 Shell 编程完全指南

> 基于 **226 个实战脚本** 的系统性学习手册 | 从入门到 DevOps 实战 | 90 天学习计划

**仓库地址：** https://github.com/hjs2015/shell-notes  
**脚本总数：** **226 个** ✅  
**代码行数：** **24,242 行**  
**学习周期：** 90 天（从入门到实战）  
**最后更新：** 2026-03-20

---

## 📖 目录

- [第 1 章 快速开始（第 1 天）](#第-1-章-快速开始第 -1-天)
- [第 2 章 Bash 基础（第 2-7 天）](#第-2 章-bash 基础第 -2-7-天)
- [第 3 章 流程控制（第 8-21 天）](#第-3 章-流程控制第 -8-21-天)
- [第 4 章 数据结构（第 22-28 天）](#第-4 章-数据结构第 -22-28-天)
- [第 5 章 文本处理（第 29-42 天）](#第-5 章-文本处理第 -29-42-天)
- [第 6 章 系统编程（第 43-58 天）](#第-6 章-系统编程第 -43-58-天)
- [第 7 章 实战项目（第 59-90 天）](#第-7 章-实战项目第 -59-90-天)
- [附录 A 学习资源](#附录-a 学习资源)
- [附录 B 常用命令速查](#附录-b 常用命令速查)
- [附录 C 脚本索引](#附录-c 脚本索引)

---

## 第 1 章 快速开始（第 1 天）

> ⭐ 难度等级：入门 | 📁 脚本数量：**5 个** | ⏱️ 学习时长：1 天

快速上手 Shell 编程，完成第一个脚本，理解 Shell 环境。

### 1.1 Hello World

**脚本路径：** [`00_quickstart/01_hello_world.sh`](00_quickstart/01_hello_world.sh)

```bash
#!/bin/bash
# 第一个 Shell 脚本
echo "Hello, World!"
```

**知识点：**
- `#!/bin/bash` - shebang，指定脚本解释器
- `echo` 命令 - 输出文本
- 执行权限 - `chmod +x script.sh`

**执行方式：**
```bash
chmod +x 00_quickstart/01_hello_world.sh
./00_quickstart/01_hello_world.sh
```

**输出：**
```
Hello, World!
```

---

### 1.2 特殊变量

**脚本路径：** [`00_quickstart/02_special_variables.sh`](00_quickstart/02_special_variables.sh)

**知识点：**
| 变量 | 含义 | 示例 |
|------|------|------|
| `$0` | 脚本名称 | `echo $0` → `script.sh` |
| `$1-$9` | 位置参数 | `echo $1` → `arg1` |
| `$#` | 参数个数 | `echo $#` → `3` |
| `$@` | 所有参数（独立） | `echo $@` → `arg1 arg2 arg3` |
| `$*` | 所有参数（字符串） | `echo "$*"` → `arg1 arg2 arg3` |
| `$?` | 上一个命令退出码 | `echo $?` → `0` |
| `$$` | 当前进程 ID | `echo $$` → `12345` |
| `$!` | 最后一个后台进程 ID | `echo $!` → `12346` |
| `$RANDOM` | 随机数 | `echo $RANDOM` → `17632` |

**示例：**
```bash
#!/bin/bash
echo "脚本名称：$0"
echo "第一个参数：$1"
echo "参数个数：\`$#\`"
echo "所有参数：$@"
echo "进程 ID: $$"
```

**运行测试：**
```bash
bash 00_quickstart/02_special_variables.sh arg1 arg2 arg3
```

---

### 1.3 输入输出基础

**脚本路径：** [`00_quickstart/03_echo_read.sh`](00_quickstart/03_echo_read.sh)

**知识点：**
- `echo` - 输出文本
- `read` - 读取用户输入
- `read -p` - 带提示语
- `read -s` - 隐藏输入（密码）

**示例：**
```bash
#!/bin/bash
echo "欢迎使用 Shell 脚本！"
read -p "请输入姓名：" name
read -sp "请输入密码：" password
echo ""
echo "你好，$name！"
```

---

### 1.4 Shell 环境检测

**脚本路径：** [`00_quickstart/04_shell_environment_check.sh`](00_quickstart/04_shell_environment_check.sh)

**知识点：**
- 检测 Shell 类型
- 检测操作系统
- 检测用户权限
- 显示系统信息

**实战应用：**
```bash
# 检测当前 Shell
echo "当前 Shell: $SHELL"

# 检测操作系统
uname -a

# 检测用户
whoami

# 检测权限
if [ $EUID -eq 0 ]; then
    echo "root 用户"
else
    echo "普通用户"
fi
```

---

### 1.5 脚本执行方式

**脚本路径：** [`00_quickstart/05_script_execution_methods.sh`](00_quickstart/05_script_execution_methods.sh)

**知识点：**
| 方式 | 命令 | 说明 |
|------|------|------|
| 直接执行 | `./script.sh` | 需要执行权限 |
| Bash 执行 | `bash script.sh` | 无需执行权限 |
| Source 执行 | `source script.sh` | 在当前 Shell 执行 |
| 点号执行 | `. script.sh` | source 的简写 |

**区别说明：**
- `./script.sh` - 创建子 Shell 执行
- `bash script.sh` - 创建子 Shell 执行
- `source script.sh` - 在当前 Shell 执行（变量保留）

---

## 第 2 章 Bash 基础（第 2-7 天）

> ⭐⭐ 难度等级：初级 | 📁 脚本数量：**28 个** | ⏱️ 学习时长：6 天

掌握 Shell 编程的基础知识：变量、运算符、输入输出。

### 2.1 变量（7 个脚本）

**目录：** [`01_basics/01_variables/`](01_basics/01_variables/)

#### 2.1.1 变量定义与使用

**脚本：** [`01_basics/01_variables/01_hello_world.sh`](01_basics/01_variables/01_hello_world.sh)

```bash
#!/bin/bash
# 定义变量
name="World"
age=25

# 使用变量
echo "Hello, $name!"
echo "Age: $age"
```

**知识点：**
- 变量定义：`name="value"`（等号两边不能有空格）
- 变量使用：`$name` 或 `${name}`
- 变量类型：无需声明类型，自动推断

#### 2.1.2 变量类型声明

**脚本：** [`01_basics/13_variable_type_declaration.sh`](01_basics/13_variable_type_declaration.sh)

```bash
#!/bin/bash
# 声明整数
declare -i num=10

# 声明只读
declare -r PI=3.14159

# 声明数组
declare -a fruits=("apple" "banana" "orange")

# 声明关联数组
declare -A user=([name]="Alice" [age]=25)
```

#### 2.1.3 字符串操作

**脚本：** [`01_basics/14_string_operations.sh`](01_basics/14_string_operations.sh)

```bash
#!/bin/bash
str="Hello World"

# 字符串长度
echo ${#str}              # 11

# 截取子串
echo ${str:0:5}           # Hello

# 替换
echo ${str/World/Shell}   # Hello Shell

# 删除匹配
echo ${str#Hello }        # World
echo ${str% World}        # Hello
```

---

### 2.2 运算符（10 个脚本）

**目录：** [`01_basics/02_operators/`](01_basics/02_operators/)

#### 2.2.1 算术运算

**脚本：** [`01_basics/02_operators/07_arithmetic.sh`](01_basics/02_operators/07_arithmetic.sh)

```bash
#!/bin/bash
a=10
b=3

# 基本运算
echo $((a + b))    # 13
echo $((a - b))    # 7
echo $((a * b))    # 30
echo $((a / b))    # 3
echo $((a % b))    # 1

# 幂运算
echo $((a ** 2))   # 100

# 自增自减
((a++))
echo $a            # 11
```

#### 2.2.2 比较运算

**脚本：** [`01_basics/02_operators/08_comparison.sh`](01_basics/02_operators/08_comparison.sh)

```bash
#!/bin/bash
a=10
b=20

# 数值比较
[ $a -eq $b ] && echo "相等" || echo "不相等"
[ $a -ne $b ] && echo "不等" || echo "相等"
[ $a -gt $b ] && echo "大于" || echo "不大于"
[ $a -lt $b ] && echo "小于" || echo "不小于"

# 字符串比较
[ "$a" = "$b" ] && echo "字符串相等"
[ "$a" != "$b" ] && echo "字符串不等"
```

#### 2.2.3 逻辑运算

**脚本：** [`01_basics/02_operators/09_logical.sh`](01_basics/02_operators/09_logical.sh)

```bash
#!/bin/bash
a=10
b=20

# 逻辑与
[ $a -gt 5 ] && [ $b -lt 30 ] && echo "条件成立"

# 逻辑或
[ $a -gt 15 ] || [ $b -lt 30 ] && echo "至少一个成立"

# 逻辑非
! [ $a -gt $b ] && echo "a 不大于 b"
```

---

### 2.3 输入输出（3 个脚本）

**目录：** [`01_basics/03_io/`](01_basics/03_io/)

#### 2.3.1 read 命令进阶

**脚本：** [`01_basics/18_read_advanced.sh`](01_basics/18_read_advanced.sh)

```bash
#!/bin/bash
# 带提示语
read -p "请输入姓名：" name

# 隐藏输入（密码）
read -sp "请输入密码：" password
echo ""

# 限制字符数
read -n 1 -p "确认吗？(y/n): " confirm
echo ""

# 超时
read -t 5 -p "5 秒内输入：" input
echo ""

# 读取多变量
read -p "姓名 年龄：" name age
echo "$name, $age 岁"
```

#### 2.3.2 printf 格式化

**脚本：** [`01_basics/19_printf_formatting.sh`](01_basics/19_printf_formatting.sh)

```bash
#!/bin/bash
# 格式化输出
printf "姓名：%-10s 年龄：%3d\n" "Alice" 25
printf "姓名：%-10s 年龄：%3d\n" "Bob" 30

# 数字格式
printf "十进制：%d\n" 255
printf "十六进制：%x\n" 255
printf "八进制：%o\n" 255

# 浮点数
printf "圆周率：%.2f\n" 3.14159
```

**输出：**
```
姓名：Alice      年龄： 25
姓名：Bob        年龄： 30
十进制：255
十六进制：ff
八进制：377
圆周率：3.14
```

#### 2.3.3 Here Document

**脚本：** [`01_basics/20_here_document.sh`](01_basics/20_here_document.sh)

```bash
#!/bin/bash
# 创建多行文本
cat << EOF
欢迎使用系统
==============
功能 1: 用户管理
功能 2: 文件管理
功能 3: 系统监控
EOF

# 写入文件
cat > config.txt << EOF
server=localhost
port=8080
user=admin
EOF

# 变量替换
name="Alice"
cat << EOF
你好，$name
今天是 $(date +%Y-%m-%d)
EOF
```

---

### 2.4 高级变量（8 个脚本）

**目录：** [`01_basics/`](01_basics/)

| 脚本 | 主题 | 难度 |
|------|------|------|
| [`21_variable_default_value.sh`](01_basics/21_variable_default_value.sh) | 变量默认值 | ⭐⭐ |
| [`22_array_basics.sh`](01_basics/22_array_basics.sh) | 数组基础 | ⭐⭐ |
| [`23_array_operations.sh`](01_basics/23_array_operations.sh) | 数组操作 | ⭐⭐ |
| [`24_regex_match.sh`](01_basics/24_regex_match.sh) | 正则匹配 | ⭐⭐⭐ |
| [`25_case_conversion.sh`](01_basics/25_case_conversion.sh) | 大小写转换 | ⭐⭐ |
| [`26_indirect_reference.sh`](01_basics/26_indirect_reference.sh) | 间接引用 | ⭐⭐⭐ |
| [`27_environment_variables.sh`](01_basics/27_environment_variables.sh) | 环境变量 | ⭐⭐ |
| [`28_variable_scope.sh`](01_basics/28_variable_scope.sh) | 变量作用域 | ⭐⭐⭐ |

---

## 第 3 章 流程控制（第 8-21 天）

> ⭐⭐⭐ 难度等级：中级 | 📁 脚本数量：**67 个** | ⏱️ 学习时长：14 天

掌握 Shell 编程的核心：条件判断、循环结构、函数。

### 3.1 条件判断（10 个脚本）

**目录：** [`02_control_flow/01_condition/`](02_control_flow/01_condition/)

#### 3.1.1 if 基础

**脚本：** [`02_control_flow/01_if_basic.sh`](02_control_flow/01_if_basic.sh)

```bash
#!/bin/bash
age=18

if [ $age -ge 18 ]; then
    echo "成年"
else
    echo "未成年"
fi

# elif 用法
score=85
if [ $score -ge 90 ]; then
    echo "优秀"
elif [ $score -ge 80 ]; then
    echo "良好"
elif [ $score -ge 60 ]; then
    echo "及格"
else
    echo "不及格"
fi
```

#### 3.1.2 文件测试

**脚本：** [`02_control_flow/03_file_test.sh`](02_control_flow/03_file_test.sh)

```bash
#!/bin/bash
file="/etc/passwd"

# 文件存在性
[ -e "$file" ] && echo "文件存在"

# 文件类型
[ -f "$file" ] && echo "普通文件"
[ -d "$file" ] && echo "目录"
[ -L "$file" ] && echo "符号链接"

# 文件权限
[ -r "$file" ] && echo "可读"
[ -w "$file" ] && echo "可写"
[ -x "$file" ] && echo "可执行"

# 文件属性
[ -s "$file" ] && echo "非空文件"
[ -N "$file" ] && echo "最近修改过"
```

#### 3.1.3 字符串比较

**脚本：** [`02_control_flow/04_string_compare.sh`](02_control_flow/04_string_compare.sh)

```bash
#!/bin/bash
str1="hello"
str2="world"

# 相等性
[ "$str1" = "$str2" ] && echo "相等"
[ "$str1" != "$str2" ] && echo "不等"

# 空字符串
[ -z "$str1" ] && echo "空字符串"
[ -n "$str1" ] && echo "非空字符串"

# 模式匹配
[[ "$str1" == h* ]] && echo "以 h 开头"
[[ "$str1" == *o ]] && echo "以 o 结尾"
```

---

### 3.2 case 语句（3 个脚本）

**目录：** [`02_control_flow/02_case/`](02_control_flow/02_case/)

#### 3.2.1 case 基础

**脚本：** [`02_control_flow/08_case_basic.sh`](02_control_flow/08_case_basic.sh)

```bash
#!/bin/bash
os="linux"

case $os in
    linux)
        echo "Linux 系统"
        ;;
    windows)
        echo "Windows 系统"
        ;;
    macos)
        echo "macOS 系统"
        ;;
    *)
        echo "未知系统"
        ;;
esac
```

#### 3.2.2 select 菜单

**脚本：** [`02_control_flow/10_select_menu.sh`](02_control_flow/10_select_menu.sh)

```bash
#!/bin/bash
PS3="请选择操作 (1-4): "
select action in "启动服务" "停止服务" "重启服务" "退出"; do
    case $action in
        "启动服务")
            echo "启动服务中..."
            ;;
        "停止服务")
            echo "停止服务中..."
            ;;
        "重启服务")
            echo "重启服务中..."
            ;;
        "退出")
            echo "退出程序"
            break
            ;;
        *)
            echo "无效选择"
            ;;
    esac
done
```

---

### 3.3 循环结构（20 个脚本）

**目录：** [`02_control_flow/03_loop/`](02_control_flow/03_loop/)

#### 3.3.1 for 循环

**脚本：** [`02_control_flow/11_for_basic.sh`](02_control_flow/11_for_basic.sh)

```bash
#!/bin/bash
# 遍历列表
for fruit in apple banana orange; do
    echo "水果：$fruit"
done

# 范围循环
for i in {1..5}; do
    echo "数字：$i"
done

# C 风格
for ((i=0; i<5; i++)); do
    echo "计数：$i"
done

# 遍历文件
for file in *.sh; do
    echo "脚本：$file"
done

# 遍历数组
fruits=("apple" "banana" "orange")
for fruit in "${fruits[@]}"; do
    echo "水果：$fruit"
done
```

#### 3.3.2 while 循环

**脚本：** [`02_control_flow/15_while_basic.sh`](02_control_flow/15_while_basic.sh)

```bash
#!/bin/bash
# 基础 while
count=1
while [ $count -le 5 ]; do
    echo "计数：$count"
    ((count++))
done

# 读取文件
while read -r line; do
    echo "行：$line"
done < /etc/passwd

# 无限循环
while true; do
    echo "运行中..."
    sleep 1
done
```

#### 3.3.3 until 循环

**脚本：** [`02_control_flow/17_until_loop.sh`](02_control_flow/17_until_loop.sh)

```bash
#!/bin/bash
# until 循环（条件为假时执行）
count=1
until [ $count -gt 5 ]; do
    echo "计数：$count"
    ((count++))
done

# 等待服务
until ping -c 1 google.com &>/dev/null; do
    echo "等待网络..."
    sleep 2
done
echo "网络已连接"
```

#### 3.3.4 break 和 continue

**脚本：** [`02_control_flow/18_break_continue.sh`](02_control_flow/18_break_continue.sh)

```bash
#!/bin/bash
# break 跳出循环
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break
    fi
    echo $i
done

# continue 跳过本次
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo $i  # 只输出奇数
done
```

#### 3.3.5 嵌套循环

**脚本：** [`02_control_flow/19_nested_loops.sh`](02_control_flow/19_nested_loops.sh)

```bash
#!/bin/bash
# 九九乘法表
for i in {1..9}; do
    for j in {1..$i}; do
        echo -n "$j×$i=$((i*j)) "
    done
    echo ""
done

# 打印图案
for i in {1..5}; do
    for j in {1..$i}; do
        echo -n "*"
    done
    echo ""
done
```

---

### 3.4 函数（37 个脚本）

**目录：** [`02_control_flow/04_function/`](02_control_flow/04_function/)

#### 3.4.1 函数基础

**脚本：** [`02_control_flow/31_function_basic.sh`](02_control_flow/31_function_basic.sh)

```bash
#!/bin/bash
# 函数定义
greet() {
    echo "你好，$1!"
}

# 函数调用
greet "Alice"
greet "Bob"

# 带返回值
add() {
    local sum=$(($1 + $2))
    echo $sum
}

result=$(add 10 20)
echo "结果：$result"
```

#### 3.4.2 函数参数

**脚本：** [`02_control_flow/32_function_parameters.sh`](02_control_flow/32_function_parameters.sh)

```bash
#!/bin/bash
# 位置参数
show_params() {
    echo "参数个数：$#"
    echo "所有参数：$@"
    echo "第一个参数：$1"
    echo "第二个参数：$2"
}

show_params arg1 arg2 arg3

# 默认参数
greet() {
    local name=${1:-"Guest"}
    echo "你好，$name!"
}

greet
greet "Alice"
```

#### 3.4.3 局部变量

**脚本：** [`02_control_flow/33_function_local_vars.sh`](02_control_flow/33_function_local_vars.sh)

```bash
#!/bin/bash
# 全局变量
global_var="全局"

func() {
    # 局部变量
    local local_var="局部"
    global_var="修改后的全局"
    echo "函数内：$local_var"
    echo "函数内：$global_var"
}

func
echo "函数外：$global_var"
# echo "函数外：$local_var"  # 错误：局部变量外部不可访问
```

#### 3.4.4 递归函数

**脚本：** [`02_control_flow/35_function_recursive.sh`](02_control_flow/35_function_recursive.sh)

```bash
#!/bin/bash
# 阶乘
factorial() {
    local n=$1
    if [ $n -le 1 ]; then
        echo 1
    else
        local prev=$(factorial $((n-1)))
        echo $((n * prev))
    fi
}

echo "5! = $(factorial 5)"  # 120
echo "6! = $(factorial 6)"  # 720

# 斐波那契
fibonacci() {
    local n=$1
    if [ $n -le 1 ]; then
        echo $n
    else
        local a=$(fibonacci $((n-1)))
        local b=$(fibonacci $((n-2)))
        echo $((a + b))
    fi
}

echo "斐波那契数列："
for i in {0..10}; do
    echo -n "$(fibonacci $i) "
done
echo ""
```

#### 3.4.5 函数库

**脚本：** [`02_control_flow/37_function_library.sh`](02_control_flow/37_function_library.sh)

```bash
#!/bin/bash
# 颜色输出库
color_print() {
    local text="$1"
    local color="$2"
    case $color in
        red) echo -e "\033[31m$text\033[0m" ;;
        green) echo -e "\033[32m$text\033[0m" ;;
        yellow) echo -e "\033[33m$text\033[0m" ;;
        blue) echo -e "\033[34m$text\033[0m" ;;
        *) echo "$text" ;;
    esac
}

# 日志函数
log_info() {
    color_print "[INFO] $1" "green"
}

log_error() {
    color_print "[ERROR] $1" "red"
}

log_warn() {
    color_print "[WARN] $1" "yellow"
}

# 使用示例
log_info "信息消息"
log_warn "警告消息"
log_error "错误消息"
```

#### 3.4.6 错误处理

**脚本：** [`02_control_flow/38_function_error_handling.sh`](02_control_flow/38_function_error_handling.sh)

```bash
#!/bin/bash
# 设置错误处理
set -e  # 遇到错误立即退出
set -u  # 使用未定义变量时报错
set -o pipefail  # 管道中任何命令失败则整个管道失败

# 错误处理函数
error_handler() {
    echo "错误发生在第 $1 行"
    echo "错误命令：$2"
    echo "退出码：$3"
}

trap 'error_handler $LINENO "$BASH_COMMAND" $?' ERR

# 测试
rm /nonexistent_file  # 触发错误
```

#### 3.4.7 trap 信号处理

**脚本：** [`02_control_flow/46_function_trap.sh`](02_control_flow/46_function_trap.sh)

```bash
#!/bin/bash
# 捕获中断信号
cleanup() {
    echo "收到中断信号，清理中..."
    rm -f /tmp/temp_*
    exit 1
}

trap cleanup INT TERM

# 主循环
while true; do
    echo "运行中... (按 Ctrl+C 中断)"
    sleep 1
done
```

#### 3.4.8 超时重试

**脚本：** [`02_control_flow/51_timeout_retry.sh`](02_control_flow/51_timeout_retry.sh)

```bash
#!/bin/bash
# 带超时的命令执行
timeout_exec() {
    local timeout=$1
    shift
    timeout $timeout "$@"
    return $?
}

# 重试机制
retry() {
    local max=$1
    local delay=$2
    shift 2
    local n=1
    while true; do
        "$@" && return 0 || {
            if [[ $n -lt $max ]]; then
                ((n++))
                echo "尝试 $n/$max 失败，等待 $delay 秒后重试..."
                sleep $delay
            else
                echo "重试 $max 次后放弃"
                return 1
            fi
        }
    done
}

# 使用示例
retry 3 5 curl -s https://example.com
```

---

## 第 4 章 数据结构（第 22-28 天）

> ⭐⭐⭐ 难度等级：中级 | 📁 脚本数量：**19 个** | ⏱️ 学习时长：7 天

掌握 Shell 中的数据结构：索引数组、关联数组、字符串操作。

### 4.1 索引数组（7 个脚本）

**目录：** [`03_data_structures/01_indexed_arrays/`](03_data_structures/01_indexed_arrays/)

#### 4.1.1 创建数组

**脚本：** [`01_indexed_arrays/01_array_create.sh`](03_data_structures/01_indexed_arrays/01_array_create.sh)

```bash
#!/bin/bash
# 方法 1：直接赋值
fruits=("apple" "banana" "orange")

# 方法 2：逐个赋值
colors[0]="red"
colors[1]="green"
colors[2]="blue"

# 方法 3：declare 声明
declare -a numbers
numbers=(1 2 3 4 5)

# 访问数组
echo "${fruits[0]}"     # apple
echo "${fruits[1]}"     # banana
echo "${fruits[@]}"     # apple banana orange
echo "${#fruits[@]}"    # 3 (数组长度)
```

#### 4.1.2 数组切片

**脚本：** [`01_indexed_arrays/04_array_slice.sh`](03_data_structures/01_indexed_arrays/04_array_slice.sh)

```bash
#!/bin/bash
numbers=(1 2 3 4 5 6 7 8 9 10)

# 切片语法：${array[@]:start:length}
echo "${numbers[@]:0:3}"    # 1 2 3
echo "${numbers[@]:3:4}"    # 4 5 6 7
echo "${numbers[@]:5}"      # 6 7 8 9 10

# 负数索引（从末尾开始）
echo "${numbers[@]: -3}"    # 8 9 10
```

#### 4.1.3 数组排序

**脚本：** [`01_indexed_arrays/06_array_sort.sh`](03_data_structures/01_indexed_arrays/06_array_sort.sh)

```bash
#!/bin/bash
numbers=(5 2 8 1 9 3)

# 排序
sorted=($(printf '%s\n' "${numbers[@]}" | sort -n))
echo "排序后：${sorted[@]}"  # 1 2 3 5 8 9

# 逆序
reversed=($(printf '%s\n' "${numbers[@]}" | sort -nr))
echo "逆序：${reversed[@]}"  # 9 8 5 3 2 1
```

---

### 4.2 关联数组（6 个脚本）

**目录：** [`03_data_structures/02_associative_arrays/`](03_data_structures/02_associative_arrays/)

#### 4.2.1 创建字典

**脚本：** [`02_associative_arrays/01_dict_create.sh`](03_data_structures/02_associative_arrays/01_dict_create.sh)

```bash
#!/bin/bash
# 声明关联数组
declare -A user

# 赋值
user[name]="Alice"
user[age]=25
user[city]="Beijing"

# 访问
echo "姓名：${user[name]}"
echo "年龄：${user[age]}"
echo "城市：${user[city]}"

# 遍历
for key in "${!user[@]}"; do
    echo "$key: ${user[$key]}"
done
```

#### 4.2.2 字典操作

**脚本：** [`02_associative_arrays/03_dict_operations.sh`](03_data_structures/02_associative_arrays/03_dict_operations.sh)

```bash
#!/bin/bash
declare -A fruits
fruits[apple]="red"
fruits[banana]="yellow"
fruits[orange]="orange"

# 检查键是否存在
[[ -v fruits[apple] ]] && echo "apple 存在"

# 删除键
unset fruits[banana]

# 获取所有键
echo "所有键：${!fruits[@]}"

# 获取所有值
echo "所有值：${fruits[@]}"

# 数组长度
echo "长度：${#fruits[@]}"
```

---

### 4.3 字符串处理（6 个脚本）

**目录：** [`03_data_structures/03_strings/`](03_data_structures/03_strings/)

#### 4.3.1 字符串拼接

**脚本：** [`03_strings/01_string_concat.sh`](03_data_structures/03_strings/01_string_concat.sh)

```bash
#!/bin/bash
str1="Hello"
str2="World"

# 直接拼接
result="$str1 $str2"
echo "$result"  # Hello World

# 使用变量
greeting="${str1}, ${str2}!"
echo "$greeting"  # Hello, World!
```

#### 4.3.2 字符串分割

**脚本：** [`03_strings/02_string_split.sh`](03_data_structures/03_strings/02_string_split.sh)

```bash
#!/bin/bash
str="apple,banana,orange"

# 使用 IFS
IFS=',' read -ra arr <<< "$str"
echo "${arr[0]}"  # apple
echo "${arr[1]}"  # banana

# 使用 sed
echo "$str" | sed 's/,/\n/g'

# 使用 awk
echo "$str" | awk -F',' '{print $2}'  # banana
```

#### 4.3.3 字符串修剪

**脚本：** [`03_strings/04_string_trim.sh`](03_data_structures/03_strings/04_string_trim.sh)

```bash
#!/bin/bash
str="  Hello World  "

# 去除两端空格
trimmed=$(echo "$str" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
echo "[$trimmed]"  # [Hello World]

# 使用参数扩展
trimmed="${str#"${str%%[![:space:]]*}"}"
trimmed="${trimmed%"${trimmed##*[![:space:]]}"}"
echo "[$trimmed]"
```

---

## 第 5 章 文本处理（第 29-42 天）

> ⭐⭐⭐⭐ 难度等级：高级 | 📁 脚本数量：**23 个** | ⏱️ 学习时长：14 天

掌握 Shell 文本处理三剑客：grep、sed、awk。

### 5.1 Grep 高级用法（8 个脚本）

**目录：** [`04_text_processing/01_grep/`](04_text_processing/01_grep/)

#### 5.1.1 grep 基础

**脚本：** [`01_grep/01_grep_basic.sh`](04_text_processing/01_grep/01_grep_basic.sh)

```bash
#!/bin/bash
# 基础搜索
grep "error" /var/log/syslog

# 忽略大小写
grep -i "warning" app.log

# 递归搜索
grep -r "TODO" /home/user/project/

# 显示行号
grep -n "function" script.sh

# 计数
grep -c "ERROR" app.log

# 反向匹配
grep -v "^#" config.txt  # 排除注释行

# 显示上下文
grep -C 3 "exception" app.log  # 前后 3 行
grep -B 5 "error" app.log      # 前 5 行
grep -A 5 "error" app.log      # 后 5 行
```

#### 5.1.2 正则表达式

**脚本：** [`01_grep/03_grep_regex.sh`](04_text_processing/01_grep/03_grep_regex.sh)

```bash
#!/bin/bash
# 基础正则
grep "^start" file.txt      # 以 start 开头
grep "end$" file.txt        # 以 end 结尾
grep "^$" file.txt          # 空行
grep "." file.txt           # 任意字符

# 字符类
grep "[0-9]" file.txt       # 数字
grep "[a-z]" file.txt       # 小写字母
grep "[A-Z]" file.txt       # 大写字母
grep "[[:digit:]]" file.txt # 数字（POSIX）

# 量词
grep "a*" file.txt          # 0 个或多个 a
grep "a+" file.txt          # 1 个或多个 a（需要-E）
grep "a?" file.txt          # 0 个或 1 个 a
grep "a{3}" file.txt        # 恰好 3 个 a
grep "a{2,4}" file.txt      # 2 到 4 个 a

# 分组
grep -E "(abc|def)" file.txt  # abc 或 def
```

---

### 5.2 Sed 高级用法（7 个脚本）

**目录：** [`04_text_processing/02_sed/`](04_text_processing/02_sed/)

#### 5.2.1 sed 基础

**脚本：** [`02_sed/01_sed_basic.sh`](04_text_processing/02_sed/01_sed_basic.sh)

```bash
#!/bin/bash
# 替换（只替换每行第一个）
sed 's/old/new/' file.txt

# 全局替换
sed 's/old/new/g' file.txt

# 原地修改
sed -i 's/old/new/g' file.txt

# 备份后修改
sed -i.bak 's/old/new/g' file.txt

# 删除行
sed '/pattern/d' file.txt
sed '1,10d' file.txt  # 删除前 10 行

# 打印特定行
sed -n '5p' file.txt      # 打印第 5 行
sed -n '5,10p' file.txt   # 打印 5-10 行

# 插入行
sed '5i\这是插入的行' file.txt

# 追加行
sed '5a\这是追加的行' file.txt
```

#### 5.2.2 sed 高级替换

**脚本：** [`02_sed/02_sed_replace.sh`](04_text_processing/02_sed/02_sed_replace.sh)

```bash
#!/bin/bash
# 使用分隔符（路径替换）
sed 's|/old/path|/new/path|g' file.txt

# 反向引用
sed 's/\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)/\3\/\2\/\1/' date.txt
# 2024-01-15 → 15/01/2024

# 多行替换
sed ':a;N;$!ba;s/\n/ /g' file.txt  # 合并所有行

# 条件替换
sed '/pattern/s/old/new/g' file.txt  # 只替换包含 pattern 的行
```

---

### 5.3 Awk 高级用法（8 个脚本）

**目录：** [`04_text_processing/03_awk/`](04_text_processing/03_awk/)

#### 5.3.1 awk 基础

**脚本：** [`03_awk/01_awk_basic.sh`](04_text_processing/03_awk/01_awk_basic.sh)

```bash
#!/bin/bash
# 打印字段
awk '{print $1}' file.txt        # 第一列
awk '{print $1, $3}' file.txt    # 第一列和第三列

# 指定分隔符
awk -F: '{print $1}' /etc/passwd  # 用户名
awk -F, '{print $2}' data.csv     # CSV 第二列

# 内置变量
awk '{print NR, $0}' file.txt     # 行号 + 内容
awk 'END {print NR}' file.txt     # 总行数
awk '{print NF}' file.txt         # 每行列数

# 条件过滤
awk '$3 > 100' data.txt           # 第三列大于 100
awk '$1 == "Alice"' data.txt      # 第一列等于 Alice
```

#### 5.3.2 awk 数学运算

**脚本：** [`03_awk/04_awk_math.sh`](04_text_processing/03_awk/04_awk_math.sh)

```bash
#!/bin/bash
# 求和
awk '{sum+=$1} END {print sum}' numbers.txt

# 平均值
awk '{sum+=$1; count++} END {print sum/count}' numbers.txt

# 最大值
awk 'BEGIN {max=0} {if($1>max) max=$1} END {print max}' numbers.txt

# 最小值
awk 'NR==1 {min=$1} {if($1<min) min=$1} END {print min}' numbers.txt

# 统计
awk '{sum[$1]++} END {for (i in sum) print i, sum[i]}' data.txt
```

#### 5.3.3 awk 条件与循环

**脚本：** [`03_awk/06_awk_condition_loop.sh`](04_text_processing/03_awk/06_awk_condition_loop.sh)

```bash
#!/bin/bash
# if-else
awk '{
    if ($1 >= 90) print "优秀"
    else if ($1 >= 60) print "及格"
    else print "不及格"
}' scores.txt

# for 循环
awk '{
    for (i=1; i<=NF; i++) {
        printf "%s ", $i
    }
    print ""
}' file.txt

# while 循环
awk '{
    i=1
    while (i<=NF) {
        print $i
        i++
    }
}' file.txt
```

#### 5.3.4 awk 函数

**脚本：** [`03_awk/08_awk_advanced.sh`](04_text_processing/03_awk/08_awk_advanced.sh)

```bash
#!/bin/bash
awk '
function abs(x) {
    return (x < 0) ? -x : x
}

function max(a, b) {
    return (a > b) ? a : b
}

{
    print abs($1), max($1, $2)
}
' data.txt
```

---

## 第 6 章 系统编程（第 43-58 天）

> ⭐⭐⭐⭐ 难度等级：高级 | 📁 脚本数量：**35 个** | ⏱️ 学习时长：16 天

掌握 Shell 系统编程：Shell 初始化、作业控制、信号处理、并发控制。

### 6.1 Shell 初始化（10 个脚本）

**目录：** [`05_system_programming/01_shell_init/`](05_system_programming/01_shell_init/)

#### 6.1.1 Shell 选项

**脚本：** [`01_shell_init/01_shell_options.sh`](05_system_programming/01_shell_init/01_shell_options.sh)

```bash
#!/bin/bash
# 严格模式
set -e   # 遇到错误立即退出
set -u   # 使用未定义变量时报错
set -o pipefail  # 管道中任何命令失败则整个管道失败

# 调试模式
set -x   # 打印执行的命令
set -v   # 打印读取的命令

# 查看选项
set -o
```

#### 6.1.2 profile 配置

**脚本：** [`01_shell_init/05_profile.sh`](05_system_programming/01_shell_init/05_profile.sh)

```bash
#!/bin/bash
# 加载顺序
# 1. /etc/profile (系统级)
# 2. ~/.bash_profile (用户级)
# 3. ~/.bashrc (交互式非登录 Shell)
# 4. /etc/bash.bashrc (系统级)

# 常用配置
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export PS1="\u@\h:\w\$ "

# 别名
alias ll='ls -la'
alias gs='git status'
alias gp='git push'
```

---

### 6.2 作业控制（7 个脚本）

**目录：** [`05_system_programming/02_job_control/`](05_system_programming/02_job_control/)

#### 6.2.1 后台任务

**脚本：** [`02_job_control/01_background_jobs.sh`](05_system_programming/02_job_control/01_background_jobs.sh)

```bash
#!/bin/bash
# 启动后台任务
sleep 100 &

# 查看任务
jobs -l

# 停止任务
kill %1

# 前台运行
fg %1

# 后台运行
bg %1
```

#### 6.2.2 nohup

**脚本：** [`02_job_control/04_nohup.sh`](05_system_programming/02_job_control/04_nohup.sh)

```bash
#!/bin/bash
# 忽略挂起信号
nohup ./long_running_script.sh &

# 重定向输出
nohup ./script.sh > output.log 2>&1 &

# 查看进程
ps aux | grep script.sh
```

---

### 6.3 信号处理（5 个脚本）

**目录：** [`05_system_programming/03_signals/`](05_system_programming/03_signals/)

#### 6.3.1 信号列表

**脚本：** [`03_signals/01_signal_list.sh`](05_system_programming/03_signals/01_signal_list.sh)

```bash
#!/bin/bash
# 显示所有信号
trap -l

# 常见信号
# 1) SIGHUP    - 挂起
# 2) SIGINT    - 中断 (Ctrl+C)
# 3) SIGQUIT   - 退出
# 9) SIGKILL   - 强制终止
# 15) SIGTERM  - 终止请求
# 19) SIGSTOP  - 停止
# 20) SIGTSTP  - 终端停止 (Ctrl+Z)
# 28) SIGWINCH - 窗口大小改变
```

#### 6.3.2 捕获信号

**脚本：** [`03_signals/02_signal_catch.sh`](05_system_programming/03_signals/02_signal_catch.sh)

```bash
#!/bin/bash
cleanup() {
    echo "收到中断信号，清理中..."
    rm -f /tmp/temp_*
    exit 1
}

trap cleanup INT TERM

while true; do
    echo "运行中... (按 Ctrl+C 中断)"
    sleep 1
done
```

---

### 6.4 并发控制（6 个脚本）

**目录：** [`05_system_programming/04_concurrency/`](05_system_programming/04_concurrency/)

#### 6.4.1 并行执行

**脚本：** [`04_concurrency/01_parallel_exec.sh`](05_system_programming/04_concurrency/01_parallel_exec.sh)

```bash
#!/bin/bash
# 并行执行多个任务
for i in {1..5}; do
    (echo "任务 $i 开始"; sleep 2; echo "任务 $i 完成") &
done

# 等待所有任务完成
wait
echo "所有任务完成"
```

#### 6.4.2 互斥锁

**脚本：** [`04_concurrency/02_mutex_lock.sh`](05_system_programming/04_concurrency/02_mutex_lock.sh)

```bash
#!/bin/bash
LOCKFILE=/tmp/myapp.lock

acquire_lock() {
    if ( set -o noclobber; echo $$ > "$LOCKFILE" ) 2>/dev/null; then
        trap 'rm -f "$LOCKFILE"' EXIT
        return 0
    else
        return 1
    fi
}

if acquire_lock; then
    echo "获得锁，执行关键代码..."
    sleep 5
else
    echo "无法获得锁"
    exit 1
fi
```

---

### 6.5 快捷操作（7 个脚本）

**目录：** [`05_system_programming/05_shortcuts/`](05_system_programming/05_shortcuts/)

#### 6.5.1 历史命令

**脚本：** [`05_shortcuts/01_history.sh`](05_system_programming/05_shortcuts/01_history.sh)

```bash
#!/bin/bash
# 查看历史
history

# 搜索历史
history | grep git

# 执行历史命令
!123        # 执行第 123 条
!git        # 执行最近的 git 命令
!!          # 执行上一条命令
!$          # 上一条命令的最后一个参数
!*          # 上一条命令的所有参数
```

#### 6.5.2 通配符

**脚本：** [`05_shortcuts/03_wildcards.sh`](05_system_programming/05_shortcuts/03_wildcards.sh)

```bash
#!/bin/bash
# 基础通配符
ls *.txt      # 所有 txt 文件
ls ?.txt      # 单字符 txt 文件
ls [abc].txt  # a.txt, b.txt 或 c.txt
ls [0-9].txt  # 0.txt 到 9.txt

# 扩展通配符（需要 shopt -s extglob）
ls !(test).txt  # 除了 test.txt
ls +(a).txt     # a.txt, aa.txt, aaa.txt
ls ?(a).txt     # a.txt 或 .txt
ls *(a).txt     # 0 个或多个 a
ls @(a|b).txt   # a.txt 或 b.txt
```

---

## 第 7 章 实战项目（第 59-90 天）

> ⭐⭐⭐⭐⭐ 难度等级：专家 | 📁 脚本数量：**49 个** | ⏱️ 学习时长：32 天

综合运用所学知识，完成实际项目。

### 7.1 系统监控（5 个脚本）

**目录：** [`06_real_world/01_system_monitor/`](06_real_world/01_system_monitor/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_cpu_monitor.sh`](06_real_world/01_system_monitor/01_cpu_monitor.sh) | CPU 使用率监控 | ⭐⭐⭐⭐ |
| [`02_memory_monitor.sh`](06_real_world/01_system_monitor/02_memory_monitor.sh) | 内存使用监控 | ⭐⭐⭐⭐ |
| [`03_disk_io_monitor.sh`](06_real_world/01_system_monitor/03_disk_io_monitor.sh) | 磁盘 IO 监控 | ⭐⭐⭐⭐ |
| [`04_network_speed.sh`](06_real_world/01_system_monitor/04_network_speed.sh) | 网络速度监控 | ⭐⭐⭐⭐ |
| [`05_process_top.sh`](06_real_world/01_system_monitor/05_process_top.sh) | 进程资源占用 | ⭐⭐⭐⭐ |

#### 7.1.1 CPU 监控

**脚本：** [`01_system_monitor/01_cpu_monitor.sh`](06_real_world/01_system_monitor/01_cpu_monitor.sh)

```bash
#!/bin/bash
# CPU 使用率监控
while true; do
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "CPU 使用率：${cpu_usage}%"
    
    if (( $(echo "$cpu_usage > 80" | bc -l) )); then
        echo "警告：CPU 使用率过高！"
    fi
    
    sleep 5
done
```

---

### 7.2 备份自动化（5 个脚本）

**目录：** [`06_real_world/02_backup_automation/`](06_real_world/02_backup_automation/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_incremental_backup.sh`](06_real_world/02_backup_automation/01_incremental_backup.sh) | 增量备份 | ⭐⭐⭐⭐ |
| [`02_remote_backup.sh`](06_real_world/02_backup_automation/02_remote_backup.sh) | 远程备份 | ⭐⭐⭐⭐ |
| [`03_backup_verify.sh`](06_real_world/02_backup_automation/03_backup_verify.sh) | 备份验证 | ⭐⭐⭐⭐ |
| [`04_backup_rotation.sh`](06_real_world/02_backup_automation/04_backup_rotation.sh) | 备份轮转 | ⭐⭐⭐⭐⭐ |
| [`05_database_backup.sh`](06_real_world/02_backup_automation/05_database_backup.sh) | 数据库备份 | ⭐⭐⭐⭐⭐ |

#### 7.2.1 增量备份

**脚本：** [`02_backup_automation/01_incremental_backup.sh`](06_real_world/02_backup_automation/01_incremental_backup.sh)

```bash
#!/bin/bash
SOURCE="/home/user/data"
BACKUP_DIR="/backup"
DATE=$(date +%Y%m%d_%H%M%S)

# 完整备份
tar -czf "$BACKUP_DIR/full_$DATE.tar.gz" "$SOURCE"

# 增量备份（基于修改时间）
find "$SOURCE" -mtime -1 -type f -exec tar -czf "$BACKUP_DIR/incremental_$DATE.tar.gz" {} +

echo "备份完成"
```

---

### 7.3 日志分析（5 个脚本）

**目录：** [`06_real_world/03_log_analyzer/`](06_real_world/03_log_analyzer/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_log_rotation.sh`](06_real_world/03_log_analyzer/01_log_rotation.sh) | 日志轮转 | ⭐⭐⭐⭐ |
| [`02_error_extractor.sh`](06_real_world/03_log_analyzer/02_error_extractor.sh) | 错误提取 | ⭐⭐⭐⭐ |
| [`03_access_analyzer.sh`](06_real_world/03_log_analyzer/03_access_analyzer.sh) | 访问分析 | ⭐⭐⭐⭐⭐ |
| [`04_log_aggregator.sh`](06_real_world/03_log_analyzer/04_log_aggregator.sh) | 日志聚合 | ⭐⭐⭐⭐⭐ |
| [`05_alert_system.sh`](06_real_world/03_log_analyzer/05_alert_system.sh) | 告警系统 | ⭐⭐⭐⭐⭐ |

---

### 7.4 用户管理（7 个脚本）

**目录：** [`06_real_world/04_user_manager/`](06_real_world/04_user_manager/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_batch_create_users.sh`](06_real_world/04_user_manager/01_batch_create_users.sh) | 批量创建用户 | ⭐⭐⭐⭐ |
| [`02_import_export_users.sh`](06_real_world/04_user_manager/02_import_export_users.sh) | 导入导出用户 | ⭐⭐⭐⭐ |
| [`03_password_manager.sh`](06_real_world/04_user_manager/03_password_manager.sh) | 密码管理 | ⭐⭐⭐⭐ |
| [`04_user_activity.sh`](06_real_world/04_user_manager/04_user_activity.sh) | 用户活动监控 | ⭐⭐⭐⭐⭐ |
| [`05_group_manager.sh`](06_real_world/04_user_manager/05_group_manager.sh) | 组管理 | ⭐⭐⭐⭐ |
| [`06_permission_audit.sh`](06_real_world/04_user_manager/06_permission_audit.sh) | 权限审计 | ⭐⭐⭐⭐⭐ |
| [`07_user_cleanup.sh`](06_real_world/04_user_manager/07_user_cleanup.sh) | 用户清理 | ⭐⭐⭐⭐⭐ |

---

### 7.5 部署脚本（5 个脚本）

**目录：** [`06_real_world/05_deploy_script/`](06_real_world/05_deploy_script/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_auto_deploy.sh`](06_real_world/05_deploy_script/01_auto_deploy.sh) | 自动部署 | ⭐⭐⭐⭐⭐ |
| [`02_rollback.sh`](06_real_world/05_deploy_script/02_rollback.sh) | 回滚 | ⭐⭐⭐⭐⭐ |
| [`03_health_check.sh`](06_real_world/05_deploy_script/03_health_check.sh) | 健康检查 | ⭐⭐⭐⭐ |
| [`04_blue_green_deploy.sh`](06_real_world/05_deploy_script/04_blue_green_deploy.sh) | 蓝绿部署 | ⭐⭐⭐⭐⭐ |
| [`05_canary_deploy.sh`](06_real_world/05_deploy_script/05_canary_deploy.sh) | 金丝雀部署 | ⭐⭐⭐⭐⭐ |

#### 7.5.1 自动部署

**脚本：** [`05_deploy_script/01_auto_deploy.sh`](06_real_world/05_deploy_script/01_auto_deploy.sh)

```bash
#!/bin/bash
set -e

APP_NAME="myapp"
DEPLOY_DIR="/var/www/$APP_NAME"
BACKUP_DIR="/backup/$APP_NAME"
DATE=$(date +%Y%m%d_%H%M%S)

echo "开始部署 $APP_NAME"

# 备份现有版本
if [ -d "$DEPLOY_DIR" ]; then
    echo "备份现有版本..."
    cp -r "$DEPLOY_DIR" "$BACKUP_DIR/$DATE"
fi

# 拉取最新代码
cd /opt/$APP_NAME
git pull origin main

# 安装依赖
npm install --production

# 构建
npm run build

# 部署
rsync -avz --delete dist/ "$DEPLOY_DIR/"

# 重启服务
systemctl restart $APP_NAME

# 健康检查
sleep 5
curl -f http://localhost:3000/health || {
    echo "健康检查失败，回滚..."
    cp -r "$BACKUP_DIR/$DATE/." "$DEPLOY_DIR/"
    systemctl restart $APP_NAME
    exit 1
}

echo "部署成功！"
```

---

### 7.6 网络工具（7 个脚本）

**目录：** [`06_real_world/06_network_tools/`](06_real_world/06_network_tools/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_ping_monitor.sh`](06_real_world/06_network_tools/01_ping_monitor.sh) | Ping 监控 | ⭐⭐⭐⭐ |
| [`02_dns_check.sh`](06_real_world/06_network_tools/02_dns_check.sh) | DNS 检查 | ⭐⭐⭐⭐ |
| [`03_port_scanner.sh`](06_real_world/06_network_tools/03_port_scanner.sh) | 端口扫描 | ⭐⭐⭐⭐ |
| [`04_bandwidth_monitor.sh`](06_real_world/06_network_tools/04_bandwidth_monitor.sh) | 带宽监控 | ⭐⭐⭐⭐⭐ |
| [`05_ssl_check.sh`](06_real_world/06_network_tools/05_ssl_check.sh) | SSL 证书检查 | ⭐⭐⭐⭐ |
| [`06_http_check.sh`](06_real_world/06_network_tools/06_http_check.sh) | HTTP 检查 | ⭐⭐⭐⭐ |
| [`07_network_map.sh`](06_real_world/06_network_tools/07_network_map.sh) | 网络拓扑 | ⭐⭐⭐⭐⭐ |

---

### 7.7 安全工具（8 个脚本）

**目录：** [`06_real_world/07_security_tools/`](06_real_world/07_security_tools/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_port_scanner.sh`](06_real_world/07_security_tools/01_port_scanner.sh) | 端口扫描 | ⭐⭐⭐⭐ |
| [`02_log_auditor.sh`](06_real_world/07_security_tools/02_log_auditor.sh) | 日志审计 | ⭐⭐⭐⭐⭐ |
| [`03_password_generator.sh`](06_real_world/07_security_tools/03_password_generator.sh) | 密码生成 | ⭐⭐⭐⭐ |
| [`04_file_integrity.sh`](06_real_world/07_security_tools/04_file_integrity.sh) | 文件完整性检查 | ⭐⭐⭐⭐⭐ |
| [`05_ssh_key_manager.sh`](06_real_world/07_security_tools/05_ssh_key_manager.sh) | SSH 密钥管理 | ⭐⭐⭐⭐ |
| [`06_firewall_rules.sh`](06_real_world/07_security_tools/06_firewall_rules.sh) | 防火墙规则 | ⭐⭐⭐⭐⭐ |
| [`07_vulnerability_scan.sh`](06_real_world/07_security_tools/07_vulnerability_scan.sh) | 漏洞扫描 | ⭐⭐⭐⭐⭐ |
| [`08_security_report.sh`](06_real_world/07_security_tools/08_security_report.sh) | 安全报告 | ⭐⭐⭐⭐⭐ |

---

### 7.8 DevOps 工具（21 个脚本）

**目录：** [`06_real_world/08_devops_tools/`](06_real_world/08_devops_tools/)

| 脚本 | 功能 | 难度 |
|------|------|------|
| [`01_docker_deploy.sh`](06_real_world/08_devops_tools/01_docker_deploy.sh) | Docker 部署 | ⭐⭐⭐⭐⭐ |
| [`02_docker_compose.sh`](06_real_world/08_devops_tools/02_docker_compose.sh) | Docker Compose | ⭐⭐⭐⭐⭐ |
| [`03_k8s_deploy.sh`](06_real_world/08_devops_tools/03_k8s_deploy.sh) | K8s 部署 | ⭐⭐⭐⭐⭐ |
| [`04_jenkins_job.sh`](06_real_world/08_devops_tools/04_jenkins_job.sh) | Jenkins 任务 | ⭐⭐⭐⭐⭐ |
| [`05_ansible_playbook.sh`](06_real_world/08_devops_tools/05_ansible_playbook.sh) | Ansible 剧本 | ⭐⭐⭐⭐⭐ |
| [`06_terraform_apply.sh`](06_real_world/08_devops_tools/06_terraform_apply.sh) | Terraform | ⭐⭐⭐⭐⭐ |
| [`07_prometheus_monitor.sh`](06_real_world/08_devops_tools/07_prometheus_monitor.sh) | Prometheus 监控 | ⭐⭐⭐⭐⭐ |
| [`08_grafana_dashboard.sh`](06_real_world/08_devops_tools/08_grafana_dashboard.sh) | Grafana 仪表板 | ⭐⭐⭐⭐⭐ |
| [`09_elk_stack.sh`](06_real_world/08_devops_tools/09_elk_stack.sh) | ELK 日志栈 | ⭐⭐⭐⭐⭐ |
| [`10_gitlab_ci.sh`](06_real_world/08_devops_tools/10_gitlab_ci.sh) | GitLab CI | ⭐⭐⭐⭐⭐ |
| [`11_github_actions.sh`](06_real_world/08_devops_tools/11_github_actions.sh) | GitHub Actions | ⭐⭐⭐⭐⭐ |
| [`12_argocd_deploy.sh`](06_real_world/08_devops_tools/12_argocd_deploy.sh) | ArgoCD 部署 | ⭐⭐⭐⭐⭐ |
| [`13_helm_chart.sh`](06_real_world/08_devops_tools/13_helm_chart.sh) | Helm Chart | ⭐⭐⭐⭐⭐ |
| [`14_vault_secret.sh`](06_real_world/08_devops_tools/14_vault_secret.sh) | Vault 密钥 | ⭐⭐⭐⭐⭐ |
| [`15_consul_service.sh`](06_real_world/08_devops_tools/15_consul_service.sh) | Consul 服务 | ⭐⭐⭐⭐⭐ |
| [`16_nginx_config.sh`](06_real_world/08_devops_tools/16_nginx_config.sh) | Nginx 配置 | ⭐⭐⭐⭐ |
| [`17_ssl_certbot.sh`](06_real_world/08_devops_tools/17_ssl_certbot.sh) | SSL 证书 | ⭐⭐⭐⭐ |
| [`18_backup_automation.sh`](06_real_world/08_devops_tools/18_backup_automation.sh) | 备份自动化 | ⭐⭐⭐⭐⭐ |
| [`19_log_aggregation.sh`](06_real_world/08_devops_tools/19_log_aggregation.sh) | 日志聚合 | ⭐⭐⭐⭐⭐ |
| [`20_alert_manager.sh`](06_real_world/08_devops_tools/20_alert_manager.sh) | 告警管理 | ⭐⭐⭐⭐⭐ |
| [`21_cost_optimizer.sh`](06_real_world/08_devops_tools/21_cost_optimizer.sh) | 成本优化 | ⭐⭐⭐⭐⭐ |

#### 7.8.1 Docker 部署

**脚本：** [`08_devops_tools/01_docker_deploy.sh`](06_real_world/08_devops_tools/01_docker_deploy.sh)

```bash
#!/bin/bash
set -e

APP_NAME="myapp"
IMAGE_NAME="$APP_NAME:latest"
CONTAINER_NAME="$APP_NAME-container"

echo "构建 Docker 镜像..."
docker build -t $IMAGE_NAME .

echo "停止旧容器..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "启动新容器..."
docker run -d \
    --name $CONTAINER_NAME \
    -p 8080:80 \
    -v /var/log/$APP_NAME:/var/log/app \
    -e ENV=production \
    $IMAGE_NAME

echo "清理旧镜像..."
docker image prune -f

echo "部署完成！"
docker ps | grep $CONTAINER_NAME
```

---

## 附录 A 学习资源

### 在线教程

| 资源 | 链接 | 说明 |
|------|------|------|
| Bash 官方手册 | https://www.gnu.org/software/bash/manual/ | 最权威的 Bash 文档 |
| Shell 脚本编程指南 | https://bashguide.readthedocs.io/ | 现代 Bash 编程最佳实践 |
| Linux Command | https://linuxcommand.org/ | Linux 命令入门教程 |
| Explain Shell | https://explainshell.com/ | 解释 Shell 命令 |
| ShellCheck | https://www.shellcheck.net/ | Shell 脚本语法检查 |

### 练习平台

| 平台 | 链接 | 说明 |
|------|------|------|
| Exercism - Bash | https://exercism.org/tracks/bash | 互动式 Bash 练习 |
| HackerRank - Shell | https://www.hackerrank.com/domains/shell | Shell 编程挑战 |
| Codewars - Shell | https://www.codewars.com/?language=shell | Shell 编程游戏化学习 |
| LeetCode - Shell | https://leetcode.com/problemset/shell/ | Shell 编程题目 |
| OverTheWire - Bandit | https://overthewire.org/wargames/bandit/ | Linux 安全游戏 |

### 推荐书籍

| 书名 | 作者 | 难度 |
|------|------|------|
| 《Linux Shell 脚本攻略》 | Shantanu Tushar | ⭐⭐⭐ |
| 《Bash 编程指南》 | 刘遄 | ⭐⭐⭐ |
| 《awk 程序设计语言》 | Alfred V. Aho | ⭐⭐⭐⭐ |
| 《sed & awk 中文版》 | Dale Dougherty | ⭐⭐⭐⭐ |
| 《Linux 命令行与 shell 脚本编程大全》 | Richard Blum | ⭐⭐⭐⭐ |

---

## 附录 B 常用命令速查

### 文件操作

| 命令 | 说明 | 示例 |
|------|------|------|
| `ls` | 列出文件 | `ls -la` |
| `cd` | 切换目录 | `cd /var/log` |
| `pwd` | 显示当前目录 | `pwd` |
| `cp` | 复制文件 | `cp file1 file2` |
| `mv` | 移动/重命名 | `mv old new` |
| `rm` | 删除文件 | `rm -rf dir/` |
| `mkdir` | 创建目录 | `mkdir -p a/b/c` |
| `touch` | 创建空文件 | `touch file.txt` |
| `ln` | 创建链接 | `ln -s target link` |
| `chmod` | 修改权限 | `chmod 755 script.sh` |
| `chown` | 修改所有者 | `chown user:group file` |

### 文本处理

| 命令 | 说明 | 示例 |
|------|------|------|
| `cat` | 显示文件 | `cat file.txt` |
| `less` | 分页查看 | `less file.txt` |
| `head` | 查看开头 | `head -n 10 file.txt` |
| `tail` | 查看结尾 | `tail -f log.txt` |
| `grep` | 搜索文本 | `grep "error" log.txt` |
| `sed` | 流编辑 | `sed 's/old/new/g' file` |
| `awk` | 文本分析 | `awk '{print $1}' file` |
| `cut` | 截取列 | `cut -d: -f1 /etc/passwd` |
| `sort` | 排序 | `sort -n numbers.txt` |
| `uniq` | 去重 | `sort file | uniq` |
| `wc` | 统计 | `wc -l file.txt` |
| `diff` | 比较文件 | `diff file1 file2` |

### 系统信息

| 命令 | 说明 | 示例 |
|------|------|------|
| `uname` | 系统信息 | `uname -a` |
| `hostname` | 主机名 | `hostname` |
| `whoami` | 当前用户 | `whoami` |
| `uptime` | 运行时间 | `uptime` |
| `free` | 内存使用 | `free -h` |
| `df` | 磁盘空间 | `df -h` |
| `du` | 目录大小 | `du -sh *` |
| `top` | 进程监控 | `top` |
| `ps` | 进程状态 | `ps aux` |
| `kill` | 终止进程 | `kill -9 PID` |
| `netstat` | 网络状态 | `netstat -tulpn` |
| `ss` | Socket 统计 | `ss -tulpn` |

### 压缩与归档

| 命令 | 说明 | 示例 |
|------|------|------|
| `tar` | 归档 | `tar -czf archive.tar.gz dir/` |
| `gzip` | 压缩 | `gzip file.txt` |
| `gunzip` | 解压 | `gunzip file.gz` |
| `zip` | ZIP 压缩 | `zip archive.zip file` |
| `unzip` | ZIP 解压 | `unzip archive.zip` |

### 网络命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `ping` | 测试连通性 | `ping google.com` |
| `curl` | HTTP 请求 | `curl https://api.example.com` |
| `wget` | 下载文件 | `wget https://example.com/file` |
| `ssh` | 远程登录 | `ssh user@host` |
| `scp` | 远程复制 | `scp file user@host:/path` |
| `rsync` | 同步文件 | `rsync -avz src/ dst/` |
| `nslookup` | DNS 查询 | `nslookup example.com` |
| `dig` | DNS 查询 | `dig example.com` |
| `traceroute` | 路由追踪 | `traceroute google.com` |

### 进程管理

| 命令 | 说明 | 示例 |
|------|------|------|
| `jobs` | 查看任务 | `jobs -l` |
| `fg` | 前台运行 | `fg %1` |
| `bg` | 后台运行 | `bg %1` |
| `nohup` | 忽略挂起 | `nohup command &` |
| `screen` | 终端复用 | `screen -S session` |
| `tmux` | 终端复用 | `tmux new -s session` |

### 用户与权限

| 命令 | 说明 | 示例 |
|------|------|------|
| `su` | 切换用户 | `su - username` |
| `sudo` | 超级用户 | `sudo command` |
| `useradd` | 创建用户 | `useradd -m username` |
| `userdel` | 删除用户 | `userdel username` |
| `passwd` | 修改密码 | `passwd username` |
| `groupadd` | 创建组 | `groupadd groupname` |
| `usermod` | 修改用户 | `usermod -aG group user` |

### 磁盘管理

| 命令 | 说明 | 示例 |
|------|------|------|
| `fdisk` | 分区 | `fdisk /dev/sda` |
| `mkfs` | 格式化 | `mkfs.ext4 /dev/sda1` |
| `mount` | 挂载 | `mount /dev/sda1 /mnt` |
| `umount` | 卸载 | `umount /mnt` |
| `fsck` | 文件系统检查 | `fsck /dev/sda1` |

### 软件包管理

| 发行版 | 命令 | 示例 |
|--------|------|------|
| Debian/Ubuntu | `apt` | `apt install package` |
| RHEL/CentOS | `yum` | `yum install package` |
| RHEL/CentOS 8+ | `dnf` | `dnf install package` |
| Arch Linux | `pacman` | `pacman -S package` |
| macOS | `brew` | `brew install package` |

### 常用快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+C` | 中断当前命令 |
| `Ctrl+Z` | 挂起当前命令 |
| `Ctrl+D` | 退出 Shell |
| `Ctrl+L` | 清屏 |
| `Ctrl+A` | 移动到行首 |
| `Ctrl+E` | 移动到行尾 |
| `Ctrl+U` | 删除到行首 |
| `Ctrl+K` | 删除到行尾 |
| `Ctrl+R` | 搜索历史命令 |
| `Ctrl+G` | 退出搜索 |
| `Tab` | 自动补全 |
| `!!` | 上一条命令 |
| `!$` | 上一条命令的最后一个参数 |

### 变量操作

| 操作 | 语法 | 示例 |
|------|------|------|
| 定义变量 | `var=value` | `name="Alice"` |
| 使用变量 | `$var` 或 `${var}` | `echo $name` |
| 变量长度 | `${#var}` | `echo ${#name}` |
| 截取子串 | `${var:0:5}` | `echo ${name:0:3}` |
| 替换 | `${var/old/new}` | `echo ${name/Alice/Bob}` |
| 删除匹配前缀 | `${var#pattern}` | `echo ${url#http://}` |
| 删除匹配后缀 | `${var%pattern}` | `echo ${file%.txt}` |
| 默认值 | `${var:-default}` | `echo ${name:-Guest}` |
| 设置默认值 | `${var:=default}` | `echo ${name:=Guest}` |

### 重定向与管道

| 操作符 | 说明 | 示例 |
|--------|------|------|
| `>` | 输出重定向（覆盖） | `echo "text" > file` |
| `>>` | 输出重定向（追加） | `echo "text" >> file` |
| `<` | 输入重定向 | `cat < file` |
| `2>` | 错误重定向 | `command 2> error.log` |
| `&>` | 所有输出重定向 | `command &> output.log` |
| `\|` | 管道 | `cat file \| grep pattern` |
| `xargs` | 参数传递 | `find . -name "*.txt" \| xargs rm` |

### 调试技巧

| 方法 | 说明 | 示例 |
|------|------|------|
| `set -x` | 打印执行的命令 | `set -x; command` |
| `set -v` | 打印读取的命令 | `set -v; command` |
| `set -e` | 遇到错误退出 | `set -e; command` |
| `set -u` | 未定义变量报错 | `set -u; echo $var` |
| `bash -n` | 语法检查 | `bash -n script.sh` |
| `bash -x` | 调试执行 | `bash -x script.sh` |
| `shellcheck` | 静态分析 | `shellcheck script.sh` |

---

## 附录 C 脚本索引

### 按难度分类

#### ⭐ 入门（5 个脚本）

| 脚本 | 名称 | 位置 |
|------|------|------|
| [01_hello_world.sh](00_quickstart/01_hello_world.sh) | Hello World | 00_quickstart/ |
| [02_special_variables.sh](00_quickstart/02_special_variables.sh) | 特殊变量 | 00_quickstart/ |
| [03_echo_read.sh](00_quickstart/03_echo_read.sh) | 输入输出 | 00_quickstart/ |
| [04_shell_environment_check.sh](00_quickstart/04_shell_environment_check.sh) | 环境检测 | 00_quickstart/ |
| [05_script_execution_methods.sh](00_quickstart/05_script_execution_methods.sh) | 执行方式 | 00_quickstart/ |

#### ⭐⭐ 初级（28 个脚本）

**01_basics/** (28 个脚本)
- 变量 (7 个)
- 运算符 (10 个)
- 输入输出 (3 个)
- 高级变量 (8 个)

#### ⭐⭐⭐ 中级（86 个脚本）

**02_control_flow/** (67 个脚本)
- 条件判断 (10 个)
- case 语句 (3 个)
- 循环结构 (20 个)
- 函数 (37 个)

**03_data_structures/** (19 个脚本)
- 索引数组 (7 个)
- 关联数组 (6 个)
- 字符串处理 (6 个)

#### ⭐⭐⭐⭐ 高级（58 个脚本）

**04_text_processing/** (23 个脚本)
- grep (8 个)
- sed (7 个)
- awk (8 个)

**05_system_programming/** (35 个脚本)
- Shell 初始化 (10 个)
- 作业控制 (7 个)
- 信号处理 (5 个)
- 并发控制 (6 个)
- 快捷操作 (7 个)

#### ⭐⭐⭐⭐⭐ 专家（49 个脚本）

**06_real_world/** (49 个脚本)
- 系统监控 (5 个)
- 备份自动化 (5 个)
- 日志分析 (5 个)
- 用户管理 (7 个)
- 部署脚本 (5 个)
- 网络工具 (7 个)
- 安全工具 (8 个)
- DevOps 工具 (21 个)

---

## 📊 仓库统计

| 指标 | 数值 |
|------|------|
| **脚本总数** | **226 个** ✅ |
| **代码行数** | **24,242 行** |
| **学习阶段** | **7 个** |
| **学习天数** | **90 天** |
| **文档数量** | **29 个 MD 文件** |

---

**最后更新**：2026-03-20  
**作者**：hjs2015  
**仓库**：https://github.com/hjs2015/shell-notes  
**版本**：v3.0（226 个脚本完整版）  
**许可证**：CC BY-SA 4.0

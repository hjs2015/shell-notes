# Shell 编程完全指南

> 基于 103 个实战脚本的系统性学习手册，从入门到 DevOps 实战

**仓库地址：** https://github.com/hjs2015/shell-notes  
**脚本总数：** 103 个  
**代码行数：** ~20,000 行  
**学习周期：** 90 天（从入门到实战）

---

## 📚 目录

- [第 1 章 快速开始（第 1 天）](#第-1-章-快速开始第 -1-天)
  - [1.1 Hello World](#11-hello-world)
  - [1.2 特殊变量](#12-特殊变量)
  - [1.3 通配符与 Echo](#13-通配符与-echo)
- [第 2 章 Bash 基础（第 2-7 天）](#第-2 章-bash 基础第 -2-7-天)
  - [2.1 变量](#21-变量)
  - [2.2 运算符](#22-运算符)
  - [2.3 输入输出](#23-输入输出)
- [第 3 章 流程控制（第 8-28 天）](#第-3 章-流程控制第 -8-28-天)
  - [3.1 条件判断](#31-条件判断)
  - [3.2 循环结构](#32-循环结构)
  - [3.3 Case 语句](#33-case 语句)
  - [3.4 函数](#34-函数)
- [第 4 章 数据结构（第 22-28 天）](#第-4 章-数据结构第 -22-28-天)
  - [4.1 索引数组](#41-索引数组)
  - [4.2 关联数组](#42-关联数组)
  - [4.3 字符串处理](#43-字符串处理)
- [第 5 章 文本处理（第 29-42 天）](#第-5 章-文本处理第 -29-42-天)
  - [5.1 Grep 高级用法](#51-grep 高级用法)
  - [5.2 Sed 高级用法](#52-sed 高级用法)
  - [5.3 Awk 高级用法](#53-awk 高级用法)
- [第 6 章 系统编程（第 43-58 天）](#第-6 章-系统编程第 -43-58-天)
  - [6.1 Shell 初始化](#61-shell 初始化)
  - [6.2 作业控制](#62-作业控制)
  - [6.3 并发控制](#63-并发控制)
  - [6.4 快捷键与别名](#64-快捷键与别名)
- [第 7 章 实战项目（第 59-90 天）](#第-7 章-实战项目第 -59-90-天)
  - [7.1 安全工具](#71-安全工具)
  - [7.2 DevOps 工具](#72-devops 工具)
- [附录 A 学习资源](#附录-a 学习资源)
- [附录 B 常用命令速查](#附录-b 常用命令速查)

---

## 第 1 章 快速开始（第 1 天）

> ⭐ 难度等级：入门 | 📁 脚本数量：3 个 | ⏱️ 学习时长：1 天

快速上手 Shell 编程，完成第一个脚本。

### 1.1 Hello World

**脚本路径：** `00_quickstart/01_hello_world.sh`

```bash
#!/bin/bash
# 第一个 Shell 脚本
echo 1
echo 2
echo 3
```

**知识点：**
- shebang (`#!/bin/bash`) - 指定脚本解释器
- `echo` 命令 - 输出文本
- 换行符 - echo 自动添加

**执行方式：**
```bash
chmod +x 01_hello_world.sh
./01_hello_world.sh
```

**输出：**
```
1
2
3
```

---

### 1.2 特殊变量

**脚本路径：** `00_quickstart/02_special_variables.sh`

**知识点：**
- `$0` - 脚本名称
- `$1`, `$2`, ... - 位置参数
- `$#` - 参数个数
- `$@` - 所有参数
- `$*` - 所有参数（作为一个字符串）
- `$?` - 上一个命令的退出码
- `$$` - 当前进程 ID
- `$!` - 最后一个后台进程 ID

**示例：**
```bash
#!/bin/bash
echo "脚本名称：$0"
echo "第一个参数：$1"
echo "参数个数：\`$#\`"
echo "所有参数：$@"
echo "退出码：$?"
```

---

### 1.3 通配符与 Echo

**脚本路径：** `00_quickstart/05_wildcards_and_echo.sh`

**知识点：**
- `*` - 匹配任意字符
- `?` - 匹配单个字符
- `[abc]` - 匹配指定字符
- `[0-9]` - 匹配范围
- `echo` 命令的高级用法

---

## 第 2 章 Bash 基础（第 2-7 天）

> ⭐⭐ 难度等级：初级 | 📁 脚本数量：12 个 | ⏱️ 学习时长：6 天

掌握 Shell 编程的基础知识：变量、运算符、输入输出。

### 2.1 变量

**脚本数量：** 6 个

#### 2.1.1 变量定义与使用

**脚本路径：** `01_basics/01_variables/01_hello_world.sh`

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

#### 2.1.2 特殊变量详解

**脚本路径：** `01_basics/01_variables/02_special_variables.sh`

**知识点：**
- 位置参数：`$1`, `$2`, ..., `$9`, `${10}`
- 特殊变量：`$#`, `$@`, `$*`, `$?`, `$$`, `$!`
- 环境变量 vs 局部变量

#### 2.1.3 变量操作

**脚本路径：** `01_basics/01_variables/06_variable_operations.sh`

**知识点：**
- 变量长度：`${#var}`
- 截取字符串：`${var:0:5}`
- 替换字符串：`${var/old/new}`
- 删除匹配：`${var#pattern}`, `${var%pattern}`

#### 2.1.4 布尔与逻辑

**脚本路径：** `01_basics/01_variables/07_boolean_and_logic.sh`

**知识点：**
- 布尔值：`true`, `false`
- 逻辑运算：`&&`, `||`, `!`
- 条件测试：`[ ]`, `[[ ]]`

---

### 2.2 运算符

**脚本数量：** 1 个

**脚本路径：** `01_basics/02_operators/07_arithmetic.sh`

**知识点：**
- 算术运算：`+`, `-`, `*`, `/`, `%`
- 比较运算：`-eq`, `-ne`, `-gt`, `-lt`, `-ge`, `-le`
- 位运算：`&`, `|`, `^`, `~`, `<<`, `>>`
- 自增自减：`((i++))`, `((--i))`

**示例：**
```bash
#!/bin/bash
a=10
b=3

# 算术运算
echo "a + b = $((a + b))"
echo "a / b = $((a / b))"
echo "a % b = $((a % b))"

# 比较运算
if [ $a -gt $b ]; then
    echo "a > b"
fi
```

---

### 2.3 输入输出

**脚本数量：** 5 个

#### 2.3.1 基础输入输出

**脚本路径：** `01_basics/03_io/01_name_phone_age.sh`

```bash
#!/bin/bash
# 读取用户输入
echo "请输入姓名："
read name
echo "请输入电话："
read phone
echo "请输入年龄："
read age

# 输出信息
echo "===================="
echo "姓名：$name"
echo "电话：$phone"
echo "年龄：$age"
```

#### 2.3.2 文件存在性检查

**脚本路径：** `01_basics/03_io/03_file_exist_check.sh`

**知识点：**
- `[ -e file ]` - 文件是否存在
- `[ -f file ]` - 是否是普通文件
- `[ -d dir ]` - 是否是目录
- `[ -r file ]` - 是否可读
- `[ -w file ]` - 是否可写
- `[ -x file ]` - 是否可执行

#### 2.3.3 Ping 检查

**脚本路径：** `01_basics/03_io/04_ping_check.sh`

**知识点：**
- `ping` 命令检查网络连通性
- 检查命令退出码
- 条件判断与输出

---

## 第 3 章 流程控制（第 8-28 天）

> ⭐⭐⭐ 难度等级：中级 | 📁 脚本数量：44 个 | ⏱️ 学习时长：21 天

掌握 Shell 编程的核心：条件判断、循环、case 语句、函数。

### 3.1 条件判断

**脚本数量：** 7 个

#### 3.1.1 逻辑运算

**脚本路径：** `02_control_flow/01_condition/01_logic_operation.sh`

**知识点：**
- `-a` (AND), `-o` (OR)
- `&&` (AND), `||` (OR)
- `!` (NOT)
- 复杂条件组合

**示例：**
```bash
#!/bin/bash
age=25
gender="male"

# 逻辑与
if [ $age -gt 18 ] && [ "$gender" = "male" ]; then
    echo "成年男性"
fi

# 逻辑或
if [ $age -lt 18 ] || [ $age -gt 60 ]; then
    echo "非劳动年龄"
fi
```

#### 3.1.2 文件类型检查

**脚本路径：** `02_control_flow/01_condition/02_file_type_check.sh`

**知识点：**
- 文件类型判断：`-f`, `-d`, `-l`, `-b`, `-c`, `-p`, `-s`
- 文件属性：`-r`, `-w`, `-x`, `-u`, `-g`
- 文件比较：`-nt` (newer than), `-ot` (older than)

#### 3.1.3 字符串比较

**脚本路径：** `02_control_flow/01_condition/06_string_comparison.sh`

**知识点：**
- `=` 等于
- `!=` 不等于
- `-z` 空字符串
- `-n` 非空字符串
- `<` 小于（字典序）
- `>` 大于（字典序）

---

### 3.2 循环结构

**脚本数量：** 18 个

#### 3.2.1 For 循环基础

**脚本路径：** `02_control_flow/02_loops/04_for_loop_basic.sh`

```bash
#!/bin/bash
# 遍历列表
for day in Mon Tue Wed Thu Fri; do
    echo "Day: $day"
done

# 遍历命令输出
for file in $(ls *.txt); do
    echo "File: $file"
done

# C 风格 for 循环
for ((i=0; i<5; i++)); do
    echo "Number: $i"
done
```

#### 3.2.2 While 循环

**脚本路径：** `02_control_flow/02_loops/04_until_loop.sh`

```bash
#!/bin/bash
# while 循环
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done

# until 循环（条件为假时执行）
count=5
until [ $count -le 0 ]; do
    echo "Countdown: $count"
    ((count--))
done
```

#### 3.2.3 实战案例

**脚本路径：** `02_control_flow/02_loops/`

| 脚本 | 功能 | 难度 |
|------|------|------|
| `02_multiplication_table.sh` | 打印九九乘法表 | ⭐⭐ |
| `03_countdown_2018.sh` | 倒计时程序 | ⭐⭐ |
| `08_guess_number_game.sh` | 猜数字游戏 | ⭐⭐⭐ |
| `12_prime_numbers.sh` | 求素数 | ⭐⭐⭐ |
| `16_generate_phone_numbers.sh` | 生成手机号 | ⭐⭐ |
| `18_fake_login_screen.sh` | 假登录界面 | ⭐⭐ |

**九九乘法表示例：**
```bash
#!/bin/bash
for ((i=1; i<=9; i++)); do
    for ((j=1; j<=i; j++)); do
        echo -n "$j×$i=$((i*j)) "
    done
    echo
done
```

---

### 3.3 Case 语句

**脚本数量：** 12 个

#### 3.3.1 基础用法

**脚本路径：** `02_control_flow/03_case/02_menu_system.sh`

```bash
#!/bin/bash
echo "====== 菜单系统 ======"
echo "1. 启动服务"
echo "2. 停止服务"
echo "3. 重启服务"
echo "4. 退出"
echo "======================"

read -p "请选择操作 [1-4]: " choice

case $choice in
    1)
        echo "正在启动服务..."
        ;;
    2)
        echo "正在停止服务..."
        ;;
    3)
        echo "正在重启服务..."
        ;;
    4)
        echo "退出程序"
        exit 0
        ;;
    *)
        echo "无效选择"
        ;;
esac
```

#### 3.3.2 实战案例

**脚本路径：** `02_control_flow/03_case/`

| 脚本 | 功能 | 难度 |
|------|------|------|
| `01_char_type_check.sh` | 字符类型检查 | ⭐⭐ |
| `03_service_price.sh` | 服务价格查询 | ⭐⭐ |
| `04_phone_brand_menu.sh` | 手机品牌菜单 | ⭐⭐ |
| `06_sysv_init_script.sh` | SysV 初始化脚本 | ⭐⭐⭐ |
| `08_number_to_words.sh` | 数字转中文 | ⭐⭐⭐ |
| `12_tetris_game.sh` | 俄罗斯方块游戏 | ⭐⭐⭐⭐⭐ |

---

### 3.4 函数

**脚本数量：** 4 个

#### 3.4.1 函数基础

**脚本路径：** `02_control_flow/04_functions/01_function_basics.sh`

```bash
#!/bin/bash
# 定义函数
greet() {
    echo "Hello, $1!"
}

# 调用函数
greet "World"
greet "Shell"
```

#### 3.4.2 函数参数与返回值

**脚本路径：** `02_control_flow/04_functions/02_function_parameters.sh`

**知识点：**
- 函数参数：`$1`, `$2`, ...
- 参数个数：`$#`
- 所有参数：`$@`, `$*`
- 返回值：`return` (0-255)
- 函数输出：`echo` + 命令替换

#### 3.4.3 局部变量

**脚本路径：** `02_control_flow/04_functions/03_local_variables.sh`

```bash
#!/bin/bash
my_function() {
    local var="local value"  # 局部变量
    global_var="global value" # 全局变量
    echo "Local: $var"
}
```

---

## 第 4 章 数据结构（第 22-28 天）

> ⭐⭐⭐ 难度等级：中级 | 📁 脚本数量：4 个 | ⏱️ 学习时长：7 天

### 4.1 索引数组

**脚本数量：** 2 个

**脚本路径：** `03_data_structures/01_indexed_arrays/`

```bash
#!/bin/bash
# 定义数组
fruits=("apple" "banana" "orange")

# 访问元素
echo "First: ${fruits[0]}"
echo "All: ${fruits[@]}"

# 数组长度
echo "Length: ${#fruits[@]}"

# 遍历数组
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done

# 添加元素
fruits+=("grape")

# 删除元素
unset fruits[1]
```

---

### 4.2 关联数组

**脚本数量：** 1 个

**脚本路径：** `03_data_structures/02_associative_arrays/16_associative_arrays.sh`

```bash
#!/bin/bash
# 声明关联数组
declare -A colors

# 添加元素
colors[red]="#FF0000"
colors[green]="#00FF00"
colors[blue]="#0000FF"

# 访问元素
echo "Red: ${colors[red]}"

# 遍历
for key in "${!colors[@]}"; do
    echo "$key: ${colors[$key]}"
done
```

---

### 4.3 字符串处理

**脚本数量：** 1 个

**脚本路径：** `03_data_structures/03_strings/14_variable_advanced.sh`

**知识点：**
- 字符串截取
- 字符串替换
- 字符串删除
- 字符串长度
- 大小写转换

---

## 第 5 章 文本处理（第 29-42 天）

> ⭐⭐⭐⭐ 难度等级：高级 | 📁 脚本数量：3 个 | ⏱️ 学习时长：14 天

### 5.1 Grep 高级用法

**脚本路径：** `04_text_processing/01_grep/13_grep_advanced.sh`

**知识点：**
- 基础正则表达式
- 扩展正则表达式 (`-E`)
- 反向匹配 (`-v`)
- 显示行号 (`-n`)
- 递归搜索 (`-r`)
- 只显示匹配部分 (`-o`)

**示例：**
```bash
#!/bin/bash
# 搜索包含 "error" 的行
grep "error" logfile.txt

# 忽略大小写
grep -i "error" logfile.txt

# 显示行号
grep -n "error" logfile.txt

# 递归搜索目录
grep -r "TODO" /path/to/code/

# 使用正则表达式
grep -E "^[0-9]{3}-[0-9]{4}$" phone.txt
```

---

### 5.2 Sed 高级用法

**脚本路径：** `04_text_processing/02_sed/14_sed_advanced.sh`

**知识点：**
- 替换：`s/old/new/g`
- 删除：`/pattern/d`
- 插入：`i\text`
- 追加：`a\text`
- 打印：`-n`, `p`
- 文件修改：`-i`

**示例：**
```bash
#!/bin/bash
# 替换第一个匹配
sed 's/old/new/' file.txt

# 替换所有匹配
sed 's/old/new/g' file.txt

# 删除空行
sed '/^$/d' file.txt

# 就地修改
sed -i 's/old/new/g' file.txt

# 打印特定行
sed -n '5,10p' file.txt
```

---

### 5.3 Awk 高级用法

**脚本路径：** `04_text_processing/03_awk/15_awk_advanced.sh`

**知识点：**
- 字段分隔：`-F`
- 内置变量：`$0`, `$1`, `NF`, `NR`
- 条件过滤
- 格式化输出
- 内置函数

**示例：**
```bash
#!/bin/bash
# 打印第一列
awk '{print $1}' file.txt

# 指定分隔符
awk -F: '{print $1}' /etc/passwd

# 条件过滤
awk '$3 > 1000 {print $1, $3}' data.txt

# 格式化输出
awk -F: '{printf "%-20s %s\n", $1, $3}' /etc/passwd

# 统计
awk '{sum+=$1} END {print sum}' numbers.txt
```

---

## 第 6 章 系统编程（第 43-58 天）

> ⭐⭐⭐⭐ 难度等级：高级 | 📁 脚本数量：10 个 | ⏱️ 学习时长：16 天

### 6.1 Shell 初始化

**脚本数量：** 5 个

**脚本路径：** `05_system_programming/01_shell_init/`

| 脚本 | 功能 |
|------|------|
| `01_return_code_and_logic.sh` | 返回码与逻辑运算 |
| `02_boolean_and_special_vars.sh` | 布尔与特殊变量 |
| `04_redirection_and_pipe.sh` | 重定向与管道 |
| `10_shell_initialization.sh` | Shell 初始化文件 |
| `01_log_rotation.sh` | 日志轮转 |

#### 6.1.1 返回码与逻辑运算

**脚本路径：** `05_system_programming/01_shell_init/01_return_code_and_logic.sh`

**知识点：**
- 命令返回码：0 成功，非 0 失败
- `$?` 获取上一个命令的返回码
- 逻辑与：`command1 && command2`
- 逻辑或：`command1 || command2`

```bash
#!/bin/bash
if command -v git &>/dev/null; then
    echo "Git is installed"
else
    echo "Git is not installed"
fi
```

#### 6.1.2 重定向与管道

**脚本路径：** `05_system_programming/01_shell_init/04_redirection_and_pipe.sh`

**知识点：**
- 标准输出：`>` (覆盖), `>>` (追加)
- 标准错误：`2>`, `2>>`
- 标准输入：`<`
- 合并输出：`&>`, `2>&1`
- 管道：`|`
- Here Document：`<<EOF`

```bash
#!/bin/bash
# 重定向
ls > file.txt          # 输出到文件（覆盖）
ls >> file.txt         # 输出到文件（追加）
ls 2> error.txt        # 错误输出到文件
ls &> all.txt          # 所有输出到文件

# 管道
ls | grep ".txt" | wc -l

# Here Document
cat <<EOF
This is a here document.
Line 2.
EOF
```

---

### 6.2 作业控制

**脚本数量：** 2 个

**脚本路径：** `05_system_programming/02_job_control/`

**知识点：**
- 后台运行：`command &`
- 查看作业：`jobs`
- 带到前台：`fg %n`
- 带到后台：`bg %n`
- 挂起：`Ctrl+Z`
- 终止作业：`kill %n`

---

### 6.3 并发控制

**脚本数量：** 1 个

**脚本路径：** `05_system_programming/04_concurrency/08_concurrency_control.sh`

**知识点：**
- 并发执行
- 进程同步
- 信号量
- 文件锁

---

### 6.4 快捷键与别名

**脚本数量：** 2 个

**脚本路径：** `05_system_programming/05_shortcuts/`

| 脚本 | 功能 |
|------|------|
| `11_command_history.sh` | 命令历史管理 |
| `12_alias_function.sh` | 别名与函数 |

**常用快捷键：**
- `Ctrl+A` - 行首
- `Ctrl+E` - 行尾
- `Ctrl+U` - 删除到行首
- `Ctrl+K` - 删除到行尾
- `Ctrl+R` - 搜索历史
- `Ctrl+C` - 终止当前命令
- `Ctrl+Z` - 挂起当前命令

**别名设置：**
```bash
# ~/.bashrc
alias ll='ls -la'
alias gs='git status'
alias ..='cd ..'
```

---

## 第 7 章 实战项目（第 59-90 天）

> ⭐⭐⭐⭐⭐ 难度等级：专家 | 📁 脚本数量：24 个 | ⏱️ 学习时长：32 天

综合应用前面所学知识，完成实际工作中的 DevOps 任务。

### 7.1 安全工具

**脚本数量：** 3 个

**脚本路径：** `06_real_world/07_security_tools/`

#### 7.1.1 密码验证器

**脚本路径：** `06_real_world/07_security_tools/01_password_validator.sh`

**功能：**
- 密码强度检查
- 长度验证（最少 8 位）
- 复杂度验证（大小写 + 数字 + 特殊字符）
- 常见密码检查

**知识点：**
- 正则表达式验证
- 字符串处理
- 条件判断组合

---

#### 7.1.2 用户注册系统

**脚本路径：** `06_real_world/07_security_tools/02_user_register.sh`

**功能：**
- 用户名验证
- 密码加密存储
- 用户信息保存
- 重复用户检查

**知识点：**
- 文件读写
- 密码加密（openssl/md5sum）
- 数据验证

---

#### 7.1.3 用户登录系统

**脚本路径：** `06_real_world/07_security_tools/03_user_login.sh`

**功能：**
- 用户名密码验证
- 登录失败次数限制
- 登录日志记录
- 会话管理

**知识点：**
- 文件查找
- 计数器
- 日志记录

---

### 7.2 DevOps 工具

**脚本数量：** 21 个

**脚本路径：** `06_real_world/08_devops_tools/`

| # | 脚本 | 功能 | 难度 |
|---|------|------|------|
| 1 | `01_system_info_check.sh` | 系统信息检查 | ⭐⭐⭐ |
| 2 | `02_batch_user_manager.sh` | 批量用户管理 | ⭐⭐⭐ |
| 3 | `03_service_monitor.sh` | 服务监控 | ⭐⭐⭐ |
| 4 | `04_log_cleaner.sh` | 日志清理 | ⭐⭐ |
| 5 | `05_backup_automation.sh` | 备份自动化 | ⭐⭐⭐ |
| 6 | `06_server_inspection.sh` | 服务器巡检 | ⭐⭐⭐ |
| 7 | `07_project_check.sh` | 项目检查 | ⭐⭐ |
| 8 | `08_security_audit.sh` | 安全审计 | ⭐⭐⭐⭐ |
| 9 | `09_network_diagnosis.sh` | 网络诊断 | ⭐⭐⭐ |
| 10 | `10_performance_monitor.sh` | 性能监控 | ⭐⭐⭐ |
| 11 | `11_daily_inspection.sh` | 日常巡检 | ⭐⭐⭐ |
| 12 | `12_auto_deploy.sh` | 自动部署 | ⭐⭐⭐⭐ |
| 13 | `13_security_hardening.sh` | 安全加固 | ⭐⭐⭐⭐ |
| 14 | `14_log_analysis.sh` | 日志分析 | ⭐⭐⭐ |
| 15 | `15_container_manager.sh` | 容器管理 | ⭐⭐⭐⭐ |
| 16 | `16_database_backup.sh` | 数据库备份 | ⭐⭐⭐ |
| 17 | `17_ssl_monitor.sh` | SSL 证书监控 | ⭐⭐⭐ |
| 18 | `18_resource_cleanup.sh` | 资源清理 | ⭐⭐ |
| 19 | `19_bandwidth_monitor.sh` | 带宽监控 | ⭐⭐⭐ |
| 20 | `20_file_sync.sh` | 文件同步 | ⭐⭐⭐ |
| 21 | `21_security_baseline.sh` | 安全基线检查 | ⭐⭐⭐⭐ |

---

#### 7.2.1 系统信息检查

**脚本路径：** `06_real_world/08_devops_tools/01_system_info_check.sh`

**功能：**
- 操作系统信息
- 主机名
- 运行时间
- 内存使用情况
- 磁盘使用情况
- CPU 信息
- 网络接口

**输出示例：**
```
========================================
【系统信息】
操作系统：Linux 5.4.0-42-generic
主机名：web-server-01
运行时间：up 30 days, 2:15

【内存使用】
总内存：16GB
已用：8.2GB (51%)
可用：7.8GB

【磁盘使用】
/          45%
/data      72%
/backup    23%
========================================
```

**知识点：**
- `uname` - 系统信息
- `hostname` - 主机名
- `uptime` - 运行时间
- `free -h` - 内存信息
- `df -h` - 磁盘信息
- 颜色输出
- 函数封装

---

#### 7.2.2 批量用户管理

**脚本路径：** `06_real_world/08_devops_tools/02_batch_user_manager.sh`

**功能：**
- 批量创建用户
- 批量删除用户
- 批量修改密码
- 用户列表导出

**知识点：**
- `useradd`, `userdel`, `usermod`
- 密码设置：`echo "password" | passwd --stdin username`
- 文件读取与处理
- 错误处理

---

#### 7.2.3 服务监控

**脚本路径：** `06_real_world/08_devops_tools/03_service_monitor.sh`

**功能：**
- 检查服务状态
- 自动重启失败服务
- 发送告警通知
- 监控日志记录

**监控的服务：**
- Nginx
- MySQL
- Redis
- Docker
- SSH

**知识点：**
- `systemctl status`
- `ps aux`
- `netstat -tlnp`
- 告警通知（邮件/钉钉/飞书）

---

#### 7.2.4 自动部署

**脚本路径：** `06_real_world/08_devops_tools/12_auto_deploy.sh`

**功能：**
- 代码拉取（Git）
- 依赖安装
- 编译构建
- 服务重启
- 回滚支持

**知识点：**
- Git 操作
- 依赖管理（npm/pip/maven）
- 服务管理
- 版本控制
- 回滚机制

---

#### 7.2.5 容器管理

**脚本路径：** `06_real_world/08_devops_tools/15_container_manager.sh`

**功能：**
- 容器状态检查
- 容器重启
- 日志查看
- 资源使用统计
- 镜像清理

**知识点：**
- Docker 命令
- 容器监控
- 资源统计
- 镜像管理

---

## 附录 A 学习资源

### 在线学习网站

| 网站名称 | 网址 | 说明 |
|---------|------|------|
| 菜鸟教程 | https://www.runoob.com/linux/linux-shell.html | 适合初学者的 Shell 入门教程 |
| Linux 中国 | https://linux.cn/ | Linux 技术社区，大量 Shell 实战文章 |
| 博客园 | https://www.cnblogs.com/ | 搜索"Shell 编程"有很多优质博文 |
| GitHub | https://github.com/topics/shell-script | 开源 Shell 脚本项目和示例 |
| Stack Overflow | https://stackoverflow.com/questions/tagged/bash | Shell 编程问题解答 |

### 在线练习平台

| 平台名称 | 网址 | 说明 |
|---------|------|------|
| OnlineGDB | https://www.onlinegdb.com/online_bash_shell | 在线编写和运行 Shell 脚本，无需安装环境 |
| Repl.it | https://replit.com/languages/bash | 在线 Bash 编辑器，支持保存和分享代码 |
| ShellCheck | https://www.shellcheck.net/ | 在线检查 Shell 脚本语法错误，给出改进建议 ⭐ |
| Exonum Bash Playground | https://exonum.com/bash-playground/ | 交互式 Bash 练习环境 |
| Katacoda | https://www.katacoda.com/courses/linux | 基于浏览器的 Linux 和 Shell 实战场景 |

### 推荐书籍

- 《Linux 命令行与 shell 脚本编程大全》- 经典入门书籍
- 《UNIX Shell 编程》- 系统学习 Shell 编程
- 《Advanced Bash-Scripting Guide》- 免费在线教程（英文）

### 官方文档

- GNU Bash 手册：`man bash` 或 https://www.gnu.org/software/bash/manual/
- Linux 命令大全：`man [command]` 或 https://man7.org/linux/man-pages/

---

## 附录 B 常用命令速查

### 文件测试

```bash
[ -e file ]   # 是否存在
[ -f file ]   # 是否是文件
[ -d dir ]    # 是否是目录
[ -r file ]   # 是否可读
[ -w file ]   # 是否可写
[ -x file ]   # 是否可执行
[ -L file ]   # 是否符号链接
[ -s file ]   # 是否非空
[ -u file ]   # 是否设置了 SUID 位
[ -g file ]   # 是否设置了 SGID 位
[ file1 -nt file2 ]   # file1 是否比 file2 新
[ file1 -ot file2 ]   # file1 是否比 file2 旧
```

### 数值比较

```bash
[ $a -gt $b ]   # 大于 (greater than)
[ $a -lt $b ]   # 小于 (less than)
[ $a -eq $b ]   # 等于 (equal)
[ $a -ne $b ]   # 不等于 (not equal)
[ $a -ge $b ]   # 大于等于 (greater or equal)
[ $a -le $b ]   # 小于等于 (less or equal)
```

### 字符串比较

```bash
[ "$a" = "$b" ]     # 等于
[ "$a" != "$b" ]    # 不等于
[ -z "$a" ]         # 空字符串
[ -n "$a" ]         # 非空字符串
[[ "$a" < "$b" ]]   # 小于（字典序）
[[ "$a" > "$b" ]]   # 大于（字典序）
```

### 逻辑运算

```bash
[ 条件 1 -a 条件 2 ]    # 与 (and)
[ 条件 1 -o 条件 2 ]    # 或 (or)
[[ 条件 1 && 条件 2 ]]  # 与 (and) - 推荐
[[ 条件 1 || 条件 2 ]]  # 或 (or) - 推荐
! 条件                  # 非 (not)
```

---

### 文件操作

```bash
cp source dest        # 复制
mv source dest        # 移动/重命名
rm file               # 删除
mkdir dir             # 创建目录
rmdir dir             # 删除空目录
ln -s source link     # 创建符号链接
chmod 755 file        # 修改权限
chown user:group file # 修改所有者
touch file            # 创建空文件或更新时间戳
find /path -name "*.txt"  # 查找文件
```

**高级文件操作：**
```bash
cp -r dir1 dir2           # 递归复制目录
mv -i file1 file2         # 覆盖前询问
rm -rf dir/               # 强制删除目录
mkdir -p a/b/c            # 创建多级目录
chmod -R 755 dir/         # 递归修改权限
find . -type f -name "*.log" -mtime +7  # 查找 7 天前的日志
find . -type f -size +100M  # 查找大于 100M 的文件
```

---

### 文本处理

```bash
grep "pattern" file           # 搜索文本
sed 's/old/new/g' file        # 替换文本
awk '{print $1}' file         # 提取字段
sort file                     # 排序
uniq file                     # 去重
wc -l file                    # 统计行数
head -n 10 file               # 查看前 10 行
tail -n 10 file               # 查看后 10 行
```

**Grep 高级用法：**
```bash
grep -i "pattern" file        # 忽略大小写
grep -v "pattern" file        # 反向匹配
grep -n "pattern" file        # 显示行号
grep -r "pattern" dir/        # 递归搜索
grep -E "pat1|pat2" file      # 扩展正则
grep -c "pattern" file        # 统计匹配行数
grep -l "pattern" *.txt       # 只显示文件名
```

**Sed 高级用法：**
```bash
sed -i 's/old/new/g' file     # 就地修改
sed -n '5,10p' file           # 打印 5-10 行
sed '/pattern/d' file         # 删除匹配行
sed '2d' file                 # 删除第 2 行
sed '$d' file                 # 删除最后一行
sed 's/old/new/2' file        # 替换第 2 个匹配
```

**Awk 高级用法：**
```bash
awk -F: '{print $1}' /etc/passwd    # 指定分隔符
awk '$3 > 1000 {print $1, $3}' file # 条件过滤
awk '{sum+=$1} END {print sum}' file # 求和
awk '{print NR, $0}' file           # 显示行号
awk 'length > 80' file              # 打印长度>80 的行
```

---

### 系统信息

```bash
uname -a          # 系统信息
hostname          # 主机名
uptime            # 运行时间
free -h           # 内存信息
df -h             # 磁盘信息
top               # 进程监控
ps aux            # 进程列表
netstat -tlnp     # 网络端口
```

**系统信息详情：**
```bash
cat /etc/os-release           # 操作系统版本
cat /proc/cpuinfo             # CPU 信息
cat /proc/meminfo             # 内存详情
lsblk                         # 块设备信息
fdisk -l                      # 磁盘分区
du -sh dir/                   # 目录大小
whoami                        # 当前用户
id                            # 用户 ID 和组
last                          # 最近登录记录
history                       # 命令历史
```

---

### 压缩与归档

```bash
tar -czvf archive.tar.gz dir/     # 创建 gzip 压缩包
tar -xzvf archive.tar.gz          # 解压 gzip 压缩包
tar -cjvf archive.tar.bz2 dir/    # 创建 bzip2 压缩包
tar -xjvf archive.tar.bz2         # 解压 bzip2 压缩包
zip -r archive.zip dir/           # 创建 zip 压缩包
unzip archive.zip                 # 解压 zip 压缩包
gzip file                         # 压缩文件
gunzip file.gz                    # 解压 gz 文件
```

---

### 网络命令

```bash
ping host             # 测试连通性
curl url              # 发送 HTTP 请求
wget url              # 下载文件
ssh user@host         # SSH 远程登录
scp file user@host:path  # 复制文件到远程
rsync -av src/ dest/  # 同步文件
traceroute host       # 路由追踪
dig domain            # DNS 查询
nslookup domain       # DNS 查询
```

**网络诊断：**
```bash
ip addr show                  # 查看 IP 地址
ip route show                 # 查看路由表
ss -tlnp                      # 查看监听端口
iptables -L                   # 查看防火墙规则
tcpdump -i eth0 port 80       # 抓包分析
```

---

### 进程管理

```bash
ps aux              # 查看所有进程
top                 # 实时监控进程
htop                # 增强版 top
kill PID            # 终止进程
kill -9 PID         # 强制终止
pkill name          # 按名称终止进程
pgrep name          # 按名称查找进程
```

**后台作业：**
```bash
command &           # 后台运行
jobs                # 查看后台作业
fg %1               # 带到前台
bg %1               # 带到后台
Ctrl+Z              # 挂起当前进程
nohup command &     # 忽略挂起运行
```

---

### 用户与权限

```bash
useradd username    # 创建用户
userdel username    # 删除用户
passwd username     # 修改密码
usermod -aG group user  # 添加用户到组
groupadd groupname  # 创建组
groupdel groupname  # 删除组
su - username       # 切换用户
sudo command        # 以 root 权限执行
```

**权限管理：**
```bash
chmod 755 file      # rwxr-xr-x
chmod 644 file      # rw-r--r--
chmod +x file       # 添加执行权限
chown user:group file  # 修改所有者
chgrp group file    # 修改组
umask 022           # 设置默认权限
```

---

### 磁盘管理

```bash
df -h               # 磁盘空间
du -sh dir/         # 目录大小
mount               # 挂载文件系统
umount /mnt         # 卸载文件系统
fdisk -l            # 查看分区
mkfs.ext4 /dev/sdb1 # 格式化分区
```

**磁盘清理：**
```bash
find /var/log -name "*.log" -delete    # 删除日志
journalctl --vacuum-time=7d            # 清理系统日志
apt-get clean                          # 清理包缓存
yum clean all                          # 清理 yum 缓存
```

---

### 软件包管理

**Debian/Ubuntu:**
```bash
apt update                # 更新包列表
apt upgrade               # 升级包
apt install package       # 安装包
apt remove package        # 卸载包
apt search keyword        # 搜索包
apt show package          # 显示包信息
dpkg -i package.deb       # 安装 deb 包
```

**RHEL/CentOS:**
```bash
yum update                # 更新包
yum install package       # 安装包
yum remove package        # 卸载包
yum search keyword        # 搜索包
yum info package          # 显示包信息
rpm -ivh package.rpm      # 安装 rpm 包
```

---

### 常用快捷键

```bash
Ctrl+A      # 移动到行首
Ctrl+E      # 移动到行尾
Ctrl+U      # 删除到行首
Ctrl+K      # 删除到行尾
Ctrl+W      # 删除前一个单词
Ctrl+R      # 搜索命令历史
Ctrl+C      # 终止当前命令
Ctrl+Z      # 挂起当前命令
Ctrl+D      # 退出终端/EOF
Ctrl+L      # 清屏
Tab         # 自动补全
!!          # 执行上一条命令
!$          # 上一条命令的最后一个参数
```

---

### 变量操作

```bash
var="value"           # 定义变量
echo $var             # 使用变量
${var}                # 推荐用法
${#var}               # 字符串长度
${var:0:5}            # 截取字符串
${var/old/new}        # 替换第一个匹配
${var//old/new}       # 替换所有匹配
${var#pattern}        # 删除开头匹配
${var%pattern}        # 删除结尾匹配
${var^^}              # 转大写
${var,,}              # 转小写
```

**特殊变量：**
```bash
$0        # 脚本名称
$1-$9     # 位置参数
\`$#\`        # 参数个数
$@        # 所有参数
$*        # 所有参数（作为字符串）
$?        # 上一个命令的退出码
$$        # 当前进程 ID
$!        # 最后一个后台进程 ID
$_        # 上一个命令的最后一个参数
```

---

### 重定向与管道

```bash
command > file        # 覆盖输出到文件
command >> file       # 追加输出到文件
command 2> file       # 错误输出到文件
command &> file       # 所有输出到文件
command < file        # 从文件读取输入
command1 | command2   # 管道传递
command1 | tee file   # 同时输出到屏幕和文件
```

**Here Document:**
```bash
cat <<EOF
这是多行文本
可以包含变量：$var
EOF
```

---

### 调试技巧

```bash
bash -x script.sh       # 显示执行的命令
bash -n script.sh       # 检查语法错误
bash -v script.sh       # 显示读取的命令
set -x                  # 开启调试模式
set +x                  # 关闭调试模式
set -e                  # 出错立即退出
set -u                  # 使用未定义变量时报错
```

---

## 📊 学习路径总结

| 阶段 | 章节 | 脚本数 | 难度 | 学习时长 | 完成时间 |
|------|------|--------|------|----------|----------|
| 1 | 快速开始 | 3 | ⭐ | 1 天 | 第 1 天 |
| 2 | Bash 基础 | 12 | ⭐⭐ | 6 天 | 第 2-7 天 |
| 3 | 流程控制 | 44 | ⭐⭐⭐ | 21 天 | 第 8-28 天 |
| 4 | 数据结构 | 4 | ⭐⭐⭐ | 7 天 | 第 22-28 天 |
| 5 | 文本处理 | 3 | ⭐⭐⭐⭐ | 14 天 | 第 29-42 天 |
| 6 | 系统编程 | 10 | ⭐⭐⭐⭐ | 16 天 | 第 43-58 天 |
| 7 | 实战项目 | 24 | ⭐⭐⭐⭐⭐ | 32 天 | 第 59-90 天 |
| **总计** | **7 章** | **103** | **-** | **90 天** | **3 个月** |

---

## 🎯 学习建议

### 1. 循序渐进
按照 7 个阶段依次学习，不要跳级。每个阶段的脚本都是为下一阶段打基础。

### 2. 动手实践
- 不要只看不练
- 每个脚本都要亲自运行
- 尝试修改脚本，看看会发生什么
- 用自己的想法创建新脚本

### 3. 理解原理
- 不要死记硬背
- 理解每个命令的作用
- 理解为什么这样写
- 理解错误信息

### 4. 善用工具
- 使用 `ShellCheck` 检查语法错误
- 使用 `man` 查看命令手册
- 使用 `bash -x script.sh` 调试脚本
- 使用在线练习平台快速测试

### 5. 项目驱动
- 第 7 章的实战项目最重要
- 尝试在工作中应用
- 建立自己的脚本库
- 持续优化和改进

---

**本文档基于仓库实际内容生成，与 103 个实战脚本完全对应**

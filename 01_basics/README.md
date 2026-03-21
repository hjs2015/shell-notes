# 📚 阶段 2：基础篇 (Basics)

> **学习第 2-7 天** | 难度：⭐⭐ | **28 个脚本** | 预计 12-15 小时

---

## 📋 目录

- [简介](#简介)
- [脚本清单](#脚本清单)
  - [基础入门（01-05）](#基础入门 01-05)
  - [输入输出实战（06-10）](#输入输出实战 06-10)
  - [变量高级（11-19）](#变量高级 11-19)
  - [数组和字符串（20-24）](#数组和字符串 20-24)
  - [高级主题（25-28）](#高级主题 25-28)
- [7 天学习计划](#7-天学习计划)
- [核心知识点详解](#核心知识点详解)
  - [变量定义与使用](#变量定义与使用)
  - [运算符](#运算符)
  - [输入输出](#输入输出)
  - [字符串处理](#字符串处理)
  - [数组操作](#数组操作)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 简介

掌握 Shell 编程的基础知识，包括变量、运算符、输入输出等核心概念。

**学完你能做什么**：
- ✅ 定义和使用各种变量
- ✅ 进行算术和逻辑运算
- ✅ 接收用户输入并格式化输出
- ✅ 处理字符串和数组
- ✅ 编写交互式脚本

**预计时间**：6 天，每天 1-2 小时

---

## 📁 脚本清单

### 基础入门（01-05）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [01_hello_world.sh](01_hello_world.sh) | Hello World | ⭐ | 10 分钟 | 第一个脚本 |
| [02_special_variables.sh](02_special_variables.sh) | 特殊变量 | ⭐ | 30 分钟 | $0/$1/$#/$@ |
| [03_variable_operations.sh](03_variable_operations.sh) | 变量操作 | ⭐ | 15 分钟 | 赋值/引用/删除 |
| [04_arithmetic_basics.sh](04_arithmetic_basics.sh) | 算术基础 | ⭐ | 15 分钟 | 基本计算 |
| [05_user_input_basic.sh](05_user_input_basic.sh) | 用户输入 | ⭐ | 15 分钟 | read 命令 |

### 输入输出实战（06-10）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [06_user_input_search.sh](06_user_input_search.sh) | 搜索输入 | ⭐⭐ | 20 分钟 | 交互式搜索 |
| [07_file_check.sh](07_file_check.sh) | 文件检查 | ⭐⭐ | 15 分钟 | 文件存在性 |
| [08_ping_check.sh](08_ping_check.sh) | Ping 检查 | ⭐⭐ | 15 分钟 | 网络连通性 |
| [09_user_info_complete.sh](09_user_info_complete.sh) | 完整用户信息 | ⭐⭐ | 25 分钟 | 综合练习 |
| [10_shell_execution_modes.sh](10_shell_execution_modes.sh) | 执行模式 | ⭐⭐ | 20 分钟 | source/bash/./ |

### 变量高级（11-19）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [11_variable_type_declaration.sh](11_variable_type_declaration.sh) | 变量类型声明 | ⭐⭐ | 15 分钟 | declare 命令 |
| [12_string_operations.sh](12_string_operations.sh) | 字符串操作 | ⭐⭐ | 20 分钟 | 截取/替换/删除 |
| [13_arithmetic_operations.sh](13_arithmetic_operations.sh) | 算术运算 | ⭐⭐ | 20 分钟 | 加减乘除 |
| [14_logical_operators.sh](14_logical_operators.sh) | 逻辑运算符 | ⭐⭐ | 15 分钟 | &&/||/! |
| [15_comparison_operations.sh](15_comparison_operations.sh) | 比较运算 | ⭐⭐ | 15 分钟 | 字符串/数字比较 |
| [16_read_command_advanced.sh](16_read_command_advanced.sh) | read 进阶 | ⭐⭐ | 20 分钟 | -p/-t/-a 参数 |
| [17_printf_formatting.sh](17_printf_formatting.sh) | printf 格式化 | ⭐⭐ | 20 分钟 | 格式化输出 |
| [18_here_document.sh](18_here_document.sh) | Here 文档 | ⭐⭐ | 20 分钟 | <<EOF |
| [19_variable_default_values.sh](19_variable_default_values.sh) | 默认值 | ⭐⭐ | 15 分钟 | ${var:-default} |

### 数组和字符串（20-24）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [20_array_basics.sh](20_array_basics.sh) | 数组基础 | ⭐⭐ | 20 分钟 | 定义/访问/遍历 |
| [21_regex_matching.sh](21_regex_matching.sh) | 正则匹配 | ⭐⭐⭐ | 25 分钟 | 正则表达式 |
| [22_case_conversion.sh](22_case_conversion.sh) | 大小写转换 | ⭐⭐ | 15 分钟 | 大小写互转 |
| [23_indirect_reference.sh](23_indirect_reference.sh) | 间接引用 | ⭐⭐⭐ | 20 分钟 | 间接变量引用 |
| [24_string_trim.sh](24_string_trim.sh) | 字符串修剪 | ⭐⭐ | 15 分钟 | 去除空格 |

### 高级主题（25-28）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [25_command_output_capture.sh](25_command_output_capture.sh) | 输出捕获 | ⭐⭐ | 15 分钟 | $() 和 `` |
| [26_environment_vs_local.sh](26_environment_vs_local.sh) | 环境变量 | ⭐⭐ | 20 分钟 | 环境 vs 局部 |
| [27_boolean_and_logic.sh](27_boolean_and_logic.sh) | 布尔逻辑 | ⭐⭐ | 15 分钟 | 布尔运算 |
| [28_wildcards_detailed.sh](28_wildcards_detailed.sh) | 通配符详解 | ⭐⭐ | 20 分钟 | */?/[] |

---

## 📅 7 天学习计划

### 第 2 天：基础入门（4 个脚本，1.5 小时）

**学习内容**：
- 01_hello_world.sh - 第一个脚本
- 02_special_variables.sh - 特殊变量
- 03_variable_operations.sh - 变量操作
- 04_arithmetic_basics.sh - 算术基础

**目标**：理解变量和 basic 运算

---

### 第 3 天：输入输出（4 个脚本，1.5 小时）

**学习内容**：
- 05_user_input_basic.sh - 用户输入
- 06_user_input_search.sh - 搜索输入
- 07_file_check.sh - 文件检查
- 08_ping_check.sh - Ping 检查

**目标**：掌握交互式脚本编写

---

### 第 4 天：变量高级（4 个脚本，1.5 小时）

**学习内容**：
- 09_user_info_complete.sh - 完整用户信息
- 10_shell_execution_modes.sh - 执行模式
- 11_variable_type_declaration.sh - 变量类型声明
- 12_string_operations.sh - 字符串操作

**目标**：深入理解变量和字符串

---

### 第 5 天：运算符（4 个脚本，1.5 小时）

**学习内容**：
- 13_arithmetic_operations.sh - 算术运算
- 14_logical_operators.sh - 逻辑运算符
- 15_comparison_operations.sh - 比较运算
- 16_read_command_advanced.sh - read 进阶

**目标**：掌握各种运算符

---

### 第 6 天：格式化（4 个脚本，1.5 小时）

**学习内容**：
- 17_printf_formatting.sh - printf 格式化
- 18_here_document.sh - Here 文档
- 19_variable_default_values.sh - 默认值
- 20_array_basics.sh - 数组基础

**目标**：学会格式化输出和数组

---

### 第 7 天：高级主题（5 个脚本，2 小时）

**学习内容**：
- 21_regex_matching.sh - 正则匹配
- 22_case_conversion.sh - 大小写转换
- 23_indirect_reference.sh - 间接引用
- 24_string_trim.sh - 字符串修剪
- 25-28 选学

**目标**：掌握高级字符串处理

---

## 🔍 核心知识点详解

### 变量定义与使用

**基本语法**：
```bash
#!/bin/bash
# 定义变量（等号两边不能有空格）
name="John"
age=25

# 引用变量
echo "姓名：$name"      # 输出：姓名：John
echo "年龄：${age}"     # 输出：年龄：25（推荐用花括号）

# 删除变量
unset name
```

**变量类型**：
```bash
#!/bin/bash
# 声明变量类型
declare -i num=10      # 整数
declare -r PI=3.14     # 只读
declare -a arr=(1 2 3) # 数组
declare -A map=([key]=value)  # 关联数组

# 查看变量属性
declare -p num
```

**实战应用**：
```bash
#!/bin/bash
# 配置文件读取
CONFIG_FILE="app.conf"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
    echo "数据库：$DB_HOST:$DB_PORT"
else
    echo "错误：配置文件不存在"
    exit 1
fi
```

---

### 运算符

**算术运算符**：
```bash
#!/bin/bash
a=10
b=3

# 方法 1：$(( ))
echo "和：$((a + b))"      # 13
echo "差：$((a - b))"      # 7
echo "积：$((a * b))"      # 30
echo "商：$((a / b))"      # 3（整数除法）
echo "余数：$((a % b))"    # 1

# 方法 2：let
let c=a+b
echo "c=$c"

# 方法 3：expr（老式，不推荐）
d=$(expr $a + $b)
```

**逻辑运算符**：
```bash
#!/bin/bash
# &&（与）- 前一个成功才执行后一个
[ -f file.txt ] && echo "文件存在"

# ||（或）- 前一个失败才执行后一个
[ -f file.txt ] || echo "文件不存在"

# !（非）- 取反
[ ! -f file.txt ] && echo "文件不存在"
```

**比较运算符**：
```bash
#!/bin/bash
# 字符串比较
[ "$a" = "$b" ]    # 相等
[ "$a" != "$b" ]   # 不相等
[ -z "$a" ]        # 空字符串
[ -n "$a" ]        # 非空

# 数字比较
[ $a -eq $b ]      # 相等 (equal)
[ $a -ne $b ]      # 不等 (not equal)
[ $a -gt $b ]      # 大于 (greater than)
[ $a -lt $b ]      # 小于 (less than)
[ $a -ge $b ]      # 大于等于
[ $a -le $b ]      # 小于等于
```

---

### 输入输出

**read 命令**：
```bash
#!/bin/bash
# 基本输入
read name
echo "你好，$name"

# 带提示
read -p "请输入姓名：" name

# 限时输入（10 秒）
read -t 10 -p "10 秒内输入：" input

# 隐藏输入（密码）
read -sp "请输入密码：" password
echo  # 换行

# 读取多个值
read -p "输入姓名和年龄：" name age
```

**echo vs printf**：
```bash
#!/bin/bash
# echo（自动换行）
echo "Hello"
echo "World"

# printf（需手动换行，更可控）
printf "姓名：%s\n" "John"
printf "年龄：%d\n" 25
printf "价格：%.2f\n" 99.99  # 保留 2 位小数

# 格式化表格
printf "%-10s %-10s %-10s\n" "姓名" "年龄" "城市"
printf "%-10s %-10s %-10s\n" "John" "25" "北京"
```

**Here 文档**：
```bash
#!/bin/bash
# 多行文本
cat <<EOF
========================================
欢迎使用系统
========================================
功能 1：查看日志
功能 2：备份数据
功能 3：退出
EOF

# 变量替换
name="John"
cat <<EOF
你好，$name
今天是：$(date)
EOF
```

---

### 字符串处理

**基本操作**：
```bash
#!/bin/bash
str="Hello World"

# 获取长度
echo ${#str}           # 11

# 截取子串
echo ${str:0:5}        # Hello（从 0 开始，取 5 个字符）
echo ${str:6}          # World（从第 6 个到结尾）

# 替换
echo ${str/World/Shell}     # Hello Shell（替换第一个）
echo ${str//o/0}            # Hell0 W0rld（替换所有）
echo ${str/#Hello/Hi}       # Hi World（开头替换）
echo ${str/%World/Shell}    # Hello Shell（结尾替换）

# 删除
echo ${str#H*l}        # lo World（从左边最短匹配删除）
echo ${str##H*l}       # World（从左边最长匹配删除）
echo ${str%W*d}        # Hello  （从右边最短匹配删除）
echo ${str%%W*d}       # Hello  （从右边最长匹配删除）
```

**大小写转换**：
```bash
#!/bin/bash
str="Hello World"

# Bash 4.0+
echo ${str,,}          # hello world（转小写）
echo ${str^^}          # HELLO WORLD（转大写）
echo ${str^}           # Hello world（首字母大写）

# tr 命令（兼容老版本）
echo "$str" | tr '[:upper:]' '[:lower:]'   # 小写
echo "$str" | tr '[:lower:]' '[:upper:]'   # 大写
```

---

### 数组操作

**定义数组**：
```bash
#!/bin/bash
# 方法 1：直接定义
arr=(apple banana cherry)

# 方法 2：逐个赋值
arr[0]="apple"
arr[1]="banana"
arr[2]="cherry"

# 方法 3：命令输出
files=($(ls *.txt))
```

**访问数组**：
```bash
#!/bin/bash
arr=(apple banana cherry)

# 单个元素
echo ${arr[0]}         # apple
echo ${arr[1]}         # banana

# 所有元素
echo ${arr[@]}         # apple banana cherry
echo ${arr[*]}         # apple banana cherry

# 数组长度
echo ${#arr[@]}        # 3

# 元素索引
echo ${!arr[@]}        # 0 1 2
```

**数组操作**：
```bash
#!/bin/bash
arr=(apple banana cherry)

# 添加元素
arr+=(date)            # 末尾添加
arr[3]="date"

# 删除元素
unset arr[1]           # 删除 banana

# 切片
echo ${arr[@]:1:2}     # banana cherry（从 1 开始取 2 个）

# 遍历数组
for fruit in "${arr[@]}"; do
    echo "水果：$fruit"
done
```

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. 等号两边加空格

**错误**：
```bash
name = "John"  # ❌ 语法错误
```

**正确**：
```bash
name="John"    # ✅ 等号两边无空格
```

---

### 2. 变量引用不加引号

**错误**：
```bash
file="my file.txt"
cat $file      # ❌ 会被解析为 cat my file.txt
```

**正确**：
```bash
file="my file.txt"
cat "$file"    # ✅ 用引号包裹
```

---

### 3. 算术运算语法错误

**错误**：
```bash
a=10
b=5
c=$a+$b        # ❌ 结果是 "10+5" 字符串
```

**正确**：
```bash
a=10
b=5
c=$((a + b))   # ✅ 结果是 15
```

---

### 4. 字符串比较用错运算符

**错误**：
```bash
a=10
b=5
if [ $a > $b ]; then  # ❌ > 是重定向符号
    echo "a 大于 b"
fi
```

**正确**：
```bash
a=10
b=5
if [ $a -gt $b ]; then  # ✅ 用 -gt 表示大于
    echo "a 大于 b"
fi
```

---

### 5. read 命令不检查返回值

**错误**：
```bash
read -t 10 input  # ❌ 超时后 input 为空，但继续执行
echo "输入：$input"
```

**正确**：
```bash
if read -t 10 input; then
    echo "输入：$input"
else
    echo "超时，使用默认值"
    input="default"
fi
```

---

### 6. 数组遍历不引用

**错误**：
```bash
arr=("file 1.txt" "file 2.txt")
for f in ${arr[@]}; do  # ❌ 会被拆分成 4 个词
    echo "$f"
done
```

**正确**：
```bash
arr=("file 1.txt" "file 2.txt")
for f in "${arr[@]}"; do  # ✅ 保留空格
    echo "$f"
done
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: 如何判断变量是否为空？

**方法**：
```bash
# 方法 1：-z 测试
if [ -z "$var" ]; then
    echo "变量为空"
fi

# 方法 2：直接比较
if [ "$var" = "" ]; then
    echo "变量为空"
fi

# 方法 3：默认值
echo "${var:-变量为空}"
```

---

### Q2: 如何让脚本接收命名参数？

**方法**：
```bash
#!/bin/bash
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            name="$2"
            shift 2
            ;;
        -h|--help)
            echo "用法：$0 -n <name>"
            exit 0
            ;;
        *)
            echo "未知参数：$1"
            exit 1
            ;;
    esac
done
echo "姓名：$name"
```

---

### Q3: 如何进行浮点数运算？

**方法**（使用 bc）：
```bash
#!/bin/bash
a=10
b=3

# bc 计算（保留 2 位小数）
result=$(echo "scale=2; $a / $b" | bc)
echo "结果：$result"  # 3.33
```

---

### Q4: 如何读取配置文件？

**方法**：
```bash
#!/bin/bash
# config.conf 内容：
# DB_HOST=localhost
# DB_PORT=3306

# 读取配置
source config.conf
echo "数据库：$DB_HOST:$DB_PORT"

# 或逐行读取
while IFS='=' read -r key value; do
    declare "$key=$value"
done < config.conf
```

---

### Q5: 如何调试脚本？

**方法**：
```bash
# 方法 1：bash -x（显示执行过程）
bash -x script.sh

# 方法 2：脚本内开启调试
#!/bin/bash
set -x  # 开启调试
# ... 代码 ...
set +x  # 关闭调试

# 方法 3：set -e（出错立即退出）
#!/bin/bash
set -e
# 任何命令失败都会退出
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 定义和使用变量（局部/环境/只读）
- [ ] 进行算术和逻辑运算
- [ ] 使用 read 接收用户输入
- [ ] 用 printf 格式化输出
- [ ] 处理字符串（截取/替换/删除）
- [ ] 定义和遍历数组
- [ ] 避免常见陷阱（空格/引号/运算符）
- [ ] 调试脚本问题

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[02_control_flow/](../02_control_flow/)** - 流程控制篇（第 8-21 天）

你将学习：
- 条件判断（if/elif/else/case）
- 循环（for/while/until）
- 函数定义和调用
- 错误处理

---

## 💡 小贴士

1. **变量加引号** - 始终用 `"$var"` 避免空格问题
2. **算术用 $(())** - 不要用 expr（老式且慢）
3. **调试用 -x** - `bash -x script.sh` 查看执行过程
4. **出错用 -e** - `set -e` 让脚本在错误时立即退出
5. **多练习** - 每个脚本都要亲手运行和修改

---

## 📚 参考资源

- [Bash 变量详解](https://www.gnu.org/software/bash/manual/)
- [字符串操作指南](https://tldp.org/LDP/abs/html/string-manipulation.html)
- [数组使用教程](https://www.gnu.org/software/bash/manual/html_node/Arrays.html)
- [快速参考手册](../SHELL_GUIDE_BASE.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-脚本清单) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)

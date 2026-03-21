# 📚 阶段 5：文本处理 (Text Processing)

> **学习第 29-42 天** | 难度：⭐⭐⭐⭐ | **44 个脚本** | 预计 20-25 小时

---

## 📋 目录

- [简介](#简介)
- [脚本清单](#脚本清单)
  - [grep 系列（01-10）](#grep-系列 01-10)
  - [sed 系列（11-18）](#sed-系列 11-18)
  - [awk 系列（19-28）](#awk-系列 19-28)
  - [cut 系列（29-31）](#cut-系列 29-31)
  - [sort 系列（32-34）](#sort-系列 32-34)
  - [uniq 系列（35-37）](#uniq-系列 35-37)
  - [tr 系列（38-39）](#tr-系列 38-39)
  - [wc/head/tail 系列（40-44）](#wcheadtail 系列 40-44)
- [14 天学习计划](#14-天学习计划)
- [核心知识点详解](#核心知识点详解)
  - [grep 搜索过滤](#grep-搜索过滤)
  - [sed 流编辑](#sed-流编辑)
  - [awk 文本分析](#awk-文本分析)
  - [其他文本工具](#其他文本工具)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 简介

掌握 Linux 文本处理三剑客（grep/sed/awk）及其他文本工具，成为文本处理高手。

**学完你能做什么**：
- ✅ 用 grep 快速搜索日志和文件
- ✅ 用 sed 批量替换和编辑文本
- ✅ 用 awk 分析结构化数据
- ✅ 组合工具解决复杂问题
- ✅ 编写日志分析和数据处理脚本

**预计时间**：14 天，每天 1-2 小时

---

## 📁 脚本清单

### grep 系列（01-10）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [01_grep_basic.sh](01_grep_basic.sh) | grep 基础 | ⭐⭐⭐ | 20 分钟 | 基本搜索 |
| [02_grep_regex.sh](02_grep_regex.sh) | 正则表达式 | ⭐⭐⭐ | 25 分钟 | 正则匹配 |
| [03_grep_options.sh](03_grep_options.sh) | 选项详解 | ⭐⭐⭐ | 20 分钟 | 常用选项 |
| [04_grep_context.sh](04_grep_context.sh) | 上下文显示 | ⭐⭐⭐ | 20 分钟 | -A/-B/-C |
| [05_grep_count.sh](05_grep_count.sh) | 统计匹配 | ⭐⭐ | 15 分钟 | -c 统计 |
| [06_grep_color.sh](06_grep_color.sh) | 高亮显示 | ⭐⭐ | 15 分钟 | --color |
| [07_grep_files.sh](07_grep_files.sh) | 多文件搜索 | ⭐⭐⭐ | 25 分钟 | 递归搜索 |
| [08_grep_advanced.sh](08_grep_advanced.sh) | 高级技巧 | ⭐⭐⭐⭐ | 30 分钟 | 高级用法 |
| [09_grep_exclude.sh](09_grep_exclude.sh) | 排除搜索 | ⭐⭐⭐ | 20 分钟 | --exclude |
| [10_grep_practical.sh](10_grep_practical.sh) | 实战案例 | ⭐⭐⭐⭐ | 30 分钟 | 综合应用 |

### sed 系列（11-18）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [11_sed_basic.sh](11_sed_basic.sh) | sed 基础 | ⭐⭐⭐ | 20 分钟 | 基本语法 |
| [12_sed_replace.sh](12_sed_replace.sh) | 替换操作 | ⭐⭐⭐ | 25 分钟 | s///替换 |
| [13_sed_delete.sh](13_sed_delete.sh) | 删除操作 | ⭐⭐⭐ | 20 分钟 | d 删除 |
| [14_sed_insert.sh](14_sed_insert.sh) | 插入操作 | ⭐⭐⭐ | 25 分钟 | i/a 插入 |
| [15_sed_print.sh](15_sed_print.sh) | 打印控制 | ⭐⭐⭐ | 20 分钟 | p 打印 |
| [16_sed_file.sh](16_sed_file.sh) | 文件编辑 | ⭐⭐⭐⭐ | 30 分钟 | -i 编辑 |
| [17_sed_advanced.sh](17_sed_advanced.sh) | 高级技巧 | ⭐⭐⭐⭐ | 30 分钟 | 高级用法 |
| [18_sed_practical.sh](18_sed_practical.sh) | 实战案例 | ⭐⭐⭐⭐ | 30 分钟 | 综合应用 |

### awk 系列（19-28）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [19_awk_fields.sh](19_awk_fields.sh) | 字段处理 | ⭐⭐⭐ | 25 分钟 | $1/$2 字段 |
| [20_awk_print.sh](20_awk_print.sh) | 打印控制 | ⭐⭐⭐ | 20 分钟 | print 输出 |
| [21_awk_math.sh](21_awk_math.sh) | 数学运算 | ⭐⭐⭐ | 25 分钟 | 数学计算 |
| [22_awk_condition.sh](22_awk_condition.sh) | 条件判断 | ⭐⭐⭐ | 25 分钟 | if 判断 |
| [23_awk_loop.sh](23_awk_loop.sh) | 循环操作 | ⭐⭐⭐⭐ | 30 分钟 | for/while |
| [24_awk_function.sh](24_awk_function.sh) | 函数使用 | ⭐⭐⭐⭐ | 30 分钟 | 自定义函数 |
| [25_awk_basic.sh](25_awk_basic.sh) | 基础综合 | ⭐⭐⭐ | 25 分钟 | 综合练习 |
| [26_awk_advanced.sh](26_awk_advanced.sh) | 高级技巧 | ⭐⭐⭐⭐ | 35 分钟 | 高级用法 |
| [27_awk_regex.sh](27_awk_regex.sh) | 正则匹配 | ⭐⭐⭐⭐ | 30 分钟 | 正则表达式 |
| [28_awk_practical.sh](28_awk_practical.sh) | 实战案例 | ⭐⭐⭐⭐ | 35 分钟 | 综合应用 |

### cut 系列（29-31）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [29_cut_basics.sh](29_cut_basics.sh) | cut 基础 | ⭐⭐ | 15 分钟 | -f/-d 切割 |
| [30_cut_advanced.sh](30_cut_advanced.sh) | cut 高级 | ⭐⭐⭐ | 20 分钟 | 高级用法 |
| [31_cut_practical.sh](31_cut_practical.sh) | cut 实战 | ⭐⭐⭐ | 25 分钟 | 综合应用 |

### sort 系列（32-34）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [32_sort_basics.sh](32_sort_basics.sh) | sort 基础 | ⭐⭐ | 15 分钟 | 基本排序 |
| [33_sort_advanced.sh](33_sort_advanced.sh) | sort 高级 | ⭐⭐⭐ | 25 分钟 | 多字段排序 |
| [34_sort_practical.sh](34_sort_practical.sh) | sort 实战 | ⭐⭐⭐ | 25 分钟 | 综合应用 |

### uniq 系列（35-37）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [35_uniq_basics.sh](35_uniq_basics.sh) | uniq 基础 | ⭐⭐ | 15 分钟 | 去重统计 |
| [36_uniq_advanced.sh](36_uniq_advanced.sh) | uniq 高级 | ⭐⭐⭐ | 20 分钟 | 高级用法 |
| [37_uniq_practical.sh](37_uniq_practical.sh) | uniq 实战 | ⭐⭐⭐ | 25 分钟 | 综合应用 |

### tr 系列（38-39）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [38_tr_basics.sh](38_tr_basics.sh) | tr 基础 | ⭐⭐ | 15 分钟 | 字符转换 |
| [39_tr_advanced.sh](39_tr_advanced.sh) | tr 高级 | ⭐⭐⭐ | 20 分钟 | 高级用法 |

### wc/head/tail 系列（40-44）

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [40_wc_basics.sh](40_wc_basics.sh) | wc 基础 | ⭐⭐ | 15 分钟 | 统计行数 |
| [41_wc_advanced.sh](41_wc_advanced.sh) | wc 高级 | ⭐⭐ | 15 分钟 | 高级用法 |
| [42_head_basics.sh](42_head_basics.sh) | head 基础 | ⭐⭐ | 15 分钟 | 查看头部 |
| [43_tail_basics.sh](43_tail_basics.sh) | tail 基础 | ⭐⭐ | 15 分钟 | 查看尾部 |
| [44_tail_follow.sh](44_tail_follow.sh) | tail 跟踪 | ⭐⭐⭐ | 20 分钟 | -f 跟踪 |

---

## 📅 14 天学习计划

### 第 29-30 天：grep 基础（5 个脚本，2 小时）

**学习内容**：
- 01_grep_basic.sh - grep 基础
- 02_grep_regex.sh - 正则表达式
- 03_grep_options.sh - 选项详解
- 04_grep_context.sh - 上下文显示
- 05_grep_count.sh - 统计匹配

**目标**：掌握基本搜索和过滤

---

### 第 31-32 天：grep 高级（5 个脚本，2.5 小时）

**学习内容**：
- 06_grep_color.sh - 高亮显示
- 07_grep_files.sh - 多文件搜索
- 08_grep_advanced.sh - 高级技巧
- 09_grep_exclude.sh - 排除搜索
- 10_grep_practical.sh - 实战案例

**目标**：熟练多文件搜索和排除

---

### 第 33-34 天：sed 基础（4 个脚本，2 小时）

**学习内容**：
- 11_sed_basic.sh - sed 基础
- 12_sed_replace.sh - 替换操作
- 13_sed_delete.sh - 删除操作
- 14_sed_insert.sh - 插入操作

**目标**：掌握基本流编辑

---

### 第 35-36 天：sed 高级（4 个脚本，2.5 小时）

**学习内容**：
- 15_sed_print.sh - 打印控制
- 16_sed_file.sh - 文件编辑
- 17_sed_advanced.sh - 高级技巧
- 18_sed_practical.sh - 实战案例

**目标**：熟练文件编辑和替换

---

### 第 37-39 天：awk 核心（6 个脚本，4 小时）

**学习内容**：
- 19_awk_fields.sh - 字段处理
- 20_awk_print.sh - 打印控制
- 21_awk_math.sh - 数学运算
- 22_awk_condition.sh - 条件判断
- 23_awk_loop.sh - 循环操作
- 24_awk_function.sh - 函数使用

**目标**：掌握 awk 基本语法

---

### 第 40-41 天：awk 高级（4 个脚本，2.5 小时）

**学习内容**：
- 25_awk_basic.sh - 基础综合
- 26_awk_advanced.sh - 高级技巧
- 27_awk_regex.sh - 正则匹配
- 28_awk_practical.sh - 实战案例

**目标**：熟练复杂文本分析

---

### 第 42 天：其他工具（6 个脚本，2 小时）

**学习内容**：
- 29-31 cut 系列
- 32-34 sort 系列
- 35-37 uniq 系列
- 38-39 tr 系列
- 40-44 wc/head/tail 系列

**目标**：掌握辅助工具

---

## 🔍 核心知识点详解

### grep 搜索过滤

**基本语法**：
```bash
# 搜索包含 pattern 的行
grep "pattern" file.txt

# 递归搜索目录
grep -r "pattern" /path/to/dir

# 忽略大小写
grep -i "pattern" file.txt

# 显示行号
grep -n "pattern" file.txt

# 统计匹配行数
grep -c "pattern" file.txt

# 显示上下文（前后 3 行）
grep -C 3 "pattern" file.txt
grep -A 3 "pattern" file.txt  # 后 3 行
grep -B 3 "pattern" file.txt  # 前 3 行
```

**正则表达式**：
```bash
# 基本正则
grep "^start" file.txt      # 以 start 开头
grep "end$" file.txt        # 以 end 结尾
grep "^[0-9]" file.txt      # 以数字开头
grep "\.txt$" file.txt      # 以.txt 结尾

# 扩展正则（-E）
grep -E "error|warning" file.txt    # 或
grep -E "colou?r" file.txt          # 可选
grep -E "[0-9]{3}" file.txt         # 重复 3 次
grep -E "(abc)+" file.txt           # 分组
```

**排除和反向**：
```bash
# 反向匹配（不包含）
grep -v "error" file.txt

# 排除文件
grep -r "pattern" --exclude="*.log" .
grep -r "pattern" --exclude-dir=".git" .

# 只匹配整个单词
grep -w "error" file.txt

# 只匹配文件名
grep -l "pattern" *.txt
```

**实战应用**：
```bash
# 搜索日志中的错误
grep -i "error\|fail" /var/log/syslog

# 统计访问 IP
grep "GET" access.log | awk '{print $1}' | sort | uniq -c | sort -rn

# 查找包含特定函数的代码
grep -rn "function_name" --include="*.py" .
```

---

### sed 流编辑

**基本语法**：
```bash
# 替换（只输出，不修改文件）
sed 's/old/new/' file.txt        # 替换第一个
sed 's/old/new/g' file.txt       # 替换所有

# 删除行
sed '2d' file.txt                # 删除第 2 行
sed '2,5d' file.txt              # 删除 2-5 行
sed '/pattern/d' file.txt        # 删除匹配行

# 打印特定行
sed -n '5p' file.txt             # 打印第 5 行
sed -n '5,10p' file.txt          # 打印 5-10 行
sed -n '/pattern/p' file.txt     # 打印匹配行
```

**插入和追加**：
```bash
# 在行前插入
sed '2i\新内容' file.txt

# 在行后追加
sed '2a\新内容' file.txt

# 替换整行
sed '2c\新内容' file.txt
```

**文件编辑**：
```bash
# 直接修改文件（谨慎使用！）
sed -i 's/old/new/g' file.txt

# 创建备份后修改
sed -i.bak 's/old/new/g' file.txt

# macOS 需要空字符串
sed -i '' 's/old/new/g' file.txt
```

**高级用法**：
```bash
# 多命令
sed -e 's/a/b/' -e 's/c/d/' file.txt

# 使用不同分隔符（路径替换）
sed 's|/old/path|/new/path|g' file.txt

# 反向引用
sed 's/\([0-9]\+\)-\([0-9]\+\)/\2-\1/' file.txt
```

**实战应用**：
```bash
# 批量替换配置文件
sed -i 's/localhost/192.168.1.100/g' config.ini

# 删除空行
sed '/^$/d' file.txt

# 删除行首空格
sed 's/^[[:space:]]*//' file.txt

# 在特定行后添加
sed '/pattern/a\新内容' file.txt
```

---

### awk 文本分析

**基本语法**：
```bash
# 打印字段
awk '{print $1}' file.txt        # 第 1 列
awk '{print $1, $3}' file.txt    # 第 1 和 3 列
awk '{print $NF}' file.txt       # 最后 1 列
awk '{print $(NF-1)}' file.txt   # 倒数第 2 列

# 指定分隔符
awk -F: '{print $1}' /etc/passwd    # 以:分隔
awk -F, '{print $2}' data.csv       # 以,分隔

# 条件过滤
awk '$1 > 100' file.txt             # 第 1 列>100
awk '/pattern/ {print $1}' file.txt # 匹配 pattern
```

**数学运算**：
```bash
# 求和
awk '{sum+=$1} END {print sum}' file.txt

# 平均值
awk '{sum+=$1; count++} END {print sum/count}' file.txt

# 最大值
awk 'BEGIN{max=0} {if($1>max) max=$1} END {print max}' file.txt

# 格式化输出
awk '{printf "%-10s %d\n", $1, $2}' file.txt
```

**内置变量**：
```bash
# 常用变量
awk '{print NR, $0}' file.txt     # 行号
awk '{print NF, $0}' file.txt     # 字段数
awk 'BEGIN{OFS=","} {print $1,$2}' # 输出分隔符
awk 'BEGIN{ORS="\n\n"} {print}'    # 输出记录分隔符
```

**流程控制**：
```bash
# if 语句
awk '{if($1 > 100) print $0}' file.txt

# for 循环
awk '{for(i=1; i<=NF; i++) print $i}' file.txt

# while 循环
awk '{i=1; while(i<=NF) print $i++}' file.txt
```

**函数**：
```bash
# 内置函数
awk '{print length($0)}' file.txt      # 字符串长度
awk '{print toupper($1)}' file.txt     # 转大写
awk '{print tolower($1)}' file.txt     # 转小写
awk '{print substr($1,1,3)}' file.txt  # 子串

# 自定义函数
awk 'function add(a,b) {return a+b} {print add($1,$2)}' file.txt
```

**实战应用**：
```bash
# 统计日志访问次数
awk '{print $1}' access.log | sort | uniq -c | sort -rn

# 计算销售额
awk -F, '{sum+=$2} END {print "总销售额：", sum}' sales.csv

# 提取特定字段
awk -F: '$3 >= 1000 {print $1}' /etc/passwd  # UID>=1000 的用户
```

---

### 其他文本工具

**cut（切割）**：
```bash
# 按字段切割
cut -d: -f1 /etc/passwd           # 第 1 字段
cut -d: -f1,3 /etc/passwd         # 第 1 和 3 字段
cut -d: -f1-3 /etc/passwd         # 第 1-3 字段

# 按字符切割
cut -c1-5 file.txt                # 第 1-5 字符
```

**sort（排序）**：
```bash
# 基本排序
sort file.txt                     # 字母排序
sort -n file.txt                  # 数字排序
sort -r file.txt                  # 逆序

# 多字段排序
sort -t: -k3 -n /etc/passwd       # 按第 3 字段数字排序
sort -t, -k2 -k1 data.csv         # 先按第 2 字段，再按第 1 字段

# 去重排序
sort file.txt | uniq
```

**uniq（去重）**：
```bash
# 去重
sort file.txt | uniq

# 统计次数
sort file.txt | uniq -c

# 只显示重复
sort file.txt | uniq -d

# 只显示唯一
sort file.txt | uniq -u
```

**tr（转换）**：
```bash
# 大小写转换
echo "Hello" | tr '[:upper:]' '[:lower:]'   # hello
echo "hello" | tr '[:lower:]' '[:upper:]'   # HELLO

# 删除字符
echo "abc123" | tr -d '0-9'                 # abc

# 替换字符
echo "hello" | tr 'o' '0'                   # hell0

# 压缩重复
echo "aaabbb" | tr -s 'a' 'A'               # Aabbb
```

**wc/head/tail**：
```bash
# wc 统计
wc file.txt              # 行数/单词数/字节数
wc -l file.txt           # 行数
wc -w file.txt           # 单词数
wc -c file.txt           # 字节数

# head 查看头部
head file.txt            # 前 10 行
head -n 20 file.txt      # 前 20 行

# tail 查看尾部
tail file.txt            # 后 10 行
tail -n 20 file.txt      # 后 20 行
tail -f file.txt         # 跟踪文件变化（日志监控）
tail -F file.txt         # 跟踪（文件轮转也继续）
```

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. sed 直接修改文件无备份

**错误**：
```bash
sed -i 's/old/new/g' file.txt  # ❌ 无备份，出错无法恢复
```

**正确**：
```bash
sed -i.bak 's/old/new/g' file.txt  # ✅ 创建 file.txt.bak 备份
```

---

### 2. grep 正则未转义

**错误**：
```bash
grep "file.txt" file.txt  # ❌ . 匹配任意字符
```

**正确**：
```bash
grep "file\.txt" file.txt  # ✅ 转义点号
grep -F "file.txt" file.txt  # ✅ 或固定字符串
```

---

### 3. awk 字段引用错误

**错误**：
```bash
awk '{print $10}' file.txt  # ❌ 可能不是想要的
```

**正确**：
```bash
# 先确认分隔符
head -1 file.txt  # 查看格式
awk -F, '{print $10}' file.txt  # ✅ 指定分隔符
```

---

### 4. uniq 未先排序

**错误**：
```bash
uniq file.txt  # ❌ 只删除相邻重复行
```

**正确**：
```bash
sort file.txt | uniq  # ✅ 先排序再去重
```

---

### 5. 管道中变量作用域

**错误**：
```bash
cat file.txt | while read line; do
    count=$((count+1))
done
echo $count  # ❌ 变量在子 shell 中，外部访问不到
```

**正确**：
```bash
count=0
while read line; do
    count=$((count+1))
done < file.txt
echo $count  # ✅ 重定向输入
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: grep 如何搜索多个模式？

**方法**：
```bash
# 扩展正则（推荐）
grep -E "error|warning|fail" file.txt

# 多个-e 参数
grep -e "error" -e "warning" file.txt

# 从文件读取模式
grep -f patterns.txt file.txt
```

---

### Q2: sed 如何替换多行？

**方法**：
```bash
# 替换包含换行的内容
sed ':a;N;$!ba;s/old\nnew/replacement/g' file.txt

# 或用 perl（更简单）
perl -i -0pe 's/old\nnew/replacement/g' file.txt
```

---

### Q3: awk 如何设置输入输出分隔符？

**方法**：
```bash
# 输入分隔符
awk -F: '{print $1}' /etc/passwd

# 输出分隔符
awk 'BEGIN{OFS=","} {print $1,$2}' file.txt

# 同时设置
awk 'BEGIN{FS=":"; OFS=","} {print $1,$3}' /etc/passwd
```

---

### Q4: 如何组合多个工具？

**示例**：
```bash
# 统计日志中访问最多的 IP
grep "GET" access.log |           # 过滤 GET 请求
awk '{print $1}' |                # 提取 IP
sort |                            # 排序
uniq -c |                         # 统计
sort -rn |                        # 按次数排序
head -10                          # 前 10 个
```

---

### Q5: tail -f 如何退出？

**方法**：
```bash
tail -f file.log  # Ctrl+C 退出

# 或在另一个终端
tail -f file.log &
kill %1  # 后台任务退出
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 用 grep 搜索和过滤文本
- [ ] 用 sed 替换和编辑文本
- [ ] 用 awk 分析结构化数据
- [ ] 使用 cut/sort/uniq/tr 处理文本
- [ ] 组合多个工具解决复杂问题
- [ ] 编写日志分析脚本
- [ ] 避免常见陷阱
- [ ] 调试文本处理问题

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[05_system_programming/](../05_system_programming/)** - 系统编程篇（第 43-58 天）

你将学习：
- 文件和目录操作
- 进程管理
- 系统监控
- 网络编程

---

## 💡 小贴士

1. **sed 先备份** - `sed -i.bak` 避免数据丢失
2. **grep 用-E** - 扩展正则更强大
3. **awk 指定分隔符** - `-F` 明确字段分隔
4. **uniq 先排序** - `sort | uniq` 才有效
5. **管道测变量** - 用重定向 `<` 而非管道 `|`
6. **组合工具** - 小工具组合解决大问题

---

## 📚 参考资源

- [grep 详解](https://www.gnu.org/software/grep/manual/grep.html)
- [sed 教程](https://www.gnu.org/software/sed/manual/sed.html)
- [awk 指南](https://www.gnu.org/software/gawk/manual/gawk.html)
- [快速参考手册](../SHELL_GUIDE_BASE.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-脚本清单) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)

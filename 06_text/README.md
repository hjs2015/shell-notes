# 📝 文本处理 (Text Processing)

> 学习使用 AWK 进行强大的文本处理：字段提取、数据分析、报告生成

**难度**: ⭐⭐⭐⭐  
**脚本数**: 3 个 (AWK)  
**建议学时**: 2-3 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_field_extractor.awk](./01_field_extractor.awk) | ⭐⭐⭐ | 字段提取基础 | 45 |
| 2 | [02_data_analyzer.awk](./02_data_analyzer.awk) | ⭐⭐⭐⭐ | 数据分析统计 | 78 |
| 3 | [03_report_generator.awk](./03_report_generator.awk) | ⭐⭐⭐⭐⭐ | 报告生成 | 125 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 理解 AWK 工作原理
- ✅ 提取和打印指定字段
- ✅ 使用条件过滤数据
- ✅ 进行数值计算和统计
- ✅ 格式化输出报告
- ✅ 处理 CSV 和日志文件

---

## 📚 知识点

### 1. AWK 基础语法

```bash
# 基本格式
awk '模式 { 动作 }' 文件

# 打印第一列
awk '{ print $1 }' file.txt

# 打印第一列和第三列
awk '{ print $1, $3 }' file.txt

# 带条件
awk '$1 > 10 { print $0 }' file.txt

# 指定分隔符
awk -F: '{ print $1 }' /etc/passwd
```

### 2. 内置变量

| 变量 | 说明 | 示例 |
|------|------|------|
| `$0` | 整行 | `print $0` |
| `$1`, `$2`... | 第 n 列 | `print $1` |
| `NF` | 字段数 | `print NF` |
| `NR` | 行号 | `print NR` |
| `FS` | 输入分隔符 | `FS=":"` |
| `OFS` | 输出分隔符 | `OFS="\t"` |

### 3. 常用命令

```bash
# 统计行数
awk 'END { print NR }' file.txt

# 求和
awk '{ sum += $1 } END { print sum }' numbers.txt

# 平均值
awk '{ sum += $1; count++ } END { print sum/count }' numbers.txt

# 最大值
awk 'BEGIN { max=0 } { if ($1 > max) max=$1 } END { print max }' numbers.txt

# 查找包含关键词的行
awk '/keyword/ { print }' file.txt

# 匹配多个条件
awk '$1 > 10 && $2 < 20 { print }' file.txt
```

### 4. 格式化输出

```bash
# printf 格式化
awk '{ printf "%-10s %5d %8.2f\n", $1, $2, $3 }' data.txt

# 格式说明符
# %-10s  左对齐字符串，宽度 10
# %5d    右对齐整数，宽度 5
# %8.2f  浮点数，总宽 8，小数 2 位
```

---

## 💻 示例代码

### 示例 1: 字段提取

```awk
#!/usr/bin/awk -f
# 文件名：01_field_extractor.awk
# 功能：提取指定字段

BEGIN {
    FS = ":"  # 设置输入分隔符
    print "=== 用户信息提取 ==="
}

{
    # 打印用户名和 UID
    printf "用户：%-15s UID: %s\n", $1, $3
}

END {
    print "==================="
    print "处理完成"
}
```

**使用**:
```bash
awk -f 01_field_extractor.awk /etc/passwd
```

**输出**:
```
=== 用户信息提取 ===
用户：root            UID: 0
用户：bin             UID: 1
用户：daemon          UID: 2
...
===================
处理完成
```

### 示例 2: 数据分析

```awk
#!/usr/bin/awk -f
# 文件名：02_data_analyzer.awk
# 功能：数据分析统计

BEGIN {
    FS = ","
    sum = 0
    count = 0
    max = 0
    min = 999999
}

NR > 1 {  # 跳过标题行
    sum += $2
    count++
    
    if ($2 > max) max = $2
    if ($2 < min) min = $2
}

END {
    print "=== 数据统计报告 ==="
    print "记录数：", count
    print "总和：", sum
    print "平均值：", sum/count
    print "最大值：", max
    print "最小值：", min
    print "===================="
}
```

**使用**:
```bash
awk -f 02_data_analyzer.awk sales.csv
```

### 示例 3: 报告生成

```awk
#!/usr/bin/awk -f
# 文件名：03_report_generator.awk
# 功能：生成格式化报告

BEGIN {
    FS = ":"
    print ""
    print "╔════════════════════════════════════════╗"
    print "║         系统用户报告                   ║"
    print "╠════════════════════════════════════════╣"
    printf "║ %-20s %-8s %-10s ║\n", "用户名", "UID", "家目录"
    print "╠════════════════════════════════════════╣"
}

$3 >= 1000 && $3 < 65534 {
    printf "║ %-20s %-8s %-10s ║\n", $1, $3, $6
}

END {
    print "╚════════════════════════════════════════╝"
}
```

**使用**:
```bash
awk -f 03_report_generator.awk /etc/passwd
```

**输出**:
```
╔════════════════════════════════════════╗
║         系统用户报告                   ║
╠════════════════════════════════════════╣
║ 用户名                 UID      家目录     ║
╠════════════════════════════════════════╣
║ user1                1000     /home/user1 ║
║ user2                1001     /home/user2 ║
╚════════════════════════════════════════╝
```

---

## 🔧 练习任务

### 任务 1: 日志分析

分析 Nginx 访问日志，统计 PV 和 UV：

**参考**:
```awk
#!/usr/bin/awk -f
# 文件名：log_analyzer.awk

BEGIN {
    pv = 0
}

{
    pv++
    ips[$1]++
}

END {
    print "=== 访问统计 ==="
    print "总访问量 (PV):", pv
    print "独立访客 (UV):", length(ips)
    print ""
    print "Top 5 IP:"
    
    # 简单排序
    for (ip in ips) {
        if (ips[ip] > max_count) {
            max_count = ips[ip]
            max_ip = ip
        }
    }
    print "1.", max_ip, max_count, "次"
}
```

**使用**:
```bash
awk -f log_analyzer.awk /var/log/nginx/access.log
```

### 任务 2: CSV 数据转换

将 CSV 转换为 Markdown 表格：

**参考**:
```awk
#!/usr/bin/awk -f
# 文件名：csv_to_markdown.awk

BEGIN {
    FS = ","
}

NR == 1 {
    # 标题行
    printf "| "
    for (i=1; i<=NF; i++) {
        printf "%s |", $i
    }
    print ""
    
    # 分隔线
    printf "|"
    for (i=1; i<=NF; i++) {
        printf " --- |"
    }
    print ""
}

NR > 1 {
    printf "| "
    for (i=1; i<=NF; i++) {
        printf "%s |", $i
    }
    print ""
}
```

---

## 📝 最佳实践

### 1. 使用 -F 指定分隔符

```bash
✅ awk -F: '{ print $1 }' /etc/passwd

❌ awk '{ FS=":"; print $1 }' /etc/passwd  # FS 设置太晚
```

### 2. 在 BEGIN 中初始化变量

```bash
✅ awk 'BEGIN { sum=0 } { sum+=$1 } END { print sum }' file

❌ awk '{ sum+=$1 } END { print sum }' file  # 未初始化
```

### 3. 使用 NR 跳过标题行

```bash
✅ awk 'NR > 1 { print }' data.csv  # 跳过第一行

❌ awk '{ print }' data.csv  # 包含标题
```

### 4. 格式化输出用 printf

```bash
✅ awk '{ printf "%-10s %5d\n", $1, $2 }' file

❌ awk '{ print $1, $2 }' file  # 对齐不整齐
```

---

## ⚠️ 常见错误

### 错误 1: 字段编号从 0 开始

```bash
❌ awk '{ print $0 }'  # 这是整行，不是第一列

✅ awk '{ print $1 }'  # 第一列
```

### 错误 2: 忘记引号

```bash
❌ awk { print $1 } file.txt  # 语法错误

✅ awk '{ print $1 }' file.txt
```

### 错误 3: 变量未初始化

```bash
❌ awk '{ sum += $1 } END { print sum }' file.txt
   # 如果文件为空，sum 未定义

✅ awk 'BEGIN { sum=0 } { sum += $1 } END { print sum }' file.txt
```

---

## 📖 扩展阅读

- [AWK 官方文档](https://www.gnu.org/software/gawk/manual/gawk.html)
- [AWK 入门教程](https://www.grymoire.com/Unix/Awk.html)
- [AWK 单行命令](https://www.pement.org/awk/)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **07_system/** - 系统管理脚本
2. **08_practice/** - 综合练习
3. **09_devops/** - DevOps 实战应用

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

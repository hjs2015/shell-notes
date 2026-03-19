# 📝 文本处理 (Text Processing)

> **学习第 29-42 天** | 难度：⭐⭐⭐⭐ | 6 个脚本

---

## 📖 简介

文本处理是 Shell 的**杀手锏**，掌握 grep、sed、awk 三剑客。

**目标**：
- ✅ 掌握 grep 文本搜索
- ✅ 掌握 sed 流编辑
- ✅ 掌握 awk 文本分析

**预计时间**：2 周

---

## 📁 脚本清单

```
04_text_processing/
├── 01_grep/      # grep 搜索 (1 个)
├── 02_sed/       # sed 编辑 (1 个)
└── 03_awk/       # awk 分析 (4 个)
```

---

## 🎯 学习目标

### grep
- ✅ 基本搜索
- ✅ 正则表达式
- ✅ 选项使用（-i, -v, -r, -n）

### sed
- ✅ 文本替换
- ✅ 文本删除
- ✅ 行操作

### awk
- ✅ 字段提取
- ✅ 条件过滤
- ✅ 循环计算
- ✅ 报表生成

---

## 📝 学习路径

### 第 29-32 天：grep

**脚本**：`01_grep/13_grep_advanced.sh`

**示例**：
```bash
# 基本搜索
grep "error" logfile.txt

# 忽略大小写
grep -i "error" logfile.txt

# 反向匹配
grep -v "info" logfile.txt

# 递归搜索
grep -r "TODO" ./src/

# 显示行号
grep -n "error" logfile.txt

# 正则表达式
grep -E "^[0-9]{3}" file.txt
```

---

### 第 33-36 天：sed

**脚本**：`02_sed/14_sed_advanced.sh`

**示例**：
```bash
# 替换（仅输出）
sed 's/old/new/g' file.txt

# 替换（直接修改）
sed -i 's/old/new/g' file.txt

# 删除行
sed '/pattern/d' file.txt

# 打印特定行
sed -n '5,10p' file.txt

# 多替换
sed -e 's/a/b/g' -e 's/c/d/g' file.txt
```

---

### 第 37-42 天：awk

**脚本**：
- `03_awk/01_field_extract.awk` - 字段提取
- `03_awk/02_condition_filter.awk` - 条件过滤
- `03_awk/03_loop_calc.awk` - 循环计算
- `03_awk/15_awk_advanced.sh` - 高级用法

**示例**：
```bash
# 字段提取
awk '{print $1, $3}' data.txt

# 条件过滤
awk '$1 > 100' data.txt

# 内置变量
awk '{print NR, $0}' file.txt  # 行号 + 内容

# 计算
awk '{sum+=$1} END {print sum}' numbers.txt

# 格式化输出
awk -F: '{printf "%-10s %s\n", $1, $3}' /etc/passwd
```

---

## ✅ 学习检查

- [ ] 使用 grep 搜索文本
- [ ] 使用正则表达式匹配
- [ ] 使用 sed 替换和删除
- [ ] 使用 awk 提取字段
- [ ] 使用 awk 生成报表

---

## 🎓 下一步

👉 **[05_system_programming/](../05_system_programming/)** - 系统编程（第 43-58 天）

---

**祝你学习顺利！** 🚀

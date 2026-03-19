# 🗂️ 数据结构 (Data Structures)

> **学习第 22-28 天** | 难度：⭐⭐⭐ | 4 个脚本

---

## 📖 简介

数据结构帮助你**组织和操作复杂数据**。

**目标**：
- ✅ 掌握索引数组
- ✅ 掌握关联数组（字典）
- ✅ 掌握字符串高级操作

**预计时间**：1 周

---

## 📁 脚本清单

```
03_data_structures/
├── 01_indexed_arrays/      # 索引数组 (2 个)
├── 02_associative_arrays/  # 关联数组 (1 个)
└── 03_strings/             # 字符串操作 (1 个)
```

---

## 🎯 学习目标

### 索引数组
- ✅ 数组定义和初始化
- ✅ 访问数组元素
- ✅ 数组遍历
- ✅ 数组操作（添加、删除、切片）

### 关联数组
- ✅ 声明关联数组
- ✅ 键值对操作
- ✅ 遍历关联数组

### 字符串操作
- ✅ 字符串切片
- ✅ 字符串替换
- ✅ 字符串删除
- ✅ 字符串长度

---

## 📝 学习路径

### 第 22-24 天：索引数组

**脚本**：
- `01_indexed_arrays/05_for_array.sh` - for 循环遍历数组
- `01_indexed_arrays/09_arrays.sh` - 数组操作大全

**示例**：
```bash
# 数组定义
fruits=("apple" "banana" "orange")

# 访问元素
echo ${fruits[0]}      # apple
echo ${fruits[@]}      # 所有元素
echo ${#fruits[@]}     # 数组长度

# 遍历数组
for fruit in "${fruits[@]}"; do
    echo $fruit
done

# 添加元素
fruits+=("grape")

# 删除元素
unset fruits[1]
```

---

### 第 25 天：关联数组

**脚本**：
- `02_associative_arrays/16_associative_arrays.sh` - 关联数组

**示例**：
```bash
# 声明关联数组
declare -A colors

# 添加键值对
colors[red]="#FF0000"
colors[green]="#00FF00"
colors[blue]="#0000FF"

# 访问值
echo ${colors[red]}

# 遍历
for key in "${!colors[@]}"; do
    echo "$key: ${colors[$key]}"
done
```

---

### 第 26-28 天：字符串操作

**脚本**：
- `03_strings/14_variable_advanced.sh` - 字符串高级操作

**示例**：
```bash
str="Hello, World!"

# 字符串切片
echo ${str:0:5}     # Hello
echo ${str:7}       # World!

# 字符串替换
echo ${str/World/Bash}  # Hello, Bash!

# 字符串删除
echo ${str#Hello,}      # World!
echo ${str%World!}      # Hello,

# 字符串长度
echo ${#str}            # 13
```

---

## ✅ 学习检查

- [ ] 定义和访问索引数组
- [ ] 遍历数组元素
- [ ] 使用关联数组存储键值对
- [ ] 进行字符串切片和替换
- [ ] 计算字符串长度

---

## 🎓 下一步

👉 **[04_text_processing/](../04_text_processing/)** - 文本处理（第 29-42 天）

---

**祝你学习顺利！** 🚀

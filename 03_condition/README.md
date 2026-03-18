# 🔀 条件判断 (Condition)

> 学习如何让脚本做决策：if/else、逻辑运算、文件测试

**难度**: ⭐⭐  
**脚本数**: 4 个  
**建议学时**: 1.5 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_logic_operation.sh](./01_logic_operation.sh) | ⭐⭐ | 逻辑运算 (-o, -a, !) | 52 |
| 2 | [02_file_type_check.sh](./02_file_type_check.sh) | ⭐⭐⭐ | 文件类型判断 (目录、链接、设备等) | 78 |
| 3 | [03_file_permission_check.sh](./03_file_permission_check.sh) | ⭐⭐⭐ | 文件权限检查 (可读、可写、可执行) | 85 |
| 4 | [04_dead_link_check.sh](./04_dead_link_check.sh) | ⭐⭐⭐⭐ | 死链接判断 (readlink) | 92 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 使用 if/else 进行条件判断
- ✅ 使用逻辑运算符（与、或、非）
- ✅ 判断文件类型（普通文件、目录、链接等）
- ✅ 检查文件权限（读、写、执行）
- ✅ 判断字符串和数值
- ✅ 处理死链接和符号链接

---

## 📚 知识点

### 1. if/else 基础

```bash
# 单分支
if [ 条件 ]; then
    命令
fi

# 双分支
if [ 条件 ]; then
    命令 1
else
    命令 2
fi

# 多分支
if [ 条件 1 ]; then
    命令 1
elif [ 条件 2 ]; then
    命令 2
else
    命令 3
fi
```

### 2. 逻辑运算符

```bash
# 与 (-a 或 &&)
if [ $age -ge 18 ] && [ $age -le 60 ]; then
    echo "符合条件"
fi

# 或 (-o 或 ||)
if [ $score -ge 90 ] || [ $grade = "A" ]; then
    echo "优秀"
fi

# 非 (!)
if [ ! -f "$file" ]; then
    echo "文件不存在"
fi
```

### 3. 文件测试运算符

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `-e` | 文件存在 | `[ -e "$file" ]` |
| `-f` | 普通文件 | `[ -f "$file" ]` |
| `-d` | 目录 | `[ -d "$dir" ]` |
| `-L` | 符号链接 | `[ -L "$link" ]` |
| `-r` | 可读 | `[ -r "$file" ]` |
| `-w` | 可写 | `[ -w "$file" ]` |
| `-x` | 可执行 | `[ -x "$file" ]` |
| `-s` | 非空 | `[ -s "$file" ]` |

### 4. 字符串比较

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `=` | 等于 | `[ "$a" = "$b" ]` |
| `!=` | 不等于 | `[ "$a" != "$b" ]` |
| `-z` | 空字符串 | `[ -z "$str" ]` |
| `-n` | 非空字符串 | `[ -n "$str" ]` |

### 5. 数值比较

| 运算符 | 说明 | 示例 |
|--------|------|------|
| `-eq` | 等于 | `[ $a -eq $b ]` |
| `-ne` | 不等于 | `[ $a -ne $b ]` |
| `-gt` | 大于 | `[ $a -gt $b ]` |
| `-ge` | 大于等于 | `[ $a -ge $b ]` |
| `-lt` | 小于 | `[ $a -lt $b ]` |
| `-le` | 小于等于 | `[ $a -le $b ]` |

---

## 💻 示例代码

### 示例 1: 成绩评定

```bash
#!/bin/bash
# 文件名：01_grade_evaluator.sh

read -p "请输入分数：" score

if [ $score -ge 90 ]; then
    echo "优秀 (A)"
elif [ $score -ge 80 ]; then
    echo "良好 (B)"
elif [ $score -ge 70 ]; then
    echo "中等 (C)"
elif [ $score -ge 60 ]; then
    echo "及格 (D)"
else
    echo "不及格 (F)"
fi
```

### 示例 2: 文件类型检查

```bash
#!/bin/bash
# 文件名：02_file_type_check.sh

read -p "请输入文件路径：" filepath

if [ -e "$filepath" ]; then
    if [ -f "$filepath" ]; then
        echo "✓ 是普通文件"
    elif [ -d "$filepath" ]; then
        echo "✓ 是目录"
    elif [ -L "$filepath" ]; then
        echo "✓ 是符号链接"
    else
        echo "✓ 是其他类型文件"
    fi
else
    echo "✗ 文件不存在"
fi
```

### 示例 3: 权限检查

```bash
#!/bin/bash
# 文件名：03_permission_check.sh

read -p "请输入文件路径：" file

echo "=== 文件权限检查 ==="

if [ -r "$file" ]; then
    echo "✓ 可读"
else
    echo "✗ 不可读"
fi

if [ -w "$file" ]; then
    echo "✓ 可写"
else
    echo "✗ 不可写"
fi

if [ -x "$file" ]; then
    echo "✓ 可执行"
else
    echo "✗ 不可执行"
fi
```

### 示例 4: 死链接检测

```bash
#!/bin/bash
# 文件名：04_dead_link_check.sh

read -p "请输入链接路径：" link

if [ -L "$link" ]; then
    target=$(readlink -f "$link" 2>/dev/null)
    if [ -e "$target" ]; then
        echo "✓ 链接有效，指向：$target"
    else
        echo "✗ 死链接！目标不存在"
    fi
else
    echo "✗ 不是符号链接"
fi
```

---

## 🔧 练习任务

### 任务 1: 登录验证

创建一个脚本，验证用户名和密码：
- 用户名：admin
- 密码：123456
- 最多尝试 3 次

**参考**:
```bash
#!/bin/bash
max_attempts=3
attempt=1

while [ $attempt -le $max_attempts ]; do
    read -p "用户名：" user
    read -sp "密码：" pass
    echo
    
    if [ "$user" = "admin" ] && [ "$pass" = "123456" ]; then
        echo "✓ 登录成功"
        exit 0
    else
        echo "✗ 登录失败，剩余 $((max_attempts - attempt)) 次机会"
    fi
    ((attempt++))
done

echo "账户已锁定"
```

### 任务 2: 文件备份检查

创建一个脚本，检查文件是否需要备份：
- 文件存在
- 文件大小 > 0
- 文件最后修改时间 > 7 天前

**参考**:
```bash
#!/bin/bash
file="$1"

if [ -f "$file" ] && [ -s "$file" ]; then
    echo "✓ 文件存在且非空"
    # 检查修改时间
    if [ $(find "$file" -mtime +7 | wc -l) -gt 0 ]; then
        echo "✓ 需要备份（修改超过 7 天）"
    fi
fi
```

---

## 📝 最佳实践

### 1. 使用双中括号进行复杂测试

```bash
✅ if [[ $age -ge 18 && $age -le 60 ]]; then

❌ if [ $age -ge 18 -a $age -le 60 ]; then  # 旧语法
```

### 2. 变量始终加引号

```bash
✅ if [ -f "$file" ]; then

❌ if [ -f $file ]; then  # 文件名有空格会出错
```

### 3. 使用 case 处理多分支

```bash
✅ case $choice in
    1) echo "选项 1" ;;
    2) echo "选项 2" ;;
    *) echo "无效选项" ;;
esac

❌ if [ $choice = 1 ]; then
       ...
   elif [ $choice = 2 ]; then
       ...
   fi
```

### 4. 数值比较用 -eq 而非 =

```bash
✅ if [ $count -eq 0 ]; then

❌ if [ $count = 0 ]; then  # 字符串比较
```

---

## ⚠️ 常见错误

### 错误 1: 空格问题

```bash
❌ if [ $a -eq$b ]; then  # 缺少空格

✅ if [ $a -eq $b ]; then
```

### 错误 2: 未初始化变量

```bash
❌ if [ $count -gt 0 ]; then  # count 未定义会出错

✅ if [ "${count:-0}" -gt 0 ]; then  # 设置默认值
```

### 错误 3: 逻辑运算符优先级

```bash
❌ if [ $a -gt 0 ] && [ $b -gt 0 ] || [ $c -gt 0 ]; then
   # 优先级不明确

✅ if [[ ($a -gt 0 && $b -gt 0) || $c -gt 0 ]]; then
```

---

## 📖 扩展阅读

- [Bash 条件表达式](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)
- [Shell 测试命令](https://man7.org/linux/man-pages/man1/test.1.html)
- [逻辑运算详解](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **04_loop/** - 学习循环结构
2. **05_case/** - 学习选择结构
3. **06_text/** - 学习文本处理

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

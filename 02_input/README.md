# 💬 交互式输入 (Interactive Input)

> 学习如何与用户交互：接收输入、验证数据、处理表单

**难度**: ⭐⭐  
**脚本数**: 5 个  
**建议学时**: 1.5 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_name_phone_age.sh](./01_name_phone_age.sh) | ⭐⭐ | read 命令 (-p, -s, -n, -t) | 35 |
| 2 | [02_note_search.sh](./02_note_search.sh) | ⭐⭐⭐ | 笔记查找工具 (grep, cut, sort) | 68 |
| 3 | [03_file_exist_check.sh](./03_file_exist_check.sh) | ⭐⭐ | 文件存在性检查 (-e) | 42 |
| 4 | [04_ping_check.sh](./04_ping_check.sh) | ⭐⭐ | IP 连通性检查 (ping) | 38 |
| 5 | [05_user_info_complete.sh](./05_user_info_complete.sh) | ⭐⭐⭐ | 完整用户信息输入 (性别、年龄验证) | 95 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 使用 `read` 命令接收用户输入
- ✅ 隐藏密码输入（-s 选项）
- ✅ 设置输入超时（-t 选项）
- ✅ 限制输入字符数（-n 选项）
- ✅ 验证用户输入数据
- ✅ 使用 grep 搜索内容
- ✅ 检查文件是否存在

---

## 📚 知识点

### 1. read 命令基础

```bash
read name                    # 读取输入到变量
read -p "请输入：" name      # 带提示
read -s password             # 隐藏输入（密码）
read -t 10 answer            # 10 秒超时
read -n 1 choice             # 读取 1 个字符
read -r line                 # 不解释转义字符
```

### 2. 输入验证

```bash
# 检查是否为空
if [ -z "$name" ]; then
    echo "名字不能为空"
fi

# 检查是否为数字
if ! [[ "$age" =~ ^[0-9]+$ ]]; then
    echo "年龄必须是数字"
fi

# 检查邮箱格式
if ! [[ "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
    echo "邮箱格式不正确"
fi
```

### 3. 文件检查

```bash
if [ -e "$file" ]; then      # 文件存在
    echo "文件存在"
fi

if [ -f "$file" ]; then      # 是普通文件
    echo "是文件"
fi

if [ -d "$dir" ]; then       # 是目录
    echo "是目录"
fi

if [ -r "$file" ]; then      # 可读
    echo "文件可读"
fi

if [ -x "$file" ]; then      # 可执行
    echo "文件可执行"
fi
```

### 4. grep 搜索

```bash
grep "keyword" file.txt           # 基本搜索
grep -i "keyword" file.txt        # 忽略大小写
grep -v "keyword" file.txt        # 反向匹配
grep -c "keyword" file.txt        # 统计匹配行数
grep -n "keyword" file.txt        # 显示行号
```

---

## 💻 示例代码

### 示例 1: 基本输入

```bash
#!/bin/bash
# 文件名：01_basic_input.sh

read -p "请输入你的名字：" name
read -p "请输入你的年龄：" age

echo "你好，$name！你今年 $age 岁。"
```

**运行**:
```bash
./01_basic_input.sh
```

**输出**:
```
请输入你的名字：张三
请输入你的年龄：25
你好，张三！你今年 25 岁。
```

### 示例 2: 密码输入

```bash
#!/bin/bash
# 文件名：02_password_input.sh

read -sp "请输入密码：" password
echo
read -sp "请确认密码：" password_confirm
echo

if [ "$password" = "$password_confirm" ]; then
    echo "✓ 密码设置成功"
else
    echo "✗ 两次密码不一致"
fi
```

### 示例 3: 文件存在性检查

```bash
#!/bin/bash
# 文件名：03_file_check.sh

read -p "请输入文件名：" filename

if [ -e "$filename" ]; then
    echo "✓ 文件存在"
    ls -lh "$filename"
else
    echo "✗ 文件不存在"
fi
```

### 示例 4: 笔记搜索工具

```bash
#!/bin/bash
# 文件名：04_note_search.sh

read -p "请输入要搜索的关键词：" keyword

echo "正在搜索：$keyword"
echo "========================"

grep -in "$keyword" ~/notes/*.txt

count=$(grep -rc "$keyword" ~/notes/ | wc -l)
echo "========================"
echo "找到 $count 条匹配记录"
```

---

## 🔧 练习任务

### 任务 1: 用户注册表单

创建一个脚本，收集以下信息：
- 用户名（必填）
- 邮箱（验证格式）
- 密码（隐藏输入，至少 6 位）
- 确认密码

**参考**:
```bash
#!/bin/bash
read -p "用户名：" username
if [ -z "$username" ]; then
    echo "用户名不能为空"
    exit 1
fi

read -p "邮箱：" email
if ! [[ "$email" =~ @ ]]; then
    echo "邮箱格式不正确"
    exit 1
fi

read -sp "密码：" password
if [ ${#password} -lt 6 ]; then
    echo "密码至少 6 位"
    exit 1
fi
```

### 任务 2: 文件查找工具

创建一个脚本，在指定目录查找包含关键词的文件：

**参考**:
```bash
#!/bin/bash
read -p "搜索目录：" search_dir
read -p "关键词：" keyword

grep -rl "$keyword" "$search_dir" 2>/dev/null
```

---

## 📝 最佳实践

### 1. 始终验证用户输入

```bash
✅ read -p "年龄：" age
   if ! [[ "$age" =~ ^[0-9]+$ ]]; then
       echo "年龄必须是数字"
       exit 1
   fi

❌ read -p "年龄：" age
   # 没有验证
```

### 2. 密码输入要隐藏

```bash
✅ read -sp "密码：" password
   echo

❌ read -p "密码：" password
```

### 3. 提供友好的错误提示

```bash
✅ if [ ! -f "$file" ]; then
       echo "错误：文件 '$file' 不存在"
       echo "请检查文件路径后重试"
       exit 1
   fi

❌ if [ ! -f "$file" ]; then
       echo "文件不存在"
       exit 1
   fi
```

### 4. 使用有意义的变量名

```bash
✅ user_email=$1
   max_retry_count=3

❌ e=$1
   n=3
```

---

## ⚠️ 常见错误

### 错误 1: 变量引用忘记加引号

```bash
❌ if [ -f $file ]; then  # 文件名有空格会出错

✅ if [ -f "$file" ]; then
```

### 错误 2: 密码输入后没有换行

```bash
❌ read -sp "密码：" password
   echo "密码已设置"  # 会接在密码后面

✅ read -sp "密码：" password
   echo  # 换行
   echo "密码已设置"
```

### 错误 3: 正则表达式未转义

```bash
❌ if [[ "$email" =~ ^[0-9]+@[0-9]+.[0-9]+$ ]]; then  # . 未转义

✅ if [[ "$email" =~ ^[0-9]+@[0-9]+\.[0-9]+$ ]]; then
```

---

## 📖 扩展阅读

- [read 命令详解](https://man7.org/linux/man-pages/man1/read.1.html)
- [Bash 条件测试](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)
- [grep 使用技巧](https://www.gnu.org/software/grep/manual/grep.html)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **03_condition/** - 深入学习条件判断
2. **04_loop/** - 学习循环结构
3. **05_case/** - 学习选择结构

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

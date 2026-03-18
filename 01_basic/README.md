# 🎯 基础输出 (Basic Output)

> Shell 编程入门第一课：学习如何使用 echo 和 printf 输出信息

**难度**: ⭐  
**脚本数**: 2 个  
**建议学时**: 30 分钟

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_hello_world.sh](./01_hello_world.sh) | ⭐ | Hello World - 最简单的脚本 | 15 |
| 2 | [02_special_variables.sh](./02_special_variables.sh) | ⭐⭐ | 特殊变量 ($0, $1, $$, $#, $*, $@) | 45 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 创建并执行第一个 Shell 脚本
- ✅ 理解 Shebang (`#!`) 的作用
- ✅ 使用 `echo` 和 `printf` 输出信息
- ✅ 理解 Shell 特殊变量的含义
- ✅ 给脚本添加执行权限
- ✅ 传递参数给脚本

---

## 📚 知识点

### 1. Shebang (#!)

```bash
#!/bin/bash
```

**作用**: 告诉系统使用哪个解释器执行脚本

**常见选项**:
```bash
#!/bin/bash      # 使用 bash
#!/bin/sh        # 使用 sh
#!/usr/bin/env bash  # 从环境变量查找 bash
```

### 2. echo 命令

```bash
echo "Hello World"           # 基本输出
echo -n "No newline"         # 不换行
echo -e "Tab:\tSpace"        # 解释转义字符
echo "变量：$HOME"           # 输出变量
```

### 3. printf 命令

```bash
printf "Name: %s\n" "John"   # 格式化输出
printf "Age: %d\n" 25        # 数字格式化
printf "Price: %.2f\n" 9.99  # 浮点数
```

### 4. 特殊变量

| 变量 | 说明 | 示例 |
|------|------|------|
| `$0` | 脚本名称 | `./script.sh` → `$0 = script.sh` |
| `$1`, `$2`... | 位置参数 | `./script.sh a b` → `$1=a, $2=b` |
| `$#` | 参数个数 | `./script.sh a b` → `$#=2` |
| `$*` | 所有参数（一个词） | `"a b c"` |
| `$@` | 所有参数（单独词） | `"a" "b" "c"` |
| `$$` | 当前进程 ID | `12345` |
| `$?` | 上个命令退出码 | `0` 表示成功 |

---

## 💻 示例代码

### 示例 1: Hello World

```bash
#!/bin/bash
# 文件名：01_hello_world.sh
# 功能：输出 Hello World

echo "Hello, World!"
echo "欢迎学习 Shell 编程！"
```

**运行**:
```bash
chmod +x 01_hello_world.sh
./01_hello_world.sh
```

**输出**:
```
Hello, World!
欢迎学习 Shell 编程！
```

### 示例 2: 特殊变量演示

```bash
#!/bin/bash
# 文件名：02_special_variables.sh
# 功能：演示 Shell 特殊变量

echo "脚本名称：$0"
echo "第一个参数：$1"
echo "第二个参数：$2"
echo "参数个数：$#"
echo "所有参数：$*"
echo "进程 ID: $$"
```

**运行**:
```bash
chmod +x 02_special_variables.sh
./02_special_variables.sh arg1 arg2 arg3
```

**输出**:
```
脚本名称：./02_special_variables.sh
第一个参数：arg1
第二个参数：arg2
参数个数：3
所有参数：arg1 arg2 arg3
进程 ID: 12345
```

---

## 🔧 练习任务

### 任务 1: 自我介绍脚本

创建一个脚本，输出以下信息：
- 你的名字
- 你的城市
- 你学习 Shell 的目的

**参考**:
```bash
#!/bin/bash
echo "=== 自我介绍 ==="
echo "姓名：张三"
echo "城市：北京"
echo "目标：学习 Shell 自动化"
```

### 任务 2: 参数计算器

创建一个脚本，接收两个数字参数，输出它们的和：

**参考**:
```bash
#!/bin/bash
num1=$1
num2=$2
sum=$((num1 + num2))
echo "$num1 + $num2 = $sum"
```

---

## 📝 最佳实践

### 1. 始终使用 Shebang

```bash
✅ #!/bin/bash
❌ (没有 Shebang)
```

### 2. 给脚本可执行权限

```bash
chmod +x script.sh
./script.sh
```

### 3. 使用有意义的变量名

```bash
✅ user_name=$1
❌ x=$1
```

### 4. 添加注释说明

```bash
#!/bin/bash
# 功能：计算两个数的和
# 作者：张三
# 日期：2026-03-18
```

---

## ⚠️ 常见错误

### 错误 1: 忘记添加执行权限

```bash
❌ ./script.sh
   -bash: ./script.sh: Permission denied

✅ chmod +x script.sh
   ./script.sh
```

### 错误 2: Shebang 写法错误

```bash
❌ #! /bin/bash (有空格)
❌ #!/bin/sh bash (多余内容)

✅ #!/bin/bash
```

### 错误 3: 变量引用忘记加 $

```bash
❌ echo name
✅ echo $name
```

---

## 📖 扩展阅读

- [Bash 官方文档](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本教程](https://www.shellscript.sh/)
- [Linux 命令大全](https://wangchujiang.com/linux-command/)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **02_input/** - 学习如何接收用户输入
2. **03_condition/** - 学习条件判断
3. **04_loop/** - 学习循环结构

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

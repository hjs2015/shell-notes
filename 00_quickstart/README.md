# 🚀 快速开始 (Quick Start)

> **学习第 1 天** | 难度：⭐ | 5 个脚本 | 预计 1-2 小时

---

## 📋 目录

- [简介](#简介)
- [脚本清单](#脚本清单)
- [学习目标](#学习目标)
- [学习步骤](#学习步骤)
  - [1. Hello World](#1-hello-world-10-分钟)
  - [2. 特殊变量](#2-特殊变量-30-分钟)
  - [3. 通配符与输出](#3-通配符与输出-15-分钟)
  - [4. Shell 环境检测](#4-shell-环境检测-20-分钟)
  - [5. 脚本执行方式](#5-脚本执行方式-25-分钟)
- [常见陷阱](#常见陷阱) ⭐ 新增
- [常见问题 FAQ](#常见问题-faq) ⭐ 新增
- [学习检查](#学习检查)
- [下一步](#下一步)

---

## 📖 简介

这是 Shell 编程的**第一个目录**，帮助你快速体验 Shell 脚本的魅力。

**学完你能做什么**：
- ✅ 创建并运行第一个 Shell 脚本
- ✅ 理解脚本如何接收参数
- ✅ 使用通配符快速查找文件
- ✅ 检查系统和 Shell 环境
- ✅ 用正确的方式运行脚本

**预计时间**：1-2 小时

---

## 📁 脚本清单

| 脚本 | 名称 | 难度 | 时间 | 核心技能 |
|------|------|------|------|----------|
| [01_hello_world.sh](01_hello_world.sh) | Hello World | ⭐ | 10 分钟 | 第一个脚本 |
| [02_special_variables.sh](02_special_variables.sh) | 特殊变量 | ⭐ | 30 分钟 | 参数传递 |
| [03_wildcards_and_echo.sh](03_wildcards_and_echo.sh) | 通配符 | ⭐ | 15 分钟 | 文件匹配 |
| [04_shell_environment_check.sh](04_shell_environment_check.sh) | 环境检测 | ⭐ | 20 分钟 | 系统检测 |
| [05_script_execution_methods.sh](05_script_execution_methods.sh) | 执行方式 | ⭐ | 25 分钟 | 运行脚本 |

---

## 🎯 学习目标

完成本阶段后，你将能够：

- ✅ 创建并运行 Shell 脚本
- ✅ 理解 `$0`, `$1`, `$@`, `$*` 等特殊变量
- ✅ 使用通配符 (`*`, `?`, `[]`) 匹配文件
- ✅ 使用 `echo` 和 `printf` 输出信息
- ✅ 检测 Shell 环境和系统信息
- ✅ 掌握脚本的各种执行方式及其区别

---

## 📝 学习步骤

### 1. Hello World (10 分钟)

**场景**：验证 Shell 环境，运行第一个脚本

**运行脚本**：
```bash
# 查看脚本内容
cat 01_hello_world.sh

# 添加执行权限
chmod +x 01_hello_world.sh

# 运行脚本
./01_hello_world.sh
```

**预期输出**：
```
1
2
3
```

**核心代码**：
```bash
#!/bin/bash
# Shebang（#!/bin/bash）告诉系统用 bash 解释此脚本
echo 1  # echo 命令输出文本，自动换行
echo 2
echo 3
```

**知识点**：
- `#!/bin/bash` - **Shebang**：指定脚本解释器（必须第一行）
- `chmod +x` - 添加执行权限
- `echo` - 输出文本（自动换行）

**💡 为什么需要 Shebang？**  
Shell 脚本无需编译，直接由终端解释执行。Shebang 告诉系统用哪个程序（bash/sh/python）来运行脚本。

---

### 2. 特殊变量 (30 分钟)

**场景**：编写可接收参数的脚本（如备份工具、部署脚本）

**运行脚本**：
```bash
# 查看脚本
cat 02_special_variables.sh

# 运行脚本（带 3 个参数）
./02_special_variables.sh arg1 arg2 arg3
```

**预期输出**：
```
脚本名：./02_special_variables.sh
第 1 个参数：arg1
第 2 个参数：arg2
第 3 个参数：arg3
参数个数：3
所有参数（独立）：arg1 arg2 arg3
所有参数（字符串）：arg1 arg2 arg3
```

**核心代码**：
```bash
#!/bin/bash
echo "脚本名：$0"           # $0 = 脚本名称
echo "第 1 个参数：$1"      # $1 = 第 1 个位置参数
echo "第 2 个参数：$2"      # $2 = 第 2 个位置参数
echo "参数个数：$#"         # $# = 参数总个数
echo "所有参数：$@"         # $@ = 所有参数（独立）
echo "进程 ID: $$"          # $$ = 当前 Shell 进程 ID
```

**特殊变量速查表**：

| 变量 | 含义 | 示例 | 输出 |
|------|------|------|------|
| `$0` | 脚本名称 | `echo $0` | `script.sh` |
| `$1-$9` | 位置参数 | `echo $1` | `arg1` |
| `$#` | 参数个数 | `echo $#` | `3` |
| `$@` | 所有参数（独立） | `echo $@` | `arg1 arg2 arg3` |
| `$*` | 所有参数（字符串） | `echo "$*"` | `arg1 arg2 arg3` |
| `$?` | 上一个命令退出码 | `echo $?` | `0` |
| `$$` | 当前进程 ID | `echo $$` | `12345` |
| `$!` | 最后后台进程 ID | `echo $!` | `12346` |
| `$RANDOM` | 随机数 | `echo $RANDOM` | `17632` |

**实战应用**：
```bash
# 批量重命名文件（接收前缀参数）
#!/bin/bash
prefix=$1  # 第 1 个参数作为前缀
for file in *.txt; do
    mv "$file" "${prefix}_${file}"
done
# 使用：./rename.sh backup
# 结果：file.txt → backup_file.txt
```

---

### 3. 通配符与输出 (15 分钟)

**场景**：快速查找文件、批量操作

**运行脚本**：
```bash
# 查看脚本
cat 03_wildcards_and_echo.sh

# 运行脚本
./03_wildcards_and_echo.sh
```

**预期输出**：
```
使用 echo 输出：Hello World
使用 printf 输出：Hello World（无换行）
当前目录的.sh 文件：
01_hello_world.sh
02_special_variables.sh
...
```

**核心代码**：
```bash
#!/bin/bash
# echo 输出（自动换行）
echo "Hello World"

# printf 输出（需手动加 \n）
printf "Hello World\n"

# 通配符匹配文件
ls *.sh    # 所有.sh 文件
ls file?.txt  # file1.txt, fileA.txt（单个字符）
ls file[1-3].txt  # file1.txt, file2.txt, file3.txt
```

**通配符速查**：

| 通配符 | 含义 | 示例 | 匹配结果 |
|--------|------|------|----------|
| `*` | 任意字符（0 或多个） | `*.sh` | 所有.sh 文件 |
| `?` | 单个字符 | `file?.txt` | file1.txt, fileA.txt |
| `[]` | 字符范围 | `file[1-3].txt` | file1.txt, file2.txt, file3.txt |
| `[!]` | 排除字符 | `file[!1].txt` | 除 file1.txt 外的所有 |

**实战应用**：
```bash
# 批量删除.log 文件
rm *.log

# 查找所有配置文件
ls *.conf

# 备份所有.txt 文件
cp *.txt backup/
```

---

### 4. Shell 环境检测 (20 分钟)

**场景**：部署脚本前检查环境、故障排查

**运行脚本**：
```bash
# 查看脚本
cat 04_shell_environment_check.sh

# 运行脚本
bash 04_shell_environment_check.sh
```

**预期输出**：
```
========================================
Shell 环境检测报告
========================================
操作系统：Linux Ubuntu 22.04
Shell 类型：bash
Shell 版本：5.1.16(1)-release
当前用户：root
主机名：copaw
...
```

**核心代码**：
```bash
#!/bin/bash
echo "操作系统：$(uname -s) $(uname -r)"  # 系统信息
echo "Shell 类型：$SHELL"                 # 当前 Shell
echo "当前用户：$(whoami)"                # 用户名
echo "主机名：$(hostname)"                # 主机名
```

**知识点**：
- `uname` - 系统信息
- `hostname` - 主机名
- `whoami` - 当前用户
- `$(command)` - 命令替换（执行命令并获取输出）

**实战应用**：
```bash
# 部署前环境检查
#!/bin/bash
if ! command -v docker &> /dev/null; then
    echo "错误：Docker 未安装"
    exit 1
fi
echo "环境检查通过"
```

---

### 5. 脚本执行方式 (25 分钟)

**场景**：用正确的方式运行脚本

**运行脚本**：
```bash
# 查看脚本
cat 05_script_execution_methods.sh

# 运行脚本
bash 05_script_execution_methods.sh
```

**预期输出**：
```
========================================
脚本执行权限与运行方式详解
========================================
【演示 1】检查脚本执行权限
【演示 2】不同执行方式对比
...
```

**5 种执行方式对比**：

| 方式 | 命令 | 是否需要权限 | 特点 |
|------|------|-------------|------|
| bash 执行 | `bash script.sh` | ❌ 不需要 | 用 bash 解释，忽略 shebang |
| 直接执行 | `./script.sh` | ✅ 需要 | 用 shebang 指定的解释器 |
| source 执行 | `source script.sh` | ❌ 不需要 | 在当前 Shell 执行（变量保留） |
| . 执行 | `. script.sh` | ❌ 不需要 | 同 source（简写） |
| sh 执行 | `sh script.sh` | ❌ 不需要 | 用 sh 解释（可能不兼容 bash） |

**核心代码**：
```bash
#!/bin/bash
# 检查执行权限
if [ -x script.sh ]; then
    echo "脚本可执行"
else
    echo "脚本不可执行，添加权限..."
    chmod +x script.sh
fi
```

**实战建议**：
- ✅ **推荐**：`./script.sh`（标准方式）
- ✅ **调试**：`bash -x script.sh`（显示执行过程）
- ✅ **加载配置**：`source ~/.bashrc`（保留变量）

---

## ⚠️ 常见陷阱 ⭐ 新增

### 1. 忘加 Shebang

**错误**：
```bash
# 脚本第一行没有 #!/bin/bash
echo "Hello"
```

**问题**：系统可能用错误的解释器（如 sh）运行，导致语法错误

**解决**：
```bash
#!/bin/bash  # 必须第一行
echo "Hello"
```

---

### 2. 空格语法错误

**错误**：
```bash
var = "value"  # ❌ 等号两边不能有空格
```

**正确**：
```bash
var="value"    # ✅ 等号两边无空格
```

---

### 3. 路径含空格

**错误**：
```bash
cd /Users/xxx/My Folder  # ❌ 会被解析为两个参数
```

**正确**：
```bash
cd "/Users/xxx/My Folder"  # ✅ 用引号包裹
cd /Users/xxx/My\ Folder   # ✅ 或用转义
```

---

### 4. 忘记执行权限

**错误**：
```bash
./script.sh  # ❌ Permission denied
```

**解决**：
```bash
chmod +x script.sh  # ✅ 添加执行权限
./script.sh
```

---

### 5. 变量引用错误

**错误**：
```bash
echo $var    # ❌ 如果 var 为空，会输出空
echo $var.txt  # ❌ 会被解析为 $v + a + r.txt
```

**正确**：
```bash
echo "$var"      # ✅ 用引号包裹
echo "${var}.txt"  # ✅ 用花括号明确范围
```

---

## ❓ 常见问题 FAQ ⭐ 新增

### Q1: 运行脚本提示 "Permission denied"

**原因**：脚本没有执行权限

**解决**：
```bash
chmod +x script.sh
./script.sh
```

---

### Q2: 中文输出乱码

**原因**：终端编码不匹配

**解决**：
```bash
# 方法 1：脚本开头添加
export LANG=zh_CN.UTF-8

# 方法 2：检查终端编码
locale  # 查看当前编码
```

---

### Q3: 脚本运行但没输出

**可能原因**：
1. 没有执行权限 → `chmod +x script.sh`
2. 路径错误 → 用绝对路径或 `./script.sh`
3. 输出被重定向 → 检查是否有 `>` 或 `>>`

**调试**：
```bash
bash -x script.sh  # 显示执行过程
```

---

### Q4: 如何传递参数给脚本？

**方法**：
```bash
# 定义参数
./script.sh arg1 arg2 arg3

# 脚本中接收
#!/bin/bash
echo "第 1 个参数：$1"
echo "第 2 个参数：$2"
echo "所有参数：$@"
```

---

### Q5: 如何获取脚本所在目录？

**方法**：
```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "脚本目录：$SCRIPT_DIR"
```

---

## ✅ 学习检查

完成本阶段后，你应该能够：

- [ ] 创建并运行一个简单的 Shell 脚本
- [ ] 解释 `$0`, `$1`, `$#` 的含义
- [ ] 使用 `*` 和 `?` 匹配文件
- [ ] 使用 `echo` 和 `printf` 输出信息
- [ ] 检测当前 Shell 环境和系统信息
- [ ] 说明 bash、./、source 三种执行方式的区别
- [ ] 避免常见陷阱（空格、权限、路径）

---

## 🎓 下一步

完成本阶段后，继续学习：

👉 **[01_basics/](../01_basics/)** - 基础篇（第 2-7 天）

你将学习：
- 变量定义和操作
- 算术和逻辑运算
- 用户输入和格式化输出

---

## 💡 小贴士

1. **多动手** - 每个脚本都要亲自运行
2. **修改代码** - 尝试修改参数看效果
3. **做笔记** - 记录特殊变量的用途
4. **遇到问题** - 查看 FAQ 或搜索错误信息

---

## 📚 参考资源

- [Bash 特殊变量详解](https://www.gnu.org/software/bash/manual/)
- [通配符使用指南](https://www.runoob.com/linux/linux-shell.html)
- [快速参考手册](../SHELL_GUIDE_BASE.md)

---

**祝你学习顺利！** 🚀

[开始学习](#-学习步骤) | [查看学习路径](../LEARNING_PATH.md) | [返回主页](../README.md)

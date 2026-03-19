# Shell 编程学习指南

> 完整的学习路径，从零基础到实战专家 | 55 个脚本 + 9 个目录 README

## 📖 学习路线

### 第 0 步：了解仓库结构

在开始之前，先了解本仓库的组织结构：

```
shell-notes/
├── 01_basic/           # 基础输出 (⭐) - 2 个脚本 + README
├── 02_input/           # 交互式输入 (⭐⭐) - 5 个脚本 + README
├── 03_condition/       # 条件判断 (⭐⭐) - 4 个脚本 + README
├── 04_loop/            # 循环结构 (⭐⭐⭐) - 20 个脚本 + README
├── 05_case/            # 选择结构 (⭐⭐⭐) - 12 个脚本 + README
├── 06_text/            # 文本处理 (⭐⭐⭐⭐) - 3 个 AWK + README
├── 07_system/          # 系统管理 (⭐⭐⭐⭐) - 1 个脚本 + README
├── 08_practice/        # 综合练习 (⭐⭐⭐⭐⭐) - 3 个脚本 + README
└── 09_devops/          # DevOps 实战 (⭐⭐⭐⭐⭐) - 5 个脚本 + README
```

**每个目录都有独立的 README.md**，包含：
- 📋 脚本清单表格
- 🎯 学习目标
- 📚 知识点详解
- 💻 示例代码
- 🔧 练习任务
- ⚠️ 常见错误
- 📖 扩展阅读

建议先阅读目录 README，了解该目录的学习重点。

---

### 第 1 阶段：基础入门 (2-3 天)

#### Day 1 - Hello World 和变量
- ✅ `01_basic/01_hello_world.sh` - 第一个脚本
- ✅ `01_basic/02_special_variables.sh` - 特殊变量
- 📚 知识点：
  - shebang (`#!/bin/bash`)
  - echo 命令
  - 变量定义和使用
  - 特殊变量：$0, $1, $$, $#, $*, $@
- 📖 **参考**: `01_basic/README.md`

**练习**:
```bash
# 1. 创建你的第一个脚本
echo "Hello, World!"

# 2. 尝试使用不同的变量
name="Alice"
echo "Hello, $name"

# 3. 理解特殊变量
bash script.sh arg1 arg2 arg3
```

#### Day 2 - 用户交互
- ✅ `02_input/01_name_phone_age.sh` - read 命令
- ✅ `02_input/03_file_exist_check.sh` - 文件存在性检查
- ✅ `02_input/04_ping_check.sh` - IP 连通性检查
- 📚 知识点：
  - read -p (提示语)
  - read -s (隐藏输入)
  - read -n (字符数限制)
  - read -t (超时)
  - if 条件判断
  - 文件测试：-e, -f, -d
- 📖 **参考**: `02_input/README.md`

**练习**:
```bash
# 创建一个简单的登录脚本
read -p "用户名:" user
read -sp "密码:" pass
echo ""
if [ "$user" = "admin" ] && [ "$pass" = "123456" ]; then
    echo "登录成功"
else
    echo "登录失败"
fi
```

#### Day 3 - 条件判断
- ✅ `03_condition/01_logic_operation.sh` - 逻辑运算
- ✅ `03_condition/02_file_type_check.sh` - 文件类型判断
- ✅ `03_condition/03_file_permission_check.sh` - 文件权限判断
- 📚 知识点：
  - if/else/elif
  - 逻辑运算符：-o (或), -a (与), ! (非)
  - 文件测试：-L, -d, -S, -p, -c, -b, -r, -w, -x
  - 整数比较：-gt, -lt, -eq, -ne
- 📖 **参考**: `03_condition/README.md`

**练习**:
```bash
# 判断文件类型
read -p "输入文件路径:" file
if [ -d "$file" ]; then
    echo "是目录"
elif [ -f "$file" ]; then
    echo "是普通文件"
elif [ -L "$file" ]; then
    echo "是符号链接"
else
    echo "其他类型"
fi
```

---

### 第 2 阶段：流程控制 (3-5 天)

#### Day 4-5 - for 循环
- ✅ `04_loop/01_recursive_echo.sh` ~ `04_loop/20_concurrent_task.sh` - for 循环基础
- ✅ `04_loop/02_multiplication_table.sh` - 99 乘法表
- 📚 知识点：
  - for in 列表
  - for seq 序列
  - for {1..100} 大括号展开
  - for ((i=1; i<=100; i++)) C 语言风格
- 📖 **参考**: `04_loop/README.md`

**练习**:
```bash
# 打印 1-100 的偶数
for i in {1..100}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo $i
    fi
done
```

#### Day 6-7 - while 和 until 循环
- ✅ `04_loop/06_while_basic.sh` - while 循环
- ✅ `04_loop/07_until_basic.sh` - until 循环
- ✅ `04_loop/17_guess_number.sh` - 猜数字游戏
- 📚 知识点：
  - while 条件
  - until 条件
  - break 退出循环
  - continue 跳过本次

**练习**:
```bash
# 猜数字游戏
number=$((RANDOM % 100 + 1))
while true; do
    read -p "猜一个数字 (1-100):" guess
    if [ $guess -eq $number ]; then
        echo "恭喜你猜对了!"
        break
    elif [ $guess -lt $number ]; then
        echo "太小了"
    else
        echo "太大了"
    fi
done
```

#### Day 8-9 - case 选择结构
- ✅ `05_case/01_case_basic.sh` - 基础 case
- ✅ `05_case/03_service_menu.sh` - 服务菜单
- ✅ `05_case/07_select_menu.sh` - select 菜单
- 📚 知识点：
  - case 模式匹配
  - 字符范围：[a-z], [A-Z], [0-9]
  - select 菜单

**练习**:
```bash
# 服务管理脚本
case "$1" in
    start)
        echo "启动服务..."
        ;;
    stop)
        echo "停止服务..."
        ;;
    restart)
        echo "重启服务..."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        ;;
esac
```

---

### 第 3 阶段：文本处理 (2-3 天)

#### Day 10-11 - grep, awk, sed
- ✅ `06_text/shell04.txt` - awk 基础教程
- ✅ `06_text/shell05.txt` - awk 脚本教程
- ✅ `06_text/1.awk` ~ `06_text/3.awk` - awk 示例
- 📚 知识点：
  - grep 文本搜索
  - awk 字段提取
  - sed 文本替换
  - cut 字段切割
  - sort 排序
  - uniq 去重
  - 管道组合

**练习**:
```bash
# 统计日志中 ERROR 的数量
grep "ERROR" /var/log/app.log | wc -l

# 提取 /etc/passwd 的用户名
awk -F: '{print $1}' /etc/passwd

# 替换文件中的文本
sed 's/old/new/g' file.txt
```

---

### 第 4 阶段：系统管理 (1-2 天)

#### Day 12 - 日志和邮件
- ✅ `07_system/01_log_rotation.sh` - 日志轮转
- 📚 知识点：
  - date 日期操作
  - mkdir 创建目录
  - mv 移动文件
  - mail 发送邮件
  - logger 系统日志
  - kill 进程管理

**练习**:
```bash
# 创建每日备份脚本
backup_dir="/backup/$(date +%Y%m%d)"
mkdir -p "$backup_dir"
cp -r /var/www/html "$backup_dir/"
echo "备份完成" | mail -s "每日备份" admin@example.com
```

---

### 第 5 阶段：综合实战 (2-3 天)

#### Day 13-15 - 完整项目
- ✅ `08_practice/01_user_register.sh` - 用户注册
- ✅ `08_practice/02_user_login.sh` - 用户登录
- ✅ `08_practice/03_register_login_system.sh` - 注册登录系统

**毕业项目**: 创建一个完整的用户管理系统
- 用户注册 (带密码验证)
- 用户登录 (带验证码)
- 密码找回
- 用户信息管理

---

## 🎯 学习建议

### 1. 多动手
- 不要只看代码，要亲手敲
- 每个脚本至少运行 3 遍
- 尝试修改参数看效果

### 2. 理解原理
- 为什么要这样写？
- 有没有更好的方法？
- 如果...会怎样？

### 3. 做笔记
- 记录学到的命令
- 整理常用代码片段
- 记录遇到的问题和解决方法

### 4. 实战练习
- 用脚本解决实际问题
- 自动化日常任务
- 参与开源项目

---

## 📚 推荐资源

### 在线教程
- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)

### 练习平台
- [Exercism - Bash](https://exercism.org/tracks/bash)
- [HackerRank - Shell](https://www.hackerrank.com/domains/shell)
- [Codewars - Shell](https://www.codewars.com/?language=shell)

### 书籍
- 《Linux Shell 脚本攻略》
- 《Bash 编程指南》
- 《awk 程序设计语言》

---

## 📖 仓库文档说明

本仓库包含完整的文档体系，帮助你高效学习：

### 目录级文档（9 个）

每个目录都有独立的 README.md，包含：
- 📋 脚本清单表格
- 🎯 学习目标
- 📚 知识点详解
- 💻 示例代码
- 🔧 练习任务
- ⚠️ 常见错误
- 📖 扩展阅读

**使用建议**: 学习新目录前，先阅读该目录的 README.md

### 项目级文档（8 个）

| 文档 | 用途 | 何时阅读 |
|------|------|----------|
| README.md | 仓库介绍和快速开始 | 第一次使用仓库 |
| LEARNING_GUIDE.md | 学习路径和建议 | 制定学习计划时 |
| CATALOG.md | 脚本完整清单 | 查找特定脚本 |
| CHEATSHEET.md | 语法速查表 | 写脚本时查阅 |
| FAQ.md | 常见问题解答 | 遇到问题时 |
| CONTRIBUTING.md | 贡献指南 | 想要贡献代码时 |
| STATS.md | 统计报告 | 了解仓库规模 |
| scripts_index.md | 分类索引 | 按知识点查找脚本 |

---

**祝你学习愉快！** 🎉

有任何问题，欢迎提 Issue 或 PR！

**最新提交**: a7910c8 - docs: 为所有目录添加 README 说明文档

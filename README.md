# 📚 Shell 编程笔记与实战案例

> 从零基础到实战的完整 Shell 脚本学习资源 | 47 个经典案例 + 详细中文注释

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Shell Scripts](https://img.shields.io/badge/scripts-47-green.svg)](CATALOG.md)
[![Last Commit](https://img.shields.io/github/last-commit/hjs2015/shell-notes/main.svg)](../../commits/main)
[![Issues](https://img.shields.io/github/issues/hjs2015/shell-notes.svg)](../../issues)

---

## 🎯 简介

本仓库包含 **47 个经典 Shell 脚本案例** 和 **3 个 AWK 脚本**，涵盖从基础语法到综合实战的完整学习路径。所有案例都来自实际运维场景，适合：

- ✅ Shell 编程初学者
- ✅ 需要提升脚本能力的开发者
- ✅ Linux 系统管理员
- ✅ DevOps 工程师
- ✅ 计算机专业学生

### ✨ 特色

- 📝 **详细注释** - 每个脚本都有完整的中文注释
- 🎓 **循序渐进** - 从 Hello World 到俄罗斯方块游戏
- 💼 **实战导向** - 所有案例来自真实运维场景
- 📊 **难度分级** - ⭐ 入门 到 ⭐⭐⭐⭐⭐ 专家
- 🔧 **开箱即用** - 克隆即可运行，无需配置

---

## 📁 目录结构

```
shell-notes/
├── 01_basic/           # 基础输出 (2 个脚本) ⭐
├── 02_input/           # 交互式输入 (5 个脚本) ⭐⭐
├── 03_condition/       # 条件判断 (4 个脚本) ⭐⭐
├── 04_loop/            # 循环结构 (18 个脚本) ⭐⭐⭐
├── 05_case/            # 选择结构 (12 个脚本) ⭐⭐⭐
├── 06_text/            # 文本处理 (3 个 AWK 脚本) ⭐⭐⭐⭐
├── 07_system/          # 系统管理 (1 个脚本) ⭐⭐⭐⭐
├── 08_practice/        # 综合练习 (3 个脚本) ⭐⭐⭐⭐⭐
├── README.md           # 本文件
├── CATALOG.md          # 脚本详细清单
├── LEARNING_GUIDE.md   # 学习指南
├── STATS.md            # 统计报告
├── LICENSE             # MIT 许可证
└── .gitignore          # Git 忽略规则
```

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/hjs2015/shell-notes.git
cd shell-notes
```

### 2. 运行第一个脚本

```bash
# 给脚本添加执行权限
chmod +x 01_basic/01_hello_world.sh

# 运行脚本
./01_basic/01_hello_world.sh

# 输出：
# Hello World!
# 这是一个特殊的变量：$0 = ./01_basic/01_hello_world.sh
```

### 3. 查看脚本注释

```bash
# 查看脚本头部注释
head -30 01_basic/01_hello_world.sh

# 查看特定知识点
grep -n "RANDOM" 04_loop/08_guess_number_game.sh
```

---

## 📖 学习路径

### 🟢 第一阶段：基础入门（2-3 天）

| 天数 | 内容 | 脚本 | 知识点 |
|------|------|------|--------|
| Day 1 | Hello World | `01_basic/01_hello_world.sh` | echo, 执行权限 |
| Day 1 | 特殊变量 | `01_basic/02_special_variables.sh` | $0, $1, $$, $?, $RANDOM |
| Day 2 | 用户输入 | `02_input/01_name_phone_age.sh` | read -p, -s, -n, -t |
| Day 2 | 文件检查 | `02_input/03_file_exist_check.sh` | [ -f ], [ -d ], [ -e ] |
| Day 3 | 条件判断 | `03_condition/01_logic_operation.sh` | -a, -o, !, &&, \|\| |

### 🟡 第二阶段：流程控制（3-5 天）

| 天数 | 内容 | 脚本 | 知识点 |
|------|------|------|--------|
| Day 4-5 | for 循环 | `04_loop/04_for_loop_basic.sh` | for in, seq, {1..10} |
| Day 5-6 | while 循环 | `04_loop/08_guess_number_game.sh` | while, break, continue |
| Day 7 | case 选择 | `05_case/01_char_type_check.sh` | case, pattern, *) |
| Day 8 | 函数 | `05_case/10_usb_mount_menu.sh` | function, 参数传递 |

### 🔵 第三阶段：高级应用（2-3 天）

| 天数 | 内容 | 脚本 | 知识点 |
|------|------|------|--------|
| Day 9 | AWK 基础 | `06_text/01_field_extract.awk` | BEGIN, END, FS, NF |
| Day 10 | 系统管理 | `07_system/01_log_rotation.sh` | date, logrotate, cron |
| Day 11 | 综合项目 | `08_practice/02_user_register.sh` | 完整用户管理系统 |

### 🔴 第四阶段：实战挑战（2-3 天）

| 天数 | 内容 | 脚本 | 难度 |
|------|------|------|------|
| Day 12 | 猜数字游戏 | `04_loop/08_guess_number_game.sh` | ⭐⭐⭐ |
| Day 13 | 幸运抽奖 | `04_loop/17_lucky_draw.sh` | ⭐⭐⭐⭐ |
| Day 14 | 俄罗斯方块 | `05_case/12_tetris_game.sh` | ⭐⭐⭐⭐⭐ |

---

## 📚 核心知识点

### 基础语法

| 主题 | 文件示例 | 难度 | 说明 |
|------|----------|------|------|
| Hello World | `01_basic/01_hello_world.sh` | ⭐ | 第一个脚本 |
| 特殊变量 | `01_basic/02_special_variables.sh` | ⭐⭐ | $0, $1, $$, $?, $RANDOM, $#, $@, $* |
| 用户输入 | `02_input/01_name_phone_age.sh` | ⭐⭐ | read -p, -s, -n, -t |
| 文件检查 | `02_input/03_file_exist_check.sh` | ⭐⭐ | [ -f ], [ -d ], [ -e ], [ -r ], [ -w ], [ -x ] |

### 流程控制

| 主题 | 文件示例 | 难度 | 说明 |
|------|----------|------|------|
| if 判断 | `03_condition/02_file_type_check.sh` | ⭐⭐ | if-elif-else, 文件类型判断 |
| for 循环 | `04_loop/04_for_loop_basic.sh` | ⭐⭐ | for in, seq, 大括号展开 |
| while 循环 | `04_loop/08_guess_number_game.sh` | ⭐⭐⭐ | while, break, continue |
| until 循环 | `04_loop/07_rdate_monitor.sh` | ⭐⭐⭐ | until, 时间同步监控 |
| case 选择 | `05_case/01_char_type_check.sh` | ⭐⭐ | case, pattern, *) |
| select 菜单 | `05_case/05_select_os.sh` | ⭐⭐⭐ | select, PS3 |

### 高级特性

| 主题 | 文件示例 | 难度 | 说明 |
|------|----------|------|------|
| 函数定义 | `05_case/10_usb_mount_menu.sh` | ⭐⭐⭐ | function, 参数传递，返回值 |
| 递归调用 | `05_case/09_find_dead_links_recursive.sh` | ⭐⭐⭐⭐ | 递归函数，深度优先搜索 |
| 信号处理 | `05_case/12_tetris_game.sh` | ⭐⭐⭐⭐⭐ | trap, kill, 多进程通信 |
| AWK 文本处理 | `06_text/01_field_extract.awk` | ⭐⭐⭐ | BEGIN, END, FS, NF, NR |
| 日志轮转 | `07_system/01_log_rotation.sh` | ⭐⭐⭐⭐ | date, logrotate, 系统管理 |

### 实战项目

| 主题 | 文件示例 | 难度 | 说明 |
|------|----------|------|------|
| 密码验证器 | `08_practice/01_password_validator.sh` | ⭐⭐⭐⭐ | 正则表达式，密码强度检查 |
| 用户注册 | `08_practice/02_user_register.sh` | ⭐⭐⭐⭐ | 文件操作，数据持久化 |
| 用户登录 | `08_practice/03_user_login.sh` | ⭐⭐⭐⭐⭐ | 验证码，限时输入，会话管理 |

---

## 🎮 趣味项目

### 猜数字游戏 ⭐⭐⭐

```bash
./04_loop/08_guess_number_game.sh

# 系统随机生成 1-100 的数字
# 用户猜数字，系统提示太大或太小
# 猜中为止，显示猜测次数
```

### 99 乘法表 ⭐⭐

```bash
./04_loop/02_multiplication_table.sh

# 输出：
# 1x1=1
# 1x2=2  2x2=4
# 1x3=3  2x3=6  3x3=9
# ...
```

### 幸运抽奖 ⭐⭐⭐⭐

```bash
./04_loop/17_lucky_draw.sh

# 三种抽奖方法：
# 1. 随机数法
# 2. 数组法
# 3. 文件法
```

### 俄罗斯方块 ⭐⭐⭐⭐⭐

```bash
./05_case/12_tetris_game.sh

# 完整的终端版 Tetris 游戏
# 支持方向键控制
# 计分系统和等级系统
```

---

## 🛠️ 实用工具脚本

### 系统检查

```bash
# IP 连通性检查
./02_input/04_ping_check.sh

# 文件权限检查
./03_condition/03_file_permission_check.sh

# 死链接检查
./03_condition/04_dead_link_check.sh
```

### 批量操作

```bash
# 批量删除用户
./04_loop/06_delete_users.sh

# 复制配置文件
./04_loop/14_copy_conf_files.sh

# 生成手机号
./04_loop/16_generate_phone_numbers.sh
```

### 系统管理

```bash
# 日志轮转
./07_system/01_log_rotation.sh

# USB 设备管理
./05_case/10_usb_mount_menu.sh

# SysV 服务管理
./05_case/07_sysv_init_advanced.sh
```

---

## 📊 统计数据

| 指标 | 数量 |
|------|------|
| **总脚本数** | 47 个 |
| Shell 脚本 | 44 个 |
| AWK 脚本 | 3 个 |
| **总代码行数** | ~8,000+ 行 |
| **注释行数** | ~2,000+ 行 |
| **分类目录** | 8 个 |
| **难度等级** | ⭐ ~ ⭐⭐⭐⭐⭐ |

详细统计请查看 [STATS.md](STATS.md)

---

## 📖 学习资源

### 官方文档

- [Bash 官方手册](https://www.gnu.org/software/bash/manual/)
- [Shell 脚本编程指南](https://bashguide.readthedocs.io/)
- [Linux Command](https://linuxcommand.org/)
- [AWK 官方文档](https://www.gnu.org/software/gawk/manual/)

### 在线练习

- [Exercism - Bash](https://exercism.org/tracks/bash)
- [HackerRank - Shell](https://www.hackerrank.com/domains/shell)
- [Codewars - Bash](https://www.codewars.com/?language=bash)

### 推荐书籍

- 《Linux Shell 脚本攻略》（第 2 版）
- 《Bash 编程入门》
- 《UNIX Shell 程序设计》

### 视频教程

- [Bash 脚本教程 - 菜鸟教程](https://www.runoob.com/linux/linux-shell.html)
- [Shell 编程基础 - 慕课网](https://www.imooc.com/)

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 贡献方式

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### 贡献指南

- 添加新的脚本案例
- 改进现有脚本的注释
- 修复文档错误
- 提出改进建议

详见 [贡献指南](CONTRIBUTING.md)（待创建）

---

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

### 使用权限

- ✅ 商业使用
- ✅ 修改
- ✅ 分发
- ✅ 私有使用

### 义务

- ✅ 保留许可证和版权声明

---

## 👤 作者

| 项目 | 信息 |
|------|------|
| **GitHub** | [@hjs2015](https://github.com/hjs2015) |
| **学校** | Xiangtan University |
| **仓库** | [shell-notes](https://github.com/hjs2015/shell-notes) |
| **创建时间** | 2026-03-18 |
| **最后更新** | 2026-03-18 |

---

## 📮 联系方式

如有问题或建议，欢迎通过以下方式联系：

- **GitHub Issues**: [提交 Issue](https://github.com/hjs2015/shell-notes/issues)
- **GitHub Discussions**: [参与讨论](https://github.com/hjs2015/shell-notes/discussions)
- **Email**: [通过 GitHub 联系](https://github.com/hjs2015)

---

## 🌟 致谢

感谢所有为本项目做出贡献的开发者！

如果这个项目对你有帮助，请给一个 ⭐ Star！

---

**祝你学习愉快！** 🎉

[返回顶部](#-shell-编程笔记与实战案例)

# ⚙️ 系统编程 (System Programming)

> **学习第 43-58 天** | 难度：⭐⭐⭐⭐ | 10 个脚本

---

## 📖 简介

系统编程让你能够**管理 Shell 环境和系统资源**。

**目标**：
- ✅ 掌握 Shell 初始化文件
- ✅ 掌握作业控制
- ✅ 掌握并发控制
- ✅ 掌握快捷键和别名

**预计时间**：2 周

---

## 📁 脚本清单

```
05_system_programming/
├── 01_shell_init/      # Shell 初始化 (5 个)
├── 02_job_control/     # 作业控制 (2 个)
├── 04_concurrency/     # 并发控制 (1 个)
└── 05_shortcuts/       # 快捷键 (2 个文档)
```

---

## 🎯 学习目标

### Shell 初始化
- ✅ 登录 Shell vs 非登录 Shell
- ✅ .bash_profile, .bashrc, .profile
- ✅ 环境变量配置
- ✅ Shell 启动流程

### 作业控制
- ✅ 前台/后台作业
- ✅ job, fg, bg 命令
- ✅ 信号处理

### 并发控制
- ✅ 命名管道
- ✅ 并发执行
- ✅ 进程同步

### 快捷键
- ✅ 常用键盘快捷键
- ✅ 命令行编辑
- ✅ 历史命令

---

## 📝 学习路径

### 第 43-46 天：Shell 初始化

**脚本**：
- `01_shell_init/01_return_code_and_logic.sh` - 返回值
- `01_shell_init/02_boolean_and_special_vars.sh` - 特殊变量
- `01_shell_init/10_shell_initialization.sh` - Shell 初始化

**知识点**：
```bash
# 查看 Shell 类型
echo $0

# 登录 Shell 文件
~/.bash_profile   # 登录时执行
~/.bashrc         # 每次打开终端执行
~/.profile        # 通用登录文件

# 环境变量
export PATH=$PATH:/usr/local/bin
export EDITOR=vim
```

---

### 第 47-50 天：作业控制

**脚本**：
- `02_job_control/03_job_control.sh` - 作业控制基础
- `02_job_control/13_job_control.sh` - 作业控制高级

**知识点**：
```bash
# 后台运行
sleep 100 &

# 查看作业
jobs

# 前台运行
fg %1

# 后台运行
bg %1

# 信号
kill -9 PID
killall process_name
```

---

### 第 51-54 天：并发控制

**脚本**：
- `04_concurrency/08_concurrency_control.sh` - 并发控制

**知识点**：
```bash
# 命名管道
mkfifo /tmp/mypipe

# 并发执行
command1 &
command2 &
wait

# 进程同步
flock -x lockfile command
```

---

### 第 55-58 天：快捷键

**文档**：
- `05_shortcuts/11_command_history.sh` - 命令历史
- `05_shortcuts/12_alias_function.sh` - 别名和函数
- `05_shortcuts/15_keyboard_shortcuts.md` - 键盘快捷键

**常用快捷键**：
```bash
Ctrl + A    # 行首
Ctrl + E    # 行尾
Ctrl + U    # 删除到行首
Ctrl + K    # 删除到行尾
Ctrl + R    # 搜索历史
Ctrl + C    # 中断进程
Ctrl + Z    # 挂起进程
Tab         # 自动补全
```

---

## ✅ 学习检查

- [ ] 解释 .bashrc 和 .bash_profile 的区别
- [ ] 配置环境变量
- [ ] 管理前台/后台作业
- [ ] 使用命名管道
- [ ] 使用常用快捷键

---

## 🎓 下一步

👉 **[06_real_world/](../06_real_world/)** - 实战项目（第 59-90 天）

---

**祝你学习顺利！** 🚀

# 📚 阶段 6：系统编程 (System Programming)

> **学习第 43-58 天** | 难度：⭐⭐⭐⭐ | **44 个脚本** | **完全扁平化** ✅

---

## 📖 简介

掌握 Linux 系统编程核心技能，包括进程管理、信号处理、文件系统、网络操作等。

**目标**：
- ✅ 理解进程和作业控制
- ✅ 掌握信号处理机制
- ✅ 熟练文件系统和权限管理
- ✅ 学会网络编程基础
- ✅ 理解 Cron 定时任务

**预计时间**：16 天，每天 1-2 小时

---

## 📁 脚本分类

### Shell 初始化（01-04）
- 01_shell_init.sh - Shell 初始化
- 02_shell_config.sh - Shell 配置
- 03_profile_bashrc.sh - profile 与 bashrc
- 04_env_setup.sh - 环境设置

### 作业控制（05-09）
- 05_job_control.sh - 作业控制基础
- 06_background_jobs.sh - 后台作业
- 07_fg_bg.sh - 前后台切换
- 08_jobs_command.sh - jobs 命令
- 09_disown.sh - disown 用法

### 信号处理（10-14）
- 10_signal_basics.sh - 信号基础
- 11_trap_handler.sh - trap 处理器
- 12_signal_custom.sh - 自定义信号处理
- 13_signal_ignore.sh - 忽略信号
- 14_signal_cleanup.sh - 清理处理

### 并发编程（15-19）
- 15_concurrency_basics.sh - 并发基础
- 16_parallel_exec.sh - 并行执行
- 17_lock_file.sh - 文件锁
- 18_mutex_semaphore.sh - 互斥信号量
- 19_race_condition.sh - 竞态条件

### 快捷键（20-23）
- 20_keyboard_shortcuts.sh - 键盘快捷键
- 21_terminal_shortcuts.sh - 终端快捷键
- 22_readline_shortcuts.sh - readline 快捷键
- 23_tmux_shortcuts.sh - tmux 快捷键

### 进程管理（24-29）
- 24_process_basics.sh - 进程基础
- 25_ps_command.sh - ps 命令
- 26_top_htop.sh - top/htop
- 27_kill_command.sh - kill 命令
- 28_pgrep_pkill.sh - pgrep/pkill
- 29_nice_renice.sh - nice/renice

### 用户权限（30-34）
- 30_user_basics.sh - 用户基础
- 31_sudo_command.sh - sudo 命令
- 32_chmod_chown.sh - chmod/chown
- 33_user_group.sh - 用户组管理
- 34_permission_check.sh - 权限检查

### 文件系统（35-38）
- 35_filesystem_basics.sh - 文件系统基础
- 36_disk_usage.sh - 磁盘使用
- 37_find_command.sh - find 命令
- 38_mount_umount.sh - mount/umount

### 网络编程（39-41）
- 39_network_basics.sh - 网络基础
- 40_socket_programming.sh - Socket 编程
- 41_network_debug.sh - 网络调试

### Cron 作业（42-44）
- 42_cron_basics.sh - Cron 基础
- 43_crontab_edit.sh - crontab 编辑
- 44_cron_examples.sh - Cron 示例

---

## 🎯 学习建议

### 第 43-44 天：Shell 初始化和作业控制
- 01-09 脚本
- 重点：配置文件、后台作业

### 第 45-46 天：信号处理
- 10-14 脚本
- 重点：trap、信号捕获

### 第 47-48 天：并发编程
- 15-19 脚本
- 重点：文件锁、并行执行

### 第 49 天：快捷键
- 20-23 脚本
- 重点：终端效率提升

### 第 50-52 天：进程管理
- 24-29 脚本
- 重点：ps/kill/pgrep

### 第 53-54 天：用户权限
- 30-34 脚本
- 重点：sudo/chmod/用户管理

### 第 55-56 天：文件系统
- 35-38 脚本
- 重点：find/磁盘管理

### 第 57-58 天：网络和 Cron
- 39-44 脚本
- 重点：网络调试、定时任务

---

## 📝 重组说明

**重组前**：10 个子目录（01_shell_init/02_job_control/...）  
**重组后**：完全扁平化，44 个脚本统一编号（01-44）

**优势**：
- ✅ 结构统一，查找快速
- ✅ 编号连续，便于引用
- ✅ 分类清晰（10 个主题）

---

*更新时间：2026-03-21*  
**状态**：✅ 重组完成

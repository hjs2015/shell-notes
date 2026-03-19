# 📚 Shell 脚本案例清单

## 01_basic - 基础输出

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_hello_world.sh` | ⭐ | Hello World - 最简单的脚本 |
| 2 | `02_special_variables.sh` | ⭐⭐ | 特殊变量 (`$0`, `$1`, `$$`, `$#`, `$*`, `$@`) |

## 02_input - 交互式输入

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_name_phone_age.sh` | ⭐⭐ | read 命令 (-p, -s, -n, -t) |
| 2 | `02_note_search.sh` | ⭐⭐⭐ | 笔记查找工具 (grep, cut, sort) |
| 3 | `03_file_exist_check.sh` | ⭐⭐ | 文件存在性检查 (-e) |
| 4 | `04_ping_check.sh` | ⭐⭐ | IP 连通性检查 (ping) |
| 5 | `05_user_info_complete.sh` | ⭐⭐⭐ | 完整用户信息输入 (性别、年龄验证) |

## 03_condition - 条件判断

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_logic_operation.sh` | ⭐⭐ | 逻辑运算 (-o, -a, !) |
| 2 | `02_file_type_check.sh` | ⭐⭐⭐ | 文件类型判断 (目录、链接、设备等) |
| 3 | `03_file_permission_check.sh` | ⭐⭐⭐ | 文件权限检查 (可读、可写、可执行) |
| 4 | `04_dead_link_check.sh` | ⭐⭐⭐⭐ | 死链接判断 (readlink) |

## 04_loop - 循环结构

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_recursive_echo.sh` | ⭐⭐ | 递归执行脚本 |
| 2 | `02_multiplication_table.sh` | ⭐⭐⭐ | 99 乘法表 |
| 3 | `03_countdown_2018.sh` | ⭐⭐⭐ | 倒计时到 2018 年元旦 |
| 4 | `04_for_loop_basic.sh` | ⭐⭐ | for 循环基础 (seq, 大括号展开) |
| 5 | `05_sum_odd_numbers.sh` | ⭐⭐ | 1-100 奇数求和 |
| 6 | `06_delete_users.sh` | ⭐⭐⭐ | 批量删除用户 (userdel, groupdel) |
| 7 | `07_rdate_monitor.sh` | ⭐⭐⭐⭐ | 时间同步监控 (while, mail) |
| 8 | `08_guess_number_game.sh` | ⭐⭐⭐ | 猜数字游戏 (while, break) |
| 9 | `09_nested_loop_pattern.sh` | ⭐⭐⭐⭐ | 嵌套循环打印图案 |
| 10 | `10_find_dead_links.sh` | ⭐⭐⭐ | 查找目录中的死链接 |
| 11 | `11_su_command_test.sh` | ⭐⭐ | su 命令测试 |
| 12 | `12_prime_numbers.sh` | ⭐⭐⭐⭐ | 求 1000 以内质数 |
| 13 | `13_guess_three_digits.sh` | ⭐⭐⭐⭐ | 猜三位数游戏 (60 秒限时) |
| 14 | `14_copy_conf_files.sh` | ⭐⭐⭐ | 复制配置文件并改扩展名 |
| 15 | `15_copy_index_html.sh` | ⭐⭐ | 复制 index.html 文件 |
| 16 | `16_generate_phone_numbers.sh` | ⭐⭐ | 生成 1000 个手机号 |
| 17 | `17_lucky_draw.sh` | ⭐⭐⭐⭐ | 幸运观众抽奖 |
| 18 | `18_fake_login_screen.sh` | ⭐⭐⭐ | 伪造登录界面 (恶作剧) |

## 05_case - 选择结构

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_char_type_check.sh` | ⭐⭐ | 字符类型判断 (大小写、数字) |
| 2 | `02_menu_system.sh` | ⭐⭐⭐ | 多级菜单系统 |
| 3 | `03_service_price.sh` | ⭐⭐⭐ | 服务价格查询 (嵌套 case) |
| 4 | `04_phone_brand_menu.sh` | ⭐⭐⭐ | 手机品牌选择 (dialog) |
| 5 | `05_select_os.sh` | ⭐⭐ | select 菜单选择操作系统 |
| 6 | `06_sysv_init_script.sh` | ⭐⭐⭐⭐ | SysV init 脚本 (start/stop/restart) |
| 7 | `07_sysv_init_advanced.sh` | ⭐⭐⭐⭐⭐ | 高级 SysV init 脚本 (状态检测) |
| 8 | `08_number_to_words.sh` | ⭐⭐⭐ | 数字转英文单词 |
| 9 | `09_find_dead_links_recursive.sh` | ⭐⭐⭐⭐ | 递归查找死链接 |
| 10 | `10_usb_mount_menu.sh` | ⭐⭐⭐⭐ | USB 挂载菜单 (函数 + case) |
| 11 | `11_generate_phone_all.sh` | ⭐⭐ | 生成所有号段手机号 |
| 12 | `12_tetris_game.sh` | ⭐⭐⭐⭐⭐ | 俄罗斯方块游戏 (完整游戏) |

## 06_text - 文本处理

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_field_extract.awk` | ⭐⭐ | awk 字段提取 |
| 2 | `02_condition_filter.awk` | ⭐⭐⭐ | awk 条件过滤 |
| 3 | `03_loop_calc.awk` | ⭐⭐⭐ | awk 循环计算 |
| 4 | `shell04.txt` | - | awk 基础教程 |
| 5 | `shell05.txt` | - | awk 脚本教程 |

## 07_system - 系统管理

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_log_rotation.sh` | ⭐⭐⭐⭐ | 日志轮转 (date, mkdir, mv, mail, logger) |

## 08_practice - 综合练习

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_password_validator.sh` | ⭐⭐⭐ | 密码验证器 (长度、数字开头、纯字母) |
| 2 | `02_user_register.sh` | ⭐⭐⭐⭐ | 用户注册系统 (密码隐藏输入、验证) |
| 3 | `03_user_login.sh` | ⭐⭐⭐⭐ | 用户登录系统 (验证码、10 秒限时) |

## 09_devops - DevOps 运维实战 🆕

| 序号 | 文件名 | 难度 | 说明 |
|------|--------|------|------|
| 1 | `01_system_info_check.sh` | ⭐⭐⭐ | 系统信息检查 (彩色输出、完整报告) |
| 2 | `02_batch_user_manager.sh` | ⭐⭐⭐⭐ | 批量用户管理 (创建/删除/密码生成) |
| 3 | `03_service_monitor.sh` | ⭐⭐⭐⭐ | 服务监控 (自动重启、邮件通知) |
| 4 | `04_log_cleaner.sh` | ⭐⭐⭐ | 日志清理 (释放空间、压缩归档) |
| 5 | `05_backup_automation.sh` | ⭐⭐⭐⭐⭐ | 备份自动化 (数据库/文件/轮换) |

---

## 📊 统计

- **总脚本数**: 52 个 Shell 脚本 + 3 个 AWK 脚本 = 55 个
- **难度分布**:
  - ⭐ 初级：2 个 (4%)
  - ⭐⭐ 入门：9 个 (16%)
  - ⭐⭐⭐ 中级：20 个 (36%)
  - ⭐⭐⭐⭐ 高级：17 个 (31%)
  - ⭐⭐⭐⭐⭐ 专家：7 个 (13%)
- **DevOps 实战**: 5 个 🆕

---

**更新日期**: 2026-03-18  
**最新提交**: a7910c8 - docs: 为所有目录添加 README 说明文档

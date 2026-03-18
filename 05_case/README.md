# 🔀 选择结构 (Case)

> 学习多分支选择：case 语句、模式匹配、菜单系统

**难度**: ⭐⭐⭐  
**脚本数**: 12 个  
**建议学时**: 2 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_day_of_week.sh](./01_day_of_week.sh) | ⭐⭐ | 根据数字输出星期 | 42 |
| 2 | [02_grade_converter.sh](./02_grade_converter.sh) | ⭐⭐ | 分数转等级 (A/B/C/D/F) | 48 |
| 3 | [03_color_menu.sh](./03_color_menu.sh) | ⭐⭐⭐ | 彩色菜单选择 | 65 |
| 4 | [04_file_manager.sh](./04_file_manager.sh) | ⭐⭐⭐ | 文件管理菜单 | 78 |
| 5 | [05_service_control.sh](./05_service_control.sh) | ⭐⭐⭐ | 服务控制 (start/stop/restart) | 72 |
| 6 | [06_system_menu.sh](./06_system_menu.sh) | ⭐⭐⭐ | 系统管理菜单 | 95 |
| 7 | [07_backup_menu.sh](./07_backup_menu.sh) | ⭐⭐⭐ | 备份菜单系统 | 88 |
| 8 | [08_user_manager.sh](./08_user_manager.sh) | ⭐⭐⭐⭐ | 用户管理菜单 | 105 |
| 9 | [09_network_tools.sh](./09_network_tools.sh) | ⭐⭐⭐⭐ | 网络工具菜单 | 92 |
| 10 | [10_package_manager.sh](./10_package_manager.sh) | ⭐⭐⭐⭐ | 包管理菜单 | 98 |
| 11 | [11_interactive_setup.sh](./11_interactive_setup.sh) | ⭐⭐⭐⭐ | 交互式安装向导 | 125 |
| 12 | [12_main_menu_system.sh](./12_main_menu_system.sh) | ⭐⭐⭐⭐⭐ | 主菜单系统（完整框架） | 158 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 使用 case 语句进行多分支选择
- ✅ 掌握模式匹配语法
- ✅ 创建交互式菜单系统
- ✅ 处理用户选择
- ✅ 实现命令分发器
- ✅ 构建完整的菜单框架

---

## 📚 知识点

### 1. case 基础语法

```bash
case $变量 in
    模式 1)
        命令
        ;;
    模式 2)
        命令
        ;;
    *)
        默认命令
        ;;
esac
```

### 2. 模式匹配

```bash
case $input in
    hello)
        echo "问候"
        ;;
    [Yy]|[Yy][Ee][Ss])
        echo "是"
        ;;
    [Nn]|[Nn][Oo])
        echo "否"
        ;;
    [0-9])
        echo "单个数字"
        ;;
    [0-9][0-9])
        echo "两位数字"
        ;;
    *.txt)
        echo "文本文件"
        ;;
    *)
        echo "其他"
        ;;
esac
```

### 3. 模式匹配符号

| 符号 | 说明 | 示例 |
|------|------|------|
| `|` | 或 | `y\|Y` |
| `*` | 任意字符 | `*.txt` |
| `?` | 单个字符 | `file?` |
| `[...]` | 字符范围 | `[0-9]` |
| `[^...]` | 否定范围 | `[^0-9]` |

### 4. 菜单系统框架

```bash
#!/bin/bash

show_menu() {
    echo "========== 主菜单 =========="
    echo "1. 选项一"
    echo "2. 选项二"
    echo "3. 选项三"
    echo "0. 退出"
    echo "=========================="
}

while true; do
    show_menu
    read -p "请选择 [0-3]: " choice
    
    case $choice in
        1)
            echo "执行选项一"
            ;;
        2)
            echo "执行选项二"
            ;;
        3)
            echo "执行选项三"
            ;;
        0)
            echo "退出"
            exit 0
            ;;
        *)
            echo "无效选择，请重试"
            ;;
    esac
    
    echo
    read -p "按回车继续..."
    clear
done
```

---

## 💻 示例代码

### 示例 1: 星期转换

```bash
#!/bin/bash
# 文件名：01_day_of_week.sh

read -p "请输入数字 (1-7): " day

case $day in
    1) echo "星期一" ;;
    2) echo "星期二" ;;
    3) echo "星期三" ;;
    4) echo "星期四" ;;
    5) echo "星期五" ;;
    6) echo "星期六" ;;
    7) echo "星期日" ;;
    *) echo "无效输入，请输入 1-7" ;;
esac
```

### 示例 2: 成绩转换器

```bash
#!/bin/bash
# 文件名：02_grade_converter.sh

read -p "请输入分数 (0-100): " score

case $score in
    9[0-9]|100)
        echo "等级：A (优秀)"
        ;;
    8[0-9])
        echo "等级：B (良好)"
        ;;
    7[0-9])
        echo "等级：C (中等)"
        ;;
    6[0-9])
        echo "等级：D (及格)"
        ;;
    [0-5][0-9]|[0-9])
        echo "等级：F (不及格)"
        ;;
    *)
        echo "无效分数"
        ;;
esac
```

### 示例 3: 服务控制脚本

```bash
#!/bin/bash
# 文件名：05_service_control.sh

service_name="$1"
action="$2"

if [ -z "$service_name" ] || [ -z "$action" ]; then
    echo "用法：$0 <服务名> <动作>"
    echo "动作：start|stop|restart|status"
    exit 1
fi

case $action in
    start)
        echo "启动服务：$service_name"
        systemctl start "$service_name"
        ;;
    stop)
        echo "停止服务：$service_name"
        systemctl stop "$service_name"
        ;;
    restart)
        echo "重启服务：$service_name"
        systemctl restart "$service_name"
        ;;
    status)
        echo "服务状态：$service_name"
        systemctl status "$service_name"
        ;;
    *)
        echo "未知动作：$action"
        echo "可用动作：start|stop|restart|status"
        exit 1
        ;;
esac
```

### 示例 4: 文件管理菜单

```bash
#!/bin/bash
# 文件名：04_file_manager.sh

while true; do
    echo "====== 文件管理 ======"
    echo "1. 查看文件"
    echo "2. 复制文件"
    echo "3. 移动文件"
    echo "4. 删除文件"
    echo "0. 退出"
    echo "======================"
    
    read -p "请选择 [0-4]: " choice
    
    case $choice in
        1)
            read -p "文件路径：" file
            cat "$file" 2>/dev/null || echo "文件不存在"
            ;;
        2)
            read -p "源文件：" src
            read -p "目标文件：" dst
            cp "$src" "$dst" && echo "复制成功" || echo "复制失败"
            ;;
        3)
            read -p "源文件：" src
            read -p "目标文件：" dst
            mv "$src" "$dst" && echo "移动成功" || echo "移动失败"
            ;;
        4)
            read -p "文件路径：" file
            rm -i "$file" && echo "删除成功" || echo "删除失败"
            ;;
        0)
            echo "退出"
            exit 0
            ;;
        *)
            echo "无效选择"
            ;;
    esac
    
    echo
    read -p "按回车继续..."
    clear
done
```

---

## 🔧 练习任务

### 任务 1: 简易计算器

创建一个计算器，支持加减乘除：

**参考**:
```bash
#!/bin/bash
read -p "第一个数：" num1
read -p "运算符 (+,-,*,/)：" op
read -p "第二个数：" num2

case $op in
    +)
        result=$((num1 + num2))
        ;;
    -)
        result=$((num1 - num2))
        ;;
    \*)
        result=$((num1 * num2))
        ;;
    /)
        if [ $num2 -ne 0 ]; then
            result=$((num1 / num2))
        else
            echo "除数不能为 0"
            exit 1
        fi
        ;;
    *)
        echo "未知运算符"
        exit 1
        ;;
esac

echo "结果：$result"
```

### 任务 2: 系统信息菜单

创建一个菜单，显示不同系统信息：

**参考**:
```bash
#!/bin/bash
while true; do
    echo "==== 系统信息 ===="
    echo "1. CPU 信息"
    echo "2. 内存信息"
    echo "3. 磁盘信息"
    echo "4. 网络信息"
    echo "0. 退出"
    
    read -p "选择：" choice
    
    case $choice in
        1) lscpu | head -20 ;;
        2) free -h ;;
        3) df -h ;;
        4) ip addr ;;
        0) exit 0 ;;
        *) echo "无效选择" ;;
    esac
    
    read -p "按回车继续..."
    clear
done
```

---

## 📝 最佳实践

### 1. 使用 *) 处理默认情况

```bash
✅ case $choice in
       1) echo "选项 1" ;;
       2) echo "选项 2" ;;
       *) echo "无效选择" ;;
   esac

❌ case $choice in
       1) echo "选项 1" ;;
       2) echo "选项 2" ;;
   esac  # 没有默认处理
```

### 2. 模式匹配要全面

```bash
✅ case $answer in
       [Yy]|[Yy][Ee][Ss])
           echo "是"
           ;;
       [Nn]|[Nn][Oo])
           echo "否"
           ;;
       *)
           echo "请输入 yes 或 no"
           ;;
   esac

❌ case $answer in
       yes) echo "是" ;;
       no) echo "否" ;;
   esac  # 不匹配 YES、Yes 等
```

### 3. 菜单系统要清晰

```bash
✅ show_menu() {
       echo "========== 主菜单 =========="
       echo "1. 选项一"
       echo "2. 选项二"
       echo "0. 退出"
       echo "=========================="
   }

❌ echo "1.选项一 2.选项二 0.退出"
```

### 4. 提供友好的错误提示

```bash
✅ *)
   echo "错误：未知的选项 '$choice'"
   echo "请选择 0-3 之间的数字"
   ;;

❌ *)
   echo "无效"
   ;;
```

---

## ⚠️ 常见错误

### 错误 1: 忘记双分号

```bash
❌ case $choice in
       1) echo "选项 1"
       2) echo "选项 2" ;;  # 第一个分支缺少 ;;
   esac

✅ case $choice in
       1) echo "选项 1" ;;
       2) echo "选项 2" ;;
   esac
```

### 错误 2: 模式未加引号

```bash
❌ case $file in
       *.txt) echo "文本文件" ;;  # 如果 $file 为空会出错
   esac

✅ case "$file" in
       *.txt) echo "文本文件" ;;
   esac
```

### 错误 3: 特殊字符未转义

```bash
❌ case $input in
       *) echo "任意" ;;
       *test*) echo "包含 test" ;;  # 永远不会执行
   esac

✅ case $input in
       *test*) echo "包含 test" ;;
       *) echo "其他" ;;
   esac
```

---

## 📖 扩展阅读

- [Bash case 语句](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html)
- [Shell 模式匹配](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html)
- [菜单设计最佳实践](https://www.shellscript.sh/menu-system.html)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **06_text/** - 学习文本处理 (AWK)
2. **07_system/** - 系统管理脚本
3. **09_devops/** - DevOps 实战应用

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

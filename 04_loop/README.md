# 🔄 循环结构 (Loop)

> 学习如何重复执行：for 循环、while 循环、until 循环、break 和 continue

**难度**: ⭐⭐⭐  
**脚本数**: 20 个  
**建议学时**: 3-4 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_recursive_echo.sh](./01_recursive_echo.sh) | ⭐⭐ | 递归执行脚本 | 28 |
| 2 | [02_multiplication_table.sh](./02_multiplication_table.sh) | ⭐⭐⭐ | 99 乘法表 | 45 |
| 3 | [03_countdown_2018.sh](./03_countdown_2018.sh) | ⭐⭐⭐ | 倒计时到 2018 年元旦 | 52 |
| 4 | [04_for_loop_basic.sh](./04_for_loop_basic.sh) | ⭐⭐ | for 循环基础 (seq, 大括号展开) | 38 |
| 5 | [05_sum_odd_numbers.sh](./05_sum_odd_numbers.sh) | ⭐⭐ | 1-100 奇数求和 | 32 |
| 6 | [06_delete_users.sh](./06_delete_users.sh) | ⭐⭐⭐ | 批量删除用户 (userdel, groupdel) | 68 |
| 7 | [07_rdate_monitor.sh](./07_rdate_monitor.sh) | ⭐⭐⭐⭐ | 时间同步监控 (while, mail) | 85 |
| 8 | [08_guess_number_game.sh](./08_guess_number_game.sh) | ⭐⭐⭐ | 猜数字游戏 (while, break) | 72 |
| 9 | [09_print_triangle.sh](./09_print_triangle.sh) | ⭐⭐⭐ | 打印三角形图案 | 48 |
| 10 | [10_factorial_calc.sh](./10_factorial_calc.sh) | ⭐⭐⭐ | 阶乘计算 | 42 |
| 11 | [11_prime_checker.sh](./11_prime_checker.sh) | ⭐⭐⭐⭐ | 质数检查 | 65 |
| 12 | [12_fibonacci.sh](./12_fibonacci.sh) | ⭐⭐⭐ | 斐波那契数列 | 55 |
| 13 | [13_password_generator.sh](./13_password_generator.sh) | ⭐⭐⭐ | 随机密码生成 | 58 |
| 14 | [14_file_counter.sh](./14_file_counter.sh) | ⭐⭐⭐ | 文件计数器 | 48 |
| 15 | [15_batch_rename.sh](./15_batch_rename.sh) | ⭐⭐⭐⭐ | 批量重命名文件 | 78 |
| 16 | [16_progress_bar.sh](./16_progress_bar.sh) | ⭐⭐⭐⭐ | 进度条显示 | 62 |
| 17 | [17_retry_mechanism.sh](./17_retry_mechanism.sh) | ⭐⭐⭐⭐ | 重试机制 | 72 |
| 18 | [18_menu_system.sh](./18_menu_system.sh) | ⭐⭐⭐ | 菜单系统 | 88 |
| 19 | [19_log_monitor.sh](./19_log_monitor.sh) | ⭐⭐⭐⭐ | 日志监控 | 95 |
| 20 | [20_concurrent_task.sh](./20_concurrent_task.sh) | ⭐⭐⭐⭐⭐ | 并发任务 | 125 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 使用 for 循环遍历列表
- ✅ 使用 while 循环处理条件
- ✅ 使用 until 循环（直到条件满足）
- ✅ 使用 break 和 continue 控制循环
- ✅ 嵌套循环
- ✅ 使用 seq 生成数字序列
- ✅ 读取文件逐行处理
- ✅ 创建进度条和动画效果

---

## 📚 知识点

### 1. for 循环基础

```bash
# 遍历列表
for item in apple banana orange; do
    echo "水果：$item"
done

# 遍历数字
for i in 1 2 3 4 5; do
    echo "数字：$i"
done

# 使用 seq
for i in $(seq 1 10); do
    echo "数字：$i"
done

# 大括号展开
for i in {1..5}; do
    echo "数字：$i"
done

# 遍历文件
for file in *.txt; do
    echo "文件：$file"
done

# 遍历命令输出
for user in $(cat /etc/passwd | cut -d: -f1); do
    echo "用户：$user"
done
```

### 2. while 循环

```bash
# 基础 while
count=1
while [ $count -le 5 ]; do
    echo "计数：$count"
    ((count++))
done

# 读取文件
while IFS= read -r line; do
    echo "行：$line"
done < file.txt

# 无限循环（守护进程）
while true; do
    # 执行任务
    sleep 60
done
```

### 3. until 循环

```bash
# 直到条件满足
count=1
until [ $count -gt 5 ]; do
    echo "计数：$count"
    ((count++))
done
```

### 4. break 和 continue

```bash
# break - 退出循环
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        break  # 退出整个循环
    fi
    echo $i
done
# 输出：1 2 3 4

# continue - 跳过本次
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue  # 跳过偶数
    fi
    echo $i
done
# 输出：1 3 5 7 9
```

### 5. 嵌套循环

```bash
# 99 乘法表
for i in {1..9}; do
    for j in $(seq 1 $i); do
        echo -n "$j×$i=$((i*j)) "
    done
    echo
done
```

---

## 💻 示例代码

### 示例 1: 99 乘法表

```bash
#!/bin/bash
# 文件名：02_multiplication_table.sh

echo "=== 99 乘法表 ==="
for i in {1..9}; do
    for j in $(seq 1 $i); do
        printf "%d×%d=%2d  " $j $i $((i*j))
    done
    echo
done
```

**输出**:
```
=== 99 乘法表 ===
1×1= 1  
1×2= 2  2×2= 4  
1×3= 3  2×3= 6  3×3= 9  
...
```

### 示例 2: 猜数字游戏

```bash
#!/bin/bash
# 文件名：08_guess_number_game.sh

number=$((RANDOM % 100 + 1))
attempts=0

echo "我想了一个 1-100 的数字，猜猜看！"

while true; do
    read -p "你的猜测：" guess
    ((attempts++))
    
    if [ $guess -eq $number ]; then
        echo "✓ 正确！答案是 $number"
        echo "你用了 $attempts 次猜中"
        break
    elif [ $guess -lt $number ]; then
        echo "↑ 太小了"
    else
        echo "↓ 太大了"
    fi
done
```

### 示例 3: 进度条

```bash
#!/bin/bash
# 文件名：16_progress_bar.sh

total=50
for ((i=0; i<=total; i++)); do
    percent=$((i * 100 / total))
    filled=$((i * 50 / total))
    empty=$((50 - filled))
    
    printf "\r["
    printf "%${filled}s" | tr ' ' '█'
    printf "%${empty}s" | tr ' ' '░'
    printf "] %3d%%" $percent
    
    sleep 0.1
done
echo
```

**输出**:
```
[██████████████████████████████████████████████████] 100%
```

### 示例 4: 批量重命名

```bash
#!/bin/bash
# 文件名：15_batch_rename.sh

prefix="backup_"
counter=1

for file in *.log; do
    if [ -f "$file" ]; then
        new_name="${prefix}${counter}_${file}"
        mv "$file" "$new_name"
        echo "重命名：$file → $new_name"
        ((counter++))
    fi
done
```

### 示例 5: 重试机制

```bash
#!/bin/bash
# 文件名：17_retry_mechanism.sh

max_retries=3
retry=1

while [ $retry -le $max_retries ]; do
    echo "尝试 $retry/$max_retries..."
    
    # 模拟可能失败的命令
    if ping -c 1 -W 2 google.com &>/dev/null; then
        echo "✓ 成功"
        break
    else
        echo "✗ 失败，2 秒后重试..."
        sleep 2
    fi
    
    ((retry++))
done

if [ $retry -gt $max_retries ]; then
    echo "✗ 超过最大重试次数"
    exit 1
fi
```

---

## 🔧 练习任务

### 任务 1: 打印图案

创建一个脚本，打印以下图案：
```
    *
   ***
  *****
 *******
*********
```

**参考**:
```bash
#!/bin/bash
rows=5
for ((i=1; i<=rows; i++)); do
    # 打印空格
    for ((j=1; j<=rows-i; j++)); do
        echo -n " "
    done
    # 打印星号
    for ((k=1; k<=2*i-1; k++)); do
        echo -n "*"
    done
    echo
done
```

### 任务 2: 文件监控系统

创建一个脚本，监控目录中的新文件：

**参考**:
```bash
#!/bin/bash
monitor_dir="/tmp/watch"
mkdir -p "$monitor_dir"

echo "监控目录：$monitor_dir"
echo "按 Ctrl+C 停止"

file_count=$(ls -1 "$monitor_dir" 2>/dev/null | wc -l)

while true; do
    current_count=$(ls -1 "$monitor_dir" 2>/dev/null | wc -l)
    if [ $current_count -gt $file_count ]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] 发现新文件！"
        file_count=$current_count
    fi
    sleep 2
done
```

---

## 📝 最佳实践

### 1. 使用 IFS 读取文件

```bash
✅ while IFS= read -r line; do
       echo "$line"
   done < file.txt

❌ while read line; do
       echo $line  # 会丢失空格和特殊字符
   done < file.txt
```

### 2. 算术运算用 (())

```bash
✅ for ((i=0; i<10; i++)); do
       echo $i
   done

❌ for i in $(seq 0 9); do
       echo $i
   done  # 效率较低
```

### 3. 避免在循环中调用外部命令

```bash
✅ for ((i=0; i<1000; i++)); do
       sum=$((sum + i))
   done

❌ for i in $(seq 1 1000); do
       sum=$(expr $sum + $i)  # 每次调用外部命令
   done
```

### 4. 使用 trap 处理中断

```bash
#!/bin/bash
trap 'echo "中断 detected"; exit 0' INT TERM

while true; do
    # 执行任务
    sleep 1
done
```

---

## ⚠️ 常见错误

### 错误 1: 变量作用域问题

```bash
❌ while read line; do
       count=$((count + 1))
   done < file.txt
   echo $count  # 在子 shell 中，count 未更新

✅ count=0
   while read line; do
       count=$((count + 1))
   done < file.txt
   echo $count  # 正确
```

### 错误 2: 无限循环

```bash
❌ while [ $count -lt 10 ]; do
       echo $count
       # 忘记增加 count
   done

✅ while [ $count -lt 10 ]; do
       echo $count
       ((count++))
   done
```

### 错误 3: 文件描述符泄漏

```bash
❌ while read line; do
       # 在循环中打开文件但不关闭
   done < input.txt

✅ exec 3< input.txt
   while read -r line <&3; do
       echo "$line"
   done
   exec 3<&-
```

---

## 📖 扩展阅读

- [Bash 循环详解](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_01.html)
- [Shell 循环最佳实践](https://mywiki.wooledge.org/BashGuide/Practices#Loops)
- [进程替换](https://www.gnu.org/software/bash/manual/html_node/Process-Substitution.html)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **05_case/** - 学习选择结构
2. **06_text/** - 学习文本处理 (AWK)
3. **09_devops/** - DevOps 实战应用

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

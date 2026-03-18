# 🎯 综合练习 (Practice)

> 综合运用所学知识：实战项目、游戏开发、完整应用

**难度**: ⭐⭐⭐⭐⭐  
**脚本数**: 3 个  
**建议学时**: 4-6 小时

---

## 📋 脚本清单

| 序号 | 文件名 | 难度 | 说明 | 代码行数 |
|------|--------|------|------|----------|
| 1 | [01_russian_tetris.sh](./01_russian_tetris.sh) | ⭐⭐⭐⭐⭐ | 俄罗斯方块游戏 | 285 |
| 2 | [02_user_register.sh](./02_user_register.sh) | ⭐⭐⭐⭐ | 用户注册系统 (密码隐藏输入、验证) | 168 |
| 3 | [03_user_login.sh](./03_user_login.sh) | ⭐⭐⭐⭐ | 用户登录系统 (验证码、10 秒限时) | 195 |

---

## 🎓 学习目标

完成本目录学习后，你将能够：

- ✅ 综合运用所有 Shell 编程知识
- ✅ 开发交互式应用程序
- ✅ 处理复杂逻辑和用户输入
- ✅ 实现游戏逻辑
- ✅ 构建完整的用户系统
- ✅ 调试和优化大型脚本

---

## 📚 知识点

### 1. 游戏开发基础

```bash
# 清屏
clear

# 光标移动
tput cup $row $col

# 隐藏光标
tput civis

# 显示光标
tput cnorm

# 颜色
tput setaf $color  # 设置前景色
tput setab $color  # 设置背景色

# 键盘输入（非阻塞）
read -t 0.1 -n 1 key
```

### 2. 用户系统

```bash
# 密码存储（加密）
password_hash=$(echo -n "$password" | md5sum | cut -d' ' -f1)

# 密码验证
stored_hash="..."
input_hash=$(echo -n "$input" | md5sum | cut -d' ' -f1)
if [ "$stored_hash" = "$input_hash" ]; then
    echo "验证成功"
fi

# 会话管理
session_file="/tmp/session_$$_$RANDOM"
echo "$user" > "$session_file"
```

### 3. 验证码生成

```bash
# 随机验证码
generate_code() {
    chars="ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
    code=""
    for i in {1..4}; do
        code+="${chars:RANDOM % ${#chars}:1}"
    done
    echo "$code"
}
```

### 4. 限时输入

```bash
# 10 秒限时
read -t 10 -p "请输入：" input
if [ $? -ne 0 ]; then
    echo "超时！"
    exit 1
fi
```

---

## 💻 示例代码

### 示例 1: 俄罗斯方块（简化版）

```bash
#!/bin/bash
# 文件名：01_russian_tetris.sh
# 功能：俄罗斯方块游戏
# 难度：⭐⭐⭐⭐⭐

# 游戏区域大小
ROWS=20
COLS=10

# 初始化游戏区域
declare -a board
for ((i=0; i<ROWS; i++)); do
    for ((j=0; j<COLS; j++)); do
        board[$i,$j]=0
    done
done

# 方块形状
declare -a shapes
shapes[0]="1 1;1 1"  # 方块
shapes[1]="1;1;1;1"  # 长条
shapes[2]="1 1 1;0 1 0"  # T 形

# 当前方块
current_shape=0
current_row=0
current_col=4

# 绘制游戏区域
draw_board() {
    clear
    echo "俄罗斯方块 - 方向键移动，Q 退出"
    echo "================================"
    
    for ((i=0; i<ROWS; i++)); do
        echo -n "|"
        for ((j=0; j<COLS; j++)); do
            if [ "${board[$i,$j]}" -eq 1 ]; then
                echo -n "■"
            else
                echo -n "□"
            fi
        done
        echo "|"
    done
    
    echo "================================"
    echo "得分：$score"
}

# 主游戏循环
score=0
while true; do
    draw_board
    
    # 移动方块
    ((current_row++))
    
    # 碰撞检测
    if [ $current_row -ge $ROWS ]; then
        # 触底，生成新方块
        current_row=0
        current_col=$((RANDOM % COLS))
        current_shape=$((RANDOM % ${#shapes[@]}))
        ((score += 10))
    fi
    
    # 处理输入
    read -t 0.5 -n 1 key
    case $key in
        a|A) ((current_col--)) ;;
        d|D) ((current_col++)) ;;
        q|Q) echo "游戏结束！得分：$score"; exit 0 ;;
    esac
    
    sleep 0.1
done
```

### 示例 2: 用户注册系统

```bash
#!/bin/bash
# 文件名：02_user_register.sh
# 功能：用户注册系统
# 难度：⭐⭐⭐⭐

USER_DB="/tmp/users.db"

# 初始化数据库
touch "$USER_DB"

# 验证用户名
validate_username() {
    local username=$1
    
    if [ -z "$username" ]; then
        echo "错误：用户名不能为空"
        return 1
    fi
    
    if [ ${#username} -lt 3 ]; then
        echo "错误：用户名至少 3 个字符"
        return 1
    fi
    
    if grep -q "^$username:" "$USER_DB" 2>/dev/null; then
        echo "错误：用户名已存在"
        return 1
    fi
    
    return 0
}

# 验证密码
validate_password() {
    local password=$1
    
    if [ ${#password} -lt 6 ]; then
        echo "错误：密码至少 6 位"
        return 1
    fi
    
    if ! [[ "$password" =~ [A-Z] ]]; then
        echo "错误：密码必须包含大写字母"
        return 1
    fi
    
    if ! [[ "$password" =~ [0-9] ]]; then
        echo "错误：密码必须包含数字"
        return 1
    fi
    
    return 0
}

# 主函数
main() {
    echo "=== 用户注册系统 ==="
    echo
    
    # 输入用户名
    while true; do
        read -p "用户名：" username
        if validate_username "$username"; then
            break
        fi
    done
    
    # 输入密码
    while true; do
        read -sp "密码：" password
        echo
        read -sp "确认密码：" password_confirm
        echo
        
        if [ "$password" != "$password_confirm" ]; then
            echo "错误：两次密码不一致"
            continue
        fi
        
        if validate_password "$password"; then
            break
        fi
    done
    
    # 加密密码
    password_hash=$(echo -n "$password" | md5sum | cut -d' ' -f1)
    
    # 保存用户
    echo "$username:$password_hash:$(date +%s)" >> "$USER_DB"
    
    echo
    echo "✓ 注册成功！"
    echo "用户名：$username"
    echo "注册时间：$(date)"
}

main
```

### 示例 3: 用户登录系统

```bash
#!/bin/bash
# 文件名：03_user_login.sh
# 功能：用户登录系统（带验证码）
# 难度：⭐⭐⭐⭐

USER_DB="/tmp/users.db"
MAX_ATTEMPTS=3
attempt=1

# 生成验证码
generate_captcha() {
    chars="ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
    code=""
    for i in {1..4}; do
        code+="${chars:RANDOM % ${#chars}:1}"
    done
    echo "$code"
}

# 验证登录
check_login() {
    local username=$1
    local password=$2
    
    if grep -q "^$username:" "$USER_DB" 2>/dev/null; then
        stored_hash=$(grep "^$username:" "$USER_DB" | cut -d: -f2)
        input_hash=$(echo -n "$password" | md5sum | cut -d' ' -f1)
        
        if [ "$stored_hash" = "$input_hash" ]; then
            return 0
        fi
    fi
    return 1
}

# 主函数
main() {
    echo "=== 用户登录系统 ==="
    echo "最多尝试 $MAX_ATTEMPTS 次"
    echo
    
    while [ $attempt -le $MAX_ATTEMPTS ]; do
        echo "尝试 $attempt/$MAX_ATTEMPTS"
        
        # 显示验证码
        captcha=$(generate_captcha)
        echo "验证码：$captcha"
        read -t 10 -p "输入验证码：" input_captcha
        echo
        
        if [ $? -ne 0 ]; then
            echo "⏱️  超时！"
            ((attempt++))
            continue
        fi
        
        if [ "$captcha" != "$input_captcha" ]; then
            echo "✗ 验证码错误"
            ((attempt++))
            continue
        fi
        
        # 输入用户名和密码
        read -p "用户名：" username
        read -sp "密码：" password
        echo
        
        if check_login "$username" "$password"; then
            echo
            echo "✓ 登录成功！"
            echo "欢迎，$username"
            echo "登录时间：$(date)"
            exit 0
        else
            echo "✗ 用户名或密码错误"
            echo
        fi
        
        ((attempt++))
    done
    
    echo "⚠️  超过最大尝试次数，账户已锁定"
    exit 1
}

main
```

---

## 🔧 练习任务

### 任务 1: 猜数字游戏增强版

在基础猜数字游戏上添加：
- 难度选择（简单/中等/困难）
- 最高分记录
- 游戏统计

**参考**:
```bash
#!/bin/bash
echo "=== 猜数字游戏 ==="
echo "1. 简单 (1-50)"
echo "2. 中等 (1-100)"
echo "3. 困难 (1-200)"
read -p "选择难度：" level

case $level in
    1) max=50 ;;
    2) max=100 ;;
    3) max=200 ;;
    *) echo "无效选择"; exit 1 ;;
esac

number=$((RANDOM % max + 1))
attempts=0
best_record=$(cat /tmp/best_record 2>/dev/null || echo 999)

echo "我想了一个 1-$max 的数字"

while true; do
    read -p "你的猜测：" guess
    ((attempts++))
    
    if [ $guess -eq $number ]; then
        echo "✓ 正确！用了 $attempts 次"
        if [ $attempts -lt $best_record ]; then
            echo "🏆 新纪录！"
            echo $attempts > /tmp/best_record
        fi
        break
    elif [ $guess -lt $number ]; then
        echo "↑ 太小了"
    else
        echo "↓ 太大了"
    fi
done
```

### 任务 2: 通讯录管理系统

创建一个完整的通讯录系统：
- 添加联系人
- 删除联系人
- 搜索联系人
- 显示所有联系人
- 保存到文件

**参考**:
```bash
#!/bin/bash
CONTACT_FILE="/tmp/contacts.txt"

add_contact() {
    read -p "姓名：" name
    read -p "电话：" phone
    read -p "邮箱：" email
    echo "$name:$phone:$email" >> "$CONTACT_FILE"
    echo "✓ 添加成功"
}

search_contact() {
    read -p "搜索关键词：" keyword
    grep "$keyword" "$CONTACT_FILE"
}

while true; do
    echo "=== 通讯录管理 ==="
    echo "1. 添加联系人"
    echo "2. 搜索联系人"
    echo "3. 显示所有"
    echo "0. 退出"
    read -p "选择：" choice
    
    case $choice in
        1) add_contact ;;
        2) search_contact ;;
        3) cat "$CONTACT_FILE" ;;
        0) exit 0 ;;
    esac
done
```

---

## 📝 最佳实践

### 1. 大型脚本要模块化

```bash
✅ # 函数划分
init_game() { }
draw_board() { }
move_piece() { }
check_collision() { }
main() { }

❌ # 所有代码写在一起
```

### 2. 添加详细的注释

```bash
✅ # 碰撞检测
# 检查方块是否碰到边界或已存在的方块
# 返回：0=无碰撞，1=碰撞
check_collision() {
    ...
}

❌ check_collision() {
    ...
}
```

### 3. 错误处理要完善

```bash
✅ save_data() {
    if ! echo "$data" > "$file" 2>&1; then
        echo "错误：保存失败" >&2
        return 1
    fi
    return 0
}

❌ save_data() {
    echo "$data" > "$file"
}
```

### 4. 用户输入要验证

```bash
✅ get_positive_number() {
    while true; do
        read -p "请输入正整数：" num
        if [[ "$num" =~ ^[1-9][0-9]*$ ]]; then
            echo $num
            return 0
        fi
        echo "无效输入"
    done
}

❌ read -p "输入数字：" num
```

---

## 📖 扩展阅读

- [Bash 游戏开发](https://github.com/awesome-shell/awesome-shell#games)
- [Shell 脚本调试技巧](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_02_04.html)
- [终端颜色和控制](https://www.gnu.org/software/termutils/manual/termcap-1.3/html_mono/termcap.html)

---

## 🎯 下一步

完成本目录学习后，建议继续：

1. **09_devops/** - DevOps 实战应用
2. 参与开源项目
3. 创建自己的脚本库

---

**最后更新**: 2026-03-18  
**维护者**: hjs2015

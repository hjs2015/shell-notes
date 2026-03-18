#!/bin/bash
# =============================================================================
# 脚本名称：03_user_login.sh
# 功能描述：用户登录系统 - 带验证码和限时输入
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - grep 检查用户是否存在
#   - cut -d":" -f2 提取密码字段
#   - $RANDOM 生成随机验证码
#   - read -t 10 限时输入（10 秒）
#   - 函数定义和调用
#   - stty 隐藏输入
# 使用方法：
#   chmod +x 03_user_login.sh
#   ./03_user_login.sh
# 登录流程：
#   1. 输入用户名（检查是否已注册）
#   2. 输入密码（隐藏输入）
#   3. 生成随机验证码
#   4. 10 秒内输入验证码
#   5. 验证通过，登录成功
# =============================================================================

# 显示登录标题
echo "用户登录@_@"

# 读取用户名
read -p "用户名:" name

# 检查用户是否已注册
# grep ^$name: 查找以"用户名:"开头的行
if [ $? -eq 1 ]; then  # $?=1 表示没找到（用户不存在）
	echo "此用户还未注册，重试"
	sh $0  # 重新执行脚本
	exit 1
fi

# 定义 getchar 函数 - 逐字符读取（隐藏输入）
getchar() {
	stty cbreak -echo  # 设置不回显
	dd if=/dev/tty bs=1 count=1 2> /dev/null  # 读取 1 个字符
	stty -cbreak echo  # 恢复设置
}

# 输入密码
echo -n "请输入你的密码:"

while true
do
	char=`getchar`
	if [ -z $char ]; then  # 按回车键
		echo
		break
	fi
	password2="$password2$char"
	echo -n "*"
done

# 从文件中提取该用户的密码
# grep ^$name: 找到用户行
# cut -d":" -f2 按冒号分割，取第 2 列（密码）
password1=`grep ^$name: register_user.txt |cut -d":" -f2`

# 验证密码
if [ $password1 != $password2 ]; then
	echo "密码输入错误"
	exit 2
fi

# 生成 4 位随机验证码
# $RANDOM%10 生成 0-9 的随机数
# 连接 4 个随机数得到 4 位验证码
num1=$[$RANDOM%10]$[$RANDOM%10]$[$RANDOM%10]$[$RANDOM%10]
echo "验证码为:" $num1

# 限时 10 秒输入验证码
# read -t 10 设置 10 秒超时
read -t 10 -p "请 10 秒内输入验证码:" num2
	
# 验证验证码
if [ $num1 -eq $num2 ]; then
	echo "登录成功"
else
	echo "验证码有误"
fi

# 说明：
# 1. grep ^$name: 使用^锚定行首，确保匹配完整的用户名
# 2. cut -d":" -f2 按冒号分割，-f2 取第 2 个字段
# 3. $RANDOM 每次使用都会生成不同的随机数
# 4. read -t 10 设置 10 秒超时，超时后 read 返回非 0
# 5. 验证码是数字比较，所以用 -eq 而不是=

# 安全建议：
# 1. 密码应该加密保存和比较
# 2. 应该限制登录失败次数（防止暴力破解）
# 3. 可以添加登录日志记录
# 4. 验证码应该使用字母 + 数字组合（更安全）

# 扩展练习：
# 1. 添加"忘记密码"功能
# 2. 添加"记住我"功能
# 3. 添加登录失败次数限制

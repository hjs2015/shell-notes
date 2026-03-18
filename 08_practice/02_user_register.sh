#!/bin/bash
# =============================================================================
# 脚本名称：02_user_register.sh
# 功能描述：用户注册系统 - 带密码验证和隐藏输入
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - grep 检查用户是否已存在
#   - 函数定义和调用
#   - stty cbreak -echo 隐藏输入
#   - dd if=/dev/tty 逐字符读取
#   - while true 循环输入
#   - expr length 字符串长度
#   - [[ $var =~ regex ]] 正则匹配
#   - exit 1/2/3/4/5 不同错误码
# 使用方法：
#   chmod +x 02_user_register.sh
#   ./02_user_register.sh
# 注册流程：
#   1. 输入用户名（检查是否已注册）
#   2. 输入密码（隐藏输入，显示*号）
#   3. 密码验证（长度、数字开头、纯字母）
#   4. 确认密码（两次输入一致）
#   5. 保存到文件
# =============================================================================

# 显示注册标题
echo "用户注册@_@"

# 读取用户名
read -p "用户名:" name

# 检查用户名是否已存在
# grep ^$name: 查找以"用户名:"开头的行
# &>/dev/null 不显示输出
if [ $? -eq 0 ]; then
	echo "此用户已经被注册，重试"
	sh $0  # 重新执行本脚本
	exit 1  # 退出
fi

# 定义 getchar 函数 - 逐字符读取（隐藏输入）
getchar() {
	# stty cbreak -echo 设置终端为原始模式，不回显字符
	stty cbreak -echo
	# dd if=/dev/tty bs=1 count=1 从终端读取 1 个字节
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	# stty -cbreak echo 恢复终端设置
	stty -cbreak echo
}

# 第一次输入密码
echo -n "请输入你的密码:"

while true
do
	char=`getchar`  # 读取一个字符
	if [ -z $char ]; then  # 如果按回车键（空字符）
		echo  # 换行
		break  # 退出循环
	fi
	password1="$password1$char"  # 累加字符
	echo -n "*"  # 显示*号
done

# 密码验证规则 1：长度至少 8 位
if [ `expr length "$password1"` -lt 8 ]; then
	echo "密码长度需要至少 8 位"
	exit 2

# 密码验证规则 2：不能以数字开头
elif [[ $password1 =~ ^[0-9] ]]; then
	echo "密码不能以数字开头"
	exit 3

# 密码验证规则 3：不能是纯字母
elif [[ $password1 =~ ^[a-zA-Z]*$ ]]; then
	echo "密码不能为纯字母"
	exit 4	
fi

# 第二次输入密码（确认）
echo -n "请再次输入你的密码:"

while true
do
	char=`getchar`
	if [ -z $char ]; then
		echo
		break
	fi
	password2="$password2$char"
	echo -n "*"
done

# 检查两次密码是否一致
echo
if [ $password1 != $password2 ]; then
	echo "两次密码输入不一致"
	exit 5
fi

# 保存用户信息到文件
# 格式：用户名：密码
echo $name:$password1 >> register_user.txt 
echo "注册成功!"

# 说明：
# 1. stty cbreak -echo 设置终端不回显（用于密码输入）
# 2. getchar 函数逐字符读取，实现自定义的密码输入
# 3. 密码以明文保存，实际应用中应该加密（如 md5sum）
# 4. exit 返回不同错误码，便于调试和排查问题

# 安全建议：
# 1. 密码应该加密保存（使用 md5sum 或 openssl）
# 2. 文件权限应该设置为 600（只有所有者可读写）
# 3. 可以添加邮箱验证、手机验证等

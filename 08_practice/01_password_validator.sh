#!/bin/bash
# =============================================================================
# 脚本名称：01_password_validator.sh
# 功能描述：密码验证器 - 验证密码是否符合安全要求
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - read -p 读取输入
#   - expr length 字符串长度
#   - grep 正则表达式匹配
#   - [[ $var =~ regex ]] 正则匹配（Bash 3.0+）
#   - ^[0-9] 以数字开头
#   - ^[a-zA-Z]*$ 纯字母
#   - exit 1/2/3 返回不同状态码
# 使用方法：
#   chmod +x 01_password_validator.sh
#   ./01_password_validator.sh
# 密码规则：
#   1. 长度至少 8 位
#   2. 不能以数字开头
#   3. 不能是纯字母
# =============================================================================

#!/bin/sh

# 提示用户输入密码
read  -p "please input the password:" password
echo  # 换行

# 规则 1：检查密码长度
# expr length "$password" 计算字符串长度
# -lt 8 表示小于 8
if [ `expr length "$password"` -lt 8 ]; then
	echo "it can not less then 8"  # 长度不够
	exit 1  # 返回状态码 1

# 规则 2：检查是否以数字开头
# [[ $password =~ ^[0-9] ]] 使用正则匹配
# ^[0-9] 表示以数字开头
elif [[ $password =~ ^[0-9] ]]; then
	echo "the password can not begin with a number"  # 不能以数字开头
	exit 2  # 返回状态码 2

# 规则 3：检查是否是纯字母
# ^[a-zA-Z]*$ 表示从头到尾都是字母
# ^ 表示开头，$ 表示结尾，* 表示 0 个或多个
elif [[ $password =~ ^[a-zA-Z]*$ ]]; then
	echo "the password are all chr,it is illegal"  # 不能是纯字母
fi

# 如果通过所有检查，密码符合要求
echo "Password is valid!"

# 说明：
# 1. expr length "$password" 计算字符串长度
# 2. [[ ]] 是 Bash 的增强测试命令，支持正则表达式
# 3. =~ 是正则匹配操作符
# 4. ^[0-9] 匹配以数字开头的字符串
# 5. ^[a-zA-Z]*$ 匹配纯字母字符串
# 6. exit 返回不同的状态码，便于其他脚本判断

# 扩展练习：
# 1. 添加"必须包含特殊字符"的规则
# 2. 添加"必须包含大写字母"的规则
# 3. 添加"不能包含用户名"的规则

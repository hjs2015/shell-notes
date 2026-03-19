#!/bin/bash
# =============================================================================
# 脚本名称：05_user_info_complete.sh
# 功能描述：完整的用户信息输入（带验证）
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - while true 无限循环
#   - if-else 条件判断
#   - -a 逻辑与（and）
#   - -ne 不等于，-lt 小于，-ge 大于等于
#   - continue 跳过本次循环
#   - break 退出循环
#   - read -n 2 限制输入 2 个字符
#   - grep [^0-9] 匹配非数字字符
#   - exit 2 退出脚本并返回状态码 2
# 使用方法：
#   chmod +x 05_user_info_complete.sh
#   ./05_user_info_complete.sh
# =============================================================================

# 读取用户姓名
read -p "input your name:" name

# 使用 while 循环确保性别输入正确
while true
do
	echo "1-男"
	echo "2-女"
	read -p "input your sex(1 or 2):" sex
	
	# 如果输入不是 1 也不是 2，提示错误并重新输入
	# -ne 表示"不等于"，-a 表示"与"（and）
	if [ $sex -ne 1 -a $sex -ne 2 ]; then
		echo "性别选择有误!,重试"
		continue  # 跳过本次循环，继续下一次
	else
		break  # 退出循环
	fi
done

# 读取年龄，限制输入 2 个字符
read -n 2 -p "input your age:" age
echo  # 换行

# 验证年龄是否为纯数字
# grep [^0-9] 匹配包含非数字字符的行
# &> /dev/null 不显示输出
echo $age |grep [^0-9] &> /dev/null

# 如果 grep 找到非数字字符（返回 0），说明年龄不是纯数字
if [ $? -eq 0 ]; then
	echo "年龄不是纯数字，重试"
	exit 2  # 退出脚本，返回状态码 2
fi

# 根据性别和年龄判断身份
# -a 表示"与"，-lt 表示"小于"，-ge 表示"大于等于"
if [ $sex -eq 1 -a $age -lt 18 ]; then
	echo "$name boy"  # 男性，小于 18 岁
elif [ $sex -eq 1 -a $age -ge 18 ]; then
	echo "$name man"  # 男性，大于等于 18 岁
elif [ $sex -eq 2 -a $age -lt 18 ]; then
	echo "$name girl"  # 女性，小于 18 岁
else
	echo "$name woman"  # 女性，大于等于 18 岁
fi

# 说明：
# 1. while true 创建无限循环，必须用 break 退出
# 2. continue 跳过本次循环剩余语句，继续下一次循环
# 3. exit 2 退出脚本并返回状态码，0 表示成功，非 0 表示失败
# 4. 多个条件用 -a（与）、-o（或）连接

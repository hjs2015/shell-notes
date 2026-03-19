#!/bin/bash
# =============================================================================
# 脚本名称：06_delete_users.sh
# 功能描述：批量删除用户和组
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - for 循环遍历
#   - userdel -r 删除用户及其家目录
#   - groupdel 删除组
# 使用方法：
#   chmod +x 06_delete_users.sh
#   sudo ./06_delete_users.sh
# 注意：需要 root 权限
# =============================================================================

# 批量删除 student1 到 student10 用户
# -r 参数表示同时删除用户的家目录
for i in {1..10}
do
	userdel -r student$i
done

# 删除 class 组
groupdel class

# 说明：
# 1. userdel 删除用户命令
# 2. -r 选项表示递归删除用户的家目录和邮件
# 3. groupdel 删除组命令
# 4. 执行前请确认这些用户和组存在

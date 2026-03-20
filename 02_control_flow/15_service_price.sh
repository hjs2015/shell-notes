#!/bin/bash
# =============================================================================
# 脚本名称：03_service_price.sh
# 功能描述：服务价格查询 - 根据性别和年龄推荐服务
# 难度等级：⭐⭐⭐ 中级
# 知识点：
#   - read -p 读取用户输入
#   - case 语句多分支
#   - 或条件匹配（男|man|boy）
#   - if 条件判断
#   - -ge 大于等于比较
#   - 嵌套 case 语句
# 使用方法：
#   chmod +x 03_service_price.sh
#   ./03_service_price.sh
# =============================================================================

# 读取用户姓名
read -p "input your name:" name

# 读取用户性别
read -p "input your sex:" sex

# 根据性别处理
case $sex in
	# 匹配男性（支持中文、英文、多种表达）
	男 | man | boy )
		# 读取年龄
		read -p "input your age:" age
		
		# 判断是否成年（大于等于 18 岁）
		# -ge 表示大于等于（greater or equal）
		if [ $age -ge 18 ]; then
			# 显示服务菜单
			echo "1-泰式"	
			echo "2-中式"
			echo "3-管式"
			
			# 读取服务选择
			read -p "$name 先生，你要选择哪种服务:" service_type 
			
			# 根据服务类型显示价格
			case $service_type in
				1 | 泰式 )
					echo "100" ;;
				2 | 中式 )
					echo "150" ;;
				3 | 管式 )
					echo "200" ;;
				* )
					echo "不提供此类服务"
			esac
		else
			# 未成年，拒绝服务
			echo "小子，回家去"	
		fi
		;;
	# 匹配女性（此脚本中未实现具体功能）
	女 | woman | girl )
		# 可以添加女性服务逻辑
		;;
	# 其他输入
	* )
		echo "你性别输入有误!"
esac

# 说明：
# 1. case 语句支持多个模式用 | 分隔（或条件）
# 2. 男|man|boy 表示匹配"男"或"man"或"boy"
# 3. if [ $age -ge 18 ] 判断年龄是否大于等于 18
# 4. 嵌套 case 语句实现多级菜单
# 5. * 是默认匹配（类似 else）

# 注意：
# 1. 这是一个示例脚本，展示条件判断和菜单逻辑
# 2. 实际应用需要更完善的输入验证
# 3. 女性服务逻辑未实现，可以扩展

#!/bin/bash
# =============================================================================
# 脚本名称：04_phone_brand_menu.sh
# 功能描述：手机品牌选择菜单 - 使用 dialog 图形界面
# 难度等级：⭐⭐⭐⭐ 高级
# 知识点：
#   - dialog --menu 创建图形菜单
#   - 2>/tmp/file.txt 重定向输出到文件
#   - cat 读取文件内容
#   - 嵌套 case 语句
#   - sleep 1 暂停 1 秒
# 使用方法：
#   chmod +x 04_phone_brand_menu.sh
#   ./04_phone_brand_menu.sh
# 前提条件：需要安装 dialog 包（yum install dialog）
# =============================================================================

# 显示手机品牌选择菜单
# dialog --menu 创建菜单对话框
# 12 30 12 分别表示：高度、宽度、菜单项数
# 1 苹果 2 三星... 是菜单项（编号 文本）
# 2>/tmp/phone_choice.txt 将用户选择重定向到文件（dialog 输出到 stderr）
dialog --menu 请选择你的手机品牌 12 30 12 1 苹果 2 三星 3 小米 4 华为 5 吹子  2>/tmp/phone_choice.txt

# 读取用户选择
choice=`cat /tmp/phone_choice.txt`

# 根据选择处理
case $choice in
	1 )
		# 选择苹果，暂停 1 秒
		sleep 1
		
		# 显示苹果手机型号选择菜单
		dialog --menu 请选择你的手机型号 12 30 12 1 苹果 5 2 苹果 6 3 苹果 7 4 苹果 8 5 苹果 X 2> /tmp/iphone_type.txt
		
		# 读取型号选择
		iphone_type=`cat /tmp/iphone_type.txt`
		
		# 根据型号显示价格
		case $iphone_type in 
			1 )
				echo "3000"  # 苹果 5
				;;
			2 )
				echo "4000"  # 苹果 6
				;;
			3 )
				echo "5000"  # 苹果 7
				;;
			4 )
				echo "6000"  # 苹果 8
				;;
			5 )
				echo "7000"  # 苹果 X
				;;
		esac
		;;
	2 )
		# 选择三星
		echo "三星"
		;;
	3 )
		# 选择小米
		echo "小米"
		;; 
	4 )
		# 选择华为
		echo "华为"
		;;
	5 )
		# 选择"吹子"（开玩笑的选项）
		echo "吹子"
		;;
	* )
		# 其他选择或取消
		echo "杂牌机不卖!"
esac

# 说明：
# 1. dialog 是终端图形界面工具
# 2. --menu 创建选择菜单
# 3. 数字参数：高度 宽度 菜单项数
# 4. dialog 将用户选择输出到 stderr（文件描述符 2）
# 5. 2>/tmp/file.txt 重定向 stderr 到文件
# 6. cat 读取文件内容获取用户选择

# dialog 常用选项：
# --menu     选择菜单
# --inputbox 输入框
# --yesno    是/否对话框
# --calendar 日历选择
# --gauge    进度条

# 注意：
# 1. 需要安装 dialog 包
# 2. dialog 输出到 stderr，需要用 2> 重定向
# 3. 临时文件要及时清理

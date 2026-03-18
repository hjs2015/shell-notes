#!/bin/bash

dialog --menu 请选择你的手机品牌 12 30 12 1 苹果 2 三星 3 小米 4 华为 5 吹子  2>/tmp/phone_choice.txt

choice=`cat /tmp/phone_choice.txt`
case $choice in
	1 )
		sleep 1
		dialog --menu 请选择你的手机型号 12 30 12 1 苹果5 2 苹果6 3 苹果7 4 苹果8 5 苹果X 2> /tmp/iphone_type.txt
		iphone_type=`cat /tmp/iphone_type.txt`
		case $iphone_type in 
			1 )
				echo "3000"
				;;
			2 )
				echo "4000"
				;;
			3 )
				echo "5000"
				;;
			4 )
				echo "6000"
				;;
			5 )
				echo "7000"
				;;
		esac
		;;
	2 )
		echo "三星"
		;;
	3 )
		echo "小米"
		;; 
	4 )
		echo "华为"
		;;
	5 )
		echo "吹子"
		;;
	* )
		echo "杂牌机不卖!"
esac

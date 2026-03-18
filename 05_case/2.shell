#!/bin/bash

read -p "input your name:" name

read -p "input your sex:" sex


case $sex in
	男|man|boy )
		read -p "input your age:" age
		if [ $age -ge 18 ];then
			echo "1-泰式"	
			echo "2-中式"
			echo "3-管式"
			read -p  "$name先生,你要选择哪种服务:" service_type 
			case $service_type in
				1|泰式 )
					echo "100" ;;
				2|中式 )
					echo "150" ;;
				3|管式 )
					echo "200" ;;
				* )
					echo "不提供此类服务"
			esac
		else
			echo "小子，回家去"	
		fi
		;;
	女|woman|girl )
		
		;;
	* )
		echo "你性别输入有误!"
esac


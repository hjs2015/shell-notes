#!/bin/bash

echo "**************************"
echo "*	  欢迎，这是总菜单     *"
echo "**************************"
echo "		操作类型	"
echo "		1-系统		"
echo "		2-程序		"
echo "		3-数据库	"
echo "		0-退出		"
echo "**************************"
read -p "请选择你要操作的类型:" choice
echo

case "$choice" in 
	0 )
		echo "谢谢使用，如有bug，请邮件给xxxx@126.com"
		exit 0
		;;
	1 )
		clear
		echo "**************************"
		echo "     欢迎来到系统子菜单   "
		echo "**************************"
		echo "          操作类型        "
		echo "          1-备份          "
		echo "          2-维护          "
		echo "          3-优化          "
		echo "          0-退出          "
		echo "**************************"
		;;
	* )
		echo "......."
esac


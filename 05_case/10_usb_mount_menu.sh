#!/bin/bash
mountusb () {
        fdisk -l
        read -p "选择你要挂载的设备(如:/dev/sdb1):" dev
        mount $dev /mnt
}

umountusb () {
        umount /mnt
}

display () {
        ls -l /mnt
}

usbtosystem () {
        display
        read -p "选择你要拷贝的文件名(相对路径):" file1
        read -p "选择你要拷贝到哪个目录(绝对路径):" dir1
        echo "拷贝中，请耐心等待..."
        cp -r /mnt/$file1 $dir1
        echo "拷贝完成"
}

systemtousb () {
        read -p "选择你要拷贝的文件名(相对路径):" file2
        echo "拷贝中，请耐心等待..."
        cp $file2 /mnt/ -rf
        echo "拷贝完成"
}

quit () {
        echo "谢谢使用，如有BUG，请联系xxx@gmail.com"
	exit 1
}

anwser=Y
while [ $anwser = Y -o $anwser = y ]
do
echo "##################################"
echo "    usb mount program by li       "
echo "##################################"
echo "                                  "
echo "          1-挂载                  "
echo "          2-卸载                  "
echo "          3-列出内容              "
echo "          4-拷文件到系统          "
echo "          5-拷文件到usb           "
echo "          0-退出程序              "
echo "                                  "
echo "##################################"
echo -n "请选择(0-5): "
read choice

case "$choice" in 
        1 ) clear && mountusb ;;
        2 ) clear && umountusb ;;
        3 ) clear && display ;;
        4 ) clear && usbtosystem ;;
        5 ) clear && systemtousb ;;
        0 ) clear && quit ;;
        * ) echo "选择有误，只能选择0-5!"
            exit 1
esac
        if [ $? -ne 0 ];then
        echo '程序出错!'
        exit 3
        fi
        echo -e "你要继续循环运行吗?(输入Y或y继续，输入其它退出)"
        read anwser
done


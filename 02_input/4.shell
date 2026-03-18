#!/bin/bash

read -p "输入你要查找笔记的分类(basic|shell|mysql|program|arch|oracle):" dir

cd /share/20170331/$dir

read -p "输入你要查找笔记的关键字:" keyword

gedit `grep $keyword * |cut -d":" -f1 |sort |grep -v ~$ |uniq -c |sort -n |tail -1 |awk '{print $2}'`

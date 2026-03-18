#!/bin/bash
read -p "input file:" dir
if [ ! -L $file ];then
        echo "$dir is not exist"
        sh $0
        exit 1 
fi  
for i in `find $dir -type -f`
do
        [ -r $i ] && echo "$i 可读" || echo "$i 不可读" 
        [ -w $i ] && echo "$i 可写" || echo "$i 不可写"
        [ -x $i ] && echo "$i 可执行" || echo "$i 不可执行"
done


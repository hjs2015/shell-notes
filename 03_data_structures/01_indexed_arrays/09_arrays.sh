#!/bin/bash
# =============================================================================
# 脚本：09_arrays.sh
# 功能：演示数组操作
# 难度：⭐⭐⭐
# 知识点：
#   - 普通数组
#   - 关联数组
#   - 数组操作（添加、删除、切片）
#   - 数组遍历
# 使用方法：
#   ./09_arrays.sh
# =============================================================================

echo "=========================================="
echo "【1】普通数组定义"
echo "=========================================="

# 方法 1：逐个赋值
arr1[0]="apple"
arr1[1]="banana"
arr1[2]="orange"

echo "方法 1 - 逐个赋值："
echo "  arr1[0]=${arr1[0]}"
echo "  arr1[1]=${arr1[1]}"
echo "  arr1[2]=${arr1[2]}"

# 方法 2：一次性赋值
arr2=("red" "green" "blue")

echo ""
echo "方法 2 - 一次性赋值："
echo "  arr2=${arr2[@]}"

# 方法 3：指定索引
arr3=([0]="first" [2]="third" [5]="fifth")

echo ""
echo "方法 3 - 指定索引："
echo "  arr3[0]=${arr3[0]}"
echo "  arr3[2]=${arr3[2]}"
echo "  arr3[5]=${arr3[5]}"

echo ""
echo "=========================================="
echo "【2】数组读取"
echo "=========================================="

colors=("red" "green" "blue" "yellow" "purple")

echo "数组：${colors[@]}"
echo ""
echo "所有元素：${colors[@]}"
echo "元素个数：${#colors[@]}"
echo "单个元素：${colors[2]}"
echo "从索引 2 开始：${colors[@]:2}"
echo "从索引 1 取 3 个：${colors[@]:1:3}"

echo ""
echo "=========================================="
echo "【3】数组遍历"
echo "=========================================="

echo "方法 1 - for 循环："
for item in "${colors[@]}"; do
    echo "  $item"
done

echo ""
echo "方法 2 - 索引循环："
for i in "${!colors[@]}"; do
    echo "  [$i] ${colors[$i]}"
done

echo ""
echo "方法 3 - while 循环："
i=0
while [ $i -lt ${#colors[@]} ]; do
    echo "  [$i] ${colors[$i]}"
    ((i++))
done

echo ""
echo "=========================================="
echo "【4】数组操作"
echo "=========================================="

nums=(1 2 3 4 5)
echo "原始数组：${nums[@]}"

# 添加元素
nums+=(6 7)
echo "添加元素后：${nums[@]}"

# 删除元素
unset nums[0]
echo "删除索引 0 后：${nums[@]}"

# 替换元素
nums[1]=100
echo "替换索引 1 后：${nums[@]}"

# 切片
echo "切片 [1:3]: ${nums[@]:1:3}"

echo ""
echo "=========================================="
echo "【5】关联数组"
echo "=========================================="

declare -A user_info

user_info[name]="张三"
user_info[age]="25"
user_info[city]="北京"

echo "关联数组："
echo "  姓名：${user_info[name]}"
echo "  年龄：${user_info[age]}"
echo "  城市：${user_info[city]}"

echo ""
echo "遍历关联数组："
for key in "${!user_info[@]}"; do
    echo "  $key = ${user_info[$key]}"
done

echo ""
echo "=========================================="
echo "【6】实战技巧"
echo "=========================================="

echo "技巧 1：数组去重"
arr=(1 2 2 3 3 3 4 4 5)
echo "原始：${arr[@]}"
unique=($(echo "${arr[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
echo "去重：${unique[@]}"

echo ""
echo "技巧 2：数组排序"
nums=(5 2 8 1 9 3)
echo "原始：${nums[@]}"
sorted=($(echo "${nums[@]}" | tr ' ' '\n' | sort -n | tr '\n' ' '))
echo "排序：${sorted[@]}"

echo ""
echo "技巧 3：数组转字符串"
words=("hello" "world" "shell")
str=$(IFS='-'; echo "${words[*]}")
echo "数组：${words[@]}"
echo "字符串：$str"

echo ""
echo "技巧 4：字符串转数组"
csv="apple,banana,orange"
IFS=',' read -ra fruits <<< "$csv"
echo "CSV: $csv"
echo "数组：${fruits[@]}"

echo ""
echo "技巧 5：检查元素是否存在"
target="banana"
if [[ " ${fruits[@]} " =~ " ${target} " ]]; then
    echo "✅ '$target' 在数组中"
else
    echo "❌ '$target' 不在数组中"
fi

echo ""
echo "=========================================="
echo "学习完成！"
echo "=========================================="

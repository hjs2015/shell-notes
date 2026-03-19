# Shell 编程完全指南

> 一本系统性的 Shell 脚本编程学习手册，从入门到实战

---

## 目录

- [第 1 章 Shell 概览](#第 1 章-shell 概览)
  - [1.1 Shell 能做什么](#11-shell 能做什么)
  - [1.2 Shell 的执行方式](#12-shell 的执行方式)
  - [1.3 Bash 中执行 Python/Expect](#13-bash 中执行 pythonexpect)
- [第 2 章 Bash Shell 基础](#第 2 章-bash-shell 基础)
  - [2.1 Shell 特性](#21-shell 特性)
  - [2.2 Shell 变量](#22-shell 变量)
  - [2.3 Shell 条件测试](#23-shell 条件测试)
  - [2.4 Shell 数值运算](#24-shell 数值运算)
  - [2.5 流程控制与循环](#25-流程控制与循环)
  - [2.6 数组](#26-数组)
  - [2.7 函数](#27-函数)
  - [2.8 Shell 内置命令](#28-shell 内置命令)
  - [2.9 正则表达式](#29-正则表达式)
  - [2.10 sed 流编辑器](#210-sed 流编辑器)
  - [2.11 awk 文本处理](#211-awk 文本处理)
- [第 3 章 实战脚本](#第 3 章-实战脚本)
  - [3.1 GitLab 备份转存脚本](#31-gitlab-备份转存脚本)
  - [3.2 求某年的某月有多少天](#32-求某年的某月有多少天)
  - [3.3 添加公网域名解析到本地 hosts](#33-添加公网域名解析到本地-hosts)
- [附录：常用命令速查](#附录常用命令速查)
- [学习资源](#学习资源)

---

## 第 1 章 Shell 概览

### 1.1 Shell 能做什么

Shell 脚本可以调用第三方命令组成有逻辑的执行顺序，实现系统初始化自动化，统一执行流程，避免手工操作错误。

| 作用 | 细节 |
|------|------|
| 1. 系统初始化程序 | update，软件安装，时区设置，安全策略 |
| 2. 软件部署程序 | LAMP，LNMP，Tomcat，LVS，Nginx |
| 3. 应用管理程序 | 集群管理扩容，MySQL |
| 4. 日志分析处理程序 | PV, UV, 200, !200, top 100, grep/awk |
| 5. 备份恢复程序 | MySQL 完全备份/增量 + Crond |
| 6. 管理程序 | 批量远程修改密码，软件升级，配置更新 |
| 7. 信息采集及监控程序 | 收集系统/应用状态信息，CPU,Mem,Disk,Net,TCP，app |
| 8. 配合 Zabbix 信息采集 | 收集系统/应用状态信息，CPU,Mem,Disk,Net,TCP，app |
| 9. 扩容 | 增加云主机→业务上线，zabbix 监控 CPU 80%，Python API 增加/删除云主机 |
| 10. 小工具 | 俄罗斯方块，打印三角形，打印圣诞树，打印五角星，运行小火车，坦克大战，排序算法实现 |
| 11. Any | For You See, You know, You can.. |

### 1.2 Shell 的执行方式

#### 命令返回状态码

每个 shell 命令的执行都会有返回值，查看返回值为 `echo $?`，返回值为 0 是正确返回，返回值为非 0 是错误返回。

```bash
[root@server ~]# date
Sat Jul 16 07:28:53 CST 2022
[root@server ~]# echo $?
0

[root@server ~]# date111
-bash: date111: command not found
[root@server ~]# echo $?
127
```

#### 语法特征：&& ；||

| 语法 | 特征 | 细节 |
|------|------|------|
| `&&` | 逻辑与 | 前面命令执行成功，后面命令才可以执行，具备逻辑判断 |
| `;` | 顺序执行 | 无论前命令是否执行成功，都会执行后命令；不具备逻辑判断 |
| `\|\|` | 逻辑或 | 前面命令执行不成功，后面命令才可以执行，具备逻辑判断 |

**示例：&& 语法**

```bash
# 成功执行-- 前面命令执行成功，后面命令才可以执行
[root@server ~]# date && echo hjs
Sat Jul 16 07:41:45 CST 2022
hjs
[root@server ~]# echo $?
0

# 错误执行-- 前面命令执行失败，后面命令停止执行
[root@server ~]# date1 && echo hjs
-bash: date1: command not found
[root@server ~]# echo $?
127
```

**示例：; 语法**

```bash
# 无论前命令是否执行成功，都执行后命令
[root@server ~]# date ; echo hjs
Sat Jul 16 07:46:48 CST 2022
hjs
[root@server ~]# echo $?
0

[root@server ~]# date1 ; echo hjs
-bash: date1: command not found
hjs
[root@server ~]# echo $?
0
```

**示例：|| 语法**

```bash
# 前命令成功执行，后命令不执行
[root@server ~]# date || echo hjs
Sat Jul 16 08:10:35 CST 2022
[root@server ~]# echo $?
0

# 前命令失败执行，后命令才执行
[root@server ~]# date1 || echo hjs
-bash: date1: command not found
hjs
[root@server ~]# echo $?
0
```

#### 布尔值

```bash
# 假值返回 1
[root@server ~]# false
[root@server ~]# echo $?
1

# 真值返回 0
[root@server ~]# true
[root@server ~]# echo $?
0
```

#### Shell 脚本的执行权限

**问题：** 创建的 shell 脚本没有执行权限，该怎么办？

**处理办法 1：** 使用 shell 解析器 bash 或者 sh 执行脚本

```bash
[root@server ~]# cat 1.1.2-a.sh
echo hjs

[root@server ~]# ./1.1.2-a.sh
-bash: ./1.1.2-a.sh: Permission denied

[root@server ~]# bash 1.1.2-a.sh
hjs

[root@server ~]# sh 1.1.2-a.sh
hjs
```

**处理办法 2：** shell 脚本内部声明 shell 解析器，然后授权脚本具有执行权限

```bash
[root@server ~]# cat 1.1.2-a.sh
#!/bin/env bash
echo hjs

[root@server ~]# chmod u+x 1.1.2-a.sh
[root@server ~]# ./1.1.2-a.sh
hjs
```

**注意：** 不同操作系统有不同的结果。CentOS 中的 bash 和 sh 是同一个 shell 解析器（MD5 值相同），Ubuntu 中 bash 和 sh 不是同一个 shell 解析器。

#### 编译型与解释型语言区别

| 类型 | 特点 | 代表语言 | 优点 | 缺点 |
|------|------|----------|------|------|
| 编译型 | 一次性把所有代码编译成机器能识别的二进制机器码/字节码，再运行 | C, C++, Java | 执行速度快 | 开发速度慢，调试周期长 |
| 解释型 | 代码从上到下一行一行解释并运行 | Python, PHP | 开发效率快，调试周期短 | 执行速度相对慢 |

### 1.3 Bash 中执行 Python/Expect

#### Bash 执行 Python

```bash
#!/bin/bash
/usr/bin/python <<-EOF
print("hello world -EOF")
print("hello world -EOF")
EOF

/usr/bin/python <<-EOFQ
print("hello world -EOFQ")
print("hello world -EOFQ")
EOFQ
```

#### 当前 Shell 执行与子 Shell 执行的区别

```bash
# 创建一个 bash_exec_child.sh
cat bash_exec_child.sh
#!/bin/env bash
cd /home
ls

# 授权用户执行权限
chmod u+x bash_exec_child.sh

# 子 shell 执行 1
bash bash_exec_child.sh
# 输出：hjs inspector (用户目录未切换)

# 子 shell 执行 2
./bash_exec_child.sh
# 输出：hjs inspector (用户目录未切换)

# 当前 shell 执行 1
. bash_exec_child.sh
# 输出：hjs inspector (发现用户目录由 tmp 切换到 home 里面去了)

# 当前 shell 执行 2
source bash_exec_child.sh
# 输出：hjs inspector (发现用户目录由 tmp 切换到 home 里面去了)
```

**总结：**
- `bash script.sh` 或 `./script.sh`：在子 shell 中执行，不影响当前 shell 环境
- `. script.sh` 或 `source script.sh`：在当前 shell 中执行，会影响当前 shell 环境

---

## 第 2 章 Bash Shell 基础

### 2.1 Shell 特性

#### 登录登出初始化

**Linux 支持的 shell 解析器：**

```bash
[root@server ~]# cat /etc/shells
/bin/sh
/bin/bash
/usr/bin/sh
/usr/bin/bash

[root@server ~]# chsh -l
/bin/sh
/bin/bash
/usr/bin/sh
/usr/bin/bash
```

**Bash 下的用户登录操作涉及的基础初始化（login shell）：**

| 作用域 | Shell 配置文件 |
|--------|---------------|
| 系统级 | `/etc/profile` `/etc/bashrc` |
| 用户级 | 登入 `.bash_profile` 登入 `.bashrc` 登出 `.bash_logout` 登出 `.bash_history` |

**su 与 su - 的区别：**

- `su 账户`：半切换
- `su - 账户`：全切换

```bash
# su - test -- 安全切换，切换后就相当于使用 test 用户登录
[root@server ~]# id
uid=0(root) gid=0(root) groups=0(root)

[root@server ~]# echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

[root@server ~]# su - test
[test@server ~]$ id
uid=1002(test) gid=1002(test) groups=1002(test)

[test@server ~]$ echo $PATH
/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/test/.local/bin:/home/test/bin

# su test -- 非完全切换，切换后还带有上一个用户的属性
[root@server ~]# su test
[test@server root]$ id
uid=1002(test) gid=1002(test) groups=1002(test)

[test@server root]$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
```

**su 总结：**
1. root 用户切换普通用户不需要密码，但是普通用户切换别的用户都需要密码
2. 建立一个普通用户后，如果没有对它设置密码，则无法登录，只能使用 root 去切换它
3. `su - 用户`：会加载用户的 login shell
4. `su 用户`：不会加载用户的 login shell

#### 命令和文件自动补齐

CentOS 7 默认不安装增强式命令补充包，需要用 yum 单独安装：

```bash
# 查看增强式命令补充包
[root@server ~]# yum info bash-comp*

# 安装增强式命令补充包
[root@server ~]# yum -y install bash-comp*
```

#### 命令历史记忆功能

```bash
# 上下键
键盘的上下键可以查看最近的输入命令

# !number
使用 history 命令后，！数字 可以引用某个执行过的命令

# !string
引用某个执行过的命令

# !$
引用最后一个命令的参数

# !!
执行最后一个命令

# ^R
选择最近使用的命令 (reverse-i-search)
```

#### 别名功能

```bash
# 查看当前 shell 别名
alias

# 取消别名
unalias cp

# 别名的配置文件
~username/.bashrc

# 忽略别名优先级，使用非别名 Cp
\cp -rf /etc/hosts .
```

#### 快捷键

| 快捷键 | 功能 |
|--------|------|
| `^R` | 搜索最近命令记录/重新连接 |
| `^C` | 中止当前操作 |
| `^D` | 退出 |
| `^A` | 光标移动到最前 |
| `^E` | 光标移动到最后 |
| `^L` | 光标置顶到首页 |
| `^U` | 光标往前删 |
| `^K` | 光标往后删 |
| `^Y` | 撤销 |
| `^S` | 锁定 |
| `^Q` | 解锁 |

#### 前后台作业控制

**& 放在启动参数后面，表示设置此进程为后台进程**

```bash
[root@server ~]# sleep 300 &
[1] 18734
[root@server ~]# ps aux|grep 18734
root 18734 0.0 0.0 108056 360 pts/2 S 12:47 0:00 sleep 300
```

**注意：** 退出终端，进程就会中止

**nohup 退出终端依旧运行命令**

```bash
# 这种方式不推荐，会在本地输出文件 nohup.out
[root@server ~]# nohup sleep 600 &
[1] 24497
nohup: ignoring input and appending output to 'nohup.out'

# 这种方式推荐，先删除上次运行产生的 nohup.out 文件
[root@server ~]# rm -f nohup.out
[root@server ~]# nohup sleep 600 &>/dev/null &
[2] 26473
[root@server ~]# ps aux|grep 26473
root 26473 0.0 0.0 108056 360 pts/2 S 13:14 0:00 sleep 600
```

**screen 多重视窗管理程序【强烈推荐】**

```bash
# 先安装 screen
[root@server ~]# yum -y install screen

# 0. 进入 screen 管理进程
screen

# 1. 查看所有 screen 列表
screen -ls
# 等价于 screen -list

# 2. 进入 screen
screen -r [screen name]

# 3. 新建 screen
screen -dmS [screen name]

# 4. 退出屏幕
CTRL + A + D
```

**^C、^Z、bg %2、fg %2、kill 15 %2**

```bash
^C          # 中止当前终端进程
^Z          # 把当前终端进程放到后台暂停运行 (fg 可以快速调出最后一个暂停进程)
jobs        # 列出属于当前用户的进程
bg %2       # 把 jobs 中编号 2 的进程放到后台运行
fg %2       # 把 jobs 中编号 2 的进程放到前台运行
kill 15 %2  # 把 jobs 中编号 2 的进程杀掉，等价 kill %2
kill 9 %2   # 把 jobs 中编号 2 的进程杀掉
```

#### 重定向

**操作系统描述符 0,1,2**

每一个文件在操作系统被打开，都会有一个与之对应的文件描述符，亦称为文件句柄 (fd)。

| 文件描述符/句柄 | 描述 | 例子 |
|----------------|------|------|
| 0 stdin | 标准输入 | `< test.txt`，实际是 `0<test.txt` 的省略用法 |
| 1 stdout | 标准输出 | `> test.txt`，实际是 `1>test.txt` 的省略用法 |
| 2 stderr | 标准错误 | `2> error.log` |

**重定向符号：**

| 符号 | 描述 | 例子 |
|------|------|------|
| `>` | 标准输出-(覆盖) 重定向 | `echo "hello" > file.txt` |
| `>>` | 标准输出-(追加) 重定向 | `echo "world" >> file.txt` |
| `2>` | 标准错误-(覆盖) 重定向 | `command 2> error.log` |
| `2>>` | 标准错误-(追加) 重定向 | `command 2>> error.log` |
| `2>&1` | 标准错误和标准输出-(覆盖) 重定向 | `command &> all.log` |
| `&>` | 标准错误和标准输出-(覆盖) 重定向 | `command &> all.log` |

**示例：**

```bash
# 示例 1：从文件读入
[root@server ~]# cat < /etc/hosts
::1 localhost localhost.localdomain
127.0.0.1 localhost

# 示例 2：Here Document
[root@server ~]# cat <<EOF > hjs
> gcq
> xch
> EOF

# 示例 3：追加写入
[root@server ~]# cat <<EOF >> file1
> hjs
> gcq
> syf
> EOF
```

#### 管道、tee

**管道：** 一个命令的输出是另一个命令的输入

```bash
# | 管道
ip addr | grep 'inet ' | grep eth0

# tee 从标准输入读取并写入标准输出和文件
ip addr | grep 'inet ' | tee test | grep eth0

# tee -a 双向追加重定向
ip addr | grep 'inet ' | tee -a test | grep eth0
```

#### 通配符 (元字符)

| 符号 | 描述 | 例子 |
|------|------|------|
| `*` | 匹配任意多个字符 | `ls in*` `rm -rf *.pdf` `find / -iname "*eth0*"` |
| `?` | 匹配任意一个字符 | `touch love loove live l7ve; ls -l l?ve` |
| `[]` | 匹配括号中任意一个字符 | `[abc]` `[a-z]` `[0-9]` `[a-zA-Z0-9]` `[^a-zA-Z0-9]` |
| `()` | 在子 shell 中执行 | `(cd /boot;ls)` `(umask 077; touch file1000)` |
| `{}` | 集合 | `touch file{1..9}` `mkdir /home/{111,222}` `mkdir -pv /home/{333/{aaa,bbb},444}` |
| `\` | 转义符，让元字符回归本意 | `echo \*` `touch yang\ sheng` `echo -e "a\tb"` |

#### echo 命令

**控制字符：**

| 控制字符 | 作用 | 例子 |
|----------|------|------|
| `\\` | 输出\本身 | `echo "\\"` |
| `\a` | 输出警告音 | `echo -e "\a"` |
| `\b` | 退格键，也就是向左删除键 | `echo -e "ab\bc"` → `ac` |
| `\c` | 取消输出行末的换行符 | `echo -e "abc\c"` |
| `\e` | ESCAPE 键 | `echo -e "\e[1;31m abcd \e[0m"` |
| `\f` | 换页符 | `echo -e "\f"` |
| `\n` | 换行符 | `echo -e "a\nb"` |
| `\r` | 回车键 | `echo -e "a\rb"` |
| `\t` | 制表符，也就是 Tab 键 | `echo -e "a\tb\tc"` |
| `\v` | 垂直制表符 | `echo -e "\v"` |
| `\0nnn` | 按照八进制 ASCII 码表输出字符 | `echo -e "\101"` → `A` |
| `\xhh` | 按照十六进制 ASCII 码表输出字符 | `echo -e "\x41"` → `A` |

**颜色控制：**

| 控制符 | 颜色 |
|--------|------|
| `30m` | 黑色 |
| `31m` | 红色 |
| `32m` | 绿色 |
| `33m` | 黄色 |
| `34m` | 蓝色 |
| `35m` | 洋红 |
| `36m` | 青色 |
| `37m` | 白色 |

**示例：**

```bash
[root@server ~]# echo -e "ab\bc"
ac

[root@server ~]# echo -e "a\tb\tc\nd\te\tf"
a   b   c
d   e   f

[root@server ~]# echo -e "\e[1;31m abcd \e[0m"
abcd  # 红色显示
```

### 2.2 Shell 变量

#### 变量的类型

**自定义变量**

| 作用 | 样例 |
|------|------|
| 定义变量 | `变量名=变量值` 变量名必须以字母或下划线开头，区分大小写 `ip1=192.168.1.100` |
| 引用变量 | `$变量名` 或 `${变量名}` |
| 查看变量 | `echo $变量名` `set`(所有变量：包括自定义变量和环境变量) |
| 取消变量 | `unset 变量名` |
| 作用范围 | 仅在当前 shell 中有效 |

**环境变量**

| 作用 | 样例 |
|------|------|
| 定义环境变量 | 方法一 `export back_dir2=/home/backup` 方法二 `export back_dir1` 将自定义变量转换成环境变量 |
| 引用环境变量 | `$变量名` 或 `${变量名}` |
| 查看环境变量 | `echo $变量名` `env` |
| 取消环境变量 | `unset 变量名` |
| 变量作用范围 | 在当前 shell 和子 shell 有效 |

**位置变量**

| 变量 | 作用 |
|------|------|
| `$0` | 脚本名 |
| `$1` - `$9` | 第 1 到第 9 个参数 |
| `${10}` - `${n}` | 第 10 个及以后的参数 |

**预定义变量**

| 变量 | 作用 | 样例 |
|------|------|------|
| `$0` | 脚本名 | `echo $0` |
| `$*` | 所有的参数 | `echo $*` |
| `$@` | 所有的参数 | `echo $@` |
| `$#` | 参数的个数 | `echo $#` |
| `$$` | 当前进程的 PID | `echo $$` |
| `$!` | 上一个后台进程的 PID | `echo $!` |
| `$?` | 上一个命令的返回值 (0 表示成功) | `echo $?` |

#### 变量的定义方式

**显式赋值**

```bash
变量名=变量值

# 示例：
ip1=192.168.1.100
school="BeiJing 1000phone"
today1=`date +%F`
today2=$(date +%F)
```

**从键盘读入变量值 - read**

```bash
read 变量名
read -p "提示信息："变量名
read -t 5 -p "提示信息："变量名
read -n 2 变量名

# 示例
#!/bin/bash
read -p "Input IP: " ip
ping -c2 $ip &>/dev/null
if [ $? = 0 ]; then
    echo "host $ip is ok"
else
    echo "host $ip is fail"
fi
```

**定义或引用变量时注意事项**

- `""` 弱引用
- `''` 强引用
- `` ` ` `` 命令替换，等价于 `$()`

```bash
# school=1000phone
# echo "${school} is good"
1000phone is good

# echo '${school} is good'
${school} is good

# touch `date +%F`_file1.txt
# touch $(date +%F)_file2.txt

# disk_free3="df -Ph |grep '/$' |awk '{print $4}'"  # 错误
# disk_free4=$(df -Ph |grep '/$' |awk '{print $4}')
# disk_free5=`df -Ph |grep '/$' |awk '{print $4}'`
```

#### 变量的运算

**1. 整数运算**

```bash
# 方法一：expr
expr 1 + 2
expr $num1 + $num2
# + - \* / %

# 方法二：$(())
echo $(($num1+$num2))
echo $((num1+num2))
echo $((5-3*2))
echo $(((5-3)*2))
echo $((2**3))
sum=$((1+2)); echo $sum

# 方法三：$[]
echo $[5+2]
echo $[5**2]
# + - * / %

# 方法四：let
let sum=2+3; echo $sum
let i++; echo $i
```

**2. 小数运算**

```bash
# 方法一：bc
echo "2*4" | bc
echo "2^4" | bc
echo "scale=2;6/4" | bc

# 方法二：awk
awk 'BEGIN{print 1/2}'

# 方法三：python
echo "print 5.0/2" | python

# 方法四：dc
dc -e '5 5 * p'
# 25
dc -e '36 v p'
# 6
```

#### 变量"内容"的删除和替换

**"内容"的删除**

```bash
# url=www.sina.com.cn

# 获取变量值的长度
echo ${#url}
# 15

# 标准查看
echo ${url}
# www.sina.com.cn

# 从前往后，最短匹配
echo ${url#*.}
# sina.com.cn

# 从前往后，最长匹配 (贪婪匹配)
echo ${url##*.}
# cn

# 从后往前，最短匹配
echo ${url%.*}
# www.sina.com

# 从后往前，最长匹配 (贪婪匹配)
echo ${url%%.*}
# www
```

**索引及切片**

```bash
# url=www.sina.com.cn

echo ${url:0:5}
# www.s

echo ${url:5:5}
# ina.c

echo ${url:5}
# ina.com.cn
```

**"内容"的替换**

```bash
# url=www.sina.com.cn

echo ${url/sina/baidu}
# www.baidu.com.cn

echo ${url/n/N}
# www.siNa.com.cn

# 贪婪匹配
echo ${url//n/N}
# www.siNa.com.cN
```

**变量的替代**

```bash
# unset var1
# var2=
# var3=111

# ${变量名 - 新的变量值}
# 变量没有被赋值：会使用"新的变量值" 替代
# 变量有被赋值（包括空值）：不会被替代
echo ${var1-aaaaa}
# aaaaa
echo ${var2-bbbbb}
# bbbbb
echo ${var3-ccccc}
# 111

# ${变量名:-新的变量值}
# 变量没有被赋值（包括空值）：都会使用"新的变量值" 替代
# 变量有被赋值：不会被替代
echo ${var1:-aaaa}
# aaaa
echo ${var2:-aaaa}
# aaaa
echo ${var3:-aaaa}
# 111

# ${变量名:+新的变量值}
# 变量有赋值：使用新值替代
# 变量没有赋值：不替代
echo ${var3:+aaaa}
# aaaa

# ${变量名=新的变量值}
# 变量没有被赋值：赋值并返回新值
# 变量有赋值：返回原值
echo ${var3=aaaa}
# 111

# ${变量名？新的变量值}
# 变量没有被赋值：显示错误信息
# 变量有赋值：返回原值
echo ${var3?aaaa}
# 111
```

**i++ 和 ++i**

```bash
# 对变量的值的影响：
# i=1
# let i++
# echo $i
# 2

# j=1
# let ++j
# echo $j
# 2

# 对表达式的值的影响：
# unset i
# unset j
# i=1
# j=1
# let x=i++  # 先赋值，再运算
# let y=++j  # 先运算，再赋值
# echo $i
# 2
# echo $j
# 2
# echo $x
# 1
# echo $y
# 2
```

### 2.3 Shell 条件测试

#### if 条件判断

**作用场景：**
- A. 文件测试
- B. 数值比较
- C. 字符串比较

**语法格式：**

```bash
# 格式 1：
test 条件表达式

# 格式 2：
[ 条件表达式 ]

# 格式 3：
[[ 条件表达式 ]]
```

**流程控制：**

```bash
# 单分支结构
if 条件测试; then
    命令序列
fi

# 双分支结构
if 条件测试; then
    命令序列
else
    命令序列
fi

# 多分支结构
if 条件测试 1; then
    命令序列
elif 条件测试 2; then
    命令序列
else
    命令序列
fi
```

**注意：** 变量需要用 `""` 引号引起来作为一个整体变量，否则 test 命令会判断整体变量不准确。

**A. 文件测试 `[ 操作符 文件或目录 ]`**

```bash
# 常用文件测试操作符
[ -e dir|file ]    # 是否存在
[ -d dir ]         # 是否存在，而且是目录
[ -f file ]        # 是否存在，而且是文件
[ -r file ]        # 当前用户对该文件是否有读权限
[ -w file ]        # 当前用户对该文件是否有写权限
[ -x file ]        # 当前用户对该文件是否有执行权限
[ -L file ]        # 是否为符号链接

# 示例
[root@server ~]# test -d /home
[root@server ~]# echo $?
0

[root@server ~]# [ -d /home ]
[root@server ~]# echo $?
0

[root@server ~]# [ ! -d /ccc ] && mkdir /ccc
[root@server ~]# [ -d /ccc ] || mkdir /ccc
```

**B. 数值比较 `[ 整数 1 操作符 整数 2 ]`**

```bash
[ 1 -gt 10 ]  # 大于 (greater than)
[ 1 -lt 10 ]  # 小于 (less than)
[ 1 -eq 10 ]  # 等于 (equal)
[ 1 -ne 10 ]  # 不等于 (not equal)
[ 1 -ge 10 ]  # 大于等于 (greater or equal)
[ 1 -le 10 ]  # 小于等于 (less or equal)

# 示例
[root@server ~]# disk_use=$(df -P |grep '/$' |awk '{print $5}' |awk -F% '{print $1}')
[root@server ~]# [ $disk_use -gt 90 ] && echo "war......"
[root@server ~]# [ $disk_use -gt 60 ] && echo "war......"
war......

[root@server ~]# [ $(id -u) -eq 0 ] && echo "当前是超级用户"
当前是超级用户

# C 语言风格的数值比较
[root@server ~]# ((1<2)); echo $?
0
[root@server ~]# ((1==2)); echo $?
1
[root@server ~]# ((1>2)); echo $?
1
[root@server ~]# ((1>=2)); echo $?
1
[root@server ~]# ((1<=2)); echo $?
0
[root@server ~]# ((1!=2)); echo $?
0
[root@server ~]# ((`id -u`>0)); echo $?
1
[root@server ~]# (($UID==0)); echo $?
0
```

**C. 字符串比较**

```bash
# 提示：使用双引号
[root@server ~]# [ "$USER" = "root" ]; echo $?
0

[root@server ~]# [ "$USER" == "root" ]; echo $?
0

# 字符长度是为 0
BBB=""
[ -z "$BBB" ]
echo $?
# 0

# 字符长度不为 0
[ -n "$BBB" ]
echo $?
# 1

# 字符串比较
[root@server ~]# [ "$USER" = "root" ]; echo $?
0
[root@server ~]# [ "$USER" = "alice" ]; echo $?
1
[root@server ~]# [ "$USER" != "alice" ]; echo $?
0

# 多条件
[root@server ~]# [ 1 -lt 2 -a 5 -gt 10 ]; echo $?
1
[root@server ~]# [ 1 -lt 2 -o 5 -gt 10 ]; echo $?
0
[root@server ~]# [[ 1 -lt 2 && 5 -gt 10 ]]; echo $?
1
[root@server ~]# [[ 1 -lt 2 || 5 -gt 10 ]]; echo $?
0

# 正则表达式 (使用双中括号)
[root@server ~]# [[ "$USER" =~ ^r ]]; echo $?
0

# 判断变量是不是数字
[root@server ~]# num10=123
[root@server ~]# num20=ssss1114ss
[root@server ~]# [[ "$num10" =~ ^[0-9]+$ ]]; echo $?
0
[root@server ~]# [[ "$num20" =~ ^[0-9]+$ ]]; echo $?
1
```

**案例 1：判断用户输入的是否是数字**

```bash
#!/bin/bash
# 判断用户输入的是否是数字
read -p "请输入一个数值："num
if [[ ! "$num" =~ ^[0-9]+$ ]]; then
    echo "你输入的不是数字，程序退出!!!"
    exit
fi
echo ccc
```

**案例 2：循环判断用户输入的是否是数字**

```bash
#!/bin/bash
# 判断用户输入的是否是数字
read -p "请输入一个数值："num
while :; do
    if [[ $num =~ ^[0-9]+$ ]]; then
        break
    else
        read -p "不是数字，请重新输入数值："num
    fi
done
echo "你输入的数字是：$num"
```

**符号总结：**

| 符号 | 用途 |
|------|------|
| `()` | 子 shell 中执行 |
| `(())` | 数值比较，运算 C 语言风格 |
| `$()` | 命令替换 |
| `(())` | 整数运算 |
| `{}` | 代码块 |
| `${}` | 变量引用 |
| `[]` | 条件测试 |
| `[[]]` | 条件测试，支持正则 `=~` |
| `$[]` | 整数运算 |

**脚本运行与调试：**

```bash
# 执行脚本：
./01.sh          # 需要执行权限，在子 shell 中执行
bash 01.sh       # 不需要执行权限，在子 shell 中执行
. 01.sh          # 不需要执行权限，在当前 shell 中执行
source 01.sh     # 不需要执行权限，在当前 shell 中执行

# 调试脚本：
sh -n 02.sh      # 仅调试 syntax error
sh -vx 02.sh     # 以调试的方式执行，查询整个执行过程
bash -x 02.sh    # 显示执行过程
```

### 2.4 Shell 数值运算

参见 [2.2 Shell 变量 - 变量的运算](#变量的运算)

### 2.5 流程控制与循环

#### for 循环

**Shell 语法：**

```bash
for 变量名 [ in 取值列表 ]; do
    循环体
done
```

**C 语言语法：**

```bash
for ((初值;条件;步长)); do
    循环体
done
```

**示例：并发探测多主机**

```bash
#!/usr/bin/bash
for i in {2..254}; do
    {
        ip=10.0.0.$i
        ping -c1 -W1 $ip &>/dev/null
        if [ $? -eq 0 ]; then
            echo "$ip up."
        fi
    } &
done
wait
echo "all finish..."
```

**示例：for expect 多主机推送公钥**

```bash
#!/usr/bin/bash
>ip.txt
password=centos

rpm -q expect &>/dev/null
if [ $? -ne 0 ]; then
    yum -y install expect
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -P "" -f ~/.ssh/id_rsa
fi

for i in {2..254}; do
    {
        ip=10.0.0.$i
        ping -c1 -W1 $ip &>/dev/null
        if [ $? -eq 0 ]; then
            echo "$ip" >> ip.txt
            /usr/bin/expect <<-EOF
set timeout 10
spawn ssh-copy-id $ip
expect {
    "yes/no" { send "yes\r"; exp_continue }
    "password:" { send "$password\r" }
}
expect eof
EOF
        fi
    } &
done
wait
echo "finish...."
```

#### while 循环

**语法结构：**

```bash
while 条件测试; do
    循环体
done
# 当条件测试成立（条件测试为真），执行循环体
```

**整体遍历：**

```bash
while read line; do
    echo $line
done < /etc/hosts
```

**计算 1+...+100 的累加值：**

```bash
i=0; sum=0
while [ $i -le 100 ]; do
    let sum=sum+i
    let i++
done
echo $sum
```

#### until 循环

**语法结构：**

```bash
until 条件测试; do
    循环体
done
# 当条件测试成立（条件测试为假），执行循环体
```

#### Expect 非交互操作

Shell expect 是一个可以自动化执行命令并对命令执行结果进行交互式处理的工具。

**示例 1：SSH 登录**

```bash
#!/usr/bin/expect
set timeout 10
set username "your_username"
set password "your_password"
set host "your_remote_host"

spawn ssh $username@$host
expect "password:"
send "$password\r"
expect "$ "
send "ls -l\r"
expect "$ "
send "exit\r"
```

**示例 2：自动登录并执行命令**

```bash
#!/usr/bin/expect
set ip [lindex $argv 0]
set user root
set password centos
set timeout 5

spawn ssh $user@$ip
expect {
    "yes/no" { send "yes\r"; exp_continue }
    "password:" { send "$password\r" }
}
# interact
expect "#"
send "useradd yangyang\r"
send "pwd\r"
send "exit\r"
expect eof
```

#### Shell 并发控制

**基本语法格式：**

```bash
for i in xx; do
    {
        xx 条件
    } &
done
wait
echo "finish..."
```

**使用文件描述符控制并发进程数：**

```bash
#!/usr/bin/bash
# 多线程控制
thread=10  # 并发数
tmp_fifofile=/tmp/$$.fifo  # 定义管道路径

mkfifo $tmp_fifofile  # 生成管道文件
exec 8<> $tmp_fifofile  # 文件描述符指向管道
rm -f $tmp_fifofile  # 删除管道文件

# 往管道添加 $thread 个空行
for i in `seq $thread`; do
    echo >&8
done

for i in {1..254}; do
    read -u 8  # 管道取数，进行管道消费
    {
        ip=10.0.0.$i
        ping -c1 -W1 $ip &>/dev/null
        if [ $? -eq 0 ]; then
            echo "$ip is up."
        else
            echo "$ip is down"
        fi
        echo >&8  # 消费完成，进行管道偿还
    } &
done

wait  # 并发消费
exec 8>&-  # 销毁文件描述符
echo "all finish..."
```

### 2.6 数组

#### 普通数组

**定义数组：**

```bash
# 方法一：一次赋一个值
array1[0]=pear
array1[1]=apple
array1[2]=orange
array1[3]=peach

# 方法二：一次赋多个值
array2=(tom jack alice)
array3=(`cat /etc/passwd`)
array4=(`ls /var/ftp/Shell/for*`)
array5=(tom jack alice "bash shell")
colors=($red $blue $green)
array5=(1 2 3 4 5 6 7 "linux shell" [20]=saltstack)
```

**查看数组：**

```bash
declare -a
declare -a array1='([0]="pear" [1]="apple" [2]="orange" [3]="peach")'
```

**访问数组元素：**

```bash
echo ${array1[@]}           # 访问数组中所有元素
echo ${array1[0]}           # 访问数组中的第一个元素
echo ${#array1[@]}          # 获取数组元素的个数
echo ${!array2[@]}          # 获取数组元素的索引
echo ${array1[@]:1}         # 从数组下标 1 开始
echo ${array1[@]:1:2}       # 从数组下标 1 开始，访问两个元素 - 切片访问
unset array[2]              # 清除元素
unset array                 # 清空整个数组
```

**遍历数组：**

```bash
# 方法一：通过数组元素的个数进行遍历
for i in ${!array[@]}; do
    echo "$i: ${array[i]}"
done

# 方法二：通过数组元素的索引进行遍历
for i in "${!array[@]}"; do
    echo "Index $i: ${array[i]}"
done
```

#### 关联数组

**定义关联数组：**

```bash
# 申明关联数组变量
declare -A ass_array1
declare -A ass_array2

# 方法一：一次赋一个值
ass_array1[index1]=pear
ass_array1[index2]=apple
ass_array1[index3]=orange
ass_array1[index4]=peach

# 方法二：一次赋多个值
ass_array2=([index1]=tom [index2]=jack [index3]=alice [index4]='bash shell')
```

**访问数组元素：**

```bash
echo ${ass_array2[index2]}     # 访问数组中的第二个元素
echo ${ass_array2[@]}          # 访问数组中所有元素
echo ${#ass_array2[@]}         # 获得数组元素的个数
echo ${!ass_array2[@]}         # 获得数组元素的索引
```

**遍历数组：**

```bash
for i in "${!ass_array2[@]}"; do
    echo "Index $i: ${ass_array2[i]}"
done
```

### 2.7 函数

**定义函数：**

```bash
# 方法一：
函数名 () {
    函数要实现的功能代码
}

# 方法二：
function 函数名 {
    函数要实现的功能代码
}
```

**调用函数：**

```bash
函数名
函数名 参数 1 参数 2
```

**传参与返回值：**

```bash
# 传参 $1,$2
# 变量 local
# 返回值 return $?
```

**示例 1：**

```bash
#!/usr/bin/env bash
# f0.sh

add () {
    let sum=$1+$2
    echo "$sum"
}

add $1 $2

# 执行：bash f0.sh 10 20
# 输出：30
```

**示例 2：**

```bash
#!/usr/bin/env bash
# f1.sh

add () {
    let sum=$sum1+$sum2
    echo "$sum"
}

sum1=10
sum2=20
add

# 执行：bash f1.sh
# 输出：30
```

**局部变量与全局变量：**

1. shell 脚本中定义的变量是 global 的，作用域从被定义的地方开始，一直到 shell 结束或者被显示删除的地方为止。
2. shell 函数定义的变量也是 global 的，其作用域从函数被调用执行变量的地方开始，到 shell 结束或者显示删除为止。
3. 函数定义的变量可以是 local 的，其作用域局限于函数内部。但是函数的参数是 local 的。
4. 如果局部变量和全局变量名字相同，那么在这个函数内部，会使用局部变量。

### 2.8 Shell 内置命令

#### 占位符

```bash
if [ ]; then
    :
fi
```

#### break

```bash
#!/usr/bin/bash
for i in {A..D}; do
    echo -n $i
    for j in {1..9}; do
        if [ $j -eq 5 ]; then
            break
        fi
        echo -n $j
    done
    echo
done

# 输出：
# A1234
# B1234
# C1234
# D1234
```

#### continue

```bash
#!/usr/bin/bash
for i in {A..D}; do
    echo -n $i
    for j in {1..9}; do
        if [ $j -eq 5 -o $j -eq 6 -o $j -eq 7 -o $j -eq 8 -o $j -eq 9 ]; then
            continue
        fi
        echo -n $j
    done
    echo
done

# 输出：
# A1234
# B1234
# C1234
# D1234
```

#### shift

```bash
#!/usr/bin/bash
while [ $# -ne 0 ]; do
    let sum+=$1
    shift 1
done
echo "sum: $sum"

# 执行：bash shift.sh 1 2 3
# 输出：sum: 6
```

### 2.9 正则表达式

#### 什么是正则表达式

正则表达式（regular expression, RE）是一种字符模式，用于在查找过程中匹配指定的字符。

**匹配数字：**

```regex
^[0-9]+$
```

**匹配 Mail：**

```regex
[a-z0-9_]+@[a-z0-9]+\.[a-z]+
```

**匹配 IP：**

```regex
[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}
```

#### 元字符

**基本正则表达式元字符：**

| 元字符 | 功能 | 示例 |
|--------|------|------|
| `^` | 行首定位符 | `^love` |
| `$` | 行尾定位符 | `love$` |
| `.` | 匹配单个字符 | `l..e` |
| `*` | 匹配前导符 0 到多次 | `ab*love` |
| `.*` | 任意多个字符 | `.*` |
| `[]` | 匹配指定范围内的一个字符 | `[lL]ove` `[a-z0-9]` |
| `[^]` | 匹配不在指定组内的字符 | `[^a-z0-9]ove` |
| `\<` | 词首定位符 | `\<love` |
| `\>` | 词尾定位符 | `love\>` |
| `\(\)` | 匹配稍后使用的字符的标签 | `\(abc\)\1` |
| `x\{m\}` | 字符 x 重复出现 m 次 | `o\{5\}` |
| `x\{m,\}` | 字符 x 重复出现 m 次以上 | `o\{5,\}` |
| `x\{m,n\}` | 字符 x 重复出现 m 到 n 次 | `o\{5,10\}` |

**扩展正则表达式元字符：**

| 元字符 | 功能 | 示例 |
|--------|------|------|
| `+` | 匹配一个或多个前导字符 | `[a-z]+ove` |
| `?` | 匹配零个或一个前导字符 | `lo?ve` |
| `a\|b` | 匹配 a 或 b | `love\|hate` |
| `()` | 组字符 | `(love|hate)` |
| `x{m}` | 字符 x 重复 m 次 | `o{5}` |
| `x{m,}` | 字符 x 重复至少 m 次 | `o{5,}` |
| `x{m,n}` | 字符 x 重复 m 到 n 次 | `o{5,10}` |

**POSIX 字符类：**

| 表达式 | 功能 | 示例 |
|--------|------|------|
| `[:alnum:]` | 字母与数字字符 | `[[:alnum:]]+` |
| `[:alpha:]` | 字母字符 (包括大小写字母) | `[[:alpha:]]{4}` |
| `[:blank:]` | 空格与制表符 | `[[:blank:]]*` |
| `[:digit:]` | 数字字母 | `[[:digit:]]?` |
| `[:lower:]` | 小写字母 | `[[:lower:]]{5,}` |
| `[:upper:]` | 大写字母 | `[[:upper:]]+` |
| `[:punct:]` | 标点符号 | `[[:punct:]]` |
| `[:space:]` | 包括换行符，回车等在内的所有空白 | `[[:space:]]+` |

### 2.10 sed 流编辑器

#### sed 技术概览

sed 是一种在线的、非交互式的编辑器，它一次处理一行内容。处理时，把当前处理的行存储在临时缓冲区中，称为"模式空间"（pattern space），接着用 sed 命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。

#### 命令格式

```bash
sed [options] 'command' file(s)
sed [options] -f scriptfile file(s)
```

#### sed 基本用法

```bash
# 打印所有行
sed -r 'p' /etc/passwd

# 只打印匹配的行
sed -r -n '/root/p' /etc/passwd

# 替换
sed -r 's/root/alice/' /etc/passwd
sed -r 's/root/alice/g' /etc/passwd
sed -r 's/root/alice/gi' /etc/passwd

# 删除
sed -r '/root/d' /etc/passwd
sed -r '\#root#d' /etc/passwd
```

#### sed 扩展

**地址（定址）：**

```bash
# 删除第 3 行
sed -r '3d' /etc/passwd

# 删除 1 到 3 行
sed -r '1,3d' /etc/passwd

# 删除 root 有关的行
sed -r '/root/d' /etc/passwd

# 删除所有奇数行
sed -r '1~2d' /etc/passwd

# 删除所有偶数行
sed -r '0~2d' /etc/passwd
```

**sed 命令：**

| 命令 | 功能 |
|------|------|
| `a` | 在当前行后添加一行或多行 |
| `c` | 用新文本修改（替换）当前行中的文本 |
| `d` | 删除行 |
| `i` | 在当前行之前插入文本 |
| `l` | 列出非打印字符 |
| `p` | 打印行 |
| `n` | 读入下一输入行 |
| `q` | 结束或退出 sed |
| `!` | 对所选行以外的所有行应用命令 |
| `s` | 用一个字符串替换另一个 |
| `r` | 从文件中读 |
| `w` | 将行写入文件 |
| `y` | 将字符转换为另一字符（不支持正则表达式） |
| `h` | 把模式空间里的内容复制到暂存缓冲区 (覆盖) |
| `H` | 把模式空间里的内容追加到暂存缓冲区 |
| `g` | 取出暂存缓冲区的内容，将其复制到模式空间，覆盖该处原有内容 |
| `G` | 取出暂存缓冲区的内容，将其复制到模式空间，追加在原有内容后面 |
| `x` | 交换暂存缓冲区与模式空间的内容 |

**选项：**

| 选项 | 功能 |
|------|------|
| `-e` | 允许多项编辑 |
| `-f` | 指定 sed 脚本文件名 |
| `-n` | 取消默认的输出 |
| `-i` | inplace，就地编辑 |
| `-r` | 支持扩展元字符 |

#### sed 常见操作

```bash
# 删除配置文件中#号注释行
sed -ri '/^#/d' file.conf
sed -ri '/^[ \t]*#/d' file.conf

# 删除无内容空行
sed -ri '/^[ \t]*$/d' file.conf

# 删除注释行及空行
sed -ri '/^[ \t]*#/d; /^[ \t]*$/d' /etc/vsftpd/vsftpd.conf
sed -ri '/^[ \t]*#|^[ \t]*$/d' /etc/vsftpd/vsftpd.conf
sed -ri '/^[ \t]*($|#)/d' /etc/vsftpd/vsftpd.conf

# 修改文件
sed -ri '$a\chroot_local_user=YES' /etc/vsftpd/vsftpd.conf
sed -ri '/^SELINUX=/cSELINUX=disabled' /etc/selinux/config
sed -ri '/UseDNS/cUseDNS no' /etc/ssh/sshd_config
sed -ri '/GSSAPIAuthentication/cGSSAPIAuthentication no' /etc/ssh/sshd_config

# 给文件行添加注释
sed -r '2,6s/^/#/' a.txt
sed -r '2,6s/(.*)/#\1/' a.txt
sed -r '2,6s/.*/#&/' a.txt  # &匹配前面查找的内容

# sed 中使用外部变量
var1=11111
sed -ri "3a$var1" /etc/hosts
sed -ri "$a$var1" /etc/hosts
```

### 2.11 awk 文本处理

awk 是一个强大的文本分析工具，相对于 grep 的查找，sed 的编辑，awk 在其对数据分析并生成报告时，显得尤为强大。

#### awk 工作原理

awk 的工作方式是逐行读取文件，将每一行按照指定的分隔符进行分割，然后执行指定的动作。

#### awk 内部变量

| 变量 | 描述 |
|------|------|
| `FS` | 输入字段分隔符，默认为空格或 Tab |
| `OFS` | 输出字段分隔符，默认为空格 |
| `RS` | 输入记录分隔符，默认为换行符 |
| `ORS` | 输出记录分隔符，默认为换行符 |
| `NR` | 当前记录数（行号） |
| `FNR` | 当前文件的记录数（行号） |
| `NF` | 当前记录的字段数 |

#### awk 示例

```bash
# 打印第一列
awk '{print $1}' file.txt

# 打印第 1 列和第 3 列
awk '{print $1, $3}' file.txt

# 使用自定义分隔符
awk -F: '{print $1}' /etc/passwd

# 条件过滤
awk -F: '$3 > 1000 {print $1}' /etc/passwd

# 统计行数
awk 'END {print NR}' file.txt

# 统计某列的和
awk '{sum+=$1} END {print sum}' file.txt

# 打印表头和数据
awk -F, 'NR==1 {print "Header: "$0} NR>1 {print "Data: "$0}' data.csv
```

---

## 第 3 章 实战脚本

### 3.1 GitLab 备份转存脚本

```bash
#!/bin/env bash
#*************************************
# Author: hjs2015
# Email: 1656126280@qq.com
# Version: 1.0
# Created Time: 2022-07-20 14:32:53
# Description: 备份转存 gitlab 上的备份到远程，清理本地备份
# License: MIT
# GitHub: https://github.com/hjs2015/shell-notes
#*************************************

source /etc/profile

# 本地路径 (备份的源路径)
local_path="/data/gitlab-config-backups /data/gitlab-backups"

# 备份路径 (备份的目标路径)
backup_path="/backup/archive/gitlab.example.com"

# 备份的保留天数 - 本地 n 天
# 3 ==> 保留 1 个备份
# 4 ==> 保留 2 个备份
backup_reserve_local_number="3"

# 备份的保留天数 - 远程 n 天
backup_reserve_remote_number="14"

## 备份
for i in ${local_path}; do
    [ ! -d ${i} ] && continue
    
    for ii in `ls -lt $i|tail -n +${backup_reserve_local_number}|awk -v aaaaa=$i '{print aaaaa"/"$NF}'`; do
        [ -d ${backup_path}${i} ] || mkdir -p ${backup_path}${i}
        \mv ${ii} ${backup_path}${i}
        echo "${i} ${ii}"
    done
done

## 清理备份数目
for i in ${local_path}; do
    [ ! -d ${backup_path}${i} ] && continue
    
    for ii in $(ls -t ${backup_path}${i}|sed -n "${backup_reserve_remote_number},100p"); do
        [ -f ${backup_path}${i}/${ii} ] && rm -f ${backup_path}${i}/${ii}
    done
done
```

### 3.2 求某年的某月有多少天

```bash
#!/bin/bash
cal_days_in_month() {
    n_year=`expr $1 + 0`
    n_month=`expr $2 + 0`
    n_day=0
    
    case $n_month in
        1|3|5|7|8|10|12)
            n_day=31
            ;;
        4|6|9|11)
            n_day=30
            ;;
        2)
            if [ `expr $n_year % 4` -eq 0 ]; then
                if [ `expr $n_year % 400` -eq 0 ]; then
                    n_day=29
                elif [ `expr $n_year % 100` -eq 0 ]; then
                    n_day=28
                else
                    n_day=29
                fi
            else
                n_day=28
            fi
            ;;
    esac
    
    echo ${n_day}
}

# 调用
cal_days_in_month $1 $2
```

### 3.3 添加公网域名解析到本地 hosts

```bash
#!/bin/env bash
#*************************************
# Author: hjs2015
# Email: 1656126280@qq.com
# Version: 1.0
# Created Time: 2025-02-19 17:02:45
# Description: 自动解析域名并更新/etc/hosts 文件
# License: MIT
# GitHub: https://github.com/hjs2015/shell-notes
#*************************************

source /etc/profile

# 定义要查询的域名和 DNS 服务器
DOMAINS=("api.dingtalk.com" "oapi.dingtalk.com")
DNS_SERVER="101.226.4.6"
HOSTS_FILE="/etc/hosts"

# 函数：更新单个域名的 IP 地址信息
update_domain() {
    local DOMAIN="$1"
    
    # 使用 nslookup 获取域名的 IPv4 地址
    IP_ADDRESS=$(nslookup $DOMAIN $DNS_SERVER | awk '/^Address: [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ {print $2}')
    
    # 检查是否成功获取 IP 地址
    if [ -z "$IP_ADDRESS" ]; then
        echo "无法解析域名 $DOMAIN 或没有返回有效的 IPv4 地址。"
        exit 1
    fi
    
    echo "${DOMAIN} 解析到的 IP 地址：$IP_ADDRESS"
    
    # 检查 HOSTS_FILE 文件中是否已存在该域名
    if ! grep -q "$DOMAIN" $HOSTS_FILE; then
        # 如果域名不存在于文件中，则添加新的条目
        echo "域名 $DOMAIN 不存在于 $HOSTS_FILE 中，添加新的条目。"
        for IP_ADDRESS_Detail in $IP_ADDRESS; do
            echo "$IP_ADDRESS_Detail $DOMAIN" | sudo tee -a $HOSTS_FILE > /dev/null
        done
    else
        # 如果域名存在于文件中，则更新相关条目
        echo "域名 $DOMAIN 存在于 $HOSTS_FILE 中，更新相关条目。"
        
        # 检查外网解析的 IP 地址是否存在于文件中，如果不存在则添加
        for IP_ADDRESS_Detail in $IP_ADDRESS; do
            found=false
            for Host_Exist_IP in $(grep " $DOMAIN$" $HOSTS_FILE 2>&1|awk '{print $1}'|grep -Eio "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"); do
                if [ "$IP_ADDRESS_Detail" == "$Host_Exist_IP" ]; then
                    found=true
                    break
                fi
            done
            if [ "$found" != "true" ]; then
                echo "$IP_ADDRESS_Detail $DOMAIN" | sudo tee -a $HOSTS_FILE > /dev/null
            fi
            found=''
        done
        
        # 检查文件中存在的 IP 地址是否在外网解析中，如果不存在则删除
        for Host_Exist_IP in $(grep " $DOMAIN$" $HOSTS_FILE 2>&1|awk '{print $1}'|grep -Eio "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"); do
            found=false
            for IP_ADDRESS_Detail in $IP_ADDRESS; do
                if [ "$Host_Exist_IP" == "$IP_ADDRESS_Detail" ]; then
                    found=true
                    break
                fi
            done
            if [ "$found" != "true" ]; then
                sed -i "/${Host_Exist_IP}.* ${DOMAIN}/d" $HOSTS_FILE
            fi
            found=''
        done
    fi
}

# 遍历每个域名并调用更新函数
for DOMAIN in "${DOMAINS[@]}"; do
    update_domain "$DOMAIN"
done

echo "操作完成。/etc/hosts 文件已更新。"
```

---

## 附录：常用命令速查

### 文件测试

```bash
[ -e file ]   # 是否存在
[ -f file ]   # 是否是文件
[ -d dir ]    # 是否是目录
[ -r file ]   # 是否可读
[ -w file ]   # 是否可写
[ -x file ]   # 是否可执行
[ -L file ]   # 是否符号链接
```

### 数值比较

```bash
[ $a -gt $b ]   # 大于
[ $a -lt $b ]   # 小于
[ $a -eq $b ]   # 等于
[ $a -ne $b ]   # 不等于
[ $a -ge $b ]   # 大于等于
[ $a -le $b ]   # 小于等于
```

### 字符串比较

```bash
[ "$a" = "$b" ]     # 等于
[ "$a" != "$b" ]    # 不等于
[ -z "$a" ]         # 空字符串
[ -n "$a" ]         # 非空字符串
```

### 逻辑运算

```bash
[ 条件 1 -a 条件 2 ]    # 与 (and)
[ 条件 1 -o 条件 2 ]    # 或 (or)
[[ 条件 1 && 条件 2 ]]  # 与 (and)
[[ 条件 1 || 条件 2 ]]  # 或 (or)
! 条件                  # 非 (not)
```

---

## 学习资源

### 在线学习网站

| 网站名称 | 网址 | 说明 |
|---------|------|------|
| 菜鸟教程 | https://www.runoob.com/linux/linux-shell.html | 适合初学者的 Shell 入门教程 |
| Linux 中国 | https://linux.cn/ | Linux 技术社区，大量 Shell 实战文章 |
| 博客园 | https://www.cnblogs.com/ | 搜索"Shell 编程"有很多优质博文 |
| GitHub | https://github.com/topics/shell-script | 开源 Shell 脚本项目和示例 |
| Stack Overflow | https://stackoverflow.com/questions/tagged/bash | Shell 编程问题解答 |

### 在线练习平台

| 平台名称 | 网址 | 说明 |
|---------|------|------|
| OnlineGDB | https://www.onlinegdb.com/online_bash_shell | 在线编写和运行 Shell 脚本，无需安装环境 |
| Repl.it | https://replit.com/languages/bash | 在线 Bash 编辑器，支持保存和分享代码 |
| ShellCheck | https://www.shellcheck.net/ | 在线检查 Shell 脚本语法错误，给出改进建议 |
| Exonum Bash Playground | https://exonum.com/bash-playground/ | 交互式 Bash 练习环境 |
| Katacoda | https://www.katacoda.com/courses/linux | 基于浏览器的 Linux 和 Shell 实战场景 |

### 推荐书籍

- 《Linux 命令行与 shell 脚本编程大全》- 经典入门书籍
- 《UNIX Shell 编程》- 系统学习 Shell 编程
- 《Advanced Bash-Scripting Guide》- 免费在线教程（英文）

### 官方文档

- GNU Bash 手册：`man bash` 或 https://www.gnu.org/software/bash/manual/
- Linux 命令大全：`man [command]` 或 https://man7.org/linux/man-pages/

### 实践建议

- 本教程基于实际工作经验总结
- 建议配合实践练习，边学边做
- 参考官方文档：`man bash`, `man test`, `man sed`, `man awk`
- 更多实战脚本请参考本仓库的 `00_quickstart/` 到 `06_real_world/` 目录

---

**版本：** 1.0  
**作者：** hjs2015  
**GitHub：** https://github.com/hjs2015/shell-notes

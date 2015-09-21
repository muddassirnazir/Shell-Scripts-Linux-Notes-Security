#!/bin/bash
echo "Enter a username"
read user
a=`cut -d: -f1 /etc/passwd | grep $user`

if [ $user == $a ]
then 
echo "$user is present"
else
echo "$user is present"
fi

#!/bin/bash
for user in linux muddassir ubuntu grras developer
do 
a=`grep ^$user: /etc/passwd`
if [ ! -z "$a" ]
then
echo $user exists
else
useradd $user && echo redhat | passwd $user --stdin
fi
done

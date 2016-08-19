#!/bin/bash
echo -e "Enter a user name:\t"
read user
a=`grep ^$user: /etc/passwd`
#if [ ! -z "$a" ]
if [ "$?" -eq "0" ]
 then
    oldifs=$IFS
    IFS=":"
    read -r _user _link  _uid _gid _comment _homedir _shell <<< "$a"
    echo -e "User $user is present\n"
    echo -e "-----------Details -------------\n"
    echo -e "user name:- \t $_user"
    echo -e "uid      :- \t $_uid"
    echo -e "gid      :- \t $_gid"
    echo -e "home dir :- \t $_homedir" 
    echo -e "bash name:- \t $_shell"
else 
    echo "User $user is not present"
    exit 1
fi

#!/bin/bash 

#Print the User details if the user is present
#The user must not have the id of less than 500
#The script when run by a user should have execute command
#Add fields : passwd expiry, Number of times passwd can be changed in day

echo -e "Enter a user name: \t"
read user
a=`grep ^$user: /etc/passwd`
b=`grep ^user: /etc/shadow`
#if [ ! -z "$a" ]
if [ "$?" -eq "0" ]
 then
    oldifs=$IFS
    IFS=":"
     read -r _user _link  _uid _gid _comment _homedir _shell <<< "$a"
     read -r _user _passwd _last _min _expire _warning _blank1 _blank2 <<< "$b"
           if [ ["$_uid" -gt 500 ] && [! -z "$b" ] ]
     		then 
		     echo -e "User $user is present\n"
		     echo -e "-----------Details -------------\n"
		     echo -e "user name:- \t $_user"
		     echo -e "uid      :- \t $_uid"
		     echo -e "gid      :- \t $_gid"
		     echo -e "home dir :- \t $_homedir" 
		     echo -e "Shell name:- \t $_shell"
		     echo -e "Last Password Change since 1 Jan 1970 : $_last"
		     echo -e "Password Expires in : $_expire days"
		     echo -e "Warning to change password is $_warning days before password expires"
	   
else 
     echo "Eihter user is not present or user id is greater than 500"
     exit 1
fi

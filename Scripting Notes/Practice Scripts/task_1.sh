#!/bin/bash

user_check()
 {
  read -p "Enter user name" a 
  id $a $> /dev/null
  if [ "$?" == 0 ]
  then 
  echo "User exists"
  else
  echo "User doesn't exists"
  fi
 }

echo -e "1) Add User \n 2) Delete a user \n 3)Modify a User \n"
read -p "Enter your choice" opt

case $opt in 
1



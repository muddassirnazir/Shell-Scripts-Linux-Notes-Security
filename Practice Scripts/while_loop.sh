#!/bin/bash

#while loop

while [ $# != 0 ]
do 
case $1 in
-f)
echo "Your file option is $2"
shift 2
;;
-l) echo "Your user list is $2"
shift 2
;;
*) echo "Enter correct choice"
;;
esac
done



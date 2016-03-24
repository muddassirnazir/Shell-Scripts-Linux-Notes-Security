##!/bin/bash

read -t 5 -s -p   " Enter your password " a
read -p " Enter second value " b
echo "$a $b"
read -r a b c
echo -e  "$a \n $b \n $c "

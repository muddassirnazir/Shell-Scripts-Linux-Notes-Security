#!/bin/bash
echo enter numbers
read a
b=1
while test $b -le 10
do
c=`expr $a \* $b`
echo $a .. $b za = $c
b=`expr $b + 1`
done

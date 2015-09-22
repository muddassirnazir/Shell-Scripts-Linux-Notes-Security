#!/bin/bash
echo enter no.
read n

n1=$n
rev=0
while test $n -gt 0
do
rem=`expr $n % 10`
rev=`expr $rev \* 10 + $rem`
n=`expr $n / 10`
done
if test $n1 -ne $rev
then
echo no. is not palindrome
else
echo no. is palindrome
fi

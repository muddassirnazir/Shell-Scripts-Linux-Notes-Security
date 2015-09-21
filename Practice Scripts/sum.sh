#!/bin/bash
echo Enter two numbers 
read a 
read b
echo Final Result is
c=$(($a+$b))
echo $c
let d=$a+$b 
echo $d

e=`expr $a + $b`
echo $e



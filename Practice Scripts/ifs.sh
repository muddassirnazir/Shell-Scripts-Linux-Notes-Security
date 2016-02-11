#!/bin/bash
a=`hostname`
oldifs=$IFS
IFS="."
read -r x y z <<< "$a"
echo "system $x"
echo "domain $y"
echo "domain2 $z"

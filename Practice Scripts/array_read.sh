#!/bin/bash

loadarray()
{
 i=0
 while read line
 do
 file[i]=$line
 i=$((i+1))
 done < $1
}
loadarray $1
echo ${#file[*]}
echo ${file[*]}

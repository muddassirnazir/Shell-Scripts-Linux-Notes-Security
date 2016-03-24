#!/bin/bash
echo enter no.
read n
for((i=1;i<=n;i++))
do
for((j=1;j<=i;j++))
do
echo -ne '*'
done
echo
done

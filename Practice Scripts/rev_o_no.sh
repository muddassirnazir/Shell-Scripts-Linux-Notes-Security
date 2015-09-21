echo enter a no.
read n
rev=0
while test $n -ne 0
do
rem=`expr $n % 10`
rev=`expr $rev \* 10 + $rem`
n=`expr $n / 10`
done
echo reverse of the given no. is $rev


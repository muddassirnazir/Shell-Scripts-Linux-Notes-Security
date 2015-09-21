echo enter the marks of first sub
read a
echo enter the marks of second sub
read b
echo enter the marks of third sub
read c

d=`expr $a + $b + $c`
avg=`expr $d / 3`

f=`expr $avg`

echo percentage is $f %

if test $f -ge 75
then 
echo honors
fi

if test $f -lt 75 -a -ge 60
then 
echo first division
fi

if test $f -lt 60
then 
echo second division 
fi
  

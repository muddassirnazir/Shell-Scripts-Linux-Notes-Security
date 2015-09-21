echo enter no.1 
read a
echo enter no.2
read b
echo choice 1 --add
echo choice 2 --subtract
echo choice 3 --multiply
echo choice 4 --divide
echo enter your choice
read ch
case $ch in
1) echo add is `expr $a + $b`;;
2) echo sub is `expr $a - $b`;;
3) echo mult is  `expr $a \* $b`;;
4) echo `expr $a / $b`;;
*) echo wrong choice;;
esac 

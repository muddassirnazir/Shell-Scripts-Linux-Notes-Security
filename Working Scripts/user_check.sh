user_check()
	{
	#read -p "Enter user name" a 
	a=$1 	
	id $a &> /dev/null
	if [ "$?" == 0 ]
	then 
	echo "User exists"
	else
	echo "User doesn't exists"
	fi
	}

user_check root 


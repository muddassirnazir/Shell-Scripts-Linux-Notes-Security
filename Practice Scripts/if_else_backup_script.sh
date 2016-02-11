#!/bin/bash
day=`date +%A`
if [ $day  == "Sunday" ] && [ ! -f "/var/backup/`date +%m%d%y`.gz.tar" ] 
then
 	if [ -d /var/backup ]
		then 
			echo "backup started"
			tar -czf /var/backup/`date +%m%d%y`.gz.tar /home/ && echo "backup created sussessfully" || echo "sorry there is some error"
	else 
			mkdir /var/backup
			tar -czf /var/backup/`date +%m%d%y`.gz.tar /home/ && echo "backup created sussessfully" || echo "sorry there is some error"
	fi
else 
echo "sorry today is not sunday or file already there"
fi


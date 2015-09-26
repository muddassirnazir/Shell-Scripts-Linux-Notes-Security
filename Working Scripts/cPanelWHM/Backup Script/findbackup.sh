#! /bin/sh
#
#  findbackup
#    Produce a sorted list (by date, earliest first) of available cpanel full
#    backups.
#    For use from configserver explorer or shell.
#
#

ME=${0##*/}
tmp=/tmp/findbackup.$$
lsopt=-l

if [ $# = 0 ]
then
    echo "Usage: $ME [-s] username"
    echo "OR  $ME part-username"
    echo Produces a sorted listing of available cpanel full backups for username
    echo " -s displays only filenames"
    exit 1
fi
if [ "$1" = "-s" ]
then
    lsopt=
    shift
fi

for dir in /backup/cp* /backup/deleted /backup/keep /backup/tmp
do
    if [ -d $dir ]
    then
	backups="$backups $dir"
    fi
done

files=$(find $backups -name "*$1*")
for dir in /home /home2 /home/cprestore /home2/cprestore
do
    [ ! -d $dir ] && continue
    for n in $dir/cpmove-*$1*
    do
	if [ -f "$n" ]
	then
	    files="$files $n"
	fi
    done 2>/dev/null
done

if [ "$files" = "" ]
then
    echo -- NO BACKUPS FOUND FOR USERNAME $1
    echo -- checking domain names for possible matches
    #  grep snow /etc/userdom* |  sort -u +1
    #grep "$1" /etc/userdomains /etc/userdomains.deleted | sort -u +1 |
    cat /etc/userdomains /etc/userdomains.deleted | grep "$1" |
	sort -u +1 > $tmp
    while IFS=":$IFS" read domain user
    do
	echo found username $user for domain $domain
        filestmp=$(find $backups -name "*${user}*")
	files="$files $filestmp"
    done < $tmp
    rm -f $tmp
fi

if [ "$files" != "" ]
then
    #
    #   The /dev/null stuff is to prevent ls -l of empty directories
    #   ... not really needed now we test for empty $files
    #
    ls -dt $lsopt $files /dev/null | grep -v /dev/null

    if [ "$string" != "" ]
    then
        echo "Finding $string ...."
	echo
	tmp=/tmp/findbackup1.$$
	trap "rm -f $tmp;exit 1" 0 1 2 3 15
	for n in $files
	do
	    tar tvzf $n > $tmp
	    if grep -q "$string" $tmp
	    then
	        echo "File: $n"
		grep "$string" $tmp
		echo
	    fi
	done
	rm -f $tmp
	trap 0 1 2 3 15
    fi
fi

exit 0

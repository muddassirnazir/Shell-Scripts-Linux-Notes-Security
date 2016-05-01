#!/bin/bash

#This script will flush the blocked IP addresses from CSF firewall on a routine basis.
#This is helpful if you do not have the physical access to your server and you are 
#getting blocked due to some reason.
#The drawback is that when the IP addresses are flushed, all the blocked IP 
#(suspicious IP/ attackers/ brute forcers) are also unblocked.
#Best solution is to have a static IP so that you can whitelist only that.

echo "Flushing ips from csf.deny"
/usr/sbin/csf -tf
/usr/sbin/csf -df
exit

#Cron job

0 */1 * * * /sbin/ip_flush.sh > /dev/null 2>&1

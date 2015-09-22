#!/bin/bash

echo "Flushing ips from csf.deny"
/usr/sbin/csf -tf
/usr/sbin/csf -df
exit


#Cron job

0 */1 * * * /sbin/ip_flush.sh > /dev/null 2>&1

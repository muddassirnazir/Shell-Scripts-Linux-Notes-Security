#!/bin/bash
#=============================================================================
# Multi DNSBL check - rblcheck.sh
#
# rblcheck.sh checks multiple IP addresses against multiple DNS Block Lists
#
# By default, it checks all non-private IP addresses on the machine it is run
# from against a default list of DNSBLs -- SpamCop, SpamHaus and SORBS
#
# If the file /etc/dnsbliplist exists, IP addresses will be read (one per line)
# from it instead.
#
# If the file /etc/dnsblacklists exists, DNSBL entries will be read (one per 
# line) from it.
#
# Comments starting with @# are allowed in the IP list and DNS block list.
# Entries in the block list are whitespace delimited. The string "IP" is
# replaced in the URL with the IP address that has been blocked when reporting
# a block.
# Format of the DNS block list file is:
#   BlocklistName   BlocklistDNSServer   URL
#
# If no IP addresses are blocked, it will run silently and return 0.
# For each IP address blocked, it will output the blocked IP address, the DNSBL
# name, and the URL for the blocklist. If any IP address has been blocked, it
# returns 1.
#
# This script can be invoked manually (e.g. `./rblcheck.sh'), but was designed
# to be run via cron (by placing it in /etc/cron.hourly/ or similar). 
#=============================================================================
PATH="/usr/local/sbin:/usr/local/bin:$PATH"
iplist=/etc/dnsbliplist
dnsbllist=/etc/dnsblacklists

#
#   Work out what IPs we have active
#
if [ -s $iplist ]
then
	ips=`grep -vE '(^ *#|^ *$)' $iplist`
else
	ips=`ifconfig -a |
	  sed -e '/inet addr/! d' \
	  -e '/Bcast/! d' \
	  -e 's/  *Bcast.*//' \
	  -e 's/.*://'`	
fi
[ "$debugip" != "" ] && ips="$debugip $ips"


#
#   Get list of DNSBLs to check
#   Comments are removed later
#
if [ -s $dnsbllist ]
then
	blacklists=$(< $dnsbllist)
else
	blacklists="
	SORBS   dnsbl.sorbs.net		www.au.sorbs.net/lookup.shtml
	SpamCop bl.spamcop.net		www.spamcop.net/w3m?action=checkblock&ip=IP
	SpamHaus_Zen   zen.spamhaus.org www.spamhaus.org/lookup.lasso
	"
fi

exitStatus=0

#
#   Now actually do the checking
#
for ip in $ips
do
	# Skip private IPs
	case "$ip" in
	10.*)		continue;;
	127.0.0.2)	;; # allow SpamCop test IP
	127.*)		continue;;
	192.168.*)	continue;;
	169.254.*)	continue;;
	esac

	# 203.1.2.3 --> 3.2.1.203
	reverseip=`echo -n ${ip}. | tac -s'.'`

	echo "$blacklists" |
	  grep -vE '(^ *#|^ *$)' |
	  while read blName blDNS blURL
	  do
		[ "$blName" = "" ] && continue
		if result=`host -t A ${reverseip}${blDNS}`
		then
			# IP is listed
            exitStatus=1
			bl="http://$(echo "$blURL" | sed -e "s/IP/$ip/g")"
			echo "${ip} is listed in ${blName}  -- see $bl"
			echo $result
		fi
	  done
done

exit $exitStatus

# end

#! /bin/sh
#==============================================================================
# CpMR
#  Cpanel coldMetal save and Restore
#
#   Makes a complete rsync copy of a cpanel system for recovery purposes
#   Can be used for a bare metal backup (to restore on top of a cpanel system).
#   This is deliberately a very simple script with a little configurability.
#
#   Usage:
#      cpmr     	- makes a local backup
#      cpmr target:	- makes a backup to host target via rsync
#
#   If you use the second form, you must setup a passwordless login for rsync
#   to use, or run cpmr by hand and enter the password.  How to setup
#   passwordless rsync isn't described here, yet.
#
#   If you use this script, take note that you agree to carefully check it for
#   validity before you use it; we take no responsibility for it.
#   If you use this script, please acknowledge that by sending us a postcard
#   at cpmr - whitedoggreenfrog - com (1st - is @, 2nd - is .).
#
#   If you need to customize the script, we recommend using the
#   cpmr.local.hostname settings file rather than modifying this file;
#   that way if a new version comes out it's really easy to update.
#
#   Note: We do intend to add some recovery functionality, but that's a lot
#   more complex.  For now, just rsync on top of a running system.  Make a
#   cpmr backup first if you like; and shut down as many services as possible
#   first.
#
#   Author: Brian Coogan, White Dog Green Frog, Sept-Oct 2008.
#   Hereby placed in the Public Domain; but please retain the authorship notes.
#
#==============================================================================

HOST=$(hostname)
target=/backup/recovery/$HOST
case "$1" in
*:)
    target="$1$target"
    shift
    ;;
esac

#
#   Include extra dirs/files only if they exist
#
for x in /var/local /usr/mailscanner/etc /usr/local/bin \
	/etc/staticroutes /var/lib/pgsql 
do
    [ -d $x ] && extras="$extras $x"
done

#
#   The main files/directories list
#
files="
  --exclude /home/virtfs/
  --exclude /var/cpanel/sessions/
  /usr/local/apache/conf
  /var/named
  /usr/local/cpanel
  /scripts
  /var/lib/mysql
  /var/cpanel
  /usr/share/ssl
  /usr/local/cpanel/3rdparty/mailman
  /var/log/bandwidth
  /usr/local/frontpage
  /var/spool/cron
  /etc/secondarymx
  /etc/vdomainaliases

  /etc/secondarymx 
  /etc/valiases 
  /etc/vfilters 
  /etc/exim* 
  /etc/proftpd* 
  /etc/pure-ftpd* 
  /etc/passwd* 
  /etc/group* 
  /etc/*domain* 
  /etc/*named* 
  /etc/wwwacct.conf 
  /etc/cpupdate.conf 
  /etc/quota.conf 
  /etc/shadow* 
  /etc/*rndc* 
  /etc/ips* 
  /etc/ipaddrpool* 
  /etc/ssl 
  /etc/hosts 
  /etc/userdomains 
  /etc/trueuserdomains 
  /etc/trueuserowners 
  /etc/nameserverips 
  /etc/demousers 
  /etc/localaliases
  /etc/myaliases
  /etc/sysconfig/network
  /etc/vmail
  /home
  /usr/local/apache/domlogs
"

# rsync --delete-during requires 2.6.4 or later, so check before using
# NB: off-system target may not be compatible but we can't test that;
# if needed, reset delopt in cpmr.local.$HOST.
delopt=--delete-after
if rsync --help 2>&1 | grep -q delete-during
then
    delopt=--delete-during
fi

# Allow host-specific config eg: in $ZOPT - eg: -z for long haul backups
# or remove delopt
[ -s cpmr.local.$HOST ] && . cpmr.local.$HOST

time eval rsync -R -a $ZOPT --stats $delopt -e "'ssh -p 20022'" \
	$* $files $extras $target

exit 0

# - End -

#!/bin/bash
# Script to upgrade MySQL on a cPanel server without breaking the php.

# To execute:
# 1) Upload the script to your server
# 2) Set its permissions to 755 or 700
# 3) Execute it as root:

# ./upgrade_mysql.sh <target_version> [--runeasy]
################################################

# Are you root?
if [ "$(id -u)" != "0" ]; then
    echo "You must be root to run this script"
    exit 1
fi

CPANEL_VERSION=$(cat /usr/local/cpanel/version | cut -d. -f2)
CURRENT_VERSION=$(mysql -V |awk '{print $5}' |cut -d. -f1,2)

# Get the target version
if [ -z $1 ] || [[ $1 != '5.0' && $1 != '5.1' && $1 != '5.5' && $1 != '5.6' ]]; then
    echo "Please specify a target version: 5.0, 5.1, 5.5, or 5.6"
    exit 1
fi

# Check for incompatible versions
if [ $1 == "5.5" ] && [ "$CPANEL_VERSION" -lt 32 ];then
    echo "You must be running cPanel 11.32 or higher to upgrade to MySQL 5.5"
    exit 1
fi

if [ $1 == "5.1" ] && [ "$CPANEL_VERSION" -gt 42 ];then
    echo "This version of MySQL is not supported on 11.44 or higher"
    exit 1
fi

if [ $1 == "5.0" ] && [ "$CPANEL_VERSION" -gt 36 ];then
    echo "This version of MySQL is not supported on 11.38 or higher"
    exit 1
fi

if [ $1 == "5.6" ] && [ "$CURRENT_VERSION" !=  "5.5" ];then
    echo "You must upgrade to MySQL 5.5 before upgrading to 5.6"
    exit 1
fi

if [ $1 == "5.6" ] && [ "$CPANEL_VERSION" -lt 42 ];then
    echo "You must be running cPanel 11.42 or higher to upgrade to MySQL 5.6"
    exit 1
fi

TARGET_VERSION=$1

# This script has only been tested on MySQL 5
if [ "$(echo $CURRENT_VERSION | cut -d. -f1)" != "5" ];then
    echo "This script requires MySQL 5"
    exit 1
elif [ $CURRENT_VERSION == $TARGET_VERSION ]; then
    echo "You are already running MySQL $TARGET_VERSION"
    exit 1
fi

# Define our library versions
if [ $CURRENT_VERSION == "5.0" ];then
    lib=15
elif [ $CURRENT_VERSION == "5.1" ];then
    lib=16
elif [ $CURRENT_VERSION == "5.5" ] || [ $CURRENT_VERSION == "5.6" ];then
    lib=18
fi

ARCH=$(uname -p)
if [ $ARCH == x86_64 ];then
    libdir=/usr/lib64
else
    libdir=/usr/lib
fi

# Copy libaries for old version

echo "Copying libraries for $CURRENT_VERSION ($lib.0.0)"

if [ -f $libdir/libmysqlclient.so.$lib.0.0 ];then
    /bin/cp -f $libdir/libmysqlclient.so.$lib.0.0 /root/
else
    echo "Missing libmysqlclient.so.$lib.0.0"
    exit 1
fi

if [ -f $libdir/libmysqlclient_r.so.$lib.0.0 ];then
    /bin/cp -f $libdir/libmysqlclient_r.so.$lib.0.0 /root/
else
    echo "Missing $libdir/libmysqlclient_r.so.$lib.0.0"
    exit 1
fi

# Fix common issues in my.cnf
echo "Backing up my.cnf to my.cnf.save"

cp -f /etc/my.cnf /etc/my.cnf.save
sed '/safe-show-database/d' -i /etc/my.cnf
sed 's/set-variable\ *\=\ *//g' -i /etc/my.cnf

# Upgrade MySQL

sed '/mysql-version/d' -i /var/cpanel/cpanel.config
echo "mysql-version=$TARGET_VERSION" >> /var/cpanel/cpanel.config

if [ "$CPANEL_VERSION" -lt 36 ];then
    rm -fv /etc/mysqlupdisable
    /scripts/mysqlup
else
    sed '/MySQL[0-5*]/d' -i /var/cpanel/rpm.versions.d/local.versions
    /usr/local/cpanel/scripts/check_cpanel_rpms --fix
fi
# Copy back old libraries

/bin/mv -f /root/libmysqlclient.so.$lib.0.0 $libdir
/bin/mv -f /root/libmysqlclient_r.so.$lib.0.0 $libdir

/bin/ln -sf $libdir/libmysqlclient_r.so.$lib.0.0 $libdir/libmysqlclient_r.so.$lib 
/bin/ln -sf $libdir/libmysqlclient.so.$lib.0.0 $libdir/libmysqlclient.so.$lib

if [ "$2" == "--runeasy" ];then
    /scripts/easyapache --build
else
    echo "Upgrade complete - please run EasyApache"
fi


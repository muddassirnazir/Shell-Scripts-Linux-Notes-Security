Requirements

Your server must be running the following:

* cPanel 11.25 or higher (may work on older versions but has not been tested!)
* MySQL 5.0 or higher
* Root SSH access

Keep in mind that some versions of MySQL are not supported in certain versions of cPanel. Please check for compatibility before running.

It's recommended to make backups of your MySQL databases before upgrading.
Instructions

To execute:

1) Upload/Paste/git the script to your server

2) Set its permissions to 755 or 700

3) Execute it as root:

./upgrade_mysql.sh <target_version> [--runeasy]

Where:

- <target_version>: The major and minor version of MySQL you want to upgrade to (5.0, 5.1, 5.5, 5.6)
- --runeasy: Indicates whether to automatically spawn EasyApache after the update.  

Using --runeasy will run /scripts/easyapache with the --build flag, forcing it to build your last successful profile. Please note that if you are running options that are not compatible with the current version of EA (such as an old PHP version, etc), your build may not be the same. Therefore, you may want to run /scripts/easyapache BEFORE running this script, configure the options you want, then save the profile as your default. This profile will be built automatically.

If MySQL doesn't restart, it's usually because of something in your my.cnf file. Check your error log in /var/lib/mysql/.err, and remove/adjust the problematic value(s). When mysql starts, run the following command:

mysql_upgrade

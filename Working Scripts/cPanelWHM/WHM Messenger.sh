#!/bin/bash
#This script will enable WHM messenger service on your server. 

echo -e 'Enabling CSF messenger service\n'

# Enable CSF messenger service; Add Port 2086 to messenger HTML service; Configure messenger service to run as csfuser
echo -n "Modifying CSF configuration... "
sed -i -e 's/MESSENGER = "0"/MESSENGER = "1"/' -e 's/MESSENGER_USER = "csf"/MESSENGER_USER = "csfuser"/' -e 's/MESSENGER_HTML_IN = "80,2082,2095"/MESSENGER_HTML_IN = "80,2082,2086,2095"/' /etc/csf/csf.conf
echo "Done"

echo -n "Modifying CSF Messenger templates... "
# Remove CSF logo and Hostname from Messenger HTML server index page
sed -i -e '/csf_small.png/d' -e '/HOSTNAME/d' /etc/csf/messenger/index.html

# Remove Hostname from Messenger Text server index page
sed -i -e '/HOSTNAME/d' /etc/csf/messenger/index.text
echo "Done"

echo -n "Adding system user... "
# Add system user - csfuser with no shell, home and locked password
/usr/sbin/useradd -s /bin/false -M -r -c "CSF Messenger service" csfuser
echo 'Done'

# Restart lfd to activate CSF messenger service
/etc/init.d/lfd restart

echo ''

echo "CSF messenger service enabled."

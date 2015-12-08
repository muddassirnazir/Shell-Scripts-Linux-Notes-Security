#Pre login banner is use for sending a warning message before authentication may be relevant for getting legal protection or just give out information to users. 
#The contents of the specified file are sent to the remote user before authentication is allowed. 
#This option is only available for protocol version 2. 
#By default, no banner is displayed (if you are using latest version of Linux/UNIX then you do not have to worry about version issue).

#To enable the warning banner and ensure it is consistent across the system, add or correct the following line in /etc/ssh/sshd_config:

#Banner /etc/issue

grep -qi ^Banner /etc/ssh/sshd_config && \
  sed -i "s/Banner.*/Banner \/etc\/issue/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "Banner /etc/issue" >> /etc/ssh/sshd_config
fi

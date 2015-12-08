#To enable the warning banner and ensure it is consistent across the system, add or correct the following line in /etc/ssh/sshd_config:

#Banner /etc/issue

grep -qi ^Banner /etc/ssh/sshd_config && \
  sed -i "s/Banner.*/Banner \/etc\/issue/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "Banner /etc/issue" >> /etc/ssh/sshd_config
fi

#Only SSH protocol version 2 connections should be permitted. 
#The default setting in /etc/ssh/sshd_config is correct, and can be verified by ensuring that the following line appears:
#"Protocol 2" without quotes or comment at start.

grep -qi ^Protocol /etc/ssh/sshd_config && \
  sed -i "s/Protocol.*/Protocol 2/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "Protocol 2" >> /etc/ssh/sshd_config
fi

#SSH allows administrators to set an idle timeout interval. 
#After this interval has passed, the idle user will be automatically logged out.
#To set an idle timeout interval, edit the following line in /etc/ssh/sshd_config as follows:

#"ClientAliveInterval interval" without quotes and comment at the beginning. 
#The timeout interval is given in seconds. To have a timeout of 15 minutes, set interval to 900.

#If a shorter timeout has already been set for the login shell, that value will preempt any SSH setting made here. 
#Keep in mind that some processes may stop SSH from correctly detecting that the user is idle. 

sshd_idle_timeout_value="300"
grep -qi ^ClientAliveInterval /etc/ssh/sshd_config && \
  sed -i "s/ClientAliveInterval.*/ClientAliveInterval $sshd_idle_timeout_value/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "ClientAliveInterval $sshd_idle_timeout_value" >> /etc/ssh/sshd_config
fi

#Single-user mode is intended as a system recovery method, providing a single user root access to the system by providing a boot option at startup.
#By default, no authentication is performed if single-user mode is selected.

#To require entry of the root password even if the system is started in single-user mode,
#Add or correct the following line in the file /etc/sysconfig/init:

#SINGLE=/sbin/sulogin

grep -q ^SINGLE /etc/sysconfig/init && \
  sed -i "s/SINGLE.*/SINGLE=\/sbin\/sulogin/g" /etc/sysconfig/init
if ! [ $? -eq 0 ]; then
    echo "SINGLE=/sbin/sulogin" >> /etc/sysconfig/init
fi

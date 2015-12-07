#To ensure the SSH idle timeout occurs precisely when the ClientAliveCountMax is set, edit /etc/ssh/sshd_config as follows:
#ClientAliveCountMax 0 

grep -qi ^ClientAliveCountMax /etc/ssh/sshd_config && \
  sed -i "s/ClientAliveCountMax.*/ClientAliveCountMax 0/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "ClientAliveCountMax 0" >> /etc/ssh/sshd_config
fi

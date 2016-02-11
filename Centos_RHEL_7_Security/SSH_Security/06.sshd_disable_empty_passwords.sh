#To explicitly disallow remote login from accounts with empty passwords, add or correct the following line in /etc/ssh/sshd_config:

#PermitEmptyPasswords no

#Any accounts with empty passwords should be disabled immediately.
#Also, PAM configuration should prevent users from being able to assign themselves empty passwords. 

grep -qi ^PermitEmptyPasswords /etc/ssh/sshd_config && \
  sed -i "s/PermitEmptyPasswords.*/PermitEmptyPasswords no/gI" /etc/ssh/sshd_config
if ! [ $? -eq 0 ]; then
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
fi

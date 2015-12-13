#To specify password length requirements for new accounts, 
#edit the file /etc/login.defs and add or correct the following lines:

#PASS_MIN_LEN 14

#The DoD requirement is 14. The FISMA requirement is 12. 
#If a program consults /etc/login.defs and also another PAM module (such as pam_pwquality) 
#during a password change operation, then the most restrictive must be satisfied.

var_accounts_password_minlen_login_defs="6"
grep -q ^PASS_MIN_LEN /etc/login.defs && \
  sed -i "s/PASS_MIN_LEN.*/PASS_MIN_LEN     $var_accounts_password_minlen_login_defs/g" /etc/login.defs
if ! [ $? -eq 0 ]; then
    echo "PASS_MIN_LEN      $var_accounts_password_minlen_login_defs" >> /etc/login.defs
fi

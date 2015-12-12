#To specify password minimum age for new accounts, edit the file /etc/login.defs and add or correct the following line, 
#replacing DAYS appropriately:

#PASS_MIN_DAYS DAYS

#A value of 1 day is considered for sufficient for many environments. The DoD requirement is 1. 

var_accounts_minimum_age_login_defs="7"
grep -q ^PASS_MIN_DAYS /etc/login.defs && \
  sed -i "s/PASS_MIN_DAYS.*/PASS_MIN_DAYS     $var_accounts_minimum_age_login_defs/g" /etc/login.defs
if ! [ $? -eq 0 ]; then
    echo "PASS_MIN_DAYS      $var_accounts_minimum_age_login_defs" >> /etc/login.defs
fi

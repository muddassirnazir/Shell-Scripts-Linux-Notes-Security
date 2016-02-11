#The pam_pwquality module's ucredit= parameter controls requirements for usage of uppercase letters in a password.
#When set to a negative number, any password will be required to contain that many uppercase characters.
#When set to a positive number, pam_pwquality will grant +1 additional length credit for each uppercase character.
#Add ucredit=-1 after pam_pwquality.so to require use of an upper case character in passwords.

var_password_pam_ucredit="-2"
if grep -q "ucredit=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(ucredit *= *\).*/\1$var_password_pam_ucredit/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ ucredit=$var_password_pam_ucredit/" /etc/pam.d/system-auth
fi

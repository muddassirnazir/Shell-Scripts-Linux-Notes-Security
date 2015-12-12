#The pam_pwquality module's lcredit= parameter controls requirements for usage of lowercase letters in a password.
#When set to a negative number, any password will be required to contain that many lowercase characters.
#When set to a positive number, pam_pwquality will grant +1 additional length credit for each lowercase character.
#Add lcredit=-1 after pam_pwquality.so to require use of a lowercase character in passwords.

var_password_pam_lcredit="-2"
if grep -q "lcredit=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(lcredit *= *\).*/\1$var_password_pam_lcredit/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ lcredit=$var_password_pam_lcredit/" /etc/pam.d/system-auth
fi

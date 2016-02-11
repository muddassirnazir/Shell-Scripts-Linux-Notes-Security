#The pam_pwquality module's dcredit parameter controls requirements for usage of digits in a password.
#When set to a negative number, any password will be required to contain that many digits.
#When set to a positive number, pam_pwquality will grant +1 additional length credit for each digit.
#Add dcredit=-1 after pam_pwquality.so to require use of a digit in passwords.

var_password_pam_dcredit="-1"
if grep -q "dcredit=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(dcredit *= *\).*/\1$var_password_pam_dcredit/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ dcredit=$var_password_pam_dcredit/" /etc/pam.d/system-auth
fi

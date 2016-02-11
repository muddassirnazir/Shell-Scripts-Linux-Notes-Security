#The pam_pwquality module's ocredit= parameter controls requirements for usage of special (or "other") characters in a password.
#When set to a negative number, any password will be required to contain that many special characters.
#When set to a positive number, pam_pwquality will grant +1 additional length credit for each special character.
#Add ocredit=-2 after pam_pwquality.so to require use of a special character in passwords.

var_password_pam_ocredit="-2"
if grep -q "ocredit=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(ocredit *= *\).*/\1$var_password_pam_ocredit/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ ocredit=$var_password_pam_ocredit/" /etc/pam.d/system-auth
fi

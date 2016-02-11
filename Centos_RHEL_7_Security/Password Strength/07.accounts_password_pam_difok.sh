#The pam_pwquality module's difok parameter controls requirements for usage of different characters during a password change.
#Add difok=NUM after pam_pwquality.so to require differing characters when changing passwords, substituting NUM appropriately.
#The DoD requirement is 15.

var_password_pam_difok="3"
if grep -q "difok=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(difok *= *\).*/\1$var_password_pam_difok/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ difok=$var_password_pam_difok/" /etc/pam.d/system-auth
fi

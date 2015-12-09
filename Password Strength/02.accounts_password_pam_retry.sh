#To configure the number of retry prompts that are permitted per-session:
#Edit the pam_pwquality.so statement in /etc/pam.d/system-auth to show retry=3, or a lower value if site policy is more restrictive.
#The DoD requirement is a maximum of 3 prompts per session.

var_password_pam_retry="3"
if grep -q "retry=" /etc/pam.d/system-auth; then
	sed -i --follow-symlink "s/\(retry *= *\).*/\1$var_password_pam_retry/" /etc/pam.d/system-auth
else
	sed -i --follow-symlink "/pam_pwquality.so/ s/$/ retry=$var_password_pam_retry/" /etc/pam.d/system-auth
fi

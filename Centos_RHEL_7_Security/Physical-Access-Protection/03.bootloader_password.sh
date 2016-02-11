#The grub2 boot loader should have a superuser account and password protection enabled to protect boot-time settings.
#To do so, select a superuser account and password and add them into the appropriate grub2 configuration file(s) under /etc/grub.d.
#Since plaintext passwords are a security risk, generate a hash for the pasword by running the following command:
grub2-mkpasswd-pbkdf2

#When prompted, enter the password that was selected and insert the returned password hash into the appropriate grub2 configuration file(s)
#under /etc/grub.d immediately after the superuser account. (Use the output from grub2-mkpasswd-pbkdf2 as the value of password-hash):
#password_pbkdf2 superusers-account password-hash

#NOTE: It is recommended not to use common administrator account names like root, admin, or administrator for the grub2 superuser account.
#To meet FISMA Moderate, the bootloader superuser account and password MUST differ from the root account and password.
#Once the superuser account and password have been added, update the grub.cfg file by running:
grub2-mkconfig -o /boot/grub2/grub.cfg

#NOTE: Do NOT manually add the superuser account and password to the grub.cfg file as the grub2-mkconfig command overwrites this file.

#The telnet service configuration file /etc/xinetd.d/telnet is not created automatically. If it was created manually, 
#check the /etc/xinetd.d/telnet file and ensure that disable = no is changed to read disable = yes as follows below:

# description: The telnet server serves telnet sessions; it uses \\
#       unencrypted username/password pairs for authentication.
#Following lines should be uncommented in the /etc/xinetd.d/telnet
#------------------------------------------------------
#service telnet
#{
#        flags           = REUSE
#        socket_type     = stream
#
#        wait            = no
#        user            = root
#        server          = /usr/sbin/in.telnetd
#        log_on_failure  += USERID
#        disable         = yes
#}
#------------------------------------------------------

systemctl disable telnet.socket

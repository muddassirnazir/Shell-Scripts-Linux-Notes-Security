 #The Datagram Congestion Control Protocol (DCCP) is a relatively new transport layer protocol, designed to support streaming 
 #media and telephony. To configure the system to prevent the dccp kernel module from being loaded, add the following line to 
 #a file in the directory /etc/modprobe.d: install dccp /bin/false 
 
echo "install dccp /bin/false" > /etc/modprobe.d/dccp.conf
 
#The Stream Control Transmission Protocol (SCTP) is a transport layer protocol, designed to support the idea of message-oriented 
#communication, with several streams of messages within one connection. To configure the system to prevent the sctp kernel module
#from being loaded, add the following line to a file in the directory /etc/modprobe.d: install sctp /bin/false 

echo "install sctp /bin/false" > /etc/modprobe.d/sctp.conf

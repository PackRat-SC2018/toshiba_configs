#!/bin/bash
# 
# In order to use this IPTables firewall script you
# must have IPTables installed. You also must be using 
# a 2.4.x series Kernel, with IPTables support complied 
# into it, which is standard for most newer Linux distributions.
#
# If you need help compiling IPtables into your kernel, please
# see our Kernel Compile/Upgrade Guide located at 
# www.linuxhelp.net/guides/
#
# Once the script has been edited with all your relevant
# information (IP's, Network Interfaces, etc..) simply
# make the script executable and run it as root.
#
# chmod 700 iptables-firewall
# ./iptables-firewall
#
# If you would like to see what rules are currently set, as
# root run iptables -L
#
# If you've messed up and need to bring down the firewall 
# for whatever reason, run iptables -F
#
# If you would like to have the firewall automatically
# come up at boot time, add the path to the script to
# the bottom of your /etc/rc.d/rc.local file. For instance
# /root/bin/iptables-firewall
#
# If you're not sure about something, check out the iptables
# man page by typing 'man iptables' (without the ''s) at the
# command prompt.
#
# This script is an enhanced/modified version of the 
# iptables-script written by Davion 
# 
# If you have any questions, please come see us in #Linuxhelp.net
# on the DALnet IRC network. (www.linuxhelp.net/ircinfo.shtml)

# The location of the IPtables binary file on your system.
IPT="/usr/bin/iptables"

# The Network Interface you will be protecting. For ADSL/dialup users,
# ppp0 should be fine. If you are using a cable internet connection or
# are connected to a LAN, you will have to change this to "eth0".
INT="enp2s0"

# The following rules will clear out any existing firewall rules, 
# and any chains that might have been created.
iptables -F
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -F -t mangle
iptables -F -t nat
iptables -X

# These will setup our policies.
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# The following line below enables IP forwarding and thus 
# by extension, NAT. Turn this on if you're going to be 
# doing NAT or IP Masquerading.
# echo 1 > /proc/sys/net/ipv4/ip_forward

# Source NAT everything heading out the enp2s0 (external) 
# interface to be the given IP. If you have a dynamic IP 
# address or a DHCP IP that changes semi-regularly, comment out 
# the first line and uncomment the second line.
#
# Remember to change the ip address below to your static ip.
#
#iptables -t nat -A POSTROUTING -o enp2s0 -j SNAT --to 216.138.195.197
iptables -t nat -A POSTROUTING -o enp2s0 -j MASQUERADE

# This rule protects your fowarding rule.
iptables -A FORWARD -i enp2s0 -m state --state NEW,INVALID -j DROP

# If you would like to forward specific ports to other machines
# on your home network, edit and uncomment the rules below. They are
# currently set up to forward port 25 & 53 (Mail & DNS) to 10.1.1.51. 
# Anything incoming over your enp2s0 through your gateway will 
# be automatically redirected invisibly to port 25 & 53 on 10.1.1.51
#iptables -t nat -A PREROUTING -i enp2s0 -p tcp --dport 25 -j DNAT --to 10.1.1.51:25
#iptables -t nat -A PREROUTING -i enp2s0 -p tcp --dport 53 -j DNAT --to 10.1.1.51:53
#iptables -t nat -A PREROUTING -i enp2s0 -p udp --dport 53 -j DNAT --to 10.1.1.51:53

# These two redirect a block of ports, in both udp and tcp.
#iptables -t nat -A PREROUTING -i enp2s0 -p tcp --dport 2300:2400 -j DNAT --to 10.1.1.50
#iptables -t nat -A PREROUTING -i enp2s0 -p udp --dport 2300:2400 -j DNAT --to 10.1.1.50


# Now, our firewall chain. We use the limit commands to 
# cap the rate at which it alerts to 15 log messages per minute.
iptables -N firewall
iptables -A firewall -m limit --limit 15/minute -j LOG --log-prefix Firewall:
iptables -A firewall -j DROP

# Now, our dropwall chain, for the final catchall filter.
iptables -N dropwall
iptables -A dropwall -m limit --limit 15/minute -j LOG --log-prefix Dropwall:
iptables -A dropwall -j DROP

# Our "hey, them's some bad tcp flags!" chain.
iptables -N badflags
iptables -A badflags -m limit --limit 15/minute -j LOG --log-prefix Badflags:
iptables -A badflags -j DROP

# And our silent logging chain.
iptables -N silent
iptables -A silent -j DROP

# Allow all loopback (lo0) traffic and drop all traffic to 127/8
# that doesn't use lo0
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 ! -i lo -j REJECT --reject-with icmp-port-unreachable

# This rule will accept connections from local machines. If you have
# a home network, enter in the IP's of the machines on the 
# network below.
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -s 192.168.57.0/24 -d 0/0 -p all -j ACCEPT
#iptables -A INPUT -s 192.168.73.0/24 -d 0/0 -p all -j ACCEPT
#iptables -A INPUT -s 10.10.10.0/24 -d 0/0 -p all -j ACCEPT
#iptables -A INPUT -s 10.1.1.52 -d 0/0 -p all -j ACCEPT

# Drop those nasty packets! These are all TCP flag 
# combinations that should never, ever occur in the
# wild. All of these are illegal combinations that 
# are used to attack a box in various ways, so we 
# just drop them and log them here.
iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j badflags
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j badflags
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j badflags

# Drop icmp, but only after letting certain types through.
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 3 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 11 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT
iptables -A INPUT -p icmp -j firewall

# If you would like to open up port 22 (SSH Access) to various IP's
# simply edit the IP's below and uncomment the line. If youw wish to 
# enable SSH access from anywhere, uncomment the second line only. 
#iptables -A INPUT -i enp2s0 -s 10.1.1.1 -d 0/0 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i enp2s0 -s 0/0 -d 0/0 -p tcp --dport 2410 -j ACCEPT

# If you are running a Web Server, uncomment the next line to open
# up port 80 on your machine.
#iptables -A INPUT -i enp2s0 -s 0/0 -d 0/0 -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -i enp2s0 -s 0/0 -d 0/0 -p tcp --dport 443 -j ACCEPT
# or these
#iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# nfs share rules
iptables -A INPUT -p tcp -m tcp --dport 111 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 2049 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 20048 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 111 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 2049 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 20048 -j ACCEPT

# vsftp rules
iptables -A INPUT  -p tcp -m tcp --dport 2412 -m conntrack --ctstate ESTABLISHED,NEW -j ACCEPT -m comment --comment "Allow ftp connections on port 2412"
iptables -A OUTPUT -p tcp -m tcp --dport 2412 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT -m comment --comment "Allow ftp connections on port 2412"

#iptables -A INPUT  -p tcp -m tcp --dport 20 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow ftp connections on port 20"
#iptables -A OUTPUT -p tcp -m tcp --dport 20 -m conntrack --ctstate ESTABLISHED -j ACCEPT -m comment --comment "Allow ftp connections on port 20"

iptables -A INPUT  -p tcp -m tcp --sport 1024: --dport 1024: -m conntrack --ctstate ESTABLISHED -j ACCEPT -m comment --comment "Allow passive inbound connections"
iptables -A OUTPUT -p tcp -m tcp --sport 1024: --dport 1024: -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow passive inbound connections"

iptables -A INPUT  -p tcp -m tcp --sport 5000: --dport 5000: -m conntrack --ctstate ESTABLISHED -j ACCEPT -m comment --comment "Allow passive inbound connections"
iptables -A OUTPUT -p tcp -m tcp --sport 5000: --dport 5000: -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow passive inbound connections"

iptables -A INPUT  -p tcp -m tcp --sport 5003: --dport 5003: -m conntrack --ctstate ESTABLISHED -j ACCEPT -m comment --comment "Allow passive inbound connections"
iptables -A OUTPUT -p tcp -m tcp --sport 5003: --dport 5003: -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT -m comment --comment "Allow passive inbound connections"

# Lets do some basic state-matching. This allows us 
# to accept related and established connections, so
# client-side things like ftp work properly, for example.
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Uncomment to drop port 137 netbios packets silently. 
# We don't like that netbios stuff, and it's way too 
# spammy with windows machines on the network.
iptables -A INPUT -p udp --sport 137 --dport 137 -j silent

# Our final trap. Everything on INPUT goes to the dropwall 
# so we don't get silent drops.
iptables -A INPUT -j dropwall


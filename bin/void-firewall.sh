#!/bin/sh

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

# Allow all loopback (lo0) traffic and drop all traffic to 127/8
# that doesn't use lo0
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 ! -i lo -j REJECT --reject-with icmp-port-unreachable

# Allow established sessions to receive traffic
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow ICMP pings
#iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Allow SSH remote
#iptables -I INPUT -p tcp --dport 22 -j ACCEPT

# Reject all other inbound connections
iptables -A INPUT -j REJECT --reject-with icmp-port-unreachable
iptables -A FORWARD -j REJECT --reject-with icmp-port-unreachable

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


iptables -t nat -A POSTROUTING -o enp2s0 -j MASQUERADE

iptables -A FORWARD -i enp2s0 -m state --state NEW,INVALID -j DROP

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -s 192.168.57.0/24 -d 0/0 -p all -j ACCEPT

iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j badflags
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j badflags
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j badflags
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j badflags

# nfs share rules
iptables -A INPUT -p tcp -m tcp --dport 111 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 2049 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 20048 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 111 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 2049 -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 20048 -j ACCEPT


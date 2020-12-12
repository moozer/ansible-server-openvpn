# OpenVPN
iptables -A INPUT -i {{ ext_if.interface }} -m state --state NEW -p udp --dport {{ openvpn_server_port }} -j ACCEPT

# Allow TUN interface connections to OpenVPN server
iptables -A INPUT -i tun+ -j ACCEPT
 
# Allow TUN interface connections to be forwarded through other interfaces
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o {{ ext_if.interface }} -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
 
# NAT the VPN client traffic to the internet
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o {{ int_if.interface }} -j MASQUERADE

#!/usr/bin/bash
ETH=$(ip addr | grep "2: " | cut -d":" -f2)
WLAN=$(ip addr | grep "3: " | cut -d":" -f2)
echo "INTERFACES,$ETH and$WLAN"

if [ "$(ls ./ | grep .conf)" ] ; then
	VPNFILE=$(ls ./ | grep .conf)	
	ROUTLIST=$(cat ./$VPNFILE | grep "remote " | cut -d" " -f2-3)
	

	iptables-save > iptables-old
	iptables -F && iptables -X

	iptables -P OUTPUT DROP
	iptables -A OUTPUT -o tun0 -j ACCEPT
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT
	iptables -A INPUT -s 255.255.255.255 -j ACCEPT
	iptables -A OUTPUT -d 255.255.255.255 -j ACCEPT

	for rout in $ROUTLIST; do
		if [[ $rout == *.* ]]; then
			IP=$rout
		else
			echo "Setting IP: $IP and PORT: $rout"
		        iptables -A OUTPUT -o$WLAN -p udp -m udp --dport $rout -d $IP/24 -j ACCEPT
		        iptables -A OUTPUT -o$ETH -p udp -m udp --dport $rout -d $IP/24 -j ACCEPT
		fi;
	done
	
	ip6tables -P OUTPUT DROP
	ip6tables -A OUTPUT -o tun0 -j ACCEPT

else 
	echo "ass"
fi;



#!/usr/bin/bash
ETH=$(ip addr | grep "2: " | cut -d":" -f2)
WLAN=$(ip addr | grep "3: " | cut -d":" -f2)

if [ "$(echo $1) = conf" ] && [ "$(ls $1 | grep .conf )" ]; then
	VPNFILE=$1
else
	echo "You should specify your .conf file"
	exit
fi;

if [ "$(whoami) = root" ] ; then
	ROUTLIST=$(cat $VPNFILE | grep "remote " | cut -d" " -f2-3)

	iptables-save > iptables-old
	echo "backup iptables config saved to $(pwd)/iptables-old"
	iptables -F && iptables -X

	iptables -P OUTPUT DROP
	iptables -A OUTPUT -o tun0 -j ACCEPT
	iptables -A INPUT -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT

	for rout in $ROUTLIST; do
		if [[ $rout == *.* ]]; then
			IP=$rout
		else
			echo "Allowing traffic on $IP/24:$rout"
		        iptables -A OUTPUT -o$WLAN -p udp -m udp --dport $rout -d $IP/24 -j ACCEPT
		        iptables -A OUTPUT -o$ETH -p udp -m udp --dport $rout -d $IP/24 -j ACCEPT
		fi;
	done

	ip6tables -P OUTPUT DROP
	ip6tables -A OUTPUT -o tun0 -j ACCEPT

	echo done
	exit
else 
	echo "Make sure to run with superuser privileges"
	exit
fi;



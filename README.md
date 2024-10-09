# killswitch-maker
Automation script for secure iptables configurations for openvpn connections

Will make this a proper tool in the future as its really usefull at times.

# How to use
Its really simple.

Clone the repository and cd into it
```
git clone https://github.com/based8/killswitch-maker.git
cd killswitch-maker
```

And run it with superuser privileges
```
chmod 770 killswitch-maker.sh
sudo ./killswitch-maker.sh <~/your/vpn/file.conf>
```

if you want I/O between another interface do 
```
sudo ./killswitch-maker.sh ~/vpns/yourvpn.conf virbr0
```
This will add the virbr0 interface to the killswitch and make it possible to use the killswitch while in a vm for example


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

Then just copy your conf file into the directory
And run it with superuser privileges
```
cp <YOUR VPN CONF FILE> ./

chmod 770 user:user killswitch-maker.sh
sudo ./killswitch-maker.sh
```



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
cp <location to your vpn .conf file> ./
sudo ./killswitch-maker.sh
```



#!/bin/sh -e
sudo sysctl net.ipv4.ip_forward=1 >/dev/null
sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -s 172.16.42.0/24 -j ACCEPT
sudo iptables -A POSTROUTING -t nat -j MASQUERADE -s 172.16.42.0/24
ssh root@172.16.42.1 ip route add default via 172.16.42.2 dev usb0

# echo ">> Now run 'ip route add default via 172.16.42.2 dev usb0' on your device!
#    (running 'ip route del default via 172.16.42.2' will undo this)
#
# >> With 'usbd' package 'sv start rndis-tethering' & 'sv stop rndis-tethering'
#    will work as well."

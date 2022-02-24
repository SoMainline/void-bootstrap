#!/bin/bash
xbps-install -y wget neard python{,-dbus,-gobject}
wget https://github.com/linux-nfc/neard/archive/master.tar.gz -t 3 --show-progress -qO /tmp/neard.tar.gz
mkdir -p /usr/libexec/nfc/test
tar -C /usr/libexec/nfc/test -xf /tmp/neard.tar.gz neard-master/test --strip-components=2
sed 's/python$/python2/' -i /usr/libexec/nfc/test/*
rm /tmp/neard.tar.gz

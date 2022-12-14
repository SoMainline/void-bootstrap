#!/bin/sh
set -e
xbps-install -y wget
wget https://gitlab.com/sdm845-mainline/alsa-ucm-conf/-/archive/master/alsa-ucm-conf-master.tar.gz -t 3 --show-progress -qO /tmp/ucm2.tar.gz
mkdir -p /usr/share/alsa/ucm2
tar -C /usr/share/alsa/ucm2 -xf /tmp/ucm2.tar.gz alsa-ucm-conf-master/ucm2 --strip-components=2
rm /tmp/ucm2.tar.gz

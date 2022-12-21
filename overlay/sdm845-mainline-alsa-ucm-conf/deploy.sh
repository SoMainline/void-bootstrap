#!/bin/bash
# OnePlus 6/6T, SHIFT6mq & Xiaomi Poco F1 supported as of 9ed12836 (2022-12-21)
set -e
xbps-install -y alsa-ucm-conf wget
wget https://gitlab.com/sdm845-mainline/alsa-ucm-conf/-/archive/master/alsa-ucm-conf-master.tar.gz -t 3 --show-progress -qO /tmp/ucm2.tar.gz
mkdir -p /usr/share/alsa-ucm2-sdm845-mainline
tar -C /usr/share/alsa-ucm2-sdm845-mainline -xf /tmp/ucm2.tar.gz alsa-ucm-conf-master/ucm2 --strip-components=2
rm /tmp/ucm2.tar.gz
mkdir -p /usr/share/alsa/ucm2/{OnePlus,SHIFT,Xiaomi}
ln -s /usr/share/alsa-ucm2-sdm845-mainline/OnePlus/{enchilada,fajita} /usr/share/alsa/ucm2/OnePlus/
ln -s /usr/share/alsa-ucm2-sdm845-mainline/SHIFT/axolotl /usr/share/alsa/ucm2/SHIFT/
ln -s /usr/share/alsa-ucm2-sdm845-mainline/Xiaomi/beryllium /usr/share/alsa/ucm2/Xiaomi/
ln -s /usr/share/alsa-ucm2-sdm845-mainline/conf.d/sdm845/{'OnePlus 6'{,T},SHIFT6mq,'Xiaomi Poco F1'}.conf /usr/share/alsa/ucm2/conf.d/sdm845/

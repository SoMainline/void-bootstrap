#!/bin/bash
# OnePlus 6/6T, SHIFT6mq & Xiaomi Poco F1 supported as of 9ed12836 (2022-12-21)
set -e
xbps-install -y alsa-ucm-conf git
git clone https://gitlab.com/sdm845-mainline/alsa-ucm-conf.git /usr/share/alsa-sdm845-mainline
ucm2=/usr/share/alsa/ucm2
sdm845_ucm2=/usr/share/alsa-sdm845-mainline/ucm2
mkdir -p $ucm2/{OnePlus,SHIFT,Xiaomi}
ln -s $sdm845_ucm2/OnePlus/{enchilada,fajita} $ucm2/OnePlus/
ln -s $sdm845_ucm2/SHIFT/axolotl $ucm2/SHIFT/
ln -s $sdm845_ucm2/Xiaomi/beryllium $ucm2/Xiaomi/
ln -s $sdm845_ucm2/conf.d/sdm845/{'OnePlus 6'{,T},SHIFT6mq,'Xiaomi Poco F1'}.conf $ucm2/conf.d/sdm845/

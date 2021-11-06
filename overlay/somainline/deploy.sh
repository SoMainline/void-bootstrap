#!/bin/bash
if [ -e /etc/gdm/custom.conf ]; then
	log 'Enabling GDM autologin for user somainline...'
	sed '/^\[daemon\]$/a AutomaticLoginEnable=True\nAutomaticLogin=somainline' -i /etc/gdm/custom.conf
else
	log 'Enabling agetty-tty1 autologin for user somainline...'
	cp -R /etc/sv/agetty-tty1 /etc/sv/agetty-autologin-tty1
	cat <<'EOF' > /etc/sv/agetty-autologin-tty1/conf
GETTY_ARGS="--autologin somainline --noclear"
BAUD_RATE=38400
TERM_NAME=linux
EOF
	disable_sv agetty-tty1
	enable_sv agetty-autologin-tty1
fi
#backend="chroot"

users=(
	'somainline:som::::SoMainline'
)
users_shell_default="/bin/zsh"
users_groups_common=(
	wheel # sudo
	video input storage bluetooth network
	socklog # svlogtail
	users
)
users_pw_default="" # disable pass login for root
users_sudo_askpass=false
#permit_root_login=true
hostname="somainline"

# overwrite systemd-nspawn stub resolv.conf
dns=(
	1.1.1.1
	1.0.0.1
	2606:4700:4700::1111
	2606:4700:4700::1001
)
#mirror="???"
img_name_format="somainline-%a-base-rootfs-$(date +'%Y-%m-%d--%H-%M').img"
img_size="3G"
#img_compress="xz"
work_dir="work"

#repos=(???)
ignorepkg=(
	# Unneeded FW
	ipw2100-firmware
	ipw2200-firmware
	zd1211-firmware
	wifi-firmware

	# These aren't particularly useful on embedded devices
	ethtool
	acpid

	# Only ext4 formatted images supported (currently)
	btrfs-progs
	xfsprogs

	nvi # We'll replace this crappy editor in base_pkgs
)
noextract=(
	# Only get firmware that is explicitly needed
	"/usr/lib/firmware/*"

	# CRDA
	"!/usr/lib/firmware/regulatory.db*"

	# WCN3990 BT
	!/usr/lib/firmware/qca/crbtfw21.tlv
	!/usr/lib/firmware/qca/crnv21.bin

	# A530/A540 GPU
	!/usr/lib/firmware/qcom/a530_pfp.fw
	!/usr/lib/firmware/qcom/a530_pm4.fw
	!/usr/lib/firmware/qcom/a530v3_gpmu.fw2

	# No rootfs encryption setup -> avoid extra runit stage
	/etc/crypttab

	# No need for raid -> avoid extra runit stage with additional spam about 4096 block size
	/usr/bin/dmraid

	# systemd is not an init system choice on Void so these are rather pointless
	"/usr/lib/systemd/*"
)
rm_pkgs=(
	nvi btrfs-progs xfsprogs
)
base_pkgs=(
	socklog-void elogind dbus-elogind # Main
	#haveged
	chrony # Time & date
	linux-firmware-{network,qualcomm} # Firmware
	bluez # Bluetooth
	NetworkManager avahi # Networking
	neard # NFC
	crda # WLAN

	zsh zsh-completions zsh-autosuggestions # Shell
	#zsh-history-substring-search zsh-syntax-highlighting

	# Some tools
	git htop neovim neofetch psmisc wget curl conspy xtools xxd ripgrep strace tree
	abootimg android-tools jq man-pages-posix binutils reboot-mode libinput evtest
	i2c-tools upower atop powertop libdrm-test-progs

	# Extended terminal definitions for proper support on ie. alacritty
	alacritty-terminfo foot-terminfo kitty-terminfo
)

extra_build_pkgs=(
	swclock-offset # Timekeeping
	qbootctl # Mark A/B slots as successfully booted on QCOM devices
	unudhcpd usbd # USB gadget setup
	qcom-fw-setup # Firmware
	libmbim libqrtr-glib libqmi ModemManager q6voiced # Cellular
	qrtr-ns pd-mapper rmtfs tqftpserv diag-router # Modem/WLAN
	gpsd-pds # GPS
	kmscube # GPU testing

	soctemp pil-squasher qmi-ping qcom-debugcc libgpiod # Extra tools
	#linuxconsoletools # (e.g. fftest)
	buffyboard # TTY on-screen touch enabled keyboard
)
extra_install_pkgs=(
	swclock-offset
	qbootctl
	unudhcpd usbd
	qcom-fw-setup
	ModemManager q6voiced
	qrtr-ns pd-mapper rmtfs tqftpserv diag-router
	gpsd-pds
	kmscube

	soctemp pil-squasher qmi-ping qcom-debugcc libgpiod
	#linuxconsoletools
	buffyboard
)

enable_sv=(
	chronyd dbus bluetoothd socklog-unix nanoklogd # Main
	swclock-offset # Timekeeping
	qbootctl # Mark A/B slots as successfully booted on QCOM devices
	#haveged elogind
	sshd

	usbd rndis-tethering # USB gadget setup
	pd-mapper rmtfs tqftpserv diag-router # Modem/WLAN
	NetworkManager avahi-daemon # Networking
	gpsd-pds # GPS
	neard # NFC
	buffyboard # TTY on-screen touch enabled keyboard
	# TODO: does it still have no keyboard visible with the following spammed on minimal simplefb tree (alpine .config)?
	#[Warn]  (66.514, +31)    indev_pointer_proc: X is 0 which is greater than hor. res      (in lv_indev.c line #349)
	#[Warn]  (66.515, +1)     indev_pointer_proc: Y is 0 which is greater than hor. res      (in lv_indev.c line #352)
)
disable_sv=(
	agetty-tty{2..6} # We don't need more than 1 active tty on embedded devices
	rndis-tethering # Just keep rndis-tethering managed by runit so "sv start rndis-tethering" works
)

overlays=(
	# Mount debugfs at /sys/kernel/d, symlinked from /d
	debugfs

	# Mount tracefs at /sys/kernel/tracing, symlinked from /t
	tracefs

	# Allow running "dmesg" & "ping" without root
	dmesg-noroot
	ping-network-group

	# Let runit manage ModemManager instead of dbus
	modemmanager-runit

	# Resize flashed rootfs on partitions
	resize-root

	# Set hostname on boot based on board DT compatible
	gen-hostname

	# Setup firmware on initial boot
	qcom-fw-setup-oneshot

	# Some NFC testing scripts
	neard-tests

	# Power off sooner on critical battery levels
	upower-critical-poweroff

	# SoMainline user configs etc.
	# NOTE: Make sure this is the last one or else config.gnome.sh breaks!
	somainline
)

# Avoid using all threads on the server for package building :)
#XBPS_MAKEJOBS=4

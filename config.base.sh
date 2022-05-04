#backend="chroot"

users=(
	'somainline:$5$/UjnRD0B7cDi5Ffh$LqUT25x224Zqb3R2kN7atvRbo.gVr2QXSS9hDGn/EgA::::SoMainline'
)
users_shell_default="/bin/zsh"
users_groups_common=(
	wheel # sudo
	video input storage bluetooth network
	socklog # svlogtail
	users
)
users_pw_encryption="" # unset if already hashed
users_pw_default="" # disable pass login for e.g. root
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
img_compress="xz"
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
	# Drop some FW that are double-signed by QCOM & OEM on retail hardware
	/usr/lib/firmware/qcom/a530_zap.*
	/usr/lib/firmware/qcom/sdm845/a630_zap.mbn
	/usr/lib/firmware/qcom/sdm845/adsp.mbn
	/usr/lib/firmware/qcom/sdm845/cdsp.mbn
	/usr/lib/firmware/qcom/sdm845/mba.mbn
	/usr/lib/firmware/qcom/sdm845/modem.mbn
	/usr/lib/firmware/qcom/sdm845/wlanmdsp.mbn
	/usr/lib/firmware/qcom/sm8250/a650_zap.mbn
	/usr/lib/firmware/qcom/sm8250/adsp.mbn
	/usr/lib/firmware/qcom/sm8250/cdsp.mbn
	/usr/lib/firmware/qcom/venus-*
	/usr/lib/firmware/qcom/vpu-*
)
rm_pkgs=(
	nvi pciutils btrfs-progs xfsprogs
)
noextract=(
	# No rootfs encryption setup -> avoid extra runit stage
	/etc/crypttab

	# No need for raid -> avoid extra runit stage with additional spam about 4096 block size
	/usr/bin/dmraid
)
base_pkgs=(
	socklog-void elogind dbus-elogind # Main
	#haveged
	fake-hwclock chrony # Time & date
	# TODO: check that fake-hwclock works properly
	# TODO: does linux-firmware-network cause QCA BT hypervisor faults?!
	linux-firmware-qualcomm # Firmware
	bluez # Bluetooth
	NetworkManager avahi # Networking
	neard # NFC
	crda # WLAN

	zsh zsh-completions zsh-autosuggestions # Shell
	#zsh-history-substring-search zsh-syntax-highlighting

	# Some tools
	git htop neovim neofetch psmisc wget curl conspy xtools xxd ripgrep strace tree
	abootimg android-tools jq man-pages-posix binutils reboot-mode libinput evtest
	i2c-tools upower atop powertop

	# Extended terminal definitions for proper support on ie. alacritty
	alacritty-terminfo foot-terminfo
)

extra_build_pkgs=(
	unudhcpd usbd # USB gadget setup
	qcom-fw-setup # Firmware
	libmbim libqrtr-glib libqmi ModemManager # Cellular
	qrtr-ns pd-mapper rmtfs tqftpserv diag-router # Modem/WLAN
	gpsd-pds # GPS

	soctemp pil-squasher qmi-ping # Extra tools
	#linuxconsoletools # (e.g. fftest)
	buffyboard # TTY on-screen touch enabled keyboard
)
extra_install_pkgs=(
	unudhcpd usbd
	qcom-fw-setup
	libqmi ModemManager
	qrtr-ns pd-mapper rmtfs tqftpserv diag-router
	gpsd-pds

	soctemp pil-squasher qmi-ping
	#linuxconsoletools
	buffyboard
)
#void_packages="https://github.com/SoMainline/void-packages.git"
#void_packages_branch="somainline"
#void_packages_shallow=true

enable_sv=(
	fake-hwclock chronyd dbus bluetoothd socklog-unix nanoklogd # Main
	#haveged elogind
	sshd

	usbd rndis-tethering # USB gadget setup
	pd-mapper rmtfs tqftpserv diag-router # Modem/WLAN
	NetworkManager avahi-daemon # Networking
	gpsd-pds # GPS
	neard # NFC
	buffyboard # TTY on-screen touch enabled keyboard
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

	# SoMainline user configs etc.
	# NOTE: Make sure this is the last one or else config.gnome.sh breaks!
	somainline
)

# Avoid using all threads on the server for package building :)
#XBPS_MAKEJOBS=4

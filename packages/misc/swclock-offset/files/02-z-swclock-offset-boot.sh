# runs after 02-udev.sh to get rtc_pm8xxx module loaded
if grep -q 'qcom,' /proc/device-tree/compatible 2>/dev/null; then
	swclock-offset-boot
	case $? in
		0) msg "System time set using swclock-offset-boot" ;;
		1) msg "System time NOT set using swclock-offset-boot: no RTC sysfs node" ;;
		2) msg "System time NOT set using swclock-offset-boot: no offset cache file" ;;
	esac
fi

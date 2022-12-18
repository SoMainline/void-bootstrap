SoMainline Void Linux rootfs image
==================================

USB
---
Device IP: 172.16.42.1
Activate reverse RNDIS tethering for internet on-device:
* Run void-bootstrap's tethering.sh on host
* Run "sudo sv start rndis-tethering" on device

Users
-----
somainline:som

Invalid date on Qualcomm devices
--------------------------------
Many modern Qualcomm RTC hardware are read-only which the swclock-offset
service takes care of, however on the initial boot the date will be wrong
and after acquiring internet connectivity you might have to
"sudo sv restart chronyd" and wait a bit for it to correct.

Call audio on Qualcomm devices
------------------------------
Read /usr/share/doc/q6voiced/README.md
Set Q6VOICE_CARD_NUM & Q6VOICE_DEVICE_NUM in /etc/sv/q6voiced/conf

Package management (via xbps)
-----------------------------
Docs: https://docs.voidlinux.org/xbps

Service management (via runit)
------------------------------
Docs: https://docs.voidlinux.org/config/services
runit FAQ: http://smarden.org/runit/faq.html

Service logging (via socklog/svlogtail)
---------------------------------------
Docs: https://docs.voidlinux.org/config/services/logging.html#socklog

Build configs (under SoMainline/void-bootstrap)
-----------------------------------------------
Reference: config.sh
Base:      config.base.sh
GNOME:     config.gnome.sh

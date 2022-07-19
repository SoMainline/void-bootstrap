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

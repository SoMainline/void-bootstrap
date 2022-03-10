# Packages
Extra `srcpkg`s to be overlaid on top of [`void-packages`](https://github.com/void-linux/void-packages).

## Usage
Any (sub)directories here containing a `template` file are copied directly to `void-packages/srcpkgs` during runtime automatically if [`extra_build_pkgs`](../config.sh) is configured (and `-B` isn't gived to [`mkrootfs.sh`](../mkrootfs.sh)).

Custom (or modified) shlibs should be placed in a `custom-shlibs` file in the root of this directory.

Custom (or modified) virtual package definitions should be placed in a `custom-virtuals` file in the root of this directory.

Additional patches to be applied on `void-packages` can also be placed in `patches` directory as well in form of `*.patch` or `*.diff` files (need to be `patch -p1` compatible).

Example layout:
```
packages
├── mypkg
│   └── template
├── mypkg-devel -> mypkg
├── patches
│   └── example.patch
├── custom-shlibs
└── custom-virtuals
```

After that call `merge.sh` to:
1. Copy all package directories to void-packages' `srcpkgs`
2. Merge `custom-shlibs` with `common/custom-shlibs`
3. Merge `custom-virtuals` with `etc/defaults.virtual`
4. Apply `patches/*.{patch,diff}`

Based on the idea of [`nvoid`](https://github.com/not-void/nvoid) alternative `xbps-src` repo.

## SoMainline tweaks
### Patches
* Add support for [checking updates to git packages](patches/0001-update-check-add-support-for-git-packages.patch)
### Modem
* [`libqrtr-glib`](modem/libqrtr-glib): Git version of [libqrtr-glib](https://gitlab.freedesktop.org/mobile-broadband/libqrtr-glib)
* [`libqmi`](modem/libqmi): Git version of [libqmi](https://gitlab.freedesktop.org/mobile-broadband/libqmi)
* [`libmbim`](modem/libmbim): Git version of [libmbim](https://gitlab.freedesktop.org/mobile-broadband/libmbim)
* [`ModemManager`](modem/ModemManager): Git version of [ModemManager](https://gitlab.freedesktop.org/mobile-broadband/ModemManager)
#### Qualcomm modem
* [`qrtr-ns`](modem/qcom/qrtr-ns): Git version of [andersson/qrtr](https://github.com/andersson/qrtr)
* [`rmtfs`](modem/qcom/rmtfs): Git version of [andersson/rmtfs](https://github.com/andersson/rmtfs)
* [`pd-mapper`](modem/qcom/pd-mapper): Git version of [andersson/pd-mapper](https://github.com/andersson/pd-mapper)
* [`tqftpserv`](modem/qcom/tqftpserv): Git version of [andersson/tqftpserv](https://github.com/andersson/tqftpserv)
* [`diag-router`](modem/qcom/diag-router): Git version of [andersson/diag](https://github.com/andersson/diag)
* [`gpsd-pds`](modem/gpsd-pds): GPSD with [PDS patch for Qualcomm SoCs](https://gitlab.com/gpsd/gpsd/-/merge_requests/139)
### Miscellaneous
* [`soctemp`](misc/soctemp): Standalone Python testing tool for [Qualcomm TSENS](https://cateee.net/lkddb/web-lkddb/QCOM_TSENS.html)
* [`usbd`](misc/usbd): Standalone daemon for configuring USB modes via [ConfigFS](https://www.kernel.org/doc/html/latest/usb/gadget_configfs.html) & starting `dhcpd` for an [RNDIS connection](https://cateee.net/lkddb/web-lkddb/USB_CONFIGFS_RNDIS.html) to the device
* [`pmos-tweaks`](misc/pmos-tweaks): Latest release of [postmarketOS/postmarketos-tweaks](https://gitlab.com/postmarketOS/postmarketos-tweaks)
* [`portfolio`](misc/portfolio): Git version of [tchx84/Portfolio](https://github.com/tchx84/Portfolio)
* [`mesa`](misc/mesa): Git version of [SoMainline/mesa](https://github.com/SoMainline/mesa) with full support for `freedreno`
* [`megapixels`](misc/megapixels): Latest release of [martijnbraam/megapixels](https://git.sr.ht/~martijnbraam/megapixels)
* [`callaudiod`](misc/callaudiod): Git version of [mobian1/callaudiod](https://gitlab.com/mobian1/callaudiod)
* [`sofia-sip`](misc/sofia-sip): Latest release of [freeswitch/sofia-sip](https://github.com/freeswitch/sofia-sip)
* [`feedbackd`](misc/feedbackd): Git version of [Librem5/feedbackd](https://source.puri.sm/Librem5/feedbackd)
* [`gnome-calls`](misc/gnome-calls): Latest release of [GNOME/calls](https://gitlab.gnome.org/GNOME/calls)
* [`purism-chatty`](misc/purism-chatty): Git version of [Librem5/chatty](https://source.puri.sm/Librem5/chatty)
* [`unudhcpd`](misc/unudhcpd): Latest release of [postmarketOS/unudhcpd](https://gitlab.com/postmarketOS/unudhcpd)
* [`pil-squasher`](misc/pil-squasher): Git version of [andersson/pil-squasher](https://github.com/andersson/pil-squasher)
* [`qcom-fw-setup`](misc/qcom-fw-setup): Git version of [JamiKettunen/qcom-fw-setup](https://github.com/JamiKettunen/qcom-fw-setup)
### Waydroid
* [`libglibutil`](waydroid/libglibutil): Latest release of [sailfishos/libglibutil](https://github.com/sailfishos/libglibutil)
* [`libgbinder`](waydroid/libgbinder): Latest release of [mer-hybris/libgbinder](https://github.com/mer-hybris/libgbinder)
* [`python3-gbinder`](waydroid/python3-gbinder): Latest release of [erfanoabdi/gbinder-python](https://github.com/erfanoabdi/gbinder-python)
* [`waydroid`](waydroid/waydroid): Git version of [waydroid](https://github.com/waydroid/waydroid)

## To-Do
* Rename `mesa` to `mesa-somainline`
* Fix `lm-sensors` and drop `soctemp`

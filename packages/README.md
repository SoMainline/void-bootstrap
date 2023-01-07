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

## Checking for package updates
Updates for packages defined in a config can be checked using:
```sh
./mkrootfs.sh --config <config file> --check-updates-only
# or even shorter
./mkrootfs.sh -c <config file> -u
```
Which should output something similar to:
```
$ ./mkrootfs.sh -c config.gnome.sh -u
...
>> Checking updates for 32 packages...
WARN: Some packages (listed below) appear to be out of date:
mutter-f5b1aa6e0be07e48508c32b81b4056626a56174c -> mutter-7da19fd844361571fd1acfdbbbf46cbef28fff29
gnome-shell-ed030b0b31b2a5a71eef28431df2058f1e469d68 -> gnome-shell-0d30d096202a0875895517cfae433c9edcb54d48
pmos-tweaks-0.12.0 -> pmos-tweaks-0.13.0
>> Cleaning up custom packages and patches from void-packages...
```
Once adjustments to the `template`s have been made the packages can be built without involving a full rootfs via:
```sh
./mkrootfs.sh --config <config file> --build-pkgs-only
# or even shorter
./mkrootfs.sh -c <config file> -b
```

## Updating packages tracking git hashes
When packages are tracking git hashes of repos their `template` should contain:
```sh
_commit=<commit SHA-1 hash>
```
Example:
```sh
_commit=c7effc8390e49f42a1971587b2bb6e2ecf39e67f
```
Something like `_branch=master` may also be present above in case the tracked branch isn't `main`.

Defined `version` in `template` should be of form:
```
version=<latest repo tag>+git<date of commit / updating in yyyy-mm-dd format>
```
Example:
```
version=1.21.1+git20221216
```
This allows for updates with built packages always cached locally.

## SoMainline additions
### Patches
* Add support for [checking updates to git packages](patches/0001-update-check-add-support-for-git-packages.patch)
### Modem
* [`libqrtr-glib`](modem/libqrtr-glib): Git version of [libqrtr-glib](https://gitlab.freedesktop.org/mobile-broadband/libqrtr-glib)
* [`libqmi`](modem/libqmi): Git version of [libqmi](https://gitlab.freedesktop.org/mobile-broadband/libqmi)
* [`libmbim`](modem/libmbim): Git version of [libmbim](https://gitlab.freedesktop.org/mobile-broadband/libmbim)
* [`ModemManager`](modem/ModemManager): Git version of [ModemManager](https://gitlab.freedesktop.org/mobile-broadband/ModemManager)
#### Qualcomm modem
* [`qmi-ping`](modem/qcom/qmi-ping): Git version of [andersson/qmi-ping](https://github.com/andersson/qmi-ping)
* [`diag-router`](modem/qcom/diag-router): Git version of [andersson/diag](https://github.com/andersson/diag)
* [`gpsd-pds`](modem/gpsd-pds): GPSD with [PDS patch for Qualcomm SoCs](https://gitlab.com/gpsd/gpsd/-/merge_requests/139)
### [GNOME mobile shell](https://blogs.gnome.org/shell-dev/2022/09/09/gnome-shell-on-mobile-an-update/)
* [`mutter`](gnome-mobile-shell/mutter): GNOME's mutter with [mobile shell patches](https://gitlab.gnome.org/verdre/mutter/-/tree/mobile-shell-devel)
* [`gnome-shell`](gnome-mobile-shell/gnome-shell): GNOME shell with [mobile shell patches](https://gitlab.gnome.org/verdre/gnome-shell/-/tree/mobile-shell-devel)
### Miscellaneous
* [`soctemp`](misc/soctemp): Standalone Python testing tool for [Qualcomm TSENS](https://cateee.net/lkddb/web-lkddb/QCOM_TSENS.html)
* [`usbd`](misc/usbd): Standalone daemon for configuring USB modes via [ConfigFS](https://www.kernel.org/doc/html/latest/usb/gadget_configfs.html) & starting `dhcpd` for an [RNDIS connection](https://cateee.net/lkddb/web-lkddb/USB_CONFIGFS_RNDIS.html) to the device
* [`pmos-tweaks`](misc/pmos-tweaks): Latest release of [postmarketOS/postmarketos-tweaks](https://gitlab.com/postmarketOS/postmarketos-tweaks)
* [`portfolio`](misc/portfolio): Git version of [tchx84/Portfolio](https://github.com/tchx84/Portfolio)
* [`mesa`](misc/mesa): Git version of [SoMainline/mesa](https://github.com/SoMainline/mesa) with full support for `freedreno`
* [`megapixels`](misc/megapixels): Latest release of [martijnbraam/megapixels](https://git.sr.ht/~martijnbraam/megapixels)
* [`callaudiod`](misc/callaudiod): Git version of [mobian1/callaudiod](https://gitlab.com/mobian1/callaudiod)
* [`sofia-sip`](misc/sofia-sip): Latest release of [freeswitch/sofia-sip](https://github.com/freeswitch/sofia-sip)
* [`feedbackd`](misc/feedbackd): Latest release of [Librem5/feedbackd](https://source.puri.sm/Librem5/feedbackd)
* [`gnome-calls`](misc/gnome-calls): Latest release of [GNOME/calls](https://gitlab.gnome.org/GNOME/calls)
* [`purism-chatty`](misc/purism-chatty): Git version of [Librem5/chatty](https://source.puri.sm/Librem5/chatty)
* [`unudhcpd`](misc/unudhcpd): Latest release of [postmarketOS/unudhcpd](https://gitlab.com/postmarketOS/unudhcpd)
* [`pil-squasher`](misc/pil-squasher): Git version of [andersson/pil-squasher](https://github.com/andersson/pil-squasher)
* [`qcom-fw-setup`](misc/qcom-fw-setup): Git version of [JamiKettunen/qcom-fw-setup](https://github.com/JamiKettunen/qcom-fw-setup)
* [`kmscube`](misc/kmscube): Git version of [mesa/kmscube](https://gitlab.freedesktop.org/mesa/kmscube)
* [`qbootctl`](misc/qbootctl): Latest release of [sdm845-mainline/qbootctl](https://gitlab.com/sdm845-mainline/qbootctl)
* [`buffyboard`](misc/buffyboard): Latest release of [cherrypicker/buffyboard](https://gitlab.com/cherrypicker/buffyboard)
* [`qcom-debugcc`](misc/qcom-debugcc): Git version of [andersson/qcom-debugcc](https://github.com/andersson/debugcc)
* [`swclock-offset`](misc/swclock-offset): Latest release of [postmarketOS/swclock-offset](https://gitlab.com/postmarketOS/swclock-offset)
* [`libgpiod`](misc/libgpiod): Latest release of [libgpiod](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git)
* [`tinyalsa`](misc/tinyalsa): Latest release of [tinyalsa](https://github.com/tinyalsa/tinyalsa)
* [`q6voiced`](modem/qcom/q6voiced): Latest release of [postmarketOS/q6voiced](https://gitlab.com/postmarketOS/q6voiced)

## To-Do
* Rename `mesa` to `mesa-somainline`
* Fix `lm-sensors` and drop `soctemp`

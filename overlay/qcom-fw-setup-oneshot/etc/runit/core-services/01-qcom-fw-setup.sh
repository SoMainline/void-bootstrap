#!/bin/sh
# Setup firmware on Qualcomm devices during first boot before
# loading kernel modules as a one-shot service.
grep -q ' / .*ro' /proc/mounts && mount -o remount,rw /
qcom-fw-setup && rm /etc/runit/core-services/01-qcom-fw-setup.sh

#!/bin/bash
# Setup qca-swiss-army-knife for WLAN firmware generation
xbps-install -y git
git clone https://github.com/qca/qca-swiss-army-knife.git /var/lib/qcom-fw-setup/qca-swiss-army-knife

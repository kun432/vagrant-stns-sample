#!/bin/bash

set -euo pipefail

# stns server settings
cat <<'EOF' | sudo tee -a /etc/stns/server/stns.conf

port     = 1104
include  = "/etc/stns/conf.d/*.conf"
EOF

mkdir -p /etc/stns/conf.d

sudo systemctl start stns
sudo systemctl enable stns
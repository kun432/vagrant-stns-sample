#!/bin/bash

set -euo pipefail

# stns client settings
cat <<EOF | sudo tee -a /etc/stns/client/stns.conf 
api_endpoint = "http://stns-server.example.internal:1104/v1"
[cached]
enable = true
EOF

sudo systemctl restart cache-stnsd
sudo systemctl enable cache-stnsd

# pam & sshd
sudo perl -wnlp -i -e 's/^((passwd|shadow|group):.*)$/$1 stns/g' /etc/nsswitch.conf 

echo 'session    required     pam_mkhomedir.so skel=/etc/skel/ umask=0022' | sudo tee -a /etc/pam.d/sshd

cat <<'EOF' | sudo tee -a /etc/ssh/sshd_config
PubkeyAuthentication yes
AuthorizedKeysCommand /usr/lib/stns/stns-key-wrapper
AuthorizedKeysCommandUser root
EOF

sudo systemctl restart sshd
sudo systemctl enable sshd
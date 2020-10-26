#!/bin/bash

set -euo pipefail

# install stns
curl -fsSL https://repo.stns.jp/scripts/yum-repo.sh | sudo bash

# install stns
sudo yum install -y stns-v2 libnss-stns-v2 https://github.com/STNS/cache-stnsd/releases/download/v0.3.1/cache-stnsd-0.3.1-1.x86_64.el7.rpm 
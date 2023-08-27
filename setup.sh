#!/bin/bash

set -euo pipefail

LANG=C
umask 0022

sudo chown -R btoll:btoll /srv
mkdir -p /srv/packages/{deb,rpm}
cp release.sh /srv/packages

sudo mkdir -p /usr/share/keyrings
# Note that key CANNOT be armored!
sudo cp public.key /usr/share/keyrings/btoll.gpg
sudo chmod 644 /usr/share/keyrings/btoll.gpg
echo "deb [signed-by=/usr/share/keyrings/btoll.gpg] http://192.168.1.200 bullseye main" \
    | sudo tee /etc/apt/sources.list.d/btoll.list


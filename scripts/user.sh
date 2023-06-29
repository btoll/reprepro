#!/usr/bin/bash

set -eux

umask 022

# Copy over the configs to create the APT repository and packages.
mkdir -p "/home/vagrant/$REPO_DIR/conf"

# Needed APT repository configs.
cat << EOF > "/home/vagrant/$REPO_DIR/conf/distributions"
Codename: bullseye
Components: main
Architectures: amd64 source
SignWith: 3A1314344B0D9912
EOF

echo ask-passphrase > "/home/vagrant/$REPO_DIR/conf/options"

# We must import the public key first or signing won't work.
# The agent forwarding will work, but the private key bits
# won't be in the keyring.
gpg --no-default-keyring \
    --keyring /home/vagrant/.gnupg/pubring.kbx \
    --import /vagrant/public.key

echo no-autostart >> /home/vagrant/.gnupg/gpg.conf


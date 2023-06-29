#!/usr/bin/bash

set -euxo pipefail

KEYNAME=${1:-Debian}

# This will target the signing subkey.
KEYGRIP=$(gpg --list-secret-keys --with-keygrip "$KEYNAME" \
    | grep -A1 "[S]" \
    | tail -1 \
    | awk '{print $3}')

gpg-connect-agent /bye
"$(gpgconf --list-dirs libexecdir)/gpg-preset-passphrase" --preset "$KEYGRIP"
gpg-connect-agent "keyinfo --list" /bye


#!/bin/bash
# shellcheck disable=SC2012

#############################################################################
# THIS SCRIPT IS AUTOMATICALLY EXECUTED BY SYSTEMD WHENEVER ANYTHING IS ADDED
# TO THE ./PACKAGES DIRECTORY...EASY DOES IT.
#############################################################################

set -exuo pipefail

# Don't use `pwd` or a relative path here.
PACKAGE_DIR="/home/btoll/projects/reprepro/packages"

# -A, --almost-all
#        do not list implied . and ..
# -B, --ignore-backups
#        do not list implied entries ending with ~
# -t     sort by time, newest first
# -1     list one file per line.
#
# There should only be directories at the top-level
PACKAGE_NAME_ADDED=$(ls -ABt1 --group-directories-first "$PACKAGE_DIR" | head -1)
echo "$PACKAGE_NAME_ADDED"
PACKAGE_VERSION_ADDED=$(ls -ABt1 --group-directories-first "$PACKAGE_DIR/$PACKAGE_NAME_ADDED" | head -1)
echo "$PACKAGE_VERSION_ADDED"

/home/btoll/go/bin/github-release create --repo "$PACKAGE_NAME_ADDED" --tag "$PACKAGE_VERSION_ADDED" --dir "$PACKAGE_DIR/$PACKAGE_NAME_ADDED/$PACKAGE_VERSION_ADDED/$PACKAGE_NAME_ADDED-$PACKAGE_VERSION_ADDED"


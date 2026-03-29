#!/usr/bin/env bash

#
# Generic re-packaging script for updating checksum and packaging.
# It fetches the latest version defined in template and updates the checksum, packages the package.
#
# Usage: repkg.sh <package-name>
#
# Arguments:
#   package-name       Name of the package in srcpkgs/
#
# Examples:
#   repkg.sh brave-bin
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.." && xgensum -fi "$1" && ./xbps-src pkg "$1"

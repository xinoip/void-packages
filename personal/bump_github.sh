#!/usr/bin/env bash

#
# Generic version bumper for packages that track GitHub releases.
#
# Usage: bump_github.sh <package-name> <github-repo> [version-transform]
#
# Arguments:
#   package-name       Name of the package in srcpkgs/
#   github-repo        GitHub repository (e.g., "brave/brave-browser")
#   version-transform  Optional: "strip-v" to remove 'v' prefix from version
#
# Examples:
#   bump_github.sh zen-browser zen-browser/desktop
#   bump_github.sh brave-bin brave/brave-browser strip-v
#

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $# -lt 2 ]; then
	echo "Usage: $0 <package-name> <github-repo> [version-transform]"
	echo "Example: $0 brave-bin brave/brave-browser strip-v"
	exit 1
fi

PACKAGE="$1"
GITHUB_REPO="$2"
VERSION_TRANSFORM="${3:-}"

REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TEMPLATE="$REPO_ROOT/srcpkgs/$PACKAGE/template"

if [ ! -f "$TEMPLATE" ]; then
	echo "Error: Template not found: $TEMPLATE"
	exit 1
fi

LATEST=$(basename "$(curl -Ls -o /dev/null -w %\{url_effective\} "https://github.com/$GITHUB_REPO/releases/latest")")

case "$VERSION_TRANSFORM" in
strip-v)
	LATEST="${LATEST#v}"
	;;
esac

CURRENT=$(grep "^version=" "$TEMPLATE" | cut -d= -f2)

if [ "$LATEST" == "$CURRENT" ]; then
	echo "$PACKAGE: Already up to date ($CURRENT)"
	exit 0
fi

echo "$PACKAGE: Updating $CURRENT -> $LATEST..."

sed -i "s/^version=.*/version=${LATEST}/" "$TEMPLATE"
sed -i "s/^revision=.*/revision=1/" "$TEMPLATE"

xgensum -fi "$TEMPLATE"
echo "$PACKAGE: Checksum updated."

"$REPO_ROOT/xbps-src" pkg "$PACKAGE"
xi "$PACKAGE"

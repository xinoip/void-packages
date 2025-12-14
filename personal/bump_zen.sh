#!/usr/bin/env bash

TEMPLATE=srcpkgs/zen-browser/template
LATEST=$(basename "$(curl -Ls -o /dev/null -w %\{url_effective\} https://github.com/zen-browser/desktop/releases/latest)")
CURRENT=$(grep "^version=" "$TEMPLATE" | cut -d= -f2)

if [ "$LATEST" == "$CURRENT" ]; then
	echo "Already up to date ($CURRENT_VER)"
	exit 0
fi

echo "Updating $CURRENT -> $LATEST..."

sed -i "s/^version=.*/version=${LATEST}/" "$TEMPLATE"
sed -i "s/^revision=.*/revision=1/" "$TEMPLATE"

xgensum -fi "$TEMPLATE"
echo "Checksum updated."

./xbps-src pkg zen-browser
xi zen-browser

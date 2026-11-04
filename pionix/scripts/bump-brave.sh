#!/bin/sh
set -e
cd "$(dirname "$0")/.."

template=srcpkgs/brave-origin/template
latest=$(curl -fsSL https://versions.brave.com/latest/origin-nightly-linux-x64.version)
current=$(sed -n 's/^version=//p' "$template")

if [ "$latest" = "$current" ]; then
    echo "brave-origin: already at $current"
    exit 0
fi

sed -i -e "s/^version=.*/version=$latest/" -e 's/^revision=.*/revision=1/' "$template"
make checksum PKG=brave-origin
echo "brave-origin: $current -> $latest"

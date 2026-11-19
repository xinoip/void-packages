#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

build_only_needed() {
	cd "$SCRIPT_DIR/../.."
	local pkg

	for pkg in pionix/srcpkgs/*; do
		./xbps-src -e pkg "${pkg##*/}"
	done
}

bump_brave_origin() {
	cd "$SCRIPT_DIR/.."
	local -r template=srcpkgs/brave-origin/template
	local latest current
	latest="$(curl -fsSL https://versions.brave.com/latest/origin-nightly-linux-x64.version)"
	current="$(sed -n 's/^version=//p' "$template")"
	readonly latest current

	if [ "$latest" = "$current" ]; then
		echo "brave-origin: already at $current"
		return
	fi

	sed -i -e "s/^version=.*/version=$latest/" -e 's/^revision=.*/revision=1/' "$template"
	make checksum PKG=brave-origin
	git commit --only -m "new: update brave-origin $current -> $latest" -- "$template"
	echo "brave-origin: $current -> $latest"
}

main() {
	cd "$SCRIPT_DIR/../.."

	# Stay outside pionix while rebase may remove and recreate it.
	git pull origin master
	git pull upstream master

	make -C pionix stow-packages
	bump_brave_origin
	build_only_needed
}

main "$@"

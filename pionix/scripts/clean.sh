#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

main() {
	cd "$SCRIPT_DIR/../.."
	local pkg_dir pkg

	for pkg_dir in pionix/archive/*; do
		pkg="${pkg_dir##*/}"
		if xbps-query "$pkg" >/dev/null 2>&1; then
			sudo xbps-remove -y "$pkg"
		fi
		rm -rf hostdir/sources/"$pkg"-[0-9]* masterdir-*/builddir/"$pkg"-[0-9]* masterdir-*/destdir/"$pkg"-[0-9]*
		find hostdir -type f -name "$pkg-[0-9]*.xbps*" -delete
		sudo find /var/cache/xbps -maxdepth 1 -type f -name "$pkg-[0-9]*.xbps*" -delete
	done
	find hostdir/binpkgs -name '*-repodata' -printf '%h\n' | sort -u | xargs -r -n1 xbps-rindex -c
}

main "$@"

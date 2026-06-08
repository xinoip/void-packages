#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	local -r PACKAGE=brave-origin
	local -r TEMPLATE="../srcpkgs/$PACKAGE/template"
	local -r VERSION_URL=https://versions.brave.com/latest/origin-nightly-linux-x64.version
	local VERSION_LATEST
	VERSION_LATEST="$(curl -fsSL "$VERSION_URL")"
	readonly VERSION_LATEST
	local VERSION_CURRENT
	VERSION_CURRENT="$(grep "^version=" "$TEMPLATE" | cut -d= -f2)"
	readonly VERSION_CURRENT

	if [ "$VERSION_LATEST" == "$VERSION_CURRENT" ]; then
		echo "$PACKAGE: Already up to date ($VERSION_CURRENT)"
		exit 0
	fi

	echo "$PACKAGE: Updating $VERSION_CURRENT -> $VERSION_LATEST..."

	sed -i "s/^version=.*/version=${VERSION_LATEST}/" "$TEMPLATE"
	sed -i "s/^revision=.*/revision=1/" "$TEMPLATE"

	./repkg.sh "$PACKAGE"
}

main "$@"
cd "$OLD_PWD"

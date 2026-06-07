#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	local -r PACKAGE="$1"
	cd ..
	xgensum -fi "$PACKAGE"
	./xbps-src pkg "$PACKAGE"
}

main "$@"
cd "$OLD_PWD"

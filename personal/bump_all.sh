#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	./bump_brave_origin.sh
	echo "mullvad-vpn: Not bumped. Check manually."
}

main "$@"
cd "$OLD_PWD"

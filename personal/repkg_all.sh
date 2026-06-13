#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	./repkg.sh brave-origin
	./repkg.sh mullvad-vpn
}

main "$@"
cd "$OLD_PWD"

#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

yesno() {
	local -r MSG="$1"
	local REPLY

	read -n 1 -p "$MSG (y/N) " REPLY
	printf "\n"

	[[ "$REPLY" == [Yy] ]]
}

main() {
	yesno "Repkg brave-origin?" && ./repkg.sh brave-origin
	yesno "Repkg mullvad-vpn?" && ./repkg.sh mullvad-vpn
	yesno "Repkg android-studio?" && ./repkg.sh android-studio
	yesno "Repkg chatgpt?" && ./repkg.sh chatgpt
}

main "$@"
cd "$OLD_PWD"

#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	./bump_brave_origin.sh
}

main "$@"
cd "$OLD_PWD"

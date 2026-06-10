#!/usr/bin/env bash
set -euo pipefail
readonly OLD_PWD="$PWD"
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

main() {
	cd ..
	git pull origin master
	git pull upstream master
	./personal/bump_all.sh
	xi -Su
	git push origin master --force
}

main "$@"
cd "$OLD_PWD"

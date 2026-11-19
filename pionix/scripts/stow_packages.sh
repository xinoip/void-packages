#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR

main() {
	cd "$SCRIPT_DIR/.."
	local pkg_dir file

	for pkg_dir in srcpkgs/*; do
		mkdir -p "../$pkg_dir"
		for file in "$pkg_dir"/*; do
			ln -sfnr "$file" "../$file"
		done
	done
}

main "$@"

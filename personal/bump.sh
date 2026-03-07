#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# "$SCRIPT_DIR/bump_zen.sh"
"$SCRIPT_DIR/bump_brave.sh"

# Bootstrap void-packages xbps repository. This needs to be run on fresh install machines.
.PHONY: xbps-bootstrap
xbps-bootstrap:
	cd .. && ./xbps-src binary-bootstrap

# My personal packages are kept under ./srcpkgs and symlinked to actual place in void-packages. This needs to be run
# each time I change structure of my personal template files to ensure links are in sync.
.PHONY: stow-packages
stow-packages:
	./scripts/stow_packages.sh

# Update this void-packages repository to the latest on all fronts:
#   - Pull my own fork
#   - Pull upstream
#   - Bump packages that can be automatically bumped
#   - Build packages that needs to be rebuilt
.PHONY: update-void-packages
update-void-packages:
	./scripts/update_void_packages.sh

# Install all of my personal templates.
.PHONY: install
install: stow-packages
	# `make` expands these wildcards at invoke time, so `cd ..` doesn't affect it.
	cd .. && xi $(notdir $(wildcard srcpkgs/*))

# Update checksum of a template using `xgensum`.
.PHONY: checksum
checksum: stow-packages
	cd .. && xgensum -fi pionix/srcpkgs/$(PKG)/template

# Uninstall archieved packages and remove build artifacts.
.PHONY: clean
clean:
	./scripts/clean.sh

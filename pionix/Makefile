.PHONY: help prepare bootstrap update update-origin update-upstream build build-all install install-all checksum bump-all clean

help:
	@echo 'make prepare                  Link custom templates and supporting files'
	@echo 'make bootstrap                Bootstrap xbps-src'
	@echo 'make update                   Pull origin and upstream, bump packages, install updates'
	@echo 'make update-origin            Pull changes from your fork'
	@echo 'make update-upstream          Pull changes from upstream'
	@echo 'make build PKG=name           Build a package'
	@echo 'make build-all                Build all custom packages'
	@echo 'make install PKG=name         Build and install a package'
	@echo 'make install-all              Build and install all custom packages'
	@echo 'make checksum PKG=name        Update a custom template checksum'
	@echo 'make bump-all                 Update custom package versions and checksums'
	@echo 'make clean                    Uninstall archived packages and remove their build data'

prepare:
	for pkg_dir in srcpkgs/*; do \
		mkdir -p "../$$pkg_dir"; \
		for file in "$$pkg_dir"/*; do \
			ln -sfnr "$$file" "../$$file"; \
		done; \
	done

bootstrap:
	cd .. && ./xbps-src binary-bootstrap

update-origin:
	cd .. && git pull origin master

update-upstream:
	cd .. && git pull upstream master

update:
	$(MAKE) update-origin
	$(MAKE) update-upstream
	$(MAKE) bump-all
	$(MAKE) install-all

build: prepare
	cd .. && ./xbps-src pkg $(PKG)

build-all: prepare
	cd .. && for pkg in pionix/srcpkgs/*; do ./xbps-src pkg "$${pkg##*/}" || exit; done

install: build
	cd .. && xi $(PKG)

install-all: build-all
	cd .. && xi $(notdir $(wildcard srcpkgs/*))

checksum: prepare
	cd .. && xgensum -fi pionix/srcpkgs/$(PKG)/template

bump-all:
	./scripts/bump-brave.sh

clean:
	cd .. && for pkg_dir in pionix/archive/*; do \
		pkg=$${pkg_dir##*/}; \
		if xbps-query "$$pkg" >/dev/null 2>&1; then \
			sudo xbps-remove -y "$$pkg" || exit; \
		fi; \
		rm -rf hostdir/sources/"$$pkg"-[0-9]* masterdir-*/builddir/"$$pkg"-[0-9]* masterdir-*/destdir/"$$pkg"-[0-9]*; \
		find hostdir -type f -name "$$pkg-[0-9]*.xbps*" -delete; \
		sudo find /var/cache/xbps -maxdepth 1 -type f -name "$$pkg-[0-9]*.xbps*" -delete; \
	done
	find ../hostdir/binpkgs -name '*-repodata' -printf '%h\n' | sort -u | xargs -r -n1 xbps-rindex -c

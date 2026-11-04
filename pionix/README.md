# Pionix

My additions to `void-packages`. Custom templates and supporting files live in
`srcpkgs/` here. The upstream `srcpkgs/` directories contain relative symlinks
to them. `Makefile` is used for central command runner:

```sh
make update
```

Unused templates are kept in `archive/` and excluded from builds and installs.
`make -C pionix clean` uninstalls archived packages with sudo, removes their local
sources, build files, and cached XBPS packages, and refreshes the local repository
indexes. Archived templates and personal files in your home directory are kept.

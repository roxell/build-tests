# Description
How to build test packages statically based from tuxmake's containers and package that into a tarball.

# Usage

First you have to clone packetdrill or ltp and 'cd path/to/test' create a
symlink or copy the build-*.sh file to the repository you cloned. Then do the
following command:

## Podman
```
podman run --rm -v $(pwd):/build -w /build tuxmake/arm64_clang ./build-packetdrill.sh arm64_clang
podman run --rm -v $(pwd):/build -w /build tuxmake/arm64_gcc ./build-packetdrill.sh arm64_gcc
```

## Docker
```
docker run -u $(id -u):$(id -g) --rm -v $(pwd):/build -w /build tuxmake/arm64_gcc ./build-packetdrill.sh arm64_gcc
```

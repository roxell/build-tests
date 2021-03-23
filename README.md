# Description
How to build test packages statically based from tuxmake's containers and package that into a tarball.

# Usage

## Podman
```
podman run --rm -v $(pwd):/build -w /build tuxmake/arm64_clang ./build-packetdrill.sh arm64_clang
podman run --rm -v $(pwd):/build -w /build tuxmake/arm64_gcc ./build-packetdrill.sh arm64_gcc
```

## Docker
```
docker run -u $(id -u):$(id -g) --rm -v $(pwd):/build -w /build tuxmake/arm64_gcc ./build-packetdrill.sh arm64_gcc
```

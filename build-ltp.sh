#!/bin/bash

#GIT_URL="https://github.com/linux-test-project/ltp.git"
#GIT_BRANCH="master"
#
#git clone -b ${GIT_BRANCH} ${GIT_URL}

if [[ ! -v $1 ]]; then
	ARCH_TC=${ARCH_TC:-$1}
fi

case "${ARCH_TC}" in
	arm64_gcc)
		export CROSS_HOST="--host=aarch64-linux-gnu"
			;;
	arm64_clang)
		export CC="clang --target=aarch64-linux-gnu"
		export CROSS_HOST="--host=aarch64-linux-gnu"
			;;
	arm_gcc)
		export CROSS_HOST="--host=arm-linux-gnueabihf"
		;;
	arm_clang)
		export CC="clang --target=arm-linux-gnueabihf"
		export CROSS_HOST="--host=arm-linux-gnueabihf"
		;;
	i386_gcc)
		export CROSS_HOST="--host=i686-linux-gnu"
		;;
	i386_clang)
		export CC="clang --target=i686-linux-gnu"
		export CROSS_HOST="--host=i686-linux-gnu"
		;;
	*);;
	x86_64_clang)
		export CC="clang"
		CROSS_HOST=""
		;;
	*);;
esac


apt update && apt install -y xz-utils flex bison wget curl net-tools quota genisoimage sudo libaio-dev libattr1-dev libcap-dev expect automake acl autotools-dev autoconf m4 pkgconf libpthread-stubs0-dev

make autotools
CFLAGS="-pthread" LDFLAGS="-pthread -static" ./configure ${CROSS_HOST} --without-tirpc
make all
make SKIP_IDCHECK=1 install
tar cJf ltp-${ARCH_TC}.tar.xz /opt/ltp

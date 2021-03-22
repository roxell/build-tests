#!/bin/bash

#GIT_URL="https://github.com/linux-test-project/ltp.git"
#GIT_BRANCH="master"
#
#git clone -b ${GIT_BRANCH} ${GIT_URL}


ARCH=x86_64
CROSS_HOST=""

if test $(which aarch64-linux-gnu-gcc) ; then
	ARCH=arm64
	export CROSS_HOST="--host=aarch64-linux-gnu"
fi
if test $(which arm-linux-gnueabihf-gcc) ; then
	ARCH=arm
	export CROSS_HOST="--host=arm-linux-gnueabihf"
fi
if test $(which i686-linux-gnu-gcc) ; then
	ARCH=i386
	export CROSS_HOST="--host=i686-linux-gnu"
fi

if test $(which clang) ; then
	export CC="clang"
fi

apt update && apt install -y xz-utils flex bison wget curl net-tools quota genisoimage sudo libaio-dev libattr1-dev libcap-dev expect automake acl autotools-dev autoconf m4 pkgconf libpthread-stubs0-dev

make autotools
CFLAGS="-pthread" LDFLAGS="-pthread -static" ./configure ${CROSS_HOST} --without-tirpc
make all
make SKIP_IDCHECK=1 install
tar cJf ltp-${ARCH}.tar.xz /opt/ltp

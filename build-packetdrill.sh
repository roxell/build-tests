#!/bin/bash

#GIT_URL="https://github.com/google/packetdrill.git"
#GIT_BRANCH="master"
#
#git clone -b ${GIT_BRANCH} ${GIT_URL}

PACKETNAME="packetdrill"
INSTALL_DIR="/opt/${PACKETNAME}_suite"


ARCH=x86_64

if test $(which aarch64-linux-gnu-gcc) ; then
	ARCH=arm64
	export CC="aarch64-linux-gnu-gcc"
	export LD="aarch64-linux-gnu-ld"
fi
if test $(which arm-linux-gnueabihf-gcc) ; then
	ARCH=arm
	export CC="arm-linux-gnueabihf-gcc"
	export LD="arm-linux-gnueabihf-ld"
fi
if test $(which i686-linux-gnu-gcc) ; then
	ARCH=i386
	export CC="i686-linux-gnu-gcc"
	export LD="i686-linux-gnu-ld"
fi
if test $(which clang) ; then
	#export CC="clang --target-arch arm64"
	export CC="clang"

fi


pushd gtests/net/${PACKETNAME}
./configure
make
mkdir -p ${INSTALL_DIR}/${PACKETNAME}
cp ${PACKETNAME} ${INSTALL_DIR}/${PACKETNAME}
cp run_all.py ${INSTALL_DIR}/${PACKETNAME}
cp in_netns.sh ${INSTALL_DIR}/${PACKETNAME}
cp -r ../tcp ${INSTALL_DIR}
cp -r ../common ${INSTALL_DIR}
popd
tar cJf ${PACKETNAME}-${ARCH}.tar.xz ${INSTALL_DIR}

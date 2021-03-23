#!/bin/bash

#GIT_URL="https://github.com/google/packetdrill.git"
#GIT_BRANCH="master"
#
#git clone -b ${GIT_BRANCH} ${GIT_URL}

PACKETNAME="packetdrill"
INSTALL_DIR="/opt/${PACKETNAME}_suite"

if [[ ! -v $1 ]]; then
	ARCH_TC=${ARCH_TC:-$1}
fi

case "${ARCH_TC}" in
	arm64_gcc)
		export CC="aarch64-linux-gnu-gcc"
		export LD="aarch64-linux-gnu-ld"
		;;
	arm64_clang)
		export CC="clang --target=aarch64-linux-gnu"
		;;
	arm_gcc)
		export CC="arm-linux-gnueabihf-gcc"
		export LD="arm-linux-gnueabihf-ld"
		;;
	arm_clang)
		export CC="clang --target=arm-linux-gnueabihf"
		;;
	i386_gcc)
		export CC="i686-linux-gnu-gcc"
		export LD="i686-linux-gnu-ld"
		;;
	i386_clang)
		export CC="clang --target=i686-linux-gnu"
		;;
	*);;
	x86_64_clang)
		export CC="clang"
		;;
	*);;
esac


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
tar cJf ${PACKETNAME}-${ARCH_TC}.tar.xz ${INSTALL_DIR}

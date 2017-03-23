#!/bin/sh

YOCTO_DIR="yocto-bsp"
YOCTO_RELEASE="morty"
YOCTO_MACHINE="sc145"
YOCTO_TARGET="at-chip-console-image"

echo
echo LINUX@CHIP Yocto BSP initialiser
echo
echo Checking required tools

if [ -z $(which git) ]; then
	echo 'Error: git not found, please install git (e.g. "apt-get install git").'
	exit 1
fi

echo ok
echo
if [ -e ./yocto-bsp ]; then
	echo 'Error: The output directory "yocto-bsp" already exists.'
        exit 2
fi
                
                

echo
echo Cloning required Git repositories
echo

git clone git://git.yoctoproject.org/poky -b $YOCTO_RELEASE $YOCTO_DIR && cd $YOCTO_DIR
git clone git://git.openembedded.org/meta-openembedded -b $YOCTO_RELEASE
git clone https://git.yoctoproject.org/git/meta-freescale -b $YOCTO_RELEASE
git clone git@github.com:beck-ipc/meta-at-chip.git
echo
echo Initialising build setup
echo
mkdir -p build-$YOCTO_MACHINE/conf
cp meta-at-chip/documentation/bblayers.conf.sample build-$YOCTO_MACHINE/conf/bblayers.conf
cp meta-at-chip/documentation/local.conf.sample build-$YOCTO_MACHINE/conf/local.conf

echo
echo
echo Your BSP has been set up in directory $YOCTO_DIR
echo
echo There run \. oe-init-build-env build-$YOCTO_MACHINE\"
echo in order to set up your build.
echo
echo For your target you can continue building a filesystem image with this command
echo
echo bitbake $YOCTO_TARGET

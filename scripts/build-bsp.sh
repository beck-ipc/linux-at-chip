#!/bin/bash

BSPVERSION="1.0"

set +e
echo
echo "LINUX@CHIP BSP Version ${BSPVERSION}"
echo
cd yocto-bsp
. ./oe-init-build-env build-sc145
echo Building for SC145 in "`pwd`"
bitbake at-chip-console-image
echo Building toolchain
bitbake at-chip-console-image -c populate_sdk
VM_TOOLCHAIN=$PWD/`ls tmp/deploy/sdk/*.sh`
echo Toolchain located at $VM_TOOLCHAIN
cd ..
echo DONE

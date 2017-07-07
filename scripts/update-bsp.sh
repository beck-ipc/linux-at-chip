#!/bin/sh

BASEDIR=$PWD
TREES=". meta-yocto meta-freescale meta-openembedded meta-at-chip meta-webstuff linux-at-chip "

echo
echo LINUX@CHIP Yocto BSP updater
echo
echo Checking required tools
echo
if [ -z $(which git) ]; then
	echo 'Error: git not found, please install git (e.g. "apt-get install git").'
	exit 1
fi
echo ok
echo
if [ ! -d ./meta-at-chip ]; then
	echo 'Error: Please run this script from your BSP main directory (usually "yocto-bsp")'
	exit 2
fi                

echo Updating known repositories
echo

rm ${BASEDIR}/manifest.txt

for tree in $TREES; do
	echo Updating $tree...
	cd $tree
	git stash && git pull --rebase && git stash pop

	git log -1 | grep "^commit" | sed "s/commit/${tree}/g" >> ${BASEDIR}/manifest.txt
	cd $BASEDIR
done

echo
echo "finished updating repositories"
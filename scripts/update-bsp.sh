#!/bin/sh

BASEDIR=$PWD
YOCTO_RELEASE="morty"

TREES=". meta-yocto meta-freescale meta-openembedded meta-qt5 meta-at-chip meta-webstuff linux-at-chip "

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

if [ ! -d ./meta-webstuff ]; then
	echo Adding meta-webstuff repository
	git clone https://github.com/kernelconcepts/meta-webstuff.git
fi

if [ ! -d ./meta-qt5 ]; then
	echo Adding meta-qt5 repository
	git clone https://github.com/meta-qt5/meta-qt5.git -b $YOCTO_RELEASE
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
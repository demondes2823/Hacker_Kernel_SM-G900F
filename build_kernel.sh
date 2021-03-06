#!/bin/bash
# kernel build script by thehacker911

KERNEL_DIR=/home/thehacker911/android/kernel/test2
BUILD_USER="$USER"
TOOLCHAIN_DIR=/home/thehacker911/android/toolchains

# Toolchains

#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/test/bin/arm-eabi-
BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.10-sm/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.9.1-sm/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.9.1/bin/arm-gnueabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.8.3/bin/arm-gnueabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-eabi-4.7/bin/arm-eabi-
#BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/arm-linux-androideabi-4.7-linaro/bin/arm-linux-androideabi-


BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`
KERNEL_DEFCONFIG=msm8974_sec_defconfig
USER_DEFCONFIG=hacker_defconfig
VARIANT_DEFCONFIG=msm8974pro_sec_klte_eur_defconfig
SELINUX_DEFCONFIG=selinux_defconfig


BUILD_KERNEL()
{	
	echo ""
	echo "=============================================="
	echo "START: MAKE CLEAN"
	echo "=============================================="
	echo ""
	

	make clean


	echo ""
	echo "=============================================="
	echo "END: MAKE CLEAN"
	echo "=============================================="
	echo ""

	echo "CPU"
	echo "$BUILD_JOB_NUMBER"
	echo "BUILD USER"
	echo "$BUILD_USER"
	echo "TOOLCHAIN"
	echo "$BUILD_CROSS_COMPILE"
	
	
	echo ""
	echo "=============================================="
	echo "START: BUILD_KERNEL"
	echo "=============================================="
	echo ""
	
	export ARCH=arm
	export CROSS_COMPILE=$BUILD_CROSS_COMPILE
	export ENABLE_GRAPHITE=true 
	make $KERNEL_DEFCONFIG $USER_DEFCONFIG VARIANT_DEFCONFIG=$VARIANT_DEFCONFIG SELINUX_DEFCONFIG=$SELINUX_DEFCONFIG
#	make CONFIG_NO_ERROR_ON_MISMATCH=y -j$BUILD_JOB_NUMBER
	make -j$BUILD_JOB_NUMBER
	

	echo ""
	echo "================================="
	echo "END: BUILD_KERNEL"
	echo "================================="
	echo ""
}





# MAIN FUNCTION
rm -rf ./build.log
(
	START_TIME=`date +%s`
	BUILD_DATE=`date +%m-%d-%Y`
	BUILD_KERNEL


	END_TIME=`date +%s`

	let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	 | tee -a ./build.log

# Credits:
# Samsung
# google
# osm0sis
# cyanogenmod
# kylon 

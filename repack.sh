#!/bin/bash
# kernel repack script by thehacker911

KERNEL_NAME=hacker_kernel_sm-g900F-v2.1
KERNEL_DIR=/home/thehacker911/android/kernel/s5
BUILD_USER="$USER"
REPACK_DIR=kernel_packer
FLASH_ZIP_FILES=zip_files
FLASH_ZIP_DIR=$FLASH_ZIP_FILES/$KERNEL_NAME
FLASH_ZIP_IMAGE_DIR=$FLASH_ZIP_DIR/hacker
OUTPUT_DIR=$KERNEL_DIR/output_kernel

REPACK_KERNEL()
{	
	echo ""
	echo "=============================================="
	echo "START: REPACK_KERNEL"
	echo "=============================================="
	echo ""
	
	cp arch/arm/boot/zImage $KERNEL_DIR/$REPACK_DIR/split_img/boot.img-zImage
	cd ../$REPACK_DIR
	cd $FLASH_ZIP_FILES
	mkdir $KERNEL_NAME
	mkdir hacker
	mv hacker $KERNEL_NAME
	cp -R META-INF $KERNEL_NAME
	cd ../
	./repackimg.sh 
	cp image-new.img $FLASH_ZIP_IMAGE_DIR/boot.img
	cd $FLASH_ZIP_FILES
	cd $KERNEL_NAME
	zip -r $KERNEL_NAME.zip hacker META-INF
	rm -rf hacker
	rm -rf META-INF
        mv $KERNEL_NAME.zip $OUTPUT_DIR
	cd ../
	rm -rf $KERNEL_NAME	

	echo ""
	echo "=============================================="
	echo "END: REPACK_KERNEL"
	echo "=============================================="
	echo ""

}

# MAIN FUNCTION
rm -rf ./repack.log
(
	START_TIME=`date +%s`
	BUILD_DATE=`date +%m-%d-%Y`
	REPACK_KERNEL


	END_TIME=`date +%s`

	let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	 | tee -a ./repack.log

# Credits:
# Samsung
# google
# osm0sis
# cyanogenmod
# kylon 

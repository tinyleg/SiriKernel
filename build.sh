#!/bin/bash

DTS=arch/arm64/boot/dts

# UberTC
#export CROSS_COMPILER=/home/darius/android/toolchain/aarch64-linux-android-6.0-kernel/bin/aarch64-linux-android-
export ARCH=arm64
export CROSS_COMPILE=/home/darius/android/toolchain/aarch64-cortex_a53-linux-gnueabi/bin/aarch64-cortex_a53-linux-gnueabi-
export ANDROID_MAJOR_VERSION=o
# Cleanup
make clean
make mrproper
# P580 Config
make exynos7870-gtanotexlwifi_defconfig
# p580 DTB
make exynos7870-gtanotexlwifi_kor_open_00.dtb exynos7870-gtanotexlwifi_kor_open_02.dtb
# Make zImage
make -j8

sudo cp /home/darius/android/kernel/SiriKernel/arch/arm64/boot/Image /home/darius/android/kernel/SiriKernel/Siri/out/boot.img-zImage

# Make dtb.img
DTS=arch/arm64/boot/dts
RDIR=$(pwd)

# UberTC
export CROSS_COMPILE=//home/darius/android/toolchain/aarch64-cortex_a53-linux-gnueabi/bin/aarch64-cortex_a53-linux-gnueabi-

# Cleanup
make clean && make mrproper
# P580 Config

make exynos7870-gtanotexlwifi_defconfig
make exynos7870-gtanotexlwifi_kor_open_00.dtb exynos7870-gtanotexlwifi_kor_open_02.dtb

# Make DT.img
./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048

# Cleaup
rm -rf $DTS/.*.tmp
rm -rf $DTS/.*.cmd
rm -rf $DTS/*.dtb

sudo cp /home/darius/android/kernel/SiriKernel/boot.img-dtb /home/darius/android/kernel/SiriKernel/Siri/out/boot.img-dtb


#Make DT.img

#./tools/dtbtool -o ./arch/arm64/boot/dt.img -v -s 2048 -p ./scripts/dtc/ $DTS/

#./scripts/dtbTool/dtbTool -o ./boot.img-dtb -d $DTS/ -s 2048

# Cleaup
#rm -rf $DTS/.*.tmp
#rm -rf $DTS/.*.cmd
#rm -rf $DTS/*.dtb

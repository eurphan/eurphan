#!/bin/sh

# 参数检测
if [ $# -eq 0 ]; then
	echo "input arguments please!"
	exit
fi

# 路径
src_root=$(pwd)
uboot_path=${src_root}/bootloader/uboot_imx-rel_imx_4.1.15_2.1.0_ga
kernel_path=${src_root}/kernel/kernel_linux-imx-rel_imx_4.1.15_2.1.0_ga
rootfs_path=${src_root}/rootfs/rootfs_buildroot-2019.08.1
device_path=${src_root}/device/fsl/imx6ul_topeet

echo "source root path:"${src_root}
echo "uboot source path:"${uboot_path}
echo "kernel source path:"${kernel_path}
echo "rootfs source path:"${rootfs_path}
echo "device path:"${device_path}

case $1 in 
	# 编译部分***********************************************
	-u)
		echo "**********build uboot**********"
		cd ${uboot_path}
		./build.sh
		cd -
		;;
	-k)
		echo "**********build kernel**********"
		cd ${kernel_path}
		./build.sh
		cd -
		;;
	-f)
		echo "**********build buildroot fs**********"
		cd ${rootfs_path}
		./build.sh
		cd -
		;;
	-a)
		echo "**********build all**********"
		echo "building uboot..."
		cd ${uboot_path}
		./build.sh
		cd -
		echo "building kernel..."
		cd ${kernel_path}
		./build.sh
		cd -
		echo "building buildroot fs..."
		cd ${rootfs_path}
		./build.sh
		cd -
		;;
	# 打包部分***********************************************
	-up)
		echo "**********package uboot**********"
		cd ${uboot_path}
		./cp.sh
		cd -
		;;
	-kp)
		echo "**********package kernel**********"
		cd ${kernel_path}
		./cp.sh
		./mkkernel.sh
		cd -
		;;
	-fp)
		echo "**********package build fs**********"
		cd ${device_path} 
		./fs_pre_package.sh ${rootfs_path}
		cd -
		cd ${rootfs_path}
		./mkrootfs.sh
		cd -
		;;
	-ap)
		echo "**********package all**********"
		echo "packaging uboot..."
		cd ${uboot_path}
		./cp.sh
		cd -
		echo "packaging kernel..."
		cd ${kernel_path}
		./cp.sh
		./mkkernel.sh
		cd -
		echo "packaging buildroot fs..."
		cd ${device_path} 
		./fs_pre_package.sh ${rootfs_path}
		cd -
		cd ${rootfs_path}
		./mkrootfs.sh
		cd -
		;;
	# 编译并打包部分***********************************************
	-ubp)
		echo "**********build and package uboot**********"
		cd ${uboot_path}
		./build.sh
		./cp.sh
		cd -
		;;
	-kbp)
		echo "**********build and package kernel**********"
		cd ${kernel_path}
		./build.sh
		./cp.sh
		./mkkernel.sh
		cd -
		;;
	-fbp)
		echo "**********build and package buildroot fs**********"
		cd ${rootfs_path}
		./build.sh
		cd -
		cd ${device_path} 
		./fs_pre_package.sh ${rootfs_path}
		cd -
		cd ${rootfs_path}
		./mkrootfs.sh
		cd -
		;;
	-abp)
		echo "**********build and package all**********"
		echo "building..."
		cd ${uboot_path}
		./build.sh
		cd -
		cd ${kernel_path}
		./build.sh
		cd -
		cd ${rootfs_path}
		./build.sh
		cd -
		echo "packaging..."
		cd ${uboot_path}
		./cp.sh
		cd -
		cd ${kernel_path}
		./cp.sh
		./mkkernel.sh
		cd -
		cd ${device_path} 
		./fs_pre_package.sh ${rootfs_path}
		cd -
		cd ${rootfs_path}
		./mkrootfs.sh
		cd -
		;;
	# 帮助菜单
	*)
		echo "input arguments please!"
		echo "arg: -u:  build uboot"
		echo "     -k:  build kernel"
		echo "     -f:  build buildroot fs"
		echo "     -a:  build all"
		echo "     -up: package uboot"
		echo "     -kp: package kernel"
		echo "     -fp: package buildroot fs"
		echo "     -ap:  package all"
		echo "     -ubp: build and package uboot"
		echo "     -kbp: build and package kernel"
		echo "     -fbp: build and package buildroot fs"
		echo "     -abp: build and package all"
		echo "     -h:  help"
		;;
esac



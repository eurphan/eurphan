#!/bin/sh

# 参数检测
if [ $# -eq 0 ]; then
	echo "input arguments please!"
	exit
fi
# 根文件系统打包文件存放路径
FS_PACKAGE_PATH=$1

echo "pre package rootfs..."

sudo rm -rf ${FS_PACKAGE_PATH}/output/wait_package/
sudo mkdir -p ${FS_PACKAGE_PATH}/output/wait_package/
# 拷贝
sudo cp -r rootdir/* ${FS_PACKAGE_PATH}/output/wait_package/

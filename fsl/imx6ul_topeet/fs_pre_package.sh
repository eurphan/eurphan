#!/bin/sh

# 参数检测
if [ $# -ne 2 ]; then
	echo "input arguments please!"
	exit
fi
# 根文件系统打包文件存放路径
FS_PACKAGE_PATH=$1
# 第三方工具包存放路径
EXTERNAL_PACKAGE_PATH=$2

echo "pre package rootfs..."

sudo rm -rf ${FS_PACKAGE_PATH}/output/wait_package/
sudo mkdir -p ${FS_PACKAGE_PATH}/output/wait_package/

# 拷贝
cat ${EXTERNAL_PACKAGE_PATH}/list | while read line; do
	echo "package external file ${line} ..."
	sudo cp -a ${EXTERNAL_PACKAGE_PATH}/${line}/out/* ${FS_PACKAGE_PATH}/output/wait_package/
done

sudo cp -r rootdir/* ${FS_PACKAGE_PATH}/output/wait_package/

sync

#!/bin/bash
set -e

KERNEL=kernel-qemu-4.4.34-jessie

IMAGE_VERSION=2017-04-10
IMAGE_TYPE=jessie


IMAGE=${IMAGE_VERSION}-raspbian-${IMAGE_TYPE}

mkdir -p data
cd data

wget -c https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/$KERNEL
wget -c https://downloads.raspberrypi.org/raspbian/images/raspbian-${IMAGE_VERSION}/${IMAGE}.zip

unzip ${IMAGE}.zip
qemu-img convert ${IMAGE}.img ${IMAGE}.qcow2
rm ${IMAGE}.img

#!/bin/bash
RPI_KERNEL=kernel-qemu-4.4.34-jessie
RPI_FS=2017-04-10-raspbian-jessie.qcow2

sudo tunctl -t tap0 -u $USER
sudo ifconfig tap0 172.16.0.1/24

qemu-system-arm -kernel $RPI_KERNEL   -cpu arm1176   -m 256   -M versatilepb   -no-reboot   -serial stdio   -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw"   -drive "file=$RPI_FS,index=0,media=disk,format=raw" -net nic -net tap,ifname=tap0,script=no,downscript=no

sudo tunctl -d tap0

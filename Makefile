KERNEL = kernel-qemu-4.4.34-jessie
IMAGE_VERSION = 2017-04-10
IMAGE_TYPE = jessie

SSH_PASS = raspberry

_IMAGE=${IMAGE_VERSION}-raspbian-${IMAGE_TYPE}

run:
	sudo tunctl -t tap0 -u ${USER}
	sudo ifconfig tap0 172.16.0.1/24

	qemu-system-arm -kernel data/${KERNEL}   \
				-cpu arm1176   -m 256   -M versatilepb   \
				-no-reboot   -serial stdio   \
				-append "root=/dev/sda2 panic=1 rootfstype=ext4 rw"   \
				-drive "file=data/${_IMAGE}.qcow2,index=0,media=disk,format=raw" \
				-net nic -net tap,ifname=tap0,script=no,downscript=no

	sudo tunctl -d tap0

apt-install:
	sudo apt update
	sudo apt install -y qemu-utils qemu-system-arm openssh-client sshpass uml-utilities

.ONESHELL:
download:
	mkdir -p data
	cd data

	wget -c https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/${KERNEL}
	wget -c https://downloads.raspberrypi.org/raspbian/images/raspbian-${IMAGE_VERSION}/${_IMAGE}.zip

	unzip ${_IMAGE}.zip
	qemu-img convert ${_IMAGE}.img ${_IMAGE}.qcow2
	rm ${_IMAGE}.img

ssh:
	sshpass -p ${SSH_PASS} ssh pi@172.16.0.2

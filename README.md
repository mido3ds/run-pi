# Emulate raspberry-pi on x86
Script to automate running raspberry-pi on x86 linux using qemu and ssh into it easily

## How to run
```bash
git clone https://github.com/mido3ds/run-pi
cd run-pi

make apt-install # (only debian/ubuntu) to install dependencies
make download # downloads the image and kernel and unzips the image, takes some time
make run
```

## How to ssh
### On raspberry-pi
```bash
# you need to run these one time
sudo systemctl enable ssh
sudo systemctl start ssh

# run each time you boot raspberry-pi
# add it to /etc/rc.local (before exit 0) to run on startup

sudo ifconfig eth0 172.16.0.2
```

### On host machine
```
make ssh
```

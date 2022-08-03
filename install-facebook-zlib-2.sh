#!/bin/bash

export user_for_Build="steven"
printf "User is: %s\n" "$user_for_Build"
export uml_VERSION="UML-11"
export zram_zswap="zram-zswap"
export zram_zswap_scripts_dir="/home/$user_for_Build/$uml_VERSION/$zram_zswap"
export zram_zswap_dir="/tmp/$zram_zswap"
export randomized_string="8234006334534"
touch /tmp/safety-8234006334534
rm -rf ${zram_zswap_dir:-/tmp/safety-8234006334534/}
mkdir "$zram_zswap_dir"
function zlog_file_config() {
zlog_file="/home/$user_for_Build/$zram_zswap/zlib_zram_zswap.log"

if [[ -f "$zlog_file" ]]
then
    rm "$zlog_file"
fi
}

zlog_file_config

function apt_Update() {
DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  -o Dpkg::Options::=--force-confold \
  -y --allow-downgrades --allow-remove-essential --allow-change-held-packages
}
# End apt_Update

#function uml_Unified_Function_File_Call() {
#. "/home/$user_for_Build/$uml_VERSION/UML-Unified-Functions-2.sh"
#}

function add_to_grub() {
FILE="/etc/grub"
read -r -d '' LINE_CONTENTS << "EOF_GRUB"
#grub-8234006334534
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4hc"
#grub-8234006334534
EOF_GRUB

}

function add_to_a_file() {
arg1=$1
arg2=$2

printf "SCRIPT TO PUT INTO %s \n \n with contents %s \n \n" "$arg1" "$arg2"  

countUML=$(grep -o -i  "$arg1" "$arg2" | wc -l )
if [ "$countUML" -eq 0 ]; then
echo "$arg1" >> "$arg2"
else
printf "Script already added in full OR in part  to .bashrc \n" 
printf "continuing \n"
fi

} 
# End add_to_a_file


function apt_install_Program_Requirements() {

DEBIAN_FRONTEND=noninteractive apt-get install wget tar build-essential twisted-doc python3-twisted zlib1g \
zlib1g-dev liblzma-dev liblz4-dev git cmake \
libboost-system-dev libboost-thread-dev \
libboost-program-options-dev libboost-test-dev stress-ng nano gedit -y
}

zlog_file_config

#uml_Unified_Function_File_Call

apt_Update
apt_install_Program_Requirements

pushd "$zram_zswap_dir" || printf "can not change to zswap-cli source directory\n"
git clone https://github.com/facebook/zstd.git
 
pushd "$zram_zswap_dir/zstd"  || printf "can not change to zstd directory\n"
git checkout release
make
make install

modprobe lz4hc lz4hc_compress

 
modprobe lz4hc lz4hc_compress

echo lz4hc > /sys/module/zswap/parameters/compressor
#nano /etc/default/grub

pushd "$zram_zswap_dir" || printf "can not change to zswap-cli source directory\n" 
git clone --recursive  --depth=1  https://github.com/xvitaly/zswap-cli.git
pushd "$zram_zswap_dir/zswap-cli" || printf 'Can not change to zswap-cli build directory, exiting' 
git submodule update --recursive --remote


mkdir build

pushd "$zram_zswap_dir/zswap-cli/build" || printf 'can not change to the zswap-cli build directory'

cmake ..
make -j "$(nproc)*2"

make install

pushd "$zram_zswap_dir" || printf 'can not change to zram_zswap_dir' 

# NO longer used
function add_this_to_etc_grub() {
FILE="/etc/default/grub"

read -r -d '' LINE_CONTENTS << 'EOF_GRUB-8234006334534'
#grub-8234006334534
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4hc"
#grub-8234006334534
EOF_GRUB-8234006334534
}
# NO Longer used

function add_this_to_initramfs_modules() {
FILE="/etc/initramfs-tools/modules"

read -r -d '' LINE_CONTENTS << 'initramfs-mods-8234006334534'
#initramfs-mods-8234006334534
# List of modules that you want to include in your initramfs.
# They will be loaded at boot time in the order below.
#
# Syntax:  module_name [args ...]
#
# You must run update-initramfs(8) to effect this change.
#
# Examples:
#
# raid1
# sd_mod
lz4
lz4_compress
z3fold
zstd
z3fold
lz4hc
lz4hc_compress
z3fold
initramfs-mods-8234006334534
}

add_this_to_initramfs_modules
add_to_a_file  "$LINE_CONTENTS" "$FILE" 

update-initramfs -u

function add_this_to_systemd() {
FILE="/etc/initramfs-tools/modules"

read -r -d '' LINE_CONTENTS << 'ZRAM_SERVICE-8234006334534'
[Unit]
Description=Zram-based swap (compressed RAM block devices)

[Service]
Type=oneshot
ExecStart=/etc/systemd/system/zram start
ExecStop=/etc/systemd/system/zram stop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
ZRAM_SERVICE-8234006334534
}
add_this_to_systemd
add_to_a_file  "$LINE_CONTENTS" "$FILE"  

function add_this_ZSWAP_to_systemd() {
FILE="/lib/systemd/system/zswap.service"


read -r -d '' LINE_CONTENTS << 'ZSWAP.service-8234006334534'
[Unit]
Description=Zram-based swap (compressed RAM block devices)

[Service]
Type=oneshot
ExecStart=/etc/systemd/system/zram start
ExecStop=/etc/systemd/system/zram stop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
ZSWAP.service-8234006334534
}

add_this_ZSWAP_to_systemd

add_to_a_file "$LINE_CONTENTS" "$FILE" 
chmod 644 /lib/systemd/system/zswap.service

update-rc.d zswap.service enable 2


function apt_install_ZRAM_Program_Requirements() {

DEBIAN_FRONTEND=noninteractive apt-get install systemd-zram-generator -y
}

apt_install_ZRAM_Program_Requirements

function add_this_ZRAM_to_systemd() {

FILE="/etc/systemd/zram-generator.conf"

read -r -d '' LINE_CONTENTS << 'ZRAM_service-8234006334534'
compression-algorithm = lz4hc[zram0]
zram-fraction=1.0
max-zram-size=16384
compression-algorithm=lz4hc
ZRAM_service-8234006334534
}

apt_install_ZRAM_Program_Requirements
add_this_ZRAM_to_systemd
add_to_a_file "$LINE_CONTENTS" "$FILE" 
chmod 644 /etc/systemd/zram-generator.conf

function generate_zram_zswap_ctrl_script() {
FILE="/usr/local/bin/zram_zswap_stat.sh"

read -r -d '' LINE_CONTENTS << 'zram_zswap_stat.sh-8234006334534'
#!/bin/bash
printf "zram configuration help  This command needs to be run as root  \n"
zramctl --help
printf "zswap configuration help  This command needs to be run as root  \n"
zswap-cli --help

printf "zswap current stats ...\n "
zswap-cli --stats
printf "zram current stats ... \n "
zramctl
zram_zswap_stat.sh-8234006334534
}

generate_zram_zswap_ctrl_script
add_to_a_file  "$LINE_CONTENTS" "$FILE"

chmod 755 "/usr/local/bin/zram_zswap_stat.sh"

zswap-cli --enabled Y --same_filled_pages_enabled Y --max_pool_percent 60 --compressor zstd --zpool z3fold --accept_threshold_percent 40

# git clone --depth=1 --recursive https://github.com/xvitaly/zswap-cli.git  compile and install straight forward
# stress-ng --vm-bytes $(awk '/MemAvailable/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1
# older kernels stress-ng --vm-bytes $(awk '/MemFree/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1

function add_ZSWAP_ZRAM_ON_binary_to_usr_bin() {

FILE="/usr/local/bin/ZRAM_ZSWAP_ON.sh"

read -r -d '' LINE_CONTENTS << 'ZRAM_ZSWAP_ON'
read -r -d '' LINE_CONTENTS << 'zram_zswap_ON-8234006334534'
#!/bin/bash

#ZRAM Config 

#Disable zswap
echo 0 > /sys/module/zswap/parameters/enabled

modprobe zram

#ZRAM swap
#zram0
echo lz4hc > /sys/block/zram0/comp_algorithm
echo 4G > /sys/block/zram0/disksize
mkswap --label zram0 /dev/zram0
swapon --priority 32767 /dev/zram0

#zram1
cat /sys/class/zram-control/hot_add
echo lz4hc > /sys/block/zram1/comp_algorithm
echo 4G > /sys/block/zram1/disksize
mkswap --label zram1 /dev/zram1
swapon --priority 32767 /dev/zram1

#zram2
cat /sys/class/zram-control/hot_add
echo lz4hc > /sys/block/zram2/comp_algorithm
echo 4G > /sys/block/zram2/disksize
mkswap --label zram2 /dev/zram2
swapon --priority 32767 /dev/zram2

#zram3
cat /sys/class/zram-control/hot_add
echo lz4hc > /sys/block/zram3/comp_algorithm
echo 4G > /sys/block/zram3/disksize
mkswap --label zram3 /dev/zram3
swapon --priority 32767 /dev/zram3

# /tmp on ZRAM
cat /sys/class/zram-control/hot_add
echo lz4hc > /sys/block/zram4/comp_algorithm
echo 6G > /sys/block/zram4/disksize
mkfs.ext4 /dev/zram4
mount /dev/zram4 /tmp
chmod 1777 /tmp

#Virtual Memory Kernel Tweaks default for low-memory systems
sysctl -w vm.swappiness=100
sysctl -w vm.vfs_cache_pressure=500
sysctl -w vm.dirty_background_ratio=1
sysctl -w vm.dirty_ratio=50
zram_zswap_ON-8234006334534
ZRAM_ZSWAP_ON
}
add_ZSWAP_ZRAM_ON_binary_to_usr_bin
add_to_a_file  "$LINE_CONTENTS" "$FILE"

chmod 755 /usr/local/bin/ZRAM_ZSWAP_ON.sh

function add_ZSWAP_ZRAM_OFF_binary_to_usr_bin() {

FILE="/usr/local/bin/ZRAM_ZSWAP_OFF.sh"

read -r -d '' LINE_CONTENTS << 'ZRAM_ZSWAP_OFF-8234006334534'
#!/bin/bash

#ZRAM Config

#ZRAM Swap
swapoff /dev/zram0
swapoff /dev/zram1
swapoff /dev/zram2
swapoff /dev/zram3
# /tmp on ZRAM
umount /dev/zram4

echo 0 > /sys/class/zram-control/hot_remove
# Not required, but creating a blank uninitalzed drive
# after removing one may be desired
cat /sys/class/zram-control/hot_add
ZRAM_ZSWAP_OFF-8234006334534
}
add_ZSWAP_ZRAM_OFF_binary_to_usr_bin
add_to_a_file  "$LINE_CONTENTS" "$FILE"
chmod 755 /usr/local/bin/ZRAM_ZSWAP_OFF.sh

printf "current grub configuration: \n" 
echo "$(</etc/default/grub )" | grep -i "GRUB_CMDLINE_LINUX_DEFAULT"
printf "\n\n\n"
cp /etc/default/grub /etc/default/grub.sav
printf "setting grub CMDLINE to:"
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4hc"/g' /etc/default/grub
echo "$(</etc/default/grub )" | grep -i "GRUB_CMDLINE_LINUX_DEFAULT"
printf "\n\n\n"
update-grub

cat <<- "PRINT_TEXT"

added  the following to /etc/default/grub
edited the line that reads 
GRUB_CMDLINE_LINUX_DEFAULT=quiet splash or something similar and
change it to read: 
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.max_pool_percent=25 zswap.compressor=lz4hc"
and made a backup copy of it at /etc/default/grub.sav

***IF FOR SOME REASON YOUR SYSTEM DOES NOT BOOT*** 
then follow these directions to get your system to boot:

https://askubuntu.com/questions/19486/how-do-i-add-a-kernel-boot-parameter

once booted you will need to do:

nano /etc/default/grub and change the 

line to read GRUB_CMDLINE_LINUX_DEFAULT=quiet splash

followed by:

sudo update-grub

You will need to know the administrator password.


After this you can safely reboot the machine.

If it does not work then you will need to follow the directions at the url again.

please take a camera shot of this screen for your notes before restarting the system


If all went well you should have a working system and the above steps will not be necessary

To stress test your system, use:

( After taking a pic with your camera, run the following command after a reboot )

stress-ng --vm-bytes '$(awk '/MemAvailable/{printf "%d\n", $2 * 0.9;}' < /proc/meminfo)k --vm-keep -m 1'
stress-ng --vm 1 --vm-bytes 75% --vm-method all --verify -t 10m -v
Run: /usr/local/bin/./zram_zswap_stat.sh 
for stats about zram zswap

For best performance consider a 4 or 8 core CPU , OR ADDING in a compression accelerator PCIe 16x card, with a high performance one you could possibly enable even much higher compression than lc4hc (which this enables). I will follow up with this in the future when I can purchase one.

Lastly, consider adding /usr/local/bin/ to Your PATH statement in ~/.bashrc (nano ~/.bashrc)
PRINT_TEXT

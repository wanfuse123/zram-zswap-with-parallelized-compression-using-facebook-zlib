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

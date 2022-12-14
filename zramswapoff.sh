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

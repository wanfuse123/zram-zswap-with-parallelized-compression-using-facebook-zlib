#!/bin/bash

start() {
  for i in {0..4}; do /usr/bin/echo 1610612736 > /sys/block/zram${i}/disksize; /usr/bin/mkswap /dev/zram${i}; /usr/bin/swapon -p100 /dev/zram${i}; done
}

stop() {
  for i in {0..4}; do /usr/bin/swapoff /dev/zram${i}; /usr/bin/echo 1 > /sys/block/zram${i}/reset; done
}

case $1 in
  start|stop) "$1" ;;
esac

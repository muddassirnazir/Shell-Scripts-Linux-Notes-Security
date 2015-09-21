#!/bin/bash
#lvcreate -L 2G -n brick$1 vg_bricks
#mkfs.xfs -i size=512 /dev/vg_bricks/brick$1
#mkdir -p /bricks/brick$1
#echo "/dev/vg_bricks/brick$1 /bricks/brick$1 xfs defaults 0 0" >> /etc/fstab
#mount -a
#df -h

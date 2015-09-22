#!/bin/bash
#Author: Muddassi Nazir
#This script will create partitions to be used with glusterfs volumes.
#Use this scripts across multiple machines and create bricks prior to creating volumes.
#Remember to put a brick number at runtime as ./brick_script.sh 1 or bash brick_script 3 etc. 

lvcreate -L 2G -n brick$1 vg_bricks`
mkfs.xfs -i size=512 /dev/vg_bricks/brick$1
mkdir -p /bricks/brick$1
echo "/dev/vg_bricks/brick$1 /bricks/brick$1 xfs defaults 0 0" >> /etc/fstab
mount -a
df -h

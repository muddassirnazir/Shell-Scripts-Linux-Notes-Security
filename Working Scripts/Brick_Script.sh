#!/bin/bash

#Author: Muddassi Nazir
#This script will create partitions to be used with glusterfs volumes.
#Use this scripts across multiple machines and create bricks prior to creating volumes.
#Remember to put a brick number at runtime as ./brick_script.sh 1 or bash brick_script 3 etc.
#Prerequisites : A volume group must be created using the vgcreate command.
#This is how lvcreate creates logical volumes using the volume group vg_bricks

lvcreate -L 2G -n brick$1 vg_bricks

#Format the lv with xfs
mkfs.xfs -i size=512 /dev/vg_bricks/brick$1

#Create a directory where this lv is to be mounted.
mkdir -p /bricks/brick$1

#Add the fstab entry
echo "/dev/vg_bricks/brick$1 /bricks/brick$1 xfs defaults 0 0" >> /etc/fstab

#Mount it up
mount -a

#Check it all out
df -h

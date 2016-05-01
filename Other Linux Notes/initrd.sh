#The initial RAM disk (initrd) is an initial root file system that is mounted prior to when the real root file system is
#available. The initrd is bound to the kernel and loaded as part of the kernel boot procedure. The kernel then mounts
#this initrd as part of the two-stage boot process to load the modules to make the real file systems available and get
#at the real root file system. The initrd contains a minimal set of directories and executables to achieve this, such
#as the insmod tool to install kernel modules into the kernel.
#In the case of desktop or server Linux systems, the initrd is a transient file system. Its lifetime is short, only serving
#as a bridge to the real root file system. In embedded systems with no mutable storage, the initrd is the permanent root
#file system.

#initrd.img is in gzip format.  So move initrd.img to initrd.gz first

`mkdir /temp`
`cd /temp`
`cp /boot/initrd.img .`
`ls`
`mv initrd.img initrd.gz`

#Unzip the initrd.gz file
`gunzip initrd.gz`

#After unziping the initrd.gz file, the initrd is further in cpio ‘newc’ format.
#So extract the files from initrd using cpio ‘newc’ format.
#Note: info cpio will give more information about ‘newc’ format.

`mkdir tmp2`
`cd tmp2/`
`cpio -id < ../initrd`

#File contents can be viewed with ls command.

#After extracting the file as shown below, make appropriate modification to any of those files.
#Then pack the files back into the archive using the following commands.
#Pack the modified files back to cpio ‘newc’ format.

`find . | cpio --create --format='newc' > /temp/tmp2/newinitrd`
`ls /temp/tmp2/`

#Gzip the new archive.
`gzip newinitrd`
`mv newinitrd.gz newinitrd.img`

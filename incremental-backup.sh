#!/bin/sh
####################################
#
# Backup to NTFS mount script.
#
####################################

# What to backup.
backup_files="/home /example/* /neatstuff/*"

# Set USB device location: sudo fdisk -l | grep NTFS | awk '{print $1}'
case "$1" in
  [a-zA-Z] ) usbDevice="/dev/sd$11";;
  *        ) usbDevice="/dev/sdb1";;
esac


# Where to backup to.
dest="/media/someDevice"

# Create archive filename.
date=$(date +%F)
hostname=$(hostname -s)
archive_file="$hostname$date.tar"
incremental_file="/home/someUser/$hostname.inc"

# Mount NTFS USB Drive
echo "Mounting $usbDevice to $dest."
sudo mount -t ntfs-3g $usbDevice $dest
echo

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file."
date
echo


# Backup the files using tar.
tar cpf $dest/$archive_file -g $incremental_file $backup_files

# Print end status message.
echo
echo "Backup finished."
date
echo

# Long listing of files in $dest to check file sizes.
ls -lh $dest

# Unmount NTFS USB Drive 
echo
echo "Unmounting $usbDevice from $dest."
sudo umount $dest
echo

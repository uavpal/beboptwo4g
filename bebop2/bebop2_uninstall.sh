#!/bin/sh
echo "=== Uninstalling BebopTwo4G on Bebop 2 ==="
echo "Remounting filesystem as read/write"
mount -o remount,rw /
echo "Reverting rcS init script"
sed -i 's/\/data\/ftp\/uavpal\/bin\/uavpal_usbmode.sh \&//g' /etc/init.d/rcS
echo "Removing ppp directory including symlink for ppp-lte settings"
rm -rf /etc/ppp
echo "Removing symlink udev rule"
rm -f /lib/udev/rules.d/70-huawei-e3372.rules
echo "Removing symlink for ntpd's config file"
rm -f /etc/ntp.conf
echo "Remounting filesystem as read-only"
mount -o remount,ro /
echo "Removing zerotier-one data"
rm -rf /data/lib/zerotier-one
echo "Removing uavpal softmod files"
rm -rf /data/ftp/internal_000/uavpal
rm -f /data/ftp/uavpal
echo "Removing uavpal softmod installation files"
rm -rf /data/ftp/internal_000/beboptwo4g*
echo "All done! :)"
echo

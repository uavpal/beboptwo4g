ulogger -s -t uavpal_drone "... enabling telnet/adb"
/usr/bin/pstart telnetd
/usr/bin/pstart adbd
sleep 15
drone_fw_version=$(grep ro.parrot.build.uid /etc/build.prop | cut -d '-' -f 3)
drone_fw_version_numeric=${drone_fw_version//.}
if [ "$drone_fw_version_numeric" -ge "470" ]; then
	ulogger -s -t uavpal_drone "... pausing shpoison (firmware >=4.7.0)"
	killall -SIGSTOP shpoison
	# Note: this will also block /bin/onoffbutton/shortpress_4.sh, as for firmware >=4.7.0, shpoison is used to enable debug mode. Therefore, we start telnet/adb manually on bootup.
else
	ulogger -s -t uavpal_drone "... pausing telnet/adb and pausing usb_mode (firmware <=4.4.2)"
	killall -SIGSTOP usb_mode
fi
ulogger -s -t uavpal_drone "... restarting udev daemon"
killall -9 udevd

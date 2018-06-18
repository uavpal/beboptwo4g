ulogger -s -t uavpal_bebop2 "... enabling telnet/adb"
/usr/bin/pstart telnetd
/usr/bin/pstart adbd
sleep 15
bebop2_fw_version=`grep ro.parrot.build.uid /etc/build.prop | cut -d '-' -f 3`
bebop2_fw_version_numeric=${bebop2_fw_version//.}
if [ "$bebop2_fw_version_numeric" -ge "470" ]; then
	ulogger -s -t uavpal_bebop2 "... pausing shpoison (firmware >=4.7.0)"
	killall -SIGSTOP shpoison
	# Note: this will also block /bin/onoffbutton/shortpress_4.sh, as for firmware >=4.7.0, shpoison is used to enable debug mode. Therefore, we start telnet/adb manually on bootup.
else
	ulogger -s -t uavpal_bebop2 "... pausing telnet/adb and pausing usb_mode (firmware <=4.4.2)"
	killall -SIGSTOP usb_mode
fi
ulogger -s -t uavpal_bebop2 "... restarting udev daemon"
killall -9 udevd

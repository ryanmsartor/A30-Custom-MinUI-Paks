#!/bin/sh

echo "1,30,50,50,50" > /sys/devices/virtual/disp/disp/attr/enhance

mount -o bind "/mnt/SDCARD/Tools/my282/RetroArch.pak/res" /usr/miyoo/res


#!/bin/sh

mydir=`dirname "$0"`
TARGET_LAUNCH_SH="/mnt/SDCARD/.system/my282/paks/MinUI.pak/launch.sh"

sed -i 's/overclock.elf userspace 2 1512 384 1080 0/overclock.elf performance 2 1344 384 1080 0/g' "$TARGET_LAUNCH_SH"

overclock.elf performance 2 1344 384 1080 0

cd $mydir

if [ ! -f "/tmp/.show_hotkeys" ]; then
    touch /tmp/.show_hotkeys
    LD_LIBRARY_PATH=libs2:/usr/miyoo/lib ./show_hotkeys
fi

export HOME=$mydir
export LD_LIBRARY_PATH=libs:/usr/miyoo/lib:/usr/lib
export SDL_VIDEODRIVER=mmiyoo
export SDL_AUDIODRIVER=mmiyoo
export EGL_VIDEODRIVER=mmiyoo

sv=`cat /proc/sys/vm/swappiness`
echo 10 > /proc/sys/vm/swappiness

cd $mydir
if [ -f 'libs/libEGL.so' ]; then
    rm -rf libs/libEGL.so
    rm -rf libs/libGLESv1_CM.so
    rm -rf libs/libGLESv2.so
fi

./drastic "$1"
sync

echo $sv > /proc/sys/vm/swappiness

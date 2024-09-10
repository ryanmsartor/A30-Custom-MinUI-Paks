#!/bin/sh

overclock.elf userspace 2 1344 384 1080 0

while :; do
    syncsettings.elf
done &
LOOP_PID=$!

echo $0 $*
RA_DIR=/mnt/SDCARD/Tools/my282/RetroArch.pak
EMU_DIR=/mnt/SDCARD/Emus/my282/EASYRPG.pak

cd "$RA_DIR"
HOME=$RA_DIR/ $RA_DIR/ra32.miyoo -v -L $RA_DIR/.retroarch/cores/easyrpg_libretro.so "$*"


kill $LOOP_PID

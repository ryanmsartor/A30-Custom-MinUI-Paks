#!/bin/sh

while :; do
    syncsettings.elf
done &
LOOP_PID=$!

export picodir=/mnt/SDCARD/Tools/my282/PICO-8.pak
export HOME="$picodir"

export PATH="$HOME"/bin:$PATH
export LD_LIBRARY_PATH="$HOME"/lib:$LD_LIBRARY_PATH
export SDL_VIDEODRIVER=mali
export SDL_JOYSTICKDRIVER=a30

cd "$picodir"

sed -i 's|^transform_screen 0$|transform_screen 135|' "$HOME/.lexaloffle/pico-8/config.txt"

overclock.elf userspace 2 1200 384 1080 0

pico8_dyn -width 640 -height 480 -scancodes -run "$1"
sync
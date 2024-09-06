#!/bin/sh

export picodir=/mnt/SDCARD/Tools/my282/PICO-8.pak
export HOME="$picodir"
export PATH="$HOME/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"
export SDL_VIDEODRIVER=mali
export SDL_JOYSTICKDRIVER=a30

WIFI_PAK_PATH="/mnt/SDCARD/Tools/my282"
MARKER_FILE="$WIFI_PAK_PATH/WiFi enabled.pak/.wifi_enabled"

SCRIPT_DIR="$(dirname "$0")"
IMAGE_PATH="$SCRIPT_DIR/res/connecting.png"

show_image() {
    show.elf "$1"
}

if [ -f "$MARKER_FILE" ]; then
    show_image "$IMAGE_PATH"
    wifi_status=$(ifconfig wlan0 | grep "inet " | wc -l)
    if [ "$wifi_status" -eq 0 ]; then
        ifconfig wlan0 up
        wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
        udhcpc -i wlan0
        sleep 5
    fi
    pkill -f "show.elf $IMAGE_PATH"
fi

while :; do
    syncsettings.elf
done &
LOOP_PID=$!

cd "$picodir"
sed -i 's|^transform_screen 0$|transform_screen 135|' "$HOME/.lexaloffle/pico-8/config.txt"

pico8_dyn -splore -width 640 -height 480 -root_path "/mnt/SDCARD/Roms/PICO8/" &> ./log.txt
sync
cp /mnt/SDCARD/App/pico/.lexaloffle/pico-8/bbs/carts/*.p8.png /mnt/SDCARD/Roms/PICO8/
sync
kill $LOOP_PID


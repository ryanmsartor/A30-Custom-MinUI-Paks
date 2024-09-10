#!/bin/sh

SCRIPT_DIR="$(dirname "$0")"
RES_PATH="$SCRIPT_DIR/res"
ENABLE_IMAGE="$RES_PATH/enable.png"
DISABLE_IMAGE="$RES_PATH/disable.png"
REBOOT_IMAGE="$RES_PATH/reboot.png"
LAUNCH_SH="/mnt/SDCARD/.system/my282/paks/MinUI.pak/launch.sh"
BACKUP_SH="/mnt/SDCARD/.system/my282/paks/MinUI.pak/launch_original.sh"
WPA_CONF="$SCRIPT_DIR/wpa_supplicant.conf"
INTERNAL_CONFIG_PATH="/config"
SYSTEM_JSON_PATH="$INTERNAL_CONFIG_PATH/system.json"
MARKER_FILE="$SCRIPT_DIR/.wifi_enabled"

show_image() {
    show.elf "$1"
}

update_system_json() {
    sed -i 's/"wifi":\s*[0-9]*/"wifi": 1/' "$1"
}

if [ -f "$MARKER_FILE" ]; then
    [ -f "$BACKUP_SH" ] && cp "$BACKUP_SH" "$LAUNCH_SH" && rm "$BACKUP_SH"
    rm "$MARKER_FILE"
    show_image "$DISABLE_IMAGE"
    rm "$INTERNAL_CONFIG_PATH/wpa_supplicant.conf"
    sed -i 's/"wifi":\s*1/"wifi": 0/' "$SYSTEM_JSON_PATH"

    show_image "$REBOOT_IMAGE"
    mv "/mnt/SDCARD/Tools/my282/WiFi enabled.pak" "/mnt/SDCARD/Tools/my282/WiFi.pak" 2>/dev/null

else
    cp "$LAUNCH_SH" "$BACKUP_SH"
    sed -i 's/^.*wpa_supplicant.*$/#&/; s/^.*MtpDaemon.*$/#&/; s/^.*ifconfig wlan0 down.*$/#&/; s/^.*killall -9 wlan0.*$/#&/' "$LAUNCH_SH"
    cp "$WPA_CONF" "$INTERNAL_CONFIG_PATH/wpa_supplicant.conf"
    update_system_json "$SYSTEM_JSON_PATH"
    touch "$MARKER_FILE"
    show_image "$ENABLE_IMAGE"

    show_image "$REBOOT_IMAGE"
    mv "/mnt/SDCARD/Tools/my282/WiFi.pak" "/mnt/SDCARD/Tools/my282/WiFi enabled.pak" 2>/dev/null
fi

sleep 2
shutdown



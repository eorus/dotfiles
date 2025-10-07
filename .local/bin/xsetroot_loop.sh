#!/usr/bin/env bash
# Ultra-lightweight DWM statusbar for X220 (Nerd Font version)

while true; do
    # --- TIME ---
    TIME=" $(date '+%H:%M %d-%b')"  # Clock

    # --- BATTERY ---
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        BAT_CAP=$(cat /sys/class/power_supply/BAT0/capacity)
        BAT_STAT=$(cat /sys/class/power_supply/BAT0/status)
        BAT_TEXT=" $BAT_CAP% $BAT_STAT"  # Battery
    else
        BAT_TEXT="No BAT"
    fi

    # --- CPU LOAD ---
    CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
    CPU_TEXT=" $CPU_LOAD"  # CPU icon

    # --- VOLUME ---
    VOL_RAW=$(amixer get Master | awk -F'[][]' 'END{ print $2 " " $4 }')
    VOL_PERCENT=$(echo $VOL_RAW | awk '{print $1}' | tr -d '%')
    VOL_MUTE=$(echo $VOL_RAW | awk '{print $2}')
    if [ "$VOL_MUTE" = "off" ] || [ "$VOL_PERCENT" = "0" ]; then
        VOL_TEXT=" Mute"  # Muted speaker
    else
        VOL_TEXT=" $VOL_RAW"  # Speaker on
    fi

    # --- Wi-Fi / IP ---
    NET_TEXT=""
    for iface in /sys/class/net/*; do
        iface_name=$(basename "$iface")
        state=$(cat "$iface/operstate")
        if [[ "$iface_name" == w* && "$state" == "up" ]]; then
            IP=$(ip -4 addr show "$iface_name" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
            NET_TEXT=" $IP"  # Wi-Fi icon
            break
        fi
    done

    # --- Root disk usage ---
    DISK=$(df -h --output=pcent /home | tail -1)
    DISK_TEXT=" $DISK"  # Hard drive icon

    # --- CPU temperature ---
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        TEMP=$(awk '{printf "%.1f", $1/1000}' /sys/class/thermal/thermal_zone0/temp)
        TEMP_TEXT=" $TEMP°C"  # Thermometer
    else
        TEMP_TEXT=""
    fi

    # --- Combine and set status ---
    STATUS="$BAT_TEXT | $CPU_TEXT | $VOL_TEXT | $DISK_TEXT | $TEMP_TEXT | $TIME"

    # DWM bar update
    xsetroot -name "$STATUS"

    # BSPWM Polybar update
    echo "$STATUS" > /tmp/dwm_status.txt

    sleep 5
done

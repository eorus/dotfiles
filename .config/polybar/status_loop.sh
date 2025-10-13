
#!/bin/bash
# ~/.local/bin/status_loop.sh
# unified status loop for dwm (xsetroot) and bspwm (stdout bars)

while :; do
    # Collect info (customize as you like)
    cpu="$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
    mem="$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    bat="$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)%"
    vol="$(pamixer --get-volume-human 2>/dev/null)"
    date_time="$(date '+%Y-%m-%d %H:%M')"

    # Build one status string
    status="CPU: $cpu | RAM: $mem | VOL: $vol | BAT: $bat | $date_time"

    # For dwm (root window name)
    xsetroot -name "$status"

    # For bspwm (stdout for polybar, lemonbar, etc.)
    echo "$status"

    sleep 5
done

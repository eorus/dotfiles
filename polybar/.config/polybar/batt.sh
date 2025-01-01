#!/bin/bash

STATUS=$(cat /sys/class/power_supply/BAT0/status)
BATT=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$STATUS" = "Discharging" ]; then

    ICON=" "
else
    ICON="⚡"
fi

echo " $ICON" "$BATT%"

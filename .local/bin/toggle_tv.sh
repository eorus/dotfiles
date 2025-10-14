#!/bin/bash
# Toggle laptop screen <-> TV at Full HD

# Detect internal screen (usually eDP)
INTERNAL=$(xrandr | grep " connected" | grep -E "eDP|LVDS" | awk '{print $1}')
HDMI_OUTPUT=$(xrandr | grep "HDMI" | grep " connected" | awk '{print $1}')
PRIMARY=$(xrandr --query | grep " primary" | awk '{print $1}')

if [ -n "$HDMI_OUTPUT" ] && [ "$PRIMARY" != "$HDMI_OUTPUT" ]; then
    # Switch to TV
    xrandr --output "$HDMI_OUTPUT" --primary --mode 1920x1080 --output "$INTERNAL" --off
    notify-send "💻 → 📺" "Switched to TV at 1920x1080"
else
    # Switch back to laptop
    xrandr --output "$INTERNAL" --primary --auto --output "$HDMI_OUTPUT" --off
    notify-send "📺 → 💻" "Switched back to laptop screen"
fi

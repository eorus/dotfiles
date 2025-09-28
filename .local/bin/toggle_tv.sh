#!/bin/bash
# Toggle laptop screen <-> TV at Full HD

# Detect connected HDMI output
HDMI_OUTPUT=$(xrandr | grep "HDMI" | grep " connected" | awk '{print $1}')

# Get current primary output
PRIMARY=$(xrandr --query | grep " primary" | awk '{print $1}')

if [ -n "$HDMI_OUTPUT" ] && [ "$PRIMARY" != "$HDMI_OUTPUT" ]; then
    # TV connected and not primary: switch to TV 1080p
    xrandr --output "$HDMI_OUTPUT" --primary --mode 1920x1080 --output eDP1 --off
    notify-send "💻 → 📺" "Switched to TV at 1920x1080"
else
    # Switch back to laptop
    xrandr --output eDP1 --primary --auto --output "$HDMI_OUTPUT" --off
    notify-send "📺 → 💻" "Switched back to laptop screen"
fi

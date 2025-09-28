#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <search query>"
    exit 1
fi

QUERY="$*"

# Fast search, only 5 results, flat playlist
SELECTED=$(yt-dlp "ytsearch5:$QUERY" --flat-playlist --get-title --get-id \
    | awk 'NR%2{printf "%s\t",$0;next}{print}' \
    | fzf --with-nth=1 --delimiter=$'\t' --prompt="Select video: ")

if [ -z "$SELECTED" ]; then
    echo "No selection made."
    exit 1
fi

VIDEO_ID=$(echo "$SELECTED" | awk -F'\t' '{print $2}')
URL="https://www.youtube.com/watch?v=$VIDEO_ID"

# Detect HDMI TV
EXT_MONITOR_IDX=$(xrandr --listmonitors | awk '/HDMI/ {print $1}' | tr -d ':')
EXT_MONITOR_IDX=${EXT_MONITOR_IDX:-0}  # fallback to 0 if no HDMI

mpv "$URL" \
    --fs \
    --fs-screen=$EXT_MONITOR_IDX \
    --ytdl-format="bestvideo[height<=1080]+bestaudio/best" \
    --hwdec=auto

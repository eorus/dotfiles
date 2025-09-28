#!/bin/sh
# Terminal YouTube search + mpv playback (full HD, HDMI detection, Intel GPU)
# Requires: yt-dlp, mpv, fzf, dmenu

# 1. Prompt for search query
query=$(dmenu -i -p "Search YouTube:")
[ -z "$query" ] && exit 0  # Exit if empty

# 2. Fetch top 5 results from YouTube (flat-playlist for speed)
#    Output format: Title[TAB]VIDEO_ID
results=$(yt-dlp "ytsearch5:$query" --flat-playlist --get-title --get-id \
    | awk 'NR%2{printf "%s\t",$0; next}{print}')

# 3. Select video via fzf
selected=$(echo "$results" | fzf --with-nth=1 --delimiter=$'\t' --prompt="Select video: ")
[ -z "$selected" ] && exit 0

video_id=$(echo "$selected" | awk -F'\t' '{print $2}')
url="https://www.youtube.com/watch?v=$video_id"

# 4. Detect HDMI monitor index for fullscreen
ext_monitor_idx=$(xrandr --listmonitors | awk '/HDMI/ {print $1}' | tr -d ':')
ext_monitor_idx=${ext_monitor_idx:-0}  # fallback to 0 if no HDMI

# 5. Launch mpv fullscreen on the correct screen
mpv "$url" \
    --fs \
    --fs-screen="$ext_monitor_idx" \
    --ytdl-format="bestvideo[height<=1080]+bestaudio/best" \
    --hwdec=auto

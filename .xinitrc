#!/bin/bash
# ~/.xinitrc - universal startx script

# Source system-wide X session settings
[ -f /etc/xprofile ] && . /etc/xprofile

# Source user X session settings
[ -f ~/.config/X11/xprofile ] && . ~/.config/X11/xprofile

# Source shell environment (aliases, exports, functions)
[ -f ~/.bashrc ] && source ~/.bashrc

# Start your status bar script in background, logging stdout and stderr
~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &

# Common background services (optional)
# picom --experimental-backends &
# nm-applet &

# Ask which WM to start using dmenu or rofi
WM=$(echo -e "dwm\nbspwm" | dmenu -i -p "Select WM:")

case "$WM" in
    dwm)
        ~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &
        exec dbus-launch --sh-syntax --exit-with-session dwm
        ;;
    bspwm)
        # Start xdg-portal for Brave dialogs
        /usr/lib/xdg-desktop-portal-gtk &
        sxhkd &
        exec dbus-launch --sh-syntax --exit-with-session bspwm
        ;;
    *)
        echo "No selection made. Starting dwm as fallback."
        ~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &
        exec dbus-launch --sh-syntax --exit-with-session dwm
        ;;
esac

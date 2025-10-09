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

# Ask which WM to start, default to dwm
choice=${WM_SESSION:-dwm}   # set WM_SESSION env var or fallback to dwm

case "$choice" in
    dwm)
        # Start dwm status script
        ~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &
        exec dbus-launch --sh-syntax --exit-with-session dwm
        ;;
    bspwm)
        # Start xdg-portal for Brave dialogs
        /usr/lib/xdg-desktop-portal-gtk &
        sxhkd &
        exec dbus-launch --sh-syntax --exit-with-session bspwm
        ;;
    i3)
        # Start xdg-portal for Brave dialogs
        /usr/lib/xdg-desktop-portal-gtk &
        # i3 uses its own bar, no need for xsetroot_loop.sh here unless you want a shared bar
        exec dbus-launch --sh-syntax --exit-with-session i3
        ;;
    *)
        echo "Unknown WM: $choice, starting dwm as fallback"
        ~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &
        exec dbus-launch --sh-syntax --exit-with-session dwm
        ;;
esac

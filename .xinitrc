#!/bin/bash

# ~/.xinitrc - startx startup script

# Source system-wide X session settings
[ -f /etc/xprofile ] && . /etc/xprofile

# Source user X session settings
[ -f ~/.config/X11/xprofile ] && . ~/.config/X11/xprofile

# Source shell environment (aliases, exports, functions)
[ -f ~/.bashrc ] && source ~/.bashrc

# Start your status bar script in background, logging stdout and stderr
~/.local/bin/xsetroot_loop.sh >> ~/.xsetroot.log 2>&1 &

# Start the window manager with dbus session for session management
exec dbus-launch --sh-syntax --exit-with-session dwm
# Alternative without dbus (uncomment if you want)
# exec dwm

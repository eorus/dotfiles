#!/bin/bash

echo "=== SYSTEM DIAGNOSTIC ==="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "Shell: $SHELL"
echo "Login shell: $(shopt -q login_shell && echo yes || echo no)"
echo "Interactive shell: $(shopt -q interactive_shell && echo yes || echo no)"
echo "Terminal: $TERM"
echo "TTY: $(tty)"
echo "Home: $HOME"
echo

echo "=== SOURCED FILES ==="
[ -n "$__SOURCED_ALIASES" ] && echo "✔ aliases sourced" || echo "✖ aliases not sourced"
[ -n "$__SOURCED_EXPORTS" ] && echo "✔ exports sourced" || echo "✖ exports not sourced"
echo "PWD: $PWD"
echo "Script: $0"
echo

echo "=== PATH ==="
echo "$PATH" | tr ':' '\n'
echo

echo "=== ALIASES ==="
alias
echo

echo "=== FUNCTIONS ==="
declare -f | head -n 20
echo "... (functions truncated)"
echo

echo "=== FONT INFO ==="
echo "Monospace font: $(fc-match monospace)"
echo "Sans-serif font: $(fc-match sans-serif)"
echo "Terminal font: ${ST_FONT:-Unknown}"
echo

echo "=== TERMINAL COLORS ==="
if command -v tput &>/dev/null; then
    echo "Foreground color: $(tput setaf 7)Sample$(tput sgr0)"
    echo "Background color: $(tput setab 0)Sample$(tput sgr0)"
fi
echo "Transparency (if any): Check ST config or $XTERM_ID"
echo

echo "=== XORG / GRAPHICS ==="
if command -v xrandr &>/dev/null; then
    xrandr --query | grep " connected"
fi
if command -v glxinfo &>/dev/null; then
    echo "OpenGL renderer: $(glxinfo | grep 'OpenGL renderer' | head -1)"
fi
echo

echo "=== TOUCHPAD / INPUT ==="
if command -v xinput &>/dev/null; then
    xinput list | grep -i touchpad
    for id in $(xinput list | grep -i touchpad | awk -F'id=' '{print $2}' | awk '{print $1}'); do
        echo "--- Properties for id $id ---"
        xinput list-props "$id" | grep -E "Tapping|NaturalScrolling|Accel"
    done
fi
echo

echo "=== MAIN PACKAGES ==="
if command -v pacman &>/dev/null; then
    echo "Pacman packages: $(pacman -Q | wc -l)"
fi
if command -v yay &>/dev/null; then
    echo "AUR packages: $(yay -Q | wc -l)"
fi
if command -v flatpak &>/dev/null; then
    echo "Flatpak packages: $(flatpak list | wc -l)"
fi
echo

echo "=== END OF DIAGNOSTIC ==="

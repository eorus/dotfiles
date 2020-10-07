#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


# Load aliases
# (if exists then load)
[ -f "$HOME/.config/aliasrc" ] && . "$HOME/.config/aliasrc" || echo "aliasrc failed to load"

setleds -D +num

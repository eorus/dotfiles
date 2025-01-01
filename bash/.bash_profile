#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then source ~/.bashrc; fi

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

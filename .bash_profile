# ~/.bash_profile

# Source .bashrc for modular config
[ -f ~/.bashrc ] && source ~/.bashrc

# Source ~/.profile if it exists (backward compatibility)
[ -f ~/.profile ] && source ~/.profile

# Start X if logging into tty1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

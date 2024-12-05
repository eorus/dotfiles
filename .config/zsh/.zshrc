#------------------------------------------------------------------#
# File:     .zshrc   ZSH resource file                             #
# Version:  0.1                                                    #
# Author:   Mr Alphonzo Orus                                       #
#------------------------------------------------------------------#

#export PS1=$'\033[36m%n\033[m@\033[32m%m:\033[33;1m%~\033[m\$'
#export PS1="%{$(tput setaf 226)%}%n%{$(tput setaf 220)%}@%{$(tput setaf 214)%}%m %{$(tput setaf 33)%}%1~ %{$(tput sgr0)%}$ "
#PROMPT='%F{cyan}%n%f@%F{green}%m:%F{yellow}%~%f$ '

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

#------------------------------
# History stuff
#------------------------------
# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

#------------------------------
# Keybindings
#------------------------------
bindkey '^R' history-incremental-search-backward

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

bindkey -s '^a' 'bc -lq\n'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


#------------------------------
# Variables
#------------------------------
export EDITOR="nvim"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias e="$EDITOR"
alias vim="nvim"
alias s!="source ~/.config/zsh/.zshrc"
alias ka="killall" \
  son="grep -i installed /var/log/pacman.log" \
	mkd="mkdir -pv" \
	cfi3="e ~/.config/i3/config" \
	cfbs="e ~/.config/bspwm/bspwmrc" \
	cfsx="e ~/.config/sxhkd/sxhkdrc" \
	cfal="e ~/.config/aliasrc" \
	cfdw="e ~/.suckless/dwm/config.def.h" \
	mpv="mpv --input-ipc-server=/tmp/mpvsoc$(date +%s)" \
	calcurse="calcurse -D ~/.calcurse"

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#-----------------------------
# Source some stuff
#-----------------------------

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutenvrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

source <(fzf --zsh)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

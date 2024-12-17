#
# ~/.bashrc
#

#!/bin/bash
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999999999999000000
HISTFILESIZE=900000000999999999
PROMPT_COMMAND="history -a"

export HISTSIZE PROMPT_COMMAND
export SHELL=/bin/bash
export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"

# Other aliases
source ~/.config/aliasrc

# colored man pages
# Set directory colors
eval `dircolors ~/.dir_colors`

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# export PS1='\[\e[0m\]\[\e[48;5;236m\]\[\e[38;5;105m\]\u\[\e[38;5;105m\]@\[\e[38;5;105m\]\h\[\e[38;5;105m\] \[\e[38;5;221m\]\w\[\e[38;5;221m\]\[\e[38;5;105m\]\[\e[0m\]\[\e[38;5;236m\]\342\226\214\342\226\214\342\226\214\[\e[0m\]'

#export PS1='\[\e[0m\]\[\e[48;5;236m\]\[\e[38;5;197m\]\u\[\e[38;5;197m\]@\[\e[38;5;197m\]\h\[\e[38;5;105m\] \[\e[38;5;221m\]\w\[\e[38;5;221m\]\[\e[38;5;105m\]\[\e[0m\]\[\e[38;5;236m\]\342\226\214\342\226\214\342\226\214\[\e[0m\]'


# FZF mappings and options
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
#[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".git"'
#export FZF_DEFAULT_COMMAND='find .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse-list --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'"

#export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"

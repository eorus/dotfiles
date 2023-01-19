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


# Define a few Colours
#BLACK='\e[0;30m'
#BLUE='\e[0;34m'
#GREEN='\e[0;32m'
#CYAN='\e[0;36m'
#RED='\e[0;31m'
#PURPLE='\e[0;35m'
#BROWN='\e[0;33m'
#LIGHTGRAY='\e[0;37m'
#DARKGRAY='\e[1;30m'
#LIGHTBLUE='\e[1;34m'
#LIGHTGREEN='\e[1;32m'
#LIGHTCYAN='\e[1;36m'
#LIGHTRED='\e[1;31m'
#LIGHTPURPLE='\e[1;35m'
#YELLOW='\e[1;33m'
#WHITE='\e[1;37m'
#NC='\e[0m' # No Color

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999999999999000000
HISTFILESIZE=900000000999999999
PROMPT_COMMAND="history -a"
export HISTSIZE PROMPT_COMMAND
export SHELL=/bin/bash
export TERMINAL="/usr/local/bin/st"
# colored man pages
# Set directory colors
eval `dircolors ~/.dir_colors`
source ~/.config/aliasrc

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


#export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

########### Welcome Message ###########
#IP_ADD=`ip addr | grep -w inet | gawk '{if (NR==2) {$0=$2; gsub(/\//," "); print $1;}}'`
#printf "${LIGHTGREEN}Hello, $USER@${IP_ADD}\n"
#printf "Today is, $(date)\n";
#printf "Sysinfo: $(uptime)${NC}\n"


# FZF mappings and options
#source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".git"'
#export FZF_DEFAULT_COMMAND='find .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse-list --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'"

#export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"


export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
alias dotfiles='/usr/bin/git --git-dir=/home/eorus/.dotfiles/ --work-tree=/home/eorus'

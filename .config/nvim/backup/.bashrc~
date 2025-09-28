
#!/bin/bash
# ~/.bashrc – Clean and modular shell setup

# If not interactive shell, exit
[[ $- != *i* ]] && return

# Source global
[ -f /etc/bashrc ] && source /etc/bashrc

# Modular config
SHELL_CONFIG_DIR="$HOME/.config/shell"
for file in "$SHELL_CONFIG_DIR"/{aliases,exports,functions,prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file SHELL_CONFIG_DIR

# Shell options
shopt -s cdspell       # Fix typos when using `cd`
shopt -s nocaseglob    # Case-insensitive globbing
shopt -s cmdhist       # Keep multiline commands together
shopt -s checkwinsize  # Auto-resize terminal after window change

# History
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTTIMEFORMAT="%F %T "
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# dircolors.
if [ -x "$(command -v dircolors)" ]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# FZF setup
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 50% -1 --layout=reverse-list --multi \
--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' \
--color=fg:#c0c5ce,bg:#212121,hl:#808080,fg+:#e6e6e6,bg+:#3b3b3b,hl+:#f7c662 \
--color=info:#f7c662,prompt:#6699cc,pointer:#a6bc69,marker:#a6bc69,spinner:#f7c662,header:#6699cc"

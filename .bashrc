platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='bsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
fi

# Append to history file
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set the prompt
PS1="\h:\W \u\$ "

# fzf settings

# Default to no-fuzzy. use 'search_term for fuzzy search.
export FZF_DEFAULT_OPTS='--exact'
# CTRL-X CTRL-R - bind ctrl-x to executing the command in ctrl-r
# bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/' | sed 's/"$/\\C-m"/')"

# Set default editor
export EDITOR="nvim"

# color mode for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Platform specific settings

if [[ $platform == 'linux' || $platform == 'unknown' ]]; then
    PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

    alias ls='ls --color=auto'

    # No caps-lock (only enable on desktop)
    # setxkbmap -option ctrl:nocaps

    #Configure xclip
    # if command -v xclip; then
    #     alias pbcopy='xclip -i -selection clipboard'
    #     alias pbpaste='xclip -selection clipboard -o'
    # fi
    if command -v gnome-open 
        then alias open='gnome-open'
    fi

    # Re-bind ctrl-l to clear the screen, which doesn't work by default when using vi input mode
    bind -m vi-insert "\C-l":clear-screen

    # Configure language settings - default to en_US
    export LANG="en_US.UTF-8"
    export LC_COLLATE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_MESSAGES="en_US.UTF-8"
    export LC_MONETARY="en_US.UTF-8"
    export LC_NUMERIC="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
    # export LC_ALL=
    # export LC_ALL="en_US.UTF-8"


    # Check if WAYLAND, and set proper env variables
    sessiontype=$(loginctl show-session $(awk '/tty/ {print $1}' <(loginctl)) -p Type | awk -F= '{print $2}')
    if [[ $sessiontype == 'wayland' ]]; then
        export MOZ_ENABLE_WAYLAND=1
    fi


elif [[ $platform == 'mac' ]]; then
    PATH="$HOME/.local/bin:/usr/local/bin:$HOME/settings/utils:$PATH"
    NODE_PATH="/usr/local/lib/node"
    alias ls='ls -G'
    alias tree='tree -C'
    bind -m vi-insert "\C-l":clear-screen
fi

# Aliases for human-readable
alias df='df -h'

set -o vi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Allow local aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


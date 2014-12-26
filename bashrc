# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add to executable search path.
export PATH="\
$HOME/.bin:\
$HOME/.composer/vendor/bin\
$PATH\
"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# Use a larger history size.
export HISTSIZE=25000
export HISTFILESIZE=50000

# Ignore lines starting with a space
export HISTIGNORE=" *"

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make "less" more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case $(whoami) in
    root)
    # All hail the mighty root user
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
    ;;
    *)
    # Green prompt for lusers
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Search in files with "ack".
if command -v ag >/dev/null; then
    alias ack=ag
elif command -v ack-grep >/dev/null; then
    alias ack=$(command -v ack-grep)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# don't allow Ctrl-S to stop terminal output
stty stop ''

### My Aliases ###
alias l='ls -lahF'
alias la='ls -aF'
alias lsize='ls -laShrF'
alias nano='nano -w'
alias df='df -h'
alias composer="php $HOME/.bin/composer.phar"

### SSH Aliases ###
alias claptrap='ssh andrew@claptrap.beyondweb.net'
alias home='ssh aceat64@tom-servo.beyondweb.net'
alias s='ssh -l root'

### Useful Functions ###
# Random password generator
function randpw() {
    if [ -n "$1" ]; then len=$1; else len=8 ; fi
    tr -dc A-Z-a-z-0-9 < /dev/urandom | head -c $len ; echo;
}

# Random number generator
function randnum() {
    if [ -n "$1" ]; then len=$1; else len=8 ; fi
    tr -dc 0-9 < /dev/urandom | head -c $len ; echo;
}

### SSH-Agent Stuff ###
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo "succeeded"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" >/dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" >/dev/null
    ps ${SSH_AGENT_PID} >/dev/null || {
        start_agent;
    }
else
    start_agent;
fi

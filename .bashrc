# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# custom prompt green='\e[0;32m'
GREEN='\e[0;32m'
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'
#if [ $(id -u) -eq 0 ];
#then
#    PS1="┌${RED}[\u]${NC} [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└> "
#else
#    PS1="┌[${GREEN}\u${NC}] [\h]$ps1_informer:\[\e[0;32;49m\]\w\[\e[0m \n└> "
#fi

# lambda prompt
PS1="  \[\e[1;36m\]λ \W \[\e[0m\]"

function cs () {
    cd "$@" && ls
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# Colors
#default=$(tput sgr0)
#red=$(tput setaf 1)
#green=$(tput setaf 2)
#purple=$(tput setaf 5)
#orange=$(tput setaf 9)

# Less colors for man pages
#export PAGER=less
# Begin blinking
#export LESS_TERMCAP_mb=$red
# Begin bold
#export LESS_TERMCAP_md=$orange
# End mode
#export LESS_TERMCAP_me=$default
# End standout-mode
#export LESS_TERMCAP_se=$default
# Begin standout-mode - info box
#export LESS_TERMCAP_so=$purple
# End underline
#export LESS_TERMCAP_ue=$default
# Begin underline
#export LESS_TERMCAP_us=$green

#terminal title by last command
#https://stackoverflow.com/a/7110386
trap 'echo -ne "\033]0;$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g")\007"' DEBUG

alias g=git
alias fan="cat ~/SysUtils/fan"
alias py="python3"
alias pro="prolog"
alias bat="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias aws="ssh admin@107.23.83.75"
alias cv="source activate cs4670"
alias bssid=" nmcli -f in-use,SSID,BSSID,signal,bars dev wifi"
alias source="source ~/.bashrc"
alias signal="signal-desktop"

function open () {
  xdg-open "$@"&
  disown
}

export RTV_EDITOR=vim

PATH=$PATH:/opt/anaconda3/bin

# save path on cd
function cd {
	    builtin cd $@
	        pwd > ~/.last_dir
	}

# restore last saved path
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi



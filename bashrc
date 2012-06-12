# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions

##############
# Git Prompt #
##############
if [ -e "$HOME/.git-completion.bash" ] ; then
        source ~/.git-completion.bash
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWSTASHSTATE=1
        export GIT_PS1_DESCRIBE_STYLE=branch
        GITPS1="\$(__git_ps1 ' [%s]')"
fi

##########
# Prompt #
##########
#Colors
black='\[\e[0;30m\]'
dkgray='\[\e[1;30m\]'
blue='\[\e[0;34m\]'
ltblue='\[\e[1;34m\]'
green='\[\e[0;32m\]'
ltgreen='\[\e[1;32m\]'
cyan='\[\e[0;36m\]'
ltcyan='\[\e[1;36m\]'
red='\[\e[0;31m\]'
ltred='\[\e[1;31m\]'
purple='\[\e[0;35m\]'
ltpurple='\[\e[1;35m\]'
brown='\[\e[0;33m\]'
yellow='\[\e[1;33m\]'
ltgray='\[\e[0;37m\]'
white='\[\e[1;37m\]'
nocolor='\[\e[0m\]'

#Return Code
cursor='\[\033[G\]'

#The Prompt
export PS1="[\u@\h \W]${ltred}${GITPS1}${nocolor} \$ "
export PS1="${cursor}$PS1"
########
# Path #
########
export PATH=$HOME/root/bin/:$PATH
export LD_LIBRARY_PATH=$HOME/root/lib/:$LD_LIBRARY_PATH

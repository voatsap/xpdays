# This file is managed by Ansible, don't make changes here - they will be overwritten.

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

export EDITOR=$(which vim)
export PAGER=$(which less)
export LESS="-R"
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=0;49;92:ln=32:bn=32:se=36'
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/opt/bin
export LANG=en_US.utf8
export LC_ALL=en_US.utf8
export HISTFILESIZE=10000
export HISTSIZE=10000
export HISTCONTROL=erasedups
export HISTIGNORE="&:ls:screen *:top:htop"
export HISTTIMEFORMAT="%t%d.%m.%y %H:%M:%S%t"

shopt -s histappend

complete -cf man
complete -cf nice
complete -cf ionice


alias c='clear'
alias s='set -o vi'
alias h='htop'
alias t='top'
alias m='mysql -e "SHOW FULL PROCESSLIST;"'
alias mf='mysql -e "SHOW FULL PROCESSLIST; show engine innodb status\G"'
alias d='dirs -v'
alias pu="pushd"
alias po="popd"
alias i='ip addr'
alias v='vim "+colorscheme elflord" "+syntax on"'
alias p='pwd'
alias ru="export INPUTRC=/root/.inputrc.yamato"
alias e='egrep'
alias config_show="e -v '(^#|^$|^[[:space:]]+#)'"
alias sy='/bin/systemctl'

# http://www.cyberciti.biz/faq/linux-which-process-is-using-swap/
# for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | less'
alias show_swap_usage='for file in /proc/*/status ; do awk '\''/VmSwap|Name/{printf $2 " " $3}END{ print ""}'\'' $file; done | sort -k 2 -n -r | less'

# notify shortcut
jobdone() {
	echo "DONE!" | mail -s "$(hostname): ${1:-Your job is done} [NOSR]" ${2:-yamato@shalb.com}
}

# count size of directories 
dudu() {
ionice -c 3 nice -n 20 du -x -h --max-depth="$1" "$2" > /tmp/du
sort -h /tmp/du > /tmp/du_sorted
jobdone
}

# strace wrapper
str() {
  strace -vyCTrf -s 1024  -o /tmp/strace.log -p "$1"
}


# custom aliases

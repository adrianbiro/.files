# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias nnn='nnn -l'
MAN_POSIXLY_CORRECT=1
export PATH=$HOME/bin:$PATH
# to edit content of cmdline in vim crtl x ctrl e
export EDITOR="/usr/bin/vim"
alias path='echo -e ${PATH//:/\\n}'
alias cg='cd ~/bin/gits/; ls'
alias clp='cd ~/bin/gits/learn/python/; ls'
alias cr='cd ~/bin/gits/ROZROBENE/; ls'
alias ch='cd ~/bin/gits/ROZROBENE/hint.md/; ls'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls='_ls'
alias ls-l='ls -l'
#alias dir='echo -e "UnixMode     User   Group Size LastWriteTime   Name\n--------     ----   ----- ---- -------------   ----"; ls -l'
#alias dir='green="\033[0;32m"; clear="\033[0m"; printf "\n\tDirectory: $(pwd)\n\n${green}UnixMode     User   Group Size LastWriteTime Name\n--------     ----   ----- ---- ------------- ----${clear}\n\t"; ls -l'
alias md='mkdir -p'
alias o='less'
alias rd='rmdir'
alias rehash='hash -r'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'

alias pscpu='ps aux --sort -pcpu | head -n30 | less -S'
# Pretty-print man(1) pages.
#export LESS_TERMCAP_mb=$'\E[1;31m'
#export LESS_TERMCAP_md=$'\E[1;31m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[1;33m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[1;32m'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

export GITS="~/bin/gits"
export DOTFILES="$GITS/dot_files"
export LEARN="$GITS/learn"
export CDPATH=".:$GITS:$DOTFILES:$LEARN:$HOME"
alias cdpath='echo -e ${CDPATH//:/\\n}'

alias mtree='tree -pFRC -h --dirsfirst .'
alias atree='tree -apFRC -h -L 3 --dirsfirst -I .git .'

# to disable -u	it's for extended glob patterns like ls **/*
# grep -d skip 'text_string' **/* this is similar to grep -d skip -R 'text_string'
shopt -s globstar
# Allow multiple terminals write to history file
shopt -s histappend


# in man bash PROMPTING
PS1="\u@\h:\w>\$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') "
#PS1="\u@\h:\w> "

function cl() {
	if [ ! -z "$1" ]; then
		builtin cd $1 && ls
	else cd ~ && ls
	fi
}

function dockrmall() {
	docker rm -f $(docker ps -a | awk 'NR>1 {print $NF}')
}



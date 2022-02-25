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
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls='_ls'
alias ls-l='ls -l'
alias dir='ls -l'
alias md='mkdir -p'
alias o='less'
alias rd='rmdir'
alias rehash='hash -r'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'


export GITS="~/bin/gits"
export DOTFILES="$GITS/.files"
export LEARN="$GITS/learn"
export CDPATH=".:$GITS:$DOTFILES:$LEARN:$HOME"
alias cdpath='echo -e ${CDPATH//:/\\n}'


# in man bash PROMPTING
PS1="\u@\h:\w>\$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') "
#PS1="\u@\h:\w> "

function cl() {
	if [ ! -z "$1" ]; then
		builtin cd $1 && ls
	else cd ~ && ls
	fi
}

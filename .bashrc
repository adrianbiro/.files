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

export GITS="~/bin/gits"
export DOTFILES="$GITS/.files"
export LEARN="$GITS/learn"
export CDPATH=".:$GITS:$DOTFILES:$LEARN:$HOME"
alias cdpath='echo -e ${CDPATH//:/\\n}'


# in man bash PROMPTING
PS1="\u@\h:\w>\$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') "
#PS1="\u@\h:\w> "



#global config
MAN_POSIXLY_CORRECT=1
export PATH=$HOME/bin:$PATH
# to edit content of cmdline in vim crtl x ctrl e; to set vi mode for readline "set -o vi"
export EDITOR="/usr/bin/vim"
alias getpurebash="bash --norc"
alias getpurevim='touch /tmp/.vimrc && vim -u /tmp/.vimrc'
alias path='echo -e ${PATH//:/\\n}'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias portstate='ss -ltpn'
alias mip="curl http://ipecho.net/plain; echo"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias cp='cp -v'
alias cpv='rsync -ah --info=progress2'
alias l='ls -alF'
alias la="ls -AlSGhB --ignore='.*.swp'"
alias lsa="ls --classify --almost-all"
alias ll='ls -lh'
[[ $(type -t _ls) == function ]] && alias ls='_ls'
alias lt='du -sh * | sort -h'
alias ls-l='ls -l'
alias o='less'
alias rd='rmdir'
alias rehash='hash -r'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias ncdu="ncdu --color=dark -x"
alias pscpu='ps aux --sort -pcpu | head -n30 | less -S'
alias mps='ps aux | grep -v grep | grep -i -e VSZ -e' #$1
alias mtree='tree -pFRC -h --dirsfirst . | less -R'
alias atree='tree -apFRC -h -L 3 --dirsfirst -I .git . | less -R'
alias mmnt='mount | column -t | less -S'
alias gh='history | grep'
alias count='find . -type f | wc -l'
alias rfree="watch -n 5 -d 'free -mht'"
alias mcache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac
##local config
#custom cd
export GITS="~/bin/gits"
export DOTFILES="$GITS/dot_files"
export LEARN="$GITS/learn"
export CDPATH=".:$GITS:$DOTFILES:$LEARN:$HOME"
alias cdpath='echo -e ${CDPATH//:/\\n}'
alias cg='cd ~/bin/gits/; ls'
alias clp='cd ~/bin/gits/learn/python/; ls'
alias cr='cd ~/bin/gits/ROZROBENE/; ls'
alias ch='cd ~/bin/gits/hint.md/; ls'
alias cdf='cd ~/bin/gits/dot_files/; ls -AF'
alias nnn='nnn -l'
alias pve='python3 -m venv ./venv'
alias pva='source ./venv/bin/activate'
alias pir="pip install -r requirements.txt"
alias pfr="pip freeze --local > requirements.txt"
alias cpath="pwd | xclip -selection clipboard"
#export MANPAGER="vim -M +MANPAGER -"
# Pretty-print man(1) pages.
#export LESS_TERMCAP_md=$'\E[1;31m'
#export LESS_TERMCAP_so=$'\E[1;33m'
#export LESS_TERMCAP_us=$'\E[1;32m'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m' # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

# to disable -u	it's for extended glob patterns like ls **/*
# grep -d skip 'text_string' **/* this is similar to grep -d skip -R 'text_string'
shopt -s globstar
# Allow multiple terminals write to history file
shopt -s histappend
shopt -s autocd #cd just by typing the name of directory; to unset -u

# in man bash PROMPTING
PS1="\u@\h:\w>\$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') "
#PS1="\u@\h:\w> " #SUSE default prompt

## functions

# SUSE predefined alias for this function
#function _ls () {
#  local IFS=' ';
#  command ls $LS_OPTIONS ${1+"$@"}
#}

function TODO() {
  python3 -c "import webbrowser; webbrowser.open('https://www.notion.so/')"
}


function mhelp() {
  whatis $1
  man $1 \
  | sed -n "/^\s*$2/,/^$/p"

}


function bak() {
  cp -r "$1" "${1}.bak"
  if [[ "$2" == "+i" ]]; then
    sudo chattr -R +i "${1}.bak"
  elif [[ "$2" == "+a" ]]; then
    sudo chattr -R +a "${1}.bak"
  fi
}


function tmuxs() {
  tmux new-session -s "${1^^}" \; split-window -v \; resize-pane -D 18 \; attach
}

function tmuxe() {
  local dir; dir=$(pwd); dir="${dir##*/}"
  tmux new-session -s "${dir^^}" \vim $1 \; split-window -v \; resize-pane -D 18 \; attach
}

function thistory(){
  local HISTTIMEFORMAT="%Y-%m-%d %T "
  history
}


# man XDG-OPEN(1)
function gopen() {
  if [[ ! -z "$1" ]]; then
    xdg-open $1
  else
    xdg-open .
  fi
}


function mnt() {
  mount \
          | awk -F' ' '{print $1,$3}' \
          | column -t \
          | egrep '^/dev/' \
          | sort
}


#Auto complete directory names.
complete -A directory cl
function cl() {
  if [[ ! -z "$1" ]]; then
	builtin cd $1
  else
    cd ~
  fi
  ls --color=auto --classify --almost-all
}


function gitt() {
  cd $(git rev-parse --show-toplevel)
}


function gita() {
  cd $(git rev-parse --show-toplevel)
  git status -s
  git add .
  if [[ ${1} = "m" ]]; then
    git commit -m "small fixes"
  fi
  git status -s
  cd -
}


function gitap() {
  local cbranch; cbranch=$(git branch | sed -e '/^[^*]/d' -e 's/* //')
  printf '\e[36m%s\033[0m%s\n' "This will add, commit and push all the files to branch " "$cbranch"
  read -p "Do you want that? y/n " -n 1 -r
  if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])+$ ]]
  then
    git add .
    git commit -m "small fixes"
    git push origin "$cbranch"
  else
    printf '\e[31m%s\033[0m\n' "Quit."
  fi
}


# Removes all containers, and prints their names and image base. "q" argument will suppress output, but "q" followed by "v" prints container id.
function dockrmall() {
  local all=$(docker ps -aq)
  if [[ -z $all ]];then
    printf '\e[21m%s\n\033[0m' "No containers found."
  return
  fi
  if [[ "$1" == "q" ]]; then
    if [[ "$2" == "v" ]]; then
      docker rm -f $all
    else
      docker rm -f $all > /dev/null
    fi
  else
    local DNI=$(docker ps -a --format '{{.Names}}:{{.Image}}')
#    docker rm -f $(docker ps -a | awk 'NR>1 {print $NF}')
    docker rm -f $(docker ps -a --format '{{.Names}}') > /dev/null
    printf '%s\n' "$DNI"
  fi
}


function dlatestpull() {
  docker images \
          | grep -v REPOSITORY \
          | awk '{print $1}' \
          | xargs -L1 docker pull
  printf '\n%s\n%s\n' "Delete old images?" "yes no"
  docker images | grep '<none>'
  read answer
  case $answer in
          y|j|o|ok|yes)
                    docker images \
                            | grep '<none>' \
                            | awk '{print  $3}' \
                            | xargs -L1 docker rmi
                    ;;
            *)
                    return
                    ;;

    esac
}


function perlrun() {
  docker run -it \
          --rm --name "PERL" \
          -v "$PWD":/usr/src/myapp \
          -w /usr/src/myapp \
          perl:latest \
          perl "$1"
}


function pythonrun() {
  docker run -it \
          --rm --name "PYTHON" \
          -v "$PWD":/usr/src/myapp \
          -w /usr/src/myapp \
          python:latest \
          python3 "$1"
}


function blackrun() {
  docker run --rm \
          --volume $(pwd):/src \
          --workdir /src \
          pyfound/black:latest \
          black --check -l 120 -S "$@"
}


mcd() {
  mkdir -p -- "$1" && builtin cd "$1"
}


function hladaj(){
  if [[ ! "$1" = "-f" ]]; then
    grep -irnT --word-regexp --color=always "$*" --binary-files=without-match --exclude=GLOB".*.swp" --exclude-dir=".git" . | less -R
  else
    find . -name "$2" | less -R
  fi
}


#function completitionlists(){
#  COMPRELY=($(compgen -W "gitstat gita gitap" "${COMP_WORDS[1]}"))
#
#}
#complete -F completitionlists run #TODO

# Stopwatch
function timer() {
  local green="\033[0;32m"
  local clear="\033[0m"
  printf "${green}Timer started. Stop with Ctrl-D.${clear}\n" && date && time cat && date
}
#TODO #{{{
#alias dir='echo -e "UnixMode     User   Group Size LastWriteTime   Name\n--------     ----   ----- ---- -------------   ----"; ls -l'
#alias dir='green="\033[0;32m"; clear="\033[0m"; printf "\n\tDirectory: $(pwd)\n\n${green}UnixMode     User   Group Size LastWriteTime Name\n--------     ----   ----- ---- ------------- ----${clear}\n\t"; ls -l'
#}}}

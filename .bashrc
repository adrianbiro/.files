#!/bin/bash
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac
# fix potential infinite sourcing
if [[ -z "${__CUSTOM__BASHRC__}" ]]; then
  __CUSTOM__BASHRC__="true"
else
  return
fi
# to disable -u	it's for extended glob patterns like ls **/*
# grep -d skip 'text_string' **/* this is similar to grep -d skip -R 'text_string'
shopt -s globstar
# Allow multiple terminals write to history file
shopt -s histappend
shopt -s autocd #cd just by typing the name of directory; to unset -u
#MAN_POSIXLY_CORRECT=1
# to edit content of cmdline in vim crtl x ctrl e; to set vi mode for readline "set -o vi"
export EDITOR="/usr/bin/vim"
export HISTSIZE=10000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups:ignoreboth:ignorespace
export HISTIGNORE="exit:pwd"
alias getpurebash="bash --norc"
alias getpurevim='vim -u $(mktemp)'
alias path='echo -e ${PATH//:/\\n}'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ports='sudo ss -tnlp'
alias mip="curl http://ipecho.net/plain; echo"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias cp='cp -v'
alias cpv='rsync -ah --info=progress2'
alias l='ls -AlF'
alias la="ls -AlSGhB --ignore='.*.swp'"
alias lsa="ls --classify --almost-all"
alias ll='ls -lh'
[[ $(type -t _ls) == function ]] && alias ls='_ls' #SUSE function _ls () { local IFS=' '; command ls $LS_OPTIONS ${1+"$@"}; }
alias lt='du -sh * | sort -h'
alias ls-l='ls -l'
alias rehash='hash -r'
alias ncdu="ncdu --color=dark -x"
alias mnetstat='sudo netstat -ltnp'
alias pscpu='ps aux --sort -pcpu | head -n30 | less -S'
alias mps='ps aux | grep -v grep | grep -i -e VSZ -e' #$1
alias mtree='tree -pFRC -h --dirsfirst . | less -R'
alias atree='tree -apFRC -h -L 3 --dirsfirst -I .git . | less -R'
alias stree='tree -aFC -s -h --du . | less -R'
alias mmnt='mount | column -t | less -S'
alias gh='history | grep'
alias count='find . -type f | wc -l'
alias rfree="watch -n 5 -d 'free -mht'"
alias mcache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
function hostip() { host -t a "${*}"; }
function stdbuf-python() { stdbuf -o0 python3 "${*}"; }
function mcd() { mkdir -p -- "$1" && builtin cd "$1" || return; }
alias pve='python3 -m venv ./venv'
alias pva='source ./venv/bin/activate'
alias pir="pip install -r requirements.txt"
alias pfr="pip freeze --local > requirements.txt"

function mhelp() {
  whatis "$1"
  man "$1" | sed -n "/^\s*${2}/,/^$/p"
}

function mman() { man "${1}" | grep -e "${2}"; }

# Stopwatch
function timer() {
  local green="\033[0;32m"
  local clear="\033[0m"
  echo -e "${green}Timer started. Stop with Ctrl-D.${clear}\n", && date && time cat && date
}

function thistory() {
  local HISTTIMEFORMAT="%Y-%m-%d %T "
  history
}

#Auto complete directory names.
complete -A directory cl
function cl() {
  if [[ -n "$1" ]]; then
    builtin cd "${1}" || return
  else
    cd ~ || return
  fi
  ls --color=auto --classify --almost-all
}

#export MANPAGER="vim -M +MANPAGER -"
# Pretty-print man(1) pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'        # end the info box
export LESS_TERMCAP_so=$'\E[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'

## PATH
#export PATH=$HOME/bin:$PATH
#PATH="/usr/local/go/bin:$PATH"
function pathappend() {
  declare arg
  for arg in "${@}"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="${PATH:+"$PATH:"}$arg"
  done
} && export -f pathappend

function pathprepend() {
  for arg in "${@}"; do
    test -d "$arg" || continue
    PATH="${PATH//:"$arg:"/:}"
    PATH="${PATH/#"$arg:"/}"
    PATH="${PATH/%":$arg"/}"
    export PATH="$arg${PATH:+":${PATH}"}"
  done
} && export -f pathprepend

# remember last arg will be first in path
pathprepend \
  "$HOME/bin" \
  "$HOME/.local/bin" \
  /usr/local/go/bin \
  /usr/local/opt/openjdk/bin \
  "$HOME/.dotnet" \
  "$HOME/.dotnet/tools" && unset arg

pathappend \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/local/games \
  /usr/games \
  /usr/sbin \
  /usr/bin \
  /snap/bin \
  /sbin \
  /bin && unset arg

# enable programmable completion features
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
  fi
fi
# enable color support of ls and also add handy aliases
if [[ -x "/usr/bin/dircolors" ]]; then
  if [[ -r "${HOME}/.dircolors" ]]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors --bourne-shell)"
  fi
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
##local config
# ssh
complete -W $(awk '/^Host\s\*/{next}; /^Host/{print $2}' "${HOME}/.ssh/config" 2>'/dev/null') ssh
# wsl
if [[ -d '/mnt/c/Users/biroa' ]]; then
  WHOME='/mnt/c/Users/biroa'
  export WHOME
  alias cwh='cd $WHOME'
  alias cwd='cd $WHOME/Downloads'
  alias dockerdesktop='/mnt/c/Program\ Files/docker/Docker/Docker\ Desktop.exe'
  # ONEDRIVE='/mnt/c/Users/biroa/OneDrive\ -\ IC\ GROUP/'
fi
if [[ -n "${WHOME}" ]]; then
  eval "$(keychain --quiet --eval --agents ssh ~/.ssh/win11GITed25519-8-11-2022)"
fi
#$(ls /run/user/${UID}/gvfs > "/dev/null" 2>&1) && \
if [[ -d "/run/user/${UID}/gvfs" ]]; then
  GDRIVE="/run/user/${UID}/gvfs/$(ls /run/user/${UID}/gvfs/)"
  export GDRIVE
  alias glsla='"gio list -a "standard::display-name"'
  alias gls='gio list -d'
  alias gcp='gio copy -p'
fi
## dot_files dir
if [[ $(uname -o) =~ "Linux" ]]; then
  if [[ -d "${HOME}/gits" ]]; then
    export GITS="${HOME}/gits"
    export DOTFILES="$GITS/dot_files"
    function cdf() {
      cd "${DOTFILES}" || return
      ls -AF
    }
    export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
  fi
else # Msys git-bash
  if [[ -d "${HOME}/src" ]]; then
    export GITS="${HOME}/src"
    export DOTFILES="$GITS/dot_files"
    function cdf() {
      cd "${DOTFILES}" || return
      ls -AF
    }
    export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
    ## git-bash specific
    alias xecho="powershell.exe -c 'Get-Clipboard'"
  fi
fi

# in man bash PROMPTING
function prompt() {
  ## just posix https://askubuntu.com/questions/640096/how-do-i-check-which-terminal-i-am-using#640105
  local emulator psgit1 pscolor1
  #emulator=$(basename "/"$(ps -o cmd -f -p "$(cat /proc/${$}/stat | cut -d ' ' -f 4)" | tail -1 | sed 's/ .*$//'))"
  emulator=$(ps -p ${$} | tail -n 1)
  psgit1="\$(git branch 2>'/dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
  pscolor1="\[\033[36m\]${psgit1}\[\033[0m\]"

  case "${emulator##*\ }" in
  code)
    export PS1="${PWD##*/}${pscolor1} "
    ;;
  *)
    local arr
    declare -A arr=(["hp-win11"]=1 ["pc"]=1 ["NP48412"]=1)
    [[ -v arr[$(hostname)] ]] && export PS1="\w%${pscolor1} "
    ;;
  esac
  unset psgit1 pscolor1 emulator arr
}
prompt

#### for local machine non portable
if command -v screen 1>"/dev/null" 2>&1; then
  alias screenr="screen -D -RR"
  #fix permission in wsl
  if [[ -v "${WHOME}" ]]; then
    export SCREENDIR="${HOME}/.screen"
    [[ -d "${SCREENDIR}" ]] || mkdir -m 700 "${SCREENDIR}"
  fi
  # set .screenrc
  if [[ ! -f "${HOME}/.screenrc" ]]; then
    cat <<HERE_DOC >>"${HOME}/.screenrc"
# change meta bind from ctrl-a to alt-a
escape ^||
bindkey "^[a" command
#
vbell off
bell_msg ""
startup_message off

HERE_DOC
  fi
fi

if command -v tmux 1>"/dev/null" 2>&1; then
  function tmuxs() {
    tmux new-session -s "${1^^}" \; split-window -v \; resize-pane -D 18 \; attach
  }

  function tmuxe() {
    local dir
    dir="${PWD##*/}"
    # shellcheck disable=SC1001
    tmux new-session -s "${dir^^}" \vim "${1}" \; split-window -v \; resize-pane -D 18 \; attach
  }
fi
# clipboard
if command -v xclip 1>"/dev/null" 2>&1; then
  alias cpath="pwd | xclip -selection clipboard"
  alias xecho="xclip -o clip"
fi

if command -v jq 1>"/dev/null" 2>&1; then

  function jless() { jq '.' -C | less -R; }
  export -f jless

  function curljson() { curl "${1}" | jless; }
  export -f curljson

  function getjsonschema() {
    jq -r 'path(..) | map(tostring) | join("/")' "${1}" | less -R
  }
  export -f getjsonschema
fi

if command -v batcat 1>"/dev/null" 2>&1; then
  alias o='batcat --pager "less -RF" --plain'
  help() {
    "$@" --help 2>&1 | batcat --plain --language=help
  }
fi

if command -v bat 1>"/dev/null" 2>&1; then
  alias o='bat --pager "less -RF" --plain'
  help() {
    "$@" --help 2>&1 | batcat --plain --language=help
  }
fi

if command -v fprettify 1>"/dev/null" 2>&1; then
  alias ,fprettify='fprettify.py -i 4 -l 80 --strict-indent'
fi

if command -v xdg-open 1>"/dev/null" 2>&1; then
  # man XDG-OPEN(1)
  function gopen() {
    if [[ -n "$1" ]]; then
      xdg-open "$1"
    else
      xdg-open .
    fi
  }
  export -f gopen
fi

## golang
if command -v go 1>"/dev/null" 2>&1; then
  #PATH="/usr/local/go/bin:$PATH"
  if [[ -d "${DOTFILES}/go-pkg-completion" ]]; then
    # shellcheck disable=SC1091
    source "${DOTFILES}/go-pkg-completion"
  fi
  alias gomih='go mod init "${PWD##*/}"'
fi

# dotnet
if [[ -d "${HOME}/.dotnet" ]]; then
  export DOTNET_ROOT="${HOME}/.dotnet"
fi

## Git
if command -v git 1>"/dev/null" 2>&1; then
  unset gitap gita gitt ,gitofetch
  function ,gitofetch() {
    git checkout "${1}" && git fetch origin && git pull origin "${1}"
  }
  export -f ,gitofetch

  function gitt() {
    cd "$(git rev-parse --show-toplevel)" || return
  }
  export -f gitt

  function gita() {
    cd "$(git rev-parse --show-toplevel)" || return
    git status -s
    git add .
    if [[ ${1} = "m" ]]; then
      git commit -m "small fixes"
    fi
    git status -s
    cd - || return
  }
  export -f gita

  function gitap() {
    local cbranch
    cbranch=$(git branch | sed -e '/^[^*]/d' -e 's/* //')
    printf '\e[36m%s\033[0m%s\n' "This will add, commit and push all the files to branch " "$cbranch"
    read -p "Do you want that? y/n " -n 1 -r
    if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
      git add .
      git commit -m "small fixes"
      git push origin "$cbranch"
    else
      printf '\e[31m%s\033[0m\n' "Quit."
    fi
  }
  export -f gitap
fi
## Docker
if command -v docker 1>"/dev/null" 2>&1; then
  function dins() {
    docker inspect "${*}" | jless
  }

  # Removes all containers, and prints their names and image base. "q" argument will suppress output, but "q" followed by "v" prints container id.
  function dockrmall() {
    local all
    all=$(docker ps -aq)
    if [[ -z "${all}" ]]; then
      printf '\e[21m%s\n\033[0m' "No containers found."
      return
    fi
    if [[ "$1" == "q" ]]; then
      if [[ "$2" == "v" ]]; then
        docker rm -f "${all}"
      else
        docker rm -f "${all}" >"/dev/null"
      fi
    else
      local DNI
      DNI="$(docker ps -a --format '{{.Names}}:{{.Image}}')"
      #    docker rm -f $(docker ps -a | awk 'NR>1 {print $NF}')
      docker rm -f "$(docker ps -a --format '{{.Names}}')" >"/dev/null"
      printf '%s\n' "${DNI}"
    fi
  }

  function dlatestpull() {
    docker images |
      grep -v REPOSITORY |
      awk '{print $1}' |
      xargs -L1 docker pull
    printf '\n%s\n%s\n' "Delete old images?" "yes no"
    docker images | grep '<none>'
    read -r answer
    case $answer in
    y | j | o | ok | yes)
      docker images |
        grep '<none>' |
        awk '{print  $3}' |
        xargs -L1 docker rmi
      ;;
    *)
      return
      ;;

    esac
  }

  #complete -W $(docker images | awk 'NR>1{printf("%s ", $1)} END{print ""}') drun

  function netrun() {
    docker run -it \
      --network host \
      --rm --name netwb \
      jonlabelle/network-tools
  }

  #function perlrun() {
  #  docker run -it \
  #          --rm --name "PERL" \
  #          -v "$PWD":/usr/src/myapp \
  #          -w /usr/src/myapp \
  #          perl:latest \
  #          perl "$1"
  #}

  function jupyrun() {
    ~/Applications/venv/bin/jupyter-lab
  }
  #function jupyrunNp() {
  #    docker run -it --rm \
  #            -v $(pwd):/home/jovyan/work -p 8888:8888 \
  #            jupyter/scipy-notebook
  #}

  function pythonrun() {
    docker run -it \
      --rm --name "PYTHON" \
      -v "${PWD}":/usr/src/myapp \
      -w /usr/src/myapp \
      python:latest \
      python3 "${1}"
  }

  function blackrun() {
    docker run --rm \
      --volume "$(pwd)":/src \
      --workdir /src \
      pyfound/black:latest \
      black --check -l 80 -S "$@"
  }
fi
## Kubectl
if command -v kubectl 1>"/dev/null" 2>&1; then
  compdir="${HOME}/.config/completion/"
  compfile="kubectl-completion-kubectl.sh"
  if [[ -f "${compdir}/${compfile}" ]]; then
    # shellcheck disable=SC1090
    source "${compdir}/${compfile}"
    unset compdir compfile
  else
    mkdir -p "${compdir}" 1>"/dev/null" 2>&1
    kubectl completion bash >"${compdir}/${compfile}"
    # shellcheck disable=SC1090
    source "${compdir}/${compfile}"
    unset compdir compfile
  fi
fi
## OC openshift
if command -v oc 1>"/dev/null" 2>&1; then
  compdir="${HOME}/.config/completion/"
  compfile="oc-completion-bash.sh"
  if [[ -f "${compdir}/${compfile}" ]]; then
    # shellcheck disable=SC1090
    source "${compdir}/${compfile}"
    unset compdir compfile
  else
    mkdir -p "${compdir}" 1>"/dev/null" 2>&1
    oc completion bash >"${compdir}/${compfile}"
    # shellcheck disable=SC1090
    source "${compdir}/${compfile}"
    unset compdir compfile
  fi
fi

if (command -v oc 1>"/dev/null" 2>&1) || (command -v kubectl 1>"/dev/null" 2>&1); then
  # shellcheck disable=2139
  function oContReady() {
    oc get pods -o wide | awk 'NR==1{print; next} {split($2, arr, "/"); if(arr[1] != arr[2]) print}'
  }
  # shellcheck disable=2139
  function oContRestarts() {
    oc get pods -o wide | awk 'NR==1{print; next} {if($4 > 0) print}'
  }

  function oContAge() {
    oc get pods -o wide | awk -v days="${1:-7}" 'NR==1{print; next} $5!~/.*d/{next}; {tmp=$5; gsub("d","",tmp); if(int(tmp) > days ){print}}'
  }
fi

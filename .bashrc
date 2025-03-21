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
#shopt -s autocd #cd just by typing the name of directory; to unset -u
#MAN_POSIXLY_CORRECT=1
# to edit content of cmdline in vim crtl x ctrl e; to set vi mode for readline "set -o vi"
# man bash(1)
export HISTSIZE=10000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoredups:ignoreboth:ignorespace
export HISTIGNORE="exit:pwd"
export EDITOR="/usr/bin/vim"
alias getpurebash="bash --norc"
#function getpurevim() { vim -u NONE -U NONE -N -i NONE "${@}"; }
alias path='echo -e ${PATH//:/\\n}'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias mip="curl --silent http://ipecho.net/plain; echo"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias cp='cp -v'
#alias cpv='rsync -ah --info=progress2'
#alias la="ls -AlSFGhB --ignore='.*.swp'"
alias lsa="ls --classify --almost-all"
alias ll='ls -lh'
#[[ $(type -t _ls) == function ]] && alias ls='_ls' #SUSE function _ls () { local IFS=' '; command ls $LS_OPTIONS ${1+"$@"}; }
#alias lt='du -sh * | sort -h'
alias ls-l='ls -l'
alias rehash='hash -r'
alias ncdu="ncdu --color=dark -x"
alias mtree='tree -pFRC -h --dirsfirst . | less -R'
alias atree='tree -apFRC -h -L 3 --dirsfirst -I .git . | less -R'
alias stree='tree -aFC -s -h --du . | less -R'
alias count-files='find . -type f | wc -l'
function stdbuf-python() { stdbuf -o0 python3 "${*}"; }
function mcd() { mkdir -p -- "$1" && builtin cd "$1" || return; }
function ,mktemp() { builtin cd "$(mktemp -d "/tmp/${*:-zmaz}XXXXXX")" || return; }
#alias pve='python3 -m venv ./venv'
#alias pva='source ./venv/bin/activate'
#alias pir="pip install -r requirements.txt"
#alias pfr="pip freeze --local > requirements.txt"

function mhelp() {
  whatis "$1"
  man "$1" | sed -n "/^\s*${2}/,/^$/p"
}

function mman() { man "${1}" | grep -e "${2}"; }

#function thistory() {
#  local HISTTIMEFORMAT="%Y-%m-%d %T "
#  history
#}

#Auto complete directory names.
#complete -A directory cl
#function cl() {
#  if [[ -n "$1" ]]; then
#    builtin cd "${1}" || return
#  else
#   cd ~ || return
#  fi
#  ls --color=auto --classify --almost-all
#}

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
  "$HOME/.local/share/coursier/bin" \
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
complete -W "$(awk '/^Host\s\*/{next}; /^Host/{print $2}' "${HOME}/.ssh/config" 2>'/dev/null')" ssh sftp
# wsl
if [[ -d '/mnt/c/Users/biroa' ]]; then
  WHOME='/mnt/c/Users/biroa'
  export WHOME
  alias cwh='cd $WHOME'
  alias cwd='cd $WHOME/Downloads'
  #alias dockerdesktop='/mnt/c/Program\ Files/docker/Docker/Docker\ Desktop.exe'
  # ONEDRIVE='/mnt/c/Users/biroa/OneDrive\ -\ IC\ GROUP/'
fi
if [[ -n "${WHOME}" ]]; then
  eval "$(keychain --quiet --eval --agents ssh ~/.ssh/wsl-GITed25519-25-3-2023)"
fi
#$(ls /run/user/${UID}/gvfs > "/dev/null" 2>&1) && \
#if [[ -d "/run/user/${UID}/gvfs" ]]; then
#  GDRIVE="/run/user/${UID}/gvfs/$(ls /run/user/${UID}/gvfs/)"
#  export GDRIVE
#  alias glsla='"gio list -a "standard::display-name"'
#  alias gls='gio list -d'
# alias gcp='gio copy -p'
#fi
## dot_files dir
if [[ $(uname -o) =~ "Linux" ]]; then
  if [[ -d "${HOME}/gits" ]]; then
    export GITS="${HOME}/gits"
    export DOTFILES="$GITS/dot_files"
    function cdf() {
      cd "${DOTFILES}" || return
      ls -AF
    }
    #export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
  fi
else # Msys git-bash
  if [[ -d "${HOME}/src" ]]; then
    export GITS="${HOME}/src"
    export DOTFILES="$GITS/dot_files"
    function cdf() {
      cd "${DOTFILES}" || return
      ls -AF
    }
    #export CDPATH=".:$HOME" #CDPATH=".:$DOTFILES:$HOME"
    ## git-bash specific
    export PATH=/bin:/usr/bin:$PATH # fix conflicts with win utils find,sort
    alias Get-Clipboard="powershell.exe -c 'Get-Clipboard'"
    alias Set-Clipboard="clip"

  fi
fi
## vim
if [[ -n ${DOTFILES} ]]; then
  export VIMINIT="source ${DOTFILES}/.vimrc"
fi

# in man bash PROMPTING
function prompt() {
  ## just posix https://askubuntu.com/questions/640096/how-do-i-check-which-terminal-i-am-using#640105
  local emulator psgit1 pscolor1
  #emulator=$(basename "/"$(ps -o cmd -f -p "$(cat /proc/${$}/stat | cut -d ' ' -f 4)" | tail -1 | sed 's/ .*$//'))"
  #emulator=$(ps -p ${$} | tail -n 1)
  #if [[ "${emulator}" =~ .*"bash" ]]; then
  emulator="${TERM_PROGRAM}"
  #fi
  psgit1="\$(git branch 2>'/dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
  pscolor1="\[\033[36m\]${psgit1}\[\033[0m\]"
  #if_err_set_red="\$([ \$? == 0 ] && echo '%' || echo '\e[01;31m%') \e[00m"
  if_err_set_red='%'

  case "${emulator##*\ }" in
  *code)
    #export PS1="${PWD##*/}%${pscolor1} "
    export PS1="\W${if_err_set_red}${pscolor1} "
    ;;
  *)
    #local hostnames=${POSHOSTNAMES:-"hp-win11 pc NP48412"}
    #if echo "$hostnames" | grep -q $(hostname); then
    local arr
    declare -A arr=(["hp-win11"]=1 ["black"]=1 ["CZ-108881"]=1 ["silver"]=1)
    [[ -v arr[$(hostname)] ]] && export PS1="\w${if_err_set_red}${pscolor1} "
    ;;
  esac
  unset psgit1 pscolor1 emulator arr
}
prompt

#### for local machine non portable
if command -v screen 1>"/dev/null" 2>&1; then
  # attach to screen session if on remote server
  [[ -z "${STY}" && -n "${SSH_CLIENT}" ]] && screen -RDR

  #alias screenr="screen -D -RR"
  #function ,screenKillAllDetached() {
  #  screen -ls | awk '/Detached/{print $1}' | xargs -I{} screen -X -S {} quit
  #}

  #function ,screenmv() {
  #  local old new
  #  old="${1:? ,screenmv <old_name> <new_name>}"
  #  new="${2:? ,screenmv <old_name> <new_name>}"
  #  screen -S "${old}" -X sessionname "${new}"
  #}

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
terminal "screen-256color"
defutf8 on

HERE_DOC
  fi
fi

#if command -v tmux 1>"/dev/null" 2>&1; then
#  function tmuxs() {
#    tmux new-session -s "${1^^}" \; split-window -v \; resize-pane -D 18 \; attach
#  }
#
#  function tmuxe() {
#    local dir
#    dir="${PWD##*/}"
#    # shellcheck disable=SC1001
#    tmux new-session -s "${dir^^}" \vim "${1}" \; split-window -v \; resize-pane -D 18 \; attach
#  }
#fi
# clipboard
#if command -v xclip 1>"/dev/null" 2>&1; then
#  alias Get-Clipboard="xclip -o clip"
#  alias Set-Clipboard="xclip -selection clipboard"
#fi

# jq
if command -v jq 1>"/dev/null" 2>&1; then

  function jless() { jq '.' -C | less -R; }
  export -f jless
fi
# bat batcat
if command -v batcat 1>"/dev/null" 2>&1; then
  alias o='batcat --pager "less -R" --plain'
  if [[ -f "${DOTFILES}/completions/go-pkg-completion" ]]; then
    # shellcheck disable=SC1091
    source "${DOTFILES}/completions/go-pkg-completion"
  fi
fi

if command -v bat 1>"/dev/null" 2>&1; then
  if [[ "${GITS##*/}" == "src" ]]; then
    function bat() {
      local index
      local args=("$@")
      for index in $(seq 0 ${#args[@]}); do
        case "${args[index]}" in
        -*) continue ;;
        *) [ -e "${args[index]}" ] && args[index]="$(cygpath --windows "${args[index]}")" ;;
        esac
      done
      command bat "${args[@]}"
    }
    export -f bat
  fi
  alias o='bat --pager "less -RF" --plain'
  if [[ -f "${DOTFILES}/completions/go-pkg-completion" ]]; then
    # shellcheck disable=SC1091
    source "${DOTFILES}/completions/go-pkg-completion"
  fi
fi

#if command -v fprettify 1>"/dev/null" 2>&1; then
#  alias ,fprettify='fprettify.py -i 4 -l 80 --strict-indent'
#fi

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
  # source completion and helper by fuction call no by default
  function ,go() {
    #PATH="/usr/local/go/bin:$PATH"
    if [[ -d "${DOTFILES}/completions/go-pkg-completion" ]]; then
      # shellcheck disable=SC1091
      source "${DOTFILES}/completions/go-pkg-completion"
    fi
    alias gomih='go mod init "${PWD##*/}"'
  }
fi

# dotnet
#if [[ -d "${HOME}/.dotnet" ]]; then
#  export DOTNET_ROOT="${HOME}/.dotnet"
#fi

## Git
if command -v git 1>"/dev/null" 2>&1; then

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
    read -p "Do you want that? y/N " -n 1 -r
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
## source helper functions by function call not by default
if command -v docker 1>"/dev/null" 2>&1; then
  function ,docker_helper_functions() {

    # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
    function dockrmall() {
      # Removes all containers, and prints their names and image base. "q" argument will suppress output, but "q" followed by "v" prints container id.
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
    } && export -f dockrmall

    # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
    function dlatestpull() {
      docker image list --format "{{.Repository}}" | xargs -L1 docker pull
      printf '\n%s\n%s\n' "Delete old images?" "yes no"
      docker images | grep '<none>'
      read -r answer
      case $answer in
      y | j | o | ok | yes)
        docker rmi "$(docker image list --format "table {{.ID}}\t{{.Tag}}" | awk '/<none>/{print $1}')"
        ;;
      *)
        return
        ;;

      esac
    } && export -f dlatestpull

    #complete -W $(docker images | awk 'NR>1{printf("%s ", $1)} END{print ""}') drun
    # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
    function netrun() {
      docker run -it \
        --network host \
        --rm --name netwb \
        jonlabelle/network-tools
    } && export -f netrun

    #function perlrun() {
    #  docker run -it \
    #          --rm --name "PERL" \
    #          -v "$PWD":/usr/src/myapp \
    #          -w /usr/src/myapp \
    #          perl:latest \
    #          perl "$1"
    #}

    #function jupyrunNp() {
    #    docker run -it --rm \
    #            -v $(pwd):/home/jovyan/work -p 8888:8888 \
    #            jupyter/scipy-notebook
    #}
    # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
    function pythonrun() {
      docker run -it \
        --rm --name "PYTHON" \
        -v "${PWD}":/usr/src/myapp \
        -w /usr/src/myapp \
        python:latest \
        python3 "${1}"
    } && export pythonrun
    # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
    function blackrun() {
      docker run --rm \
        --volume "$(pwd)":/src \
        --workdir /src \
        pyfound/black:latest \
        black --check -l 80 -S "$@"
    } && export -f blackrun
  }

fi
# ,docker_helper_functions

## source completion by function call not by default
function ,completion_k8s_oc_tf() {
  local compdir
  local compfile
  compdir="${DOTFILES}/completions/"
  ## Kubectl
  if command -v kubectl 1>"/dev/null" 2>&1; then
    compfile="kubectl-completion-kubectl.sh"
    if [[ -f "${compdir}/${compfile}" ]]; then
      # shellcheck disable=SC1090
      source "${compdir}/${compfile}"
    else
      mkdir -p "${compdir}" 1>"/dev/null" 2>&1
      kubectl completion bash >"${compdir}/${compfile}"
      # shellcheck disable=SC1090
      source "${compdir}/${compfile}"
    fi
  fi
  ## OC openshift
  if command -v oc 1>"/dev/null" 2>&1; then
    compfile="oc-completion-bash.sh"
    if [[ -f "${compdir}/${compfile}" ]]; then
      # shellcheck disable=SC1090
      source "${compdir}/${compfile}"
    else
      mkdir -p "${compdir}" 1>"/dev/null" 2>&1
      oc completion bash >"${compdir}/${compfile}"
      # shellcheck disable=SC1090
      source "${compdir}/${compfile}"
    fi
  fi

  if (command -v oc 1>"/dev/null" 2>&1) || (command -v kubectl 1>"/dev/null" 2>&1); then
    # shellcheck disable=2139
    function oContReady() {
      # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
      oc get pods -o wide | awk 'NR==1{print; next} {split($2, arr, "/"); if(arr[1] != arr[2]) print}'
    } && export -f oContReady
    # shellcheck disable=2139
    function oContRestarts() {
      # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
      oc get pods -o wide | awk 'NR==1{print; next} {if($4 > 0) print}'
    } && export -f oContRestarts

    function oContAge() {
      # shellcheck disable=SC2317  # Don't warn about unreachable commands in this function
      oc get pods -o wide | awk -v days="${1:-7}" 'NR==1{print; next} $5!~/.*d/{next}; {tmp=$5; gsub("d","",tmp); if(int(tmp) > days ){print}}'
    } && export -f oContAge
  fi

  if command -v terraform 1>"/dev/null" 2>&1; then
    complete -C "$(command -v terraform)" terraform
  fi
}
#,completion_k8s_oc_tf

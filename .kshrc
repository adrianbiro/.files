# skip for non-interactive shell
[[ -o interactive && -t 0 ]] || return

PATH=$PATH:$HOME/bin:.
export PATH

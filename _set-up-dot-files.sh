#!/bin/bash
declare -a files
files=(
    ".bashrc"
    ".kshrc"
    #".vimrc"  # cf. in .bashrc VIMINIT
    ".bash_profile"
    ".curlrc"
    ".emacs"
    ".gdbinit"
    ".gitconfig"
    ".inputrc"
    ".nanorc"
    ".psqlrc"
    ".screenrc"
    ".tmux.conf"
    )
if [[ "${PWD##*/}" != "dot_files" ]]; then
    echo "Run from dot_files directory."
    exit 1
fi
for i in "${files[@]}"; do
    ln -sf "${PWD}/${i}" "${HOME}/${i}"
done

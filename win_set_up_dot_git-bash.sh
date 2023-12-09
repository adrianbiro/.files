#!/bin/bash
declare -a files
files=(".vimrc" ".bashrc")
if [[ "${PWD##*/}" != "dot_files" ]]; then
    echo "Run from dot_files directory."
    exit 1
fi
for i in "${files[@]}"; do
    ln -sf "${PWD}/${i}" "${HOME}/${i}"
done

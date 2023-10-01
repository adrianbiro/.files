#!/bin/bash

echo 'history -a && history -c && sort -m -u -o ~/.bash_history ~/.bash_history && history -r' >> ~/.bash_logout

: <<'END_COMMENT'
history
    -a    append history lines from this session to the history file
    -c    clear the history list by deleting all of the entries
    -r    read the history file and append the contents to the history list
sort    
    -u, --unique
    -o, --output=FILE
    -m, --merge     merge already sorted files; do not sort
END_COMMENT

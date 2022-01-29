syntax on
filetype plugin on
set nocompatible
set tabstop=4 softtabstop=4
set exrc
set nu
set relativenumber
set incsearch
set scrolloff=8
set wildmenu
" auto delete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" read file template a from directory, to chose file use wildmenu with TAB
nnoremap my_templates :-1read $HOME/bin/my_templates/
" to read the concrete file, do not name command with insert character such as aAiIoO, <CR> => ENTER
" nnoremap <cmdname> :-3read $HOME/path/to/file<CR>4j2wf#a
" to fix color problem in tmux
set background=dark

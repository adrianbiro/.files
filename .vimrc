syntax on
filetype plugin on
set nocompatible
set tabstop=4 softtabstop=4
set exrc
set nu
set relativenumber
"Map F3 to togle relativenumbers Normal mode
nmap <F3> :set relativenumber! <CR>
"Map F3 to togle relativenumbers Insert mode
imap <F3> <ESC> :set relativenumber! <CR>i
"Map \ <leader>F3 to togle numbers Normal mode
nmap <leader><F3> :set nu! <CR>
set incsearch
set scrolloff=8
set wildmenu
" auto delete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

"to show tab character like ^I and space on end of line like $
set list
"custom format of list
set listchars=eol:⏎,tab:>-,trail:␣,extends:>,precedes:<
"to toge this by <F4> in Normal and Insert modes
nmap <F4> :set list! <CR>
imap <F4> <ESC> :set list! <CR>i

" read file template a from directory, to chose file use wildmenu with TAB
nnoremap my_tm :-1read $HOME/bin/gits/my_templates/
" to read the concrete file, do not name command with insert character such as aAiIoO, <CR> (ENTER)
" nnoremap <cmdname> :-3read $HOME/path/to/file<CR>4j2wf#a
" to fix color problem in tmux
set background=dark
"Autocorrect
abbr zyper zypper
" I dont like wrapping lines to mix with the line numbers
set showbreak=\ \ \ \ \ \ \ \
"Map F2 Buffers to tabs Normal mode
nmap <F2> :tab ball <CR>

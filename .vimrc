" UNFOLD by zo; close zc; open all zR; close all zM; make one zf
" SYNTAX, FILETYPE, etc "{{{
syntax on"
filetype plugin on
filetype indent on
set autoindent smartindent
set nocompatible
set tabstop=4 softtabstop=4
set expandtab
augroup configgroup
  autocmd FileType python setl tabstop=4|setl shiftwidth=4|setl softtabstop=4"
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
  autocmd BufNewFile,BufRead *.groff set filetype=groff
augroup END"
set encoding=utf-8
set fileformats=unix,dos,mac
" auto delete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" I dont like wrapping lines to mix with the line numbers
set showbreak=\ \ \ \ \ \ \ \
"set nowrap "extend long lines as far as the line can go
"}}}

" MIX "{{{
"set textwidth=72
set showcmd
set incsearch
fu! Mclear()                " To clear the last used search pattern
  :let @/ = ""
endf
command! Mclear call Mclear()
set scrolloff=10
runtime! ftplugin/man.vim   " to read man page in vim split :Man 8 ln or pres K on the word you want to find
set wildmenu
"set wildmode=list:longest "pipe all to more
" ignore files with these extensions
"set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
"set hlsearch
set history=1000
set exrc
set title       "set window title by currently edited file (terminal tab dialog)
"set ruler
"set paste
"set mouse=a
"set confirm     "when closing an unsaved file
"}}}

" REMAPPING, NUMBERS, TABS and co. {{{
set nu
set relativenumber
"Map F3 to togle relativenumbers Normal mode
nmap <F3> :set relativenumber! <CR>
"Map F3 to togle relativenumbers Insert mode
imap <F3> <ESC> :set relativenumber! <CR>i
"Map \ <leader>F3 to togle numbers Normal mode
nmap <leader><F3> :set nu! <CR>

"to show tab character like ^I and space on end of line like $
"set list
"custom format of list ° · »
set listchars=eol:⏎,tab:>-,trail:␣,extends:>,precedes:<
"to toge this by <F4> in Normal and Insert modes
nmap <F4> :set list! <CR>
imap <F4> <ESC> :set list! <CR>i

" read file template a from directory, to chose file use wildmenu with TAB
nnoremap my_tm :-1read ~/.vim/my_templates/
" to read the concrete file, do not name command with insert character such as aAiIoO, <CR> (ENTER)
" nnoremap <cmdname> :-3read $HOME/path/to/file<CR>4j2wf#a
nmap <F12> :! less ~/.vim/pomoc.md <CR>
"nmap <F12> :vsp ~/.vim/pomoc.md <CR>
"Map F2 Buffers to tabs Normal mode
nmap <F2> :tab ball <CR>
set tabpagemax=30
"}}}

" TMUX {{{
" to fix color problem in TMUX
set background=dark
"set esckeys		"allows function keys to be recognized in Insert mode
"set ttimeoutlen=20	"timeout for a key code mapping
"set timeoutlen=1000	"time(ms) to wait for key mappings
" allows cursor change in tmux mode
"if exists('$TMUX')
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
"}}}

"AUTOCORECT "{{{
abbr zyper zypper
abbr sefl self
abbr mmmgroff .SH NAME<CR>.B<CR>\-<CR>.SS SYNOPSIS<CR>\fB \fR<CR>.TP<CR>.\fB \fR<CR>.TP<CR>S\fB \fR<CR>.TP<CR>.B<CR>[\fI\, $1, $2 \/\fR]<CR>.TP<CR>.SS DESCRIPTION<CR><CR>.SS SEE ALSO<CR>
abbr mmmstartgroff .\" Manpage for<CR>.\" Contact Adrián Bíro to correct errors or typos.<CR>.TH TODOname 1 "15 March 2022" "0.1" "TODOname man page"<CR>.SH NAME<CR>.B<CR>\-<CR>.SS SYNOPSIS<CR>\fB \fR<CR>.TP<CR>.\fB \fR<CR>.TP<CR>S\fB \fR<CR>.TP<CR>S\fB \fR<CR>.TP<CR> DESCRIPTION<CR><CR>.SS SEE ALSO<CR><CR><CR><CR>.SH AUTHOR<CR>Adrián Bíro<CR>.SH BUGS<CR>I'm the bug.<CR>.SH SEE ALSO<Cr>BASH(1), vimrc(1), tmux.conf(1)TODO<CR>.PP<CR>.br<CR><https://github.com/adrianbiro/.files>TODO<CR>.br
"}}}

"NETWR :Explore :Vex {{{
" deletes netrw's hidden buffer
autocmd FileType netrw setl bufhidden=delete
"recursive search of dirs for search find [file name]
set path+=**
" Tree like displaying of files
let g:netrw_liststyle = 3
" recursive copy
let g:netrw_localcopydircmd = 'cp -r'
" open splits to the right
let g:netrw_prewiev=1
"default window size on split 0 to equal
let g:netrw_winsize = 0
"Turn off help banner I to show
let g:netrw_banner=0
"Hide the dot files on startup 'gh' to show
let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
"current dir and browsing dir are synced
"let g:netrw_keepdir = 0
"}}}

"PLUGIN "{{{
"nmap <leader>4 :let g:syntastic_check_on_open       = 1 <CR> :w <CR>
"set runtimepath^=~/.vim/pack/syntastic-master
"let g:syntastic_check_on_open       = 1
"let g:syntastic_check_on_wq         = 0
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"}}}

"folding for this file "{{{
"to save folding select text 'zf' to fold 'zo' to unfold
autocmd BufWinLeave *.* mkview
autocmd BufWinLeave *.* silent loadview
set foldmethod=marker       " fold by marks no by indentation
"foldmethod=indent
set foldlevel=0             " close folds by default
set modelines=1
"}}}


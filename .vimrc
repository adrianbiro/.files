syntax on
filetype plugin on
filetype indent on
set autoindent smartindent
set nocompatible
set tabstop=4 softtabstop=4
augroup configgroup
  autocmd FileType python setl tabstop=4|setl shiftwidth=4|setl softtabstop=4
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
"set ruler
"set paste
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
"set list
"custom format of list
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
""""""""""
" to fix color problem in TMUX
set background=dark
" allows cursor change in tmux mode
"if exists('$TMUX')
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif
"Autocorrect
abbr zyper zypper
" I dont like wrapping lines to mix with the line numbers
set showbreak=\ \ \ \ \ \ \ \
"Map F2 Buffers to tabs Normal mode
nmap <F2> :tab ball <CR>

"to save folding select text 'zf' to fold 'zo' to unfold
autocmd BufWinLeave *.* mkview
autocmd BufWinLeave *.* silent loadview

"""""""""""""""""""""""""""""""""""""""""""""""""""
"NETWR :Explore :Vex

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


""""""""""""""""""""""""""""""
"Plugin
"nmap <leader>4 :let g:syntastic_check_on_open       = 1 <CR> :w <CR>
"set runtimepath^=~/.vim/pack/syntastic-master
"let g:syntastic_check_on_open       = 1
let g:syntastic_check_on_wq         = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*





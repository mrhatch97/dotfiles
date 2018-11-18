" ~/.vimrc

" **************************************
" * VARIABLES
" **************************************
set nocompatible		" get rid of strict vi compatibility!
set nu				    " line numbering on
set autoindent			" autoindent on
set noerrorbells		" bye bye bells :)
set modeline			" show what I'm doing
set showmode			" show the mode on the dedicated line (see above)
set wildmenu			" Better command line completion
set showcmd			    " Show partial commands in last line of screen
set nowrap			    " no wrapping!
set ignorecase			" search without regards to case
set smartcase			" except when using capital letters
set backspace=indent,eol,start	" backspace over everything
set fileformats=unix,dos,mac	" open files from mac/dos
set exrc			    " open local config files
"set nojoinspaces		" don't add white space when I don't tell you to
set ruler			    " which line am I on?
set showmatch			" ensure Dyck language
set incsearch			" incremental searching
set nohlsearch			" meh
set bs=2		    	" fix backspacing in insert mode
set bg=light
set laststatus=2		" Always display status line
set confirm	    		" Confirm instead of fail 

" General indentation options

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set smartindent

" Show syntax
syntax on

" Determine editor behavior based on filetype
filetype indent plugin on

" Colorscheme
:colors slate

" For switching between many opened file by using ctrl+l or ctrl+h
map <C-J> :next <CR>
map <C-K> :prev <CR>

" Spelling toggle via F10 and F11
map <F10> <Esc>setlocal spell spelllang=en_us<CR>
map <F11> <Esc>setlocal nospell<CR>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Mapping to force write to file with root privileges
cmap w!! w !sudo tee > /dev/null %

" Avoid duplication of autocmds
if !exists("autocmds_loaded")
    let autocmds_loaded=1

    augroup vimrc_autocmds
      " Overlength line highlighting and wrapping for src files
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} highlight overLength ctermbg=red guifg=white guibg=#592929
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} match overLength /\%>80v.\+/
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} set textwidth=80

      " Expand tabs in these files
      au BufRead,BufNewFile *.{c,h,java,cpp,hpp} set expandtab
      au BufRead,BufNewFile *.{c,h,java,cpp,hpp} set shiftwidth=2
      au BufRead,BufNewFile *.{c,h,java,cpp,hpp} set tabstop=2

      " Do not expand tabs in assembly files.  
      au BufRead,BufNewFile *.s set noexpandtab
      au BufRead,BufNewFile *.s set shiftwidth=8

      " Do not expand tabs in Makefiles
      au BufRead,BufNewFile Makefile set noexpandtab
      au BufRead,BufNewFile Makefile set shiftwidth=6
      au BufRead,BufNewFile Makefile set tabstop=6

    augroup END
endif

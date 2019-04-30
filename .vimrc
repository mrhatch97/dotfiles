" ~/.vimrc
" Matthew Hatch
" Last edited 2019-04-06

set nocompatible		" get rid of strict vi compatibility!
filetype off

" **************************************
" * VUNDLE CONFIG
" **************************************

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'Chiel92/vim-autoformat'
Plugin 'godlygeek/tabular'
Plugin 'w0rp/ale'
Plugin 'Yggdroot/indentLine'

call vundle#end()            " required
filetype plugin indent on    " required

" **************************************
" VARIABLES
" **************************************
set nu                                          " line numbering on
set autoindent                                  " autoindent on
set noerrorbells                                " bye bye bells :)
set modeline                                    " show what I'm doing
set showmode                                    " show the mode on the dedicated line (see above)
set wildmenu                                    " Better command line completion
set showcmd                                     " Show partial commands in last line of screen
set ignorecase                                  " search without regards to case
set smartcase                                   " except when using capital letters
set backspace=indent,eol,start                  " backspace over everything
set fileformats=unix,dos,mac                    " open files from mac/dos
set ruler                                       " which line am I on?
set showmatch                                   " ensure Dyck language
set incsearch                                   " incremental searching
set bs=2                                        " fix backspacing in insert mode
set laststatus=2                                " Always display status line
set confirm                                     " Confirm instead of fail

" General indentation options

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set smartindent

" Syntax highlighting theme
syntax enable
set background=dark
colorscheme solarized
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Linter config
let g:ale_linters = {
\   'cpp': ['clangtidy']
\}
let g:airline#extensions#ale#enabled = 1

" **************************************
" KEYMAPS
" **************************************
noremap <F3> :Autoformat<CR>

" For switching between many opened files by using ctrl+l or ctrl+h
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

" Easy exit from insert mode
inoremap jj <ESC>

" Avoid duplication of autocmds
if !exists("autocmds_loaded")
    let autocmds_loaded=1

    augroup vimrc_autocmds
      " Overlength line highlighting and wrapping for src files
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} highlight overLength ctermbg=red guifg=white guibg=#592929
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} match overLength /\%>80v.\+/
      au BufRead,BufNewFile *.{s,c,h,java,cpp,hpp} set textwidth=80

      " Expand tabs in C files to spaces
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

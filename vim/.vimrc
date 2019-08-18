" ~/.vimrc
" Matthew Hatch
" Last edited 2019-08-18

set nocompatible        " get rid of strict vi compatibility!
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
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'Chiel92/vim-autoformat'
Plugin 'godlygeek/tabular'
Plugin 'w0rp/ale'
Plugin 'Yggdroot/indentLine'

call vundle#end()            " required
filetype plugin indent on    " required

packadd termdebug

" **************************************
" VARIABLES
" **************************************
set nu                                          " line numbering on
set encoding=utf8                               " default to UTF-8 encoding
set noerrorbells                                " bye bye bells :)
set modeline                                    " show what I'm doing
set showmode                                    " show the mode on the dedicated line (see above)
set path+=**                                    " Recursive search for file operations
set wildmenu                                    " Better command line completion
set showcmd                                     " Show partial commands in last line of screen
set ignorecase                                  " search without regards to case
set smartcase                                   " except when using capital letters
set hlsearch                                    " Highlight search results
set splitbelow                                  " h-split to bottom
set splitright                                  " v-split to right
set backspace=indent,eol,start                  " backspace over everything
"set whichwrap+=<,>,h,l                         " Allow line wrapping when navigating horizontally
set fileformats=unix,dos,mac                    " open files from mac/dos
set ruler                                       " which line am I on?
set showmatch                                   " highlight matching parentheses
set incsearch                                   " incremental searching
set laststatus=2                                " Always display status line
set confirm                                     " Confirm instead of fail
set so=15                                       " Pad edge of window by 15 lines when scrolling
set wrap                                        " Wrap lines over the terminal buffer width

" Disable swap files and backups
set nobackup
set nowb
set noswapfile

" General indentation options
" Spaces to indent, 4-wide indent
set autoindent                                  " Try to match indentation, allow smartindent
set expandtab                                   " Tab outputs spaces
set shiftwidth=4                                " Spaces per indentation step for autoindent
set tabstop=4                                   " Number of spaces \t occupies
set smarttab                                    " Insert tabs according to shiftwidth or (soft)tabstop based on context
set smartindent                                 " OK default autoindentation option for C-like languages

" Syntax highlighting theme
syntax enable

" Set these to 0 if your terminal emulator has issues with font styles
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1

set background=dark
colorscheme solarized
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

hi Terminal ctermbg=black guibg=black 

" Ignore compiled files when autocompleting
set wildignore=*.o,*.exe,*.obj,*.class,*.jar,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Built-in file browser
let g:netrw_banner=0                            " Disable banner
let g:netrw_browse_split=4                      " Open in prior window
let g:netrw_altv=1                              " Split to right
let g:netrw_liststyle=3                         " Display as tree

" airline
let g:airline_theme='badwolf'
let g:airline_solarized_bg='dark'
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

" Miscellaneous
let g:tex_flavor = "latex"                      " Default to LaTeX if can't determine type of .tex file
let g:tex_conceal = ""                          " Stop hiding LaTeX markup

" Grep for the given word, skip the prompt, open quickfix window
function Grep_internal(term)
    silent execute " grep -srnw --binary-files=without-match --exclude-dir=.git
                \ --exclude-from=exclude.list . -e " . a:term . " "
    redraw!
    cwindow
endfunction

" **************************************
" KEYMAPS
" **************************************
noremap <F2> :so $MYVIMRC<CR> " Reload the vimrc
noremap <F3> :Autoformat<CR>
noremap <F4> :NERDTree<CR>
map <F5> :call Grep_internal(expand("<cword>"))<CR>
map <F6> :!ctags --totals=yes --recurse=yes . <CR>

" Move between splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

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

" Move rest of line up a line
map L DO<c-r>"<ESC>

" Easy exit from insert mode
inoremap jj <ESC>

command! -nargs=1 Grep :call Grep_internal(<f-args>)

" Avoid duplication of autocmds
if !exists("autocmds_loaded")
    let autocmds_loaded=1

    " Move cursorline with active window
    augroup CursorLine
        au!
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
    augroup END

    augroup vimrc_autocmds
        " Overlength line highlighting for source files
        autocmd FileType c,cpp,cs,cmake,haskell,java,python,javascript highlight overLength ctermbg=red guifg=white guibg=#592929
        autocmd FileType c,cpp,cs,cmake,haskell,java,python,javascript match overLength /\%>80v.\+/
    augroup END
endif

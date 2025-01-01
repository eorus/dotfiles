"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" load  basic settings
let mapleader =","        " change the map leader
nnoremap c "_c
set nocompatible
set t_u7=
filetype off                  " required
filetype plugin indent on
set nohlsearch
syntax on
set encoding=utf-8
set number relativenumber
set title
set go+=m
set mouse=a
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab "use two spaces for indentation
set nocp
    au BufEnter * set ignorecase
set clipboard^=unnamed,unnamedplus	 " use the system clipboard

set smartcase             	 " only use case sensitive search when uppercase
set wildmode=longest,list,full 	 " Enable autocompletion
set splitright splitbelow  	 " Split to the right, to the bottom
set autoindent			 " Always set autoindenting on
set autoread              	 " auto read files changed outside vim
set cursorline            	 " highlight current line
set hidden                	 " allow background buffers
set incsearch             	 " search as characters are entered
set ignorecase            	 " case insensitive searching
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab "use two spaces for indentation
set ttimeoutlen=1

" And keep splits neat when vim is resized
autocmd VimResized * wincmd =
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup cursor_behaviour
    autocmd!

    " reset cursor on start:
    autocmd VimEnter * silent !echo -ne "\e[2 q"
    " cursor blinking bar on insert mode
    let &t_SI = "\e[5 q"
    " cursor steady block on command mode
    let &t_EI = "\e[2 q"

    " highlight current line when in insert mode
    autocmd InsertEnter * set cursorline
    " turn off current line highlighting when leaving insert mode
    autocmd InsertLeave * set nocursorline

augroup END

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

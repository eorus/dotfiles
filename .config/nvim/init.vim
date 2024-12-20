" Load all the plugins
source ~/.config/nvim/plugins.vim

" My Settings ==================================================================

" Basics
let mapleader =","        " change the map leader
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set title
set go=a
set mouse=a
set nohlsearch
set filetype=html
setlocal conceallevel=3

set clipboard+=unnamedplus	 " use the system clipboard
set hlsearch              	 " highlight the search query
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

" And keep splits neat when vim is resized
autocmd VimResized * wincmd =
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""""""""""""""""""""""""""""""""""""""""
"Mappings
"""""""""""""""""""""""""""""""""""""""""

"Find and replace
map <leader>fr  :%s///g<left><left>
map <leader>frl :%s:::g<left><left>

" FZF mappings
nmap <Leader>f :Files<CR>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <C-g> :Rg<Cr>
nnoremap <F5> :Buffers<CR>
nnoremap <F3> :tab sball<CR>
nnoremap <leader>B :enew<cr>
nnoremap <S-Tab> :bnext<cr>

" File Explorer
let NERDTreeMinimalUI=1
let g:NERDTreeQuitOnOpen = 1
map <F2> :NERDTreeToggle<CR>
let NERDTreeWinSize=32
map <leader>e :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <leader>n :Lexplore<CR>
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
nmap <space>r :RnvimrToggle<CR>
map <F2> :RnvimrToggle<CR>


" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"toggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" UnoTree Toggle
nnoremap <F4> :UndotreeToggle<cr>

" Markdown Preview Toggle
nmap <C-p> <Plug>MarkdownPreviewToggle

" Goyo plugin makes text more readable when writing prose:
map <leader>g :Goyo \| set bg=dark \| set linebreak<CR>

" Vimwiki ==================================================================
" Ensure files are read as what I want:
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/Documents/Notes/vimwiki/notes', 'syntax': 'markdown', 'ext': '.md'}]

au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map <C-d> :VimwikiMakeDiaryNote
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map <C-c> :call ToggleCalendar()
let g:instant_markdown_autostart = 0	" disable autostart
let g:vimwiki_markdown_link_ext = 1

"Backup************************************************************

" Make an undo directory if it does not exist
if !isdirectory($HOME . "/.config/nvim/undo")
    call mkdir($HOME . "/.config/nvim/undo", "p")
endif
set undodir=~/.config/nvim/undo " Set the undo directory
set undofile " Turn on persistent undo
set undoreload=10000

set backup
if !isdirectory($HOME . "/.config/nvim/backup")
    call mkdir($HOME . "/.config/nvim/backup", "p")
endif
set backupdir=~/.config/nvim/backup

let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" Deoplete *********************************************************
" omnifunc
aug omnicomplete
  au!
  au FileType css,sass,scss,stylus,less setl omnifunc=csscomplete#CompleteCSS
  au FileType html,htmldjango,jinja,markdown setl omnifunc=emmet#completeTag
  au FileType javascript,jsx,javascript.jsx setl omnifunc=tern#Complete
  au FileType python setl omnifunc=pythoncomplete#Complete
  au FileType xml setl omnifunc=xmlcomplete#CompleteTags
aug END

au FileType html setl omnifunc=csscomplete#CompleteCSS
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Colorscheme********************************************************
set t_Co=256                        "enable 256 colors
set termguicolors                   " Use true colors
colorscheme iceberg
"status line: modifiedflag, charcount, filepercent, filepath
"set statusline=%=%m\ %c\ %P\ %f

"remove current line highlight in unfocused window
au VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter * set cul
au WinLeave,FocusLost,CmdwinLeave * set nocul
"
" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

nnoremap <silent> <leader>vtt :Translate<CR>
vnoremap <silent> <leader>vtt :TranslateVisual<CR>
vnoremap <silent> <leader>vtr :TranslateReplace<CR>

let g:translate#default_languages = {
      \ 'tr': 'en',
      \ 'en': 'tr'
      \ }

let g:ale_fixers={
  \'javascript': ['prettier'],
  \'json': ['prettier'],
  \'php': ['prettier'],
  \'css': ['prettier'],
  \'html': ['prettier'],
\}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

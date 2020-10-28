if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'blindFS/vim-taskwarrior'
Plug 'tpope/vim-surround' " surrounding text objects with paranthesis, quotes, html tags...

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mbbill/undotree'
" navigation
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
Plug 'ryanoasis/vim-devicons'

Plug 'mattn/calendar-vim'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'

"Plug 'jreybert/vimagit'

Plug 'vimwiki/vimwiki'

"Look and Feel
Plug 'bling/vim-airline'
Plug 'w0ng/vim-hybrid'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ap/vim-css-color' " Display the hexadecimal colors - useful for css and color config
Plug 'khzaw/vim-conceal'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

setlocal foldmethod=indent
setlocal foldmethod=expr
setlocal foldexpr=FoldUtil#FoldFunction(v:lnum)


" My Settings ==================================================================

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
filetype indent on      " load filetype-specific indent files
set encoding=utf-8
set number relativenumber


" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set autoindent
set autoread              " auto read files changed outside vim
set cursorline            " highlight current line
set clipboard=unnamedplus " use the system clipboard
" Tabs. May be overriten by autocmd rules
set tabstop=4             " number of visual spaces per TA
set softtabstop=4         " number of spaces in tab when editing
set expandtab             " tabs are spaces
set shiftwidth=2
set expandtab
set smarttab
set encoding=utf-8        " set encoding
set fillchars+=vert:▒
set formatoptions+=j
set hidden                " allow background buffers
set incsearch             " search as characters are entered
set hlsearch              " highlight the search query
set ignorecase            " case insensitive searching
" It's useful to show the buffer number in the status line.
set laststatus=2          " always show airline
set lazyredraw            " don't redraw during macro execution
set mouse=a               " enable the mouse
set nobackup              " no backup files
set noshowmode            " doesn't show the current mode in the command bar
set noswapfile            " no swap files
set number                " show line numbers
set relativenumber
set scrolljump=1          " scroll 1 line at a time
set scrolloff=5           " start scrolling 5 lines before bottom of pane
set showcmd               " show command in bottom bar
set smartcase             " only use case sensitive search when uppercase
set termguicolors        " Use true colors
let mapleader =","        " change the map leader

if (has("nvim"))
 "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"set bg=light
set go=a
set mouse=a
set nohlsearch
set filetype=html
setlocal conceallevel=3

" Split to the right, to the bottom
set splitright splitbelow
" And keep splits neat when vim is resized
autocmd VimResized * wincmd =

" Enable autocompletion:
set wildmode=longest,list,full
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Find and replace
map <leader>fr :%s///g<left><left>
map <leader>frl :s///g<left><left>
" FZF mappings
nmap <Leader>f :Files<CR>
"nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>
nnoremap <C-g> :Rg<Cr>
" highlight last inserted text
nnoremap gV `[v`]

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" Security
" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" UnoTree Toggle
nnoremap <F4> :UndotreeToggle<cr>
nnoremap <F5> :Buffers<CR>
nnoremap <F3> :tab sball<CR>

" NERDTree
let NERDTreeMinimalUI=1
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeQuitOnOpen = 1
map <leader>e :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Task Warrior ==================================================================

let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
let g:task_report_command  = []
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" allows user to override task configurations. Seperated by space. Defaults to ''
let g:task_rc_override     = 'rc.defaultwidth=999'
" default fields to ask when adding a new task
let g:task_default_prompt  = ['due', 'description']
" whether the info window is splited vertically
let g:task_info_vsplit     = 0
" info window size
let g:task_info_size       = 15
" info window position
let g:task_info_position   = 'belowright'
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '~/.task'
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <<'
" backward arrow ...
let g:task_left_arrow      = '>> '

" Markdown Preview Toggle
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" Goyo plugin makes text more readable when writing prose:
	map <leader>g :Goyo \| set bg=dark \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

" Vimwiki ==================================================================

" Ensure files are read as what I want:

let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:vimwiki_list = [{'path': '~/notes/vimwiki/notes', 'syntax': 'markdown', 'ext': '.md'}]

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

" set airline theme
let g:airline_theme = 'nord'
"let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD

"TABLINE:

let g:airline#extensions#tabline#enabled = 1           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline


" Favourite colorscheme
set t_Co=256
set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum        " set background color
let g:nord_bold_vertical_split_line = 1
colorscheme nord

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

" deoplete
let g:deoplete#enable_at_startup = 1
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'blindFS/vim-taskwarrior'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mbbill/undotree'
Plug 'mattn/calendar-vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'tools-life/taskwiki'
Plug 'vimwiki/vimwiki'
Plug 'VincentCordobes/vim-translate'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround' " surrounding text objects with paranthesis, quotes, html tags...
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'dense-analysis/ale'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'ap/vim-css-color' " Display the hexadecimal colors - useful for css and color config
Plug 'khzaw/vim-conceal'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
call plug#end()

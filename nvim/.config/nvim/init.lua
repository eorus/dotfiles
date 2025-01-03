require("plugins")

vim.g.mapleader = ","					-- sets leader key
vim.g.netrw_banner = 0					-- gets rid of the annoying banner for netrw
vim.g.netrw_browse_split=4				-- open in prior window
vim.g.netrw_altv = 1					-- change from left splitting to right splitting
vim.g.netrw_liststyle=3					-- tree style view in netrw
vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
vim.g.vimwiki_list = {{path = '~/Documents/Notes/vimwiki/notes', syntax = 'markdown', ext = '.md'}}
vim.g.python3_host_prog='/usr/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2'

vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
vim.opt.title = true					-- show title
vim.opt.syntax = "ON"
--vim.opt.backup = false
vim.opt.compatible = false				-- turn off vi compatibility mode
vim.opt.number = true					-- turn on line numbers
vim.opt.relativenumber = true				-- turn on relative line numbers
vim.opt.mouse = 'a'						-- enable the mouse in all modes
vim.opt.ignorecase = true				-- enable case insensitive searching
vim.opt.smartcase = true				-- all searches are case insensitive unless there's a capital letter
vim.opt.hlsearch = false				-- disable all highlighted search results
vim.opt.incsearch = true				-- enable incremental searching
vim.opt.hidden = true					-- allow background buffers
vim.opt.wrap = true						-- enable text wrapping
vim.opt.tabstop = 2						-- tabs=4spaces
vim.opt.shiftwidth = 2
vim.opt.fileencoding = "utf-8"				-- encoding set to utf-8
vim.opt.pumheight = 10					-- number of items in popup menu
vim.opt.showtabline = 2					-- always show the tab line
vim.opt.laststatus = 2					-- always show statusline
vim.opt.signcolumn = "auto"
vim.opt.expandtab = true				-- expand tab
vim.opt.autoindent = true
vim.opt.cursorline = true       -- highlight current line
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.showmode = true
vim.opt.scrolloff = 8					-- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8				-- scroll page when cursor is 8 spaces from left/right
vim.opt.guifont = "monospace:h17"
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt= { "menuone", "noselect" }
vim.opt.splitbelow = true				-- split go below
vim.opt.splitright = true				-- vertical split to the right
vim.opt.termguicolors = true			-- terminal gui colors
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.backspace ="indent,eol,start"

vim.cmd [[
	set path+=**
	colorscheme iceberg
	filetype plugin on
	set wildmenu
	:autocmd BufNewFile *.sh 0r ~/.config/nvim/skeleton.sh
	:autocmd BufWritePost *.h !make
	:autocmd BufNewFile *.md 0r ~/.config/nvim/skeleton.md
	command! Reload :source ~/.config/nvim/init.lua
	command! Make :!make
]]

--Backup************************************************************
vim.cmd [[

" Make an undo directory if it does not exist
if !isdirectory($HOME . "/.local/share/nvim/undo")
    call mkdir($HOME . "/.local/share/nvim/undo", "p")
endif
set undodir=~/.local/share/nvim/undo " Set the undo directory
set undofile " Turn on persistent undo
set undoreload=10000

set backup
if !isdirectory($HOME . "/.local/share/nvim/backup")
    call mkdir($HOME . "/.local/share/nvim/backup", "p")
endif
set backupdir=~/.local/share/nvim/backup

]]
--
vim.cmd [[
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
	autocmd BufWritePost *Xresources,*Xdefaults,xresources !xrdb %
]]

--statusline
vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
vim.cmd "highlight StatusFile guibg=#fabd2f guifg=#1d2021"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = " "
				.. ""
				.. " "
				.. "%l"
				.. " "
				.. " %#StatusType#"
				.. "<< "
				.. "%Y"
				.. "  "
				.. " >>"
				.. "%#StatusFile#"
				.. "<< "
				.. "%F"
				.. " >>"
				.. "%#StatusModified#"
				.. " "
				.. "%m"
				.. " "
				.. "%#StatusNorm#"
				.. "%="
				.. "%#StatusBuffer#"
				.. "<< "
				.. "﬘ "
				.. "%n"
				.. " >>"
				.. "%#StatusLocation#"
				.. "<< "
				.. "燐 "
				.. "%l,%c"
				.. " >>"
				.. "%#StatusPercent#"
				.. "<< "
				.. "%p%%  "
				.. " >> "

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Find and replace
--map <leader>fr  :%s///g<left><left>
--map <leader>frl :%s:::g<left><left>

-- reload config
map("n", "<leader>sv", ":source ~/.config/nvim/init.lua<CR>")	-- reload neovim config
map("n", "<leader>ev", ":vsplit $MYVIMRC<CR>")              	-- reload neovim config
map("n", "<leader>eb", ":edit ~/.bashrc<CR>")	                -- edit bashrc
map("n", "<leader>et", ":edit ~/.tmux.con<CR>")	              -- edit tmux config
map("n", "<leader>en", ":edit ~/.config/newsboat/config<CR>")	-- edit newsboat config
map("n", "<leader>eu", ":edit ~/.config/newsboat/url<CR>")  	-- eidt newsboat url

-- Tab bindings
map("n", "<leader>t", ":tabnew<CR>")			-- space+t creates new tab
map("n", "<leader>x", ":tabclose<CR>")			-- space+x closes current tab
map("n", "<leader>j", ":tabprevious<CR>")		-- space+j moves to previous tab
map("n", "<leader>k", ":tabnext<CR>")			-- space+k moves to next tab
map("n", "F3", ":tab sball<CR>")			-- space+k moves to next tab

-- easy split generation
map("n", "<leader>v", ":vsplit")				-- space+v creates a veritcal split
map("n", "<leader>s", ":split")					-- space+s creates a horizontal split
map("n", "<leader>hh", ":nohl")					-- space+s creates a horizontal split

-- easy split navigation
map("n", "<C-h>", "<C-w>h")						-- control+h switches to left split
map("n", "<C-l>", "<C-w>l")						-- control+l switches to right split
map("n", "<C-j>", "<C-w>j")						-- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k")						-- control+k switches to top split

-- buffer navigation
map("n", "<Tab>", ":bnext <CR>")				-- Tab goes to next buffer
map("n", "<S-Tab>", ":bprevious <CR>")			-- Shift+Tab goes to previous buffer
map("n", "<leader>d", ":bd! <CR>")				-- Space+d delets current buffer
map("n", "<leader>b", ":buffers<CR>:buffer<Space>")				-- Space+d delets current buffer

-- adjust split sizes easier
map("n", "<C-Left>", ":vertical resize +3<CR>")		-- Control+Left resizes vertical split +
map("n", "<C-Right>", ":vertical resize -3<CR>")	-- Control+Right resizes vertical split -

-- Open netrw in 25% split in tree view
map("n", "<leader>e", ":25Lex<CR>")			-- space+e toggles netrw tree view

-- Easy way to get back to normal mode from home row
map("i", "kj", "<Esc>")					-- kj simulates ESC
map("i", "jk", "<Esc>")					-- jk simulates ESC

-- Visual Maps
map("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>")			-- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>")									-- Sort highlighted text in visual mode with Control+S
map("v", "J", ":m '>+1<CR>gv=gv")								-- Move current line down
map("v", "K", ":m '>-2<CR>gv=gv")								-- Move current line up


map("n", "<space>r", ":RnvimrToggle<CR>")			-- space+k moves to next tab
map("n", "F2", ":RnvimrToggle<CR>")			-- space+k moves to next tab

map("n", "<C-h>", ":UndotreeToggle<CR>")			-- space+k moves to next tab

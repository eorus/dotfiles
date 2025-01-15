vim.cmd("let g:netrw_liststyle = 3")

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.mouse = 'a'
--
-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python_host_prog = "/usr/bin/python2"

--Backup************************************************************
vim.cmd([[

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

]])
--
vim.cmd([[
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
]])

vim.cmd([[
	set path+=**
	filetype plugin on
	set wildmenu
	:autocmd BufNewFile *.sh 0r ~/.config/nvim/skeleton.sh
	:autocmd BufWritePost *.h !make
	:autocmd BufNewFile *.md 0r ~/.config/nvim/skeleton.md
	command! Reload :source ~/.config/nvim/init.lua
	command! Make :!make
]])

--statusline
vim.cmd("highlight StatusType guibg=#b16286 guifg=#1d2021")
vim.cmd("highlight StatusFile guibg=#fabd2f guifg=#1d2021")
vim.cmd("highlight StatusModified guibg=#1d2021 guifg=#d3869b")
vim.cmd("highlight StatusBuffer guibg=#98971a guifg=#1d2021")
vim.cmd("highlight StatusLocation guibg=#458588 guifg=#1d2021")
vim.cmd("highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2")
vim.cmd("highlight StatusNorm guibg=none guifg=white")
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

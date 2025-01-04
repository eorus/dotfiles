vim.opt.ignorecase = true     -- ignore case in search patterns
vim.opt.smartcase = true      -- smart case
vim.opt.smartindent = true    -- make indenting smarter again
vim.opt.splitbelow = true     -- force all horizontal splits to go below current window
vim.opt.splitright = true     -- force all vertical splits to go to the right of current window
vim.opt.swapfile = true      -- creates a swapfile
vim.opt.undofile = true       -- enable persistent undo
vim.opt.expandtab = true      -- convert tabs to spaces
vim.opt.shiftwidth = 4        -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4           -- insert 2 spaces for a tab
vim.opt.cursorline = true     -- highlight the current line
vim.opt.number = true         -- set numbered lines
vim.opt.relativenumber = true -- show relative line number
vim.opt.signcolumn = "yes"    -- always show the sign column, otherwise it would shift the text each time
vim.opt.scrolloff = 3         -- minimal number of screen lines to keep above and below the cursor
vim.opt.clipboard:append("unnamedplus")
vim.opt.completeopt= { "menuone", "noselect" }
vim.opt.termguicolors = true			-- terminal gui colors
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.backspace ="indent,eol,start"

-- Custom statusline
vim.opt.laststatus = 3        -- global statusline
vim.opt.statusline =
    "%#Substitute# %Y %0*" .. -- filetype
    " %f " ..                 -- path to file
    "%m" ..                   -- modifed
    "%r" ..                   -- readonly
    "%=" ..                   -- separator
    " %{&fileencoding} " ..   -- file encoding
    "|" ..                    -- padding
    " %{&fileformat} " ..     -- file format
    "|" ..                    -- padding
    " %c:%l/%L "              -- column at line per total lines


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

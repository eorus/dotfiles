vim.g.mapleader = ","
vim.keymap.set("n", "<leader><F4>", vim.cmd.UndotreeToggle)

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- reload config
keymap.set("n", "<leader>sr", ":source ~/.config/nvim/init.lua<CR>") -- reload neovim config
keymap.set("n", "<leader>ev", ":vsplit $MYVIMRC<CR>") -- reload neovim config
keymap.set("n", "<leader>eb", ":edit ~/.bashrc<CR>") -- edit bashrc
keymap.set("n", "<leader>et", ":edit ~/.tmux.conf<CR>") -- edit tmux config
keymap.set("n", "<leader>en", ":edit ~/.config/newsboat/config<CR>") -- edit newsboat config
keymap.set("n", "<leader>eu", ":edit ~/.config/newsboat/urls<CR>") -- eidt newsboat url

-- buffer navigation
keymap.set("n", "<Tab>", ":bnext <CR>") -- Tab goes to next buffer
keymap.set("n", "<S-Tab>", ":bprevious <CR>") -- Shift+Tab goes to previous buffer
keymap.set("n", "<leader>bd", ":bd! <CR>") -- Space+d delets current buffer
keymap.set("n", "<leader>bl", ":buffers<CR>:buffer<Space>") -- Space+d delets current buffer
keymap.set("n", "<leader>ba", ":tab sball<CR>") -- Tab goes to next buffer

-- adjust split sizes easier
keymap.set("n", "<C-Left>", ":vertical resize +3<CR>") -- Control+Left resizes vertical split +
keymap.set("n", "<C-Right>", ":vertical resize -3<CR>") -- Control+Right resizes vertical split -
--
-- Easy way to get back to normal mode from home row
keymap.set("i", "kj", "<Esc>") -- kj simulates ESC
keymap.set("i", "jk", "<Esc>") -- jk simulates ESC

keymap.set("n", "<M-h>", ":UndotreeToggle<CR>") -- space+k moves to next tab

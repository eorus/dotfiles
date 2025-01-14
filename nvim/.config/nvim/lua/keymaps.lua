-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false
vim.keymap.set("n", "<leader><F4>", vim.cmd.UndotreeToggle)

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>",       { desc = "Clear search highlights" })
keymap.set("n", "<Esc>",      ":nohlsearch<CR>", { desc = "Clear search highlights" })

    -- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

--  See `:help wincmd` for a list of all window commands
keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

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
return {
    -- Session
    { "<C-q>", ":quit<CR>", desc = "Quit" },
    { "<C-s>", ":update<CR>", desc = "Save" },

    -- Files
    {
        "<Leader><Leader>",
        function()
            require("fzf-lua").files({
                cwd = require("oil").get_current_dir(),
            })
        end,
        desc = "Find file",
    },
    { "<Leader>fg", "<Cmd>FzfLua git_files<CR>", desc = "Find git files" },
    { "-", "<Cmd>Oil<CR>", desc = "Browse project from here" },
    { "_", "<Cmd>Oil .<CR>", desc = "Browse project" },
    {
        "<Leader>.",
        function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Browse pinned files in project",
    },
    {
        "<Leader>>",
        function()
            require("harpoon"):list():add()
        end,
        desc = "Add current file to pinned list",
    },

    -- Buffer
    { "<Leader>,", "<Cmd>FzfLua buffers<CR>", desc = "Switch buffer" },
    {
        "<Leader>bd",
        function()
            require("mini.bufremove").delete(0)
        end,
        desc = "Delete buffer",
    },
    { "<C-Tab>", "<Cmd>bnext<CR>", desc = "Next buffer" },
    { "<C-S-Tab>", "<Cmd>bprevious<CR>", desc = "Previous buffer" },

    -- Git
    { "<Leader>gs", "<Cmd>Git<CR>", desc = "Git status" },
    { "<Leader>gb", "<Cmd>Git blame<CR>", desc = "Git blame" },
    { "<Leader>gl", "<Cmd>Git log<CR>", desc = "Git log" },
    { "<Leader>ghb", "<Cmd>silent !gh browse %<CR>", desc = "GitHub browse" },
    { "<Leader>ghr", "<Cmd>silent !gh repo view --web<CR>", desc = "GitHub repo" },
    {
        "<Leader>gd",
        function()
            require("mini.diff").toggle_overlay()
        end,
        desc = "Git diff overlay",
    },

    -- Search and replace
    { "<Leader>/", "<Cmd>FzfLua grep_project<CR>", desc = "Search project (fuzzy)" },
    { "<Leader>?", "<Cmd>FzfLua live_grep<CR>", desc = "Search project (regex)" },
    {
        "<Leader>sr",
        function()
            require("grug-far").grug_far({
                prefills = {
                    flags = vim.fn.expand("%"),
                },
            })
        end,
        desc = "Search and replace in current file",
    },
    {
        "<Leader>sR",
        function()
            require("grug-far").grug_far({})
        end,
        desc = "Search and replace in project",
    },

    -- Yank
    { "<C-c>", '"+y', mode = { "n", "v" } , desc = "Yank to clipboard"},
    { "<Leader>yF", "<Cmd>let @+ = expand('%:p:~')<CR>", desc = "Yank absolute file path to clipboard" },
    { "<Leader>yf", "<Cmd>let @+ = expand('%')<CR>", desc = "Yank relative file path to clipboard" },

    -- LSP
    { "K", vim.lsp.buf.hover, desc = "Toggle hover" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    { "go", vim.lsp.buf.type_definition, desc = "Go to type definition" },
    { "gR", vim.lsp.buf.references, desc = "Go to references" },
    { "gs", vim.lsp.buf.signature_help, desc = "Show signature" },
    { "gr", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "<Leader>=", mode = {"n", "x" }, vim.lsp.buf.format, desc = "Format buffer" },
    { "<Leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
}

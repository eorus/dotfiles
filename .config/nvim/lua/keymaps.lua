-- keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic helpers
local function has_cmd(cmd) return vim.fn.exists(":" .. cmd) == 2 end
local function has_module(name) return pcall(require, name) end

-- FZF / Telescope-like mappings (guarded by existence of commands)
map("n", "<leader>f", ":Files<CR>", opts)          -- find files (fzf.vim)
map("n", "<leader>F", ":FZF ~<CR>", opts)          -- FZF in home
map("n", "<leader>l", ":Lines<CR>", opts)          -- live lines (fzf.vim)
map("n", "<F5>",       ":Buffers<CR>", opts)       -- list buffers
map("n", "<leader>fh", ":History<CR>", opts)       -- recent files (fzf.vim)
map("n", "<leader>bb", ":Buffers<CR>", opts)       -- buffer list
map("n", "<leader>bl", ":buffers<CR>:buffer<Space>", opts) -- open :buffer with list

-- Ripgrep (requires :Rg from plugin)
  map("n", "<C-g>", ":Rg <C-r>=expand('<cword>')<CR><CR>", opts)

-- Interactive project search & replace (convenience)
map("n", "<leader>fr", ":%s///g<Left><Left>", opts)   -- fill pattern and replacement
map("n", "<leader>frl", ":%s///g<Left><Left><Left>", opts) -- leave flags spot

-- Highlight clear
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Open all buffers in tabs
map("n", "<F3>", ":tab sball<CR>", opts)

-- New empty buffer
map("n", "<leader>B", ":enew<CR>", opts)

-- Oil (file manager)
map("n", "-", "<cmd>Oil<CR>", opts)
map("n", "<leader>e", "<cmd>Oil<CR>", opts)
map("n", "<leader>vc", "<Cmd>Oil ~/.config/nvim/lua/<CR>", opts) -- open lua config

-- Split navigation (comfortable hjkl)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize splits (Ctrl for medium, Alt for fine, Shift for big)
map("n", "<C-Left>",  ":vertical resize +3<CR>", opts)
map("n", "<C-Right>", ":vertical resize -3<CR>", opts)
map("n", "<C-Up>",    ":resize +2<CR>", opts)
map("n", "<C-Down>",  ":resize -2<CR>", opts)

map("n", "<A-Left>",  ":vertical resize +1<CR>", opts)
map("n", "<A-Right>", ":vertical resize -1<CR>", opts)
map("n", "<A-Up>",    ":resize +1<CR>", opts)
map("n", "<A-Down>",  ":resize -1<CR>", opts)

map("n", "<C-S-Left>",  ":vertical resize +15<CR>", opts) -- may not work in all terminals
map("n", "<C-S-Right>", ":vertical resize -15<CR>", opts)
map("n", "<C-S-Up>",    ":resize +10<CR>", opts)
map("n", "<C-S-Down>",  ":resize -10<CR>", opts)

-- Buffer navigation
map("n", "<S-Tab>", ":bnext<CR>", opts)
map("n", "<Tab>",   ":bprevious<CR>", opts)
map("n", "<leader>bd", ":bd<CR>", opts)
map("n", "<leader>ba", ":tab sball<CR>", opts) -- open buffers in tabs

-- Save & config shortcuts
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>v", "<Cmd>e $MYVIMRC<CR>", opts)
map("n", "<leader>ev", ":vsplit $MYVIMRC<CR>", opts)
map("n", "<leader>er", ":source ~/.config/nvim/init.lua<CR>", opts)
map("n", "<leader>vs", "<Cmd>source $MYVIMRC<CR>", opts)

-- Common dotfiles editors
map("n", "<leader>eb", ":edit ~/.bashrc<CR>", opts)
map("n", "<leader>et", ":edit ~/.tmux.conf<CR>", opts)
map("n", "<leader>en", ":edit ~/.config/newsboat/config<CR>", opts)
map("n", "<leader>eu", ":edit ~/.config/newsboat/urls<CR>", opts)

-- Spell toggle
map("n", "<leader>ss", ":setlocal spell!<CR>", opts)

-- Vimwiki / Calendar
map("n", "<C-d>", ":VimwikiMakeDiaryNote<CR>", opts)
if has_cmd("Calendar") then
  map("n", "<C-c>", ":Calendar<CR>", opts)
end

-- Undotree (guarded)
  map("n", "<leader><F4>", ":UndotreeToggle<CR>", opts)

-- Colorizer toggle (guarded)
if has_module("colorizer") then
  map("n", "<leader>cc", ":ColorizerToggle<CR>", opts)
end

-- Cheat sheet popup (kept mostly as you had it, minor cleanup)
map("n", "<leader><F1>", function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "modifiable", true)

  local lines = {
    "================= 📝 Neovim Keymaps =================",
    "",
    "🔍 FZF / Telescope:",
    "  <leader>f   → Files",
    "  <leader>F   → FZF ~",
    "  <leader>l   → Lines",
    "  <C-g>       → Rg (if available)",
    "  <F5>        → Buffers",
    "  <leader>fh  → History",
    "",
    "📂 Oil.nvim:",
    "  -  → Open Oil",
    "  <leader>e → Open Oil",
    "",
    "📐 Splits:",
    "  <C-h/j/k/l> → Move between splits",
    "  <C-Arrow>   → Resize medium",
    "  <A-Arrow>   → Resize fine",
    "  <C-S-Arrow> → Resize large (may not work in terminal)",
    "",
    "🗂 Buffers:",
    "  <S-Tab> / <Tab> → Next/Previous buffer",
    "  <leader>B  → New buffer",
    "  <leader>bd → Close buffer",
    "",
    "🔤 Spell / Color:",
    "  <leader>ss → Toggle spell",
    "  <leader>cc → Toggle colorizer (if present)",
    "",
    "📖 Vimwiki:",
    "  <C-d> → Vimwiki diary",
    "  <C-c> → Calendar (if available)",
    "",
    "⏪ Undo tree:",
    "  <leader>u / <leader><F4> → Undotree",
    "",
    "⚙️ Config:",
    "  <leader>w → Save",
    "  <leader>v → Edit $MYVIMRC",
    "  <leader>vs → Source $MYVIMRC",
    "",
  }

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "help")

  local ui = vim.api.nvim_list_uis()[1]
  local pad = 6
  local content_w = 0
  for _, l in ipairs(lines) do
    local len = vim.fn.strdisplaywidth(l)
    if len > content_w then content_w = len end
  end
  local width = math.min(content_w + pad, math.floor(ui.width * 0.8))
  local height = math.min(#lines + 2, math.floor(ui.height * 0.8))
  local row = math.floor((ui.height - height) / 2)
  local col = math.floor((ui.width - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_win_set_option(win, "cursorline", false)

  local close_opts = { nowait = true, noremap = true, silent = true, buffer = buf }
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, close_opts)
  vim.keymap.set("n", "<Esc>", function()
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
  end, close_opts)

  vim.api.nvim_buf_set_option(buf, "buflisted", false)
end, opts)

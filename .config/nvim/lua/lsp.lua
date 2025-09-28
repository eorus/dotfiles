
-- lsp.lua (Neovim 0.11+ style)

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Mason setup
mason.setup()
mason_lsp.setup({
  ensure_installed = {
    "html",
    "cssls",
    "intelephense",
    "lua_ls",
    "jsonls",
    "emmet_ls",
  },
})

-- Capabilities from nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- List of servers
local servers = {
  "html",
  "cssls",
  "intelephense",
  "lua_ls",
  "jsonls",
  "emmet_ls",
}

for _, server in ipairs(servers) do
  local config = {
    capabilities = capabilities,
  }

  -- Lua language server custom settings
  if server == "lua_ls" then
    config.settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
        rocks = { enabled = false },
      },
    }
  end

  -- NEW API: define config and enable
  vim.lsp.config[server] = config
  vim.lsp.enable(server)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require("lazy").setup({
  -- {{{ Libraries
  {
    "https://github.com/nvim-lua/plenary.nvim",
    lazy = true,
  },
  -- }}}

  -- {{{ UI
  {
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏",
          tab_char = "→",
        },
        scope = {
          enabled = false,
        },
      })
    end,
  },
  -- }}}

  -- {{{ Search
  {
    "https://github.com/ibhagwan/fzf-lua",
    event = "VeryLazy",
    config = function()
      require("fzf-lua").setup({
        "max-perf",
        winopts = {
          height = 0.5,
          width = 1,
          row = 1,
        },
      })
      require("fzf-lua").register_ui_select()
    end,
  },

  {
    "https://github.com/MagicDuck/grug-far.nvim",
    lazy = true,
    config = function()
      require("grug-far").setup({})
    end,
  },
  -- }}}

  -- {{{ File manager
  {
    'stevearc/oil.nvim',
    -- @module 'oil'
    --@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  {
    "https://github.com/ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      for i = 1, 5 do
        vim.keymap.set("n", "<C-" .. i .. ">", function()
          harpoon:list():select(i)
        end)
      end
    end,
  },
  -- }}}

  -- {{{ IntelliSense

  { -- install LSPs
    "williamboman/mason.nvim",
    opts = {},
    dependencies = {
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim", -- auto-install capability
        opts = {
          ensure_installed = {
            "lua_ls",
            "ts_ls",
            "emmet_ls",
            -- add other LSPs here, find the names here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
          },
          run_on_start = true,
        },
      },
      "williamboman/mason-lspconfig.nvim", -- make mason & lspconfig work together
      "neovim/nvim-lspconfig",
    },
  },

  {

    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap -- for conciseness

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf, silent = true }

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          -- configure svelte server
          lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  -- Here use ctx.match instead of ctx.file
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,
        ["graphql"] = function()
          -- configure graphql language server
          lspconfig["graphql"].setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    end,
  },

  {    -- Completion Engine
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",         -- source for text in buffer
      "hrsh7th/cmp-path",           -- source for file system paths
      "hrsh7th/cmp-nvim-lua",       -- source for file system paths
      "hrsh7th/cmp-nvim-lsp",       -- source for file system paths
      {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*",         -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",           -- for autocompletion
      "rafamadriz/friendly-snippets",       -- useful snippets
      "onsails/lspkind.nvim",               -- vs-code like pictograms
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(),      -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" },  -- file system paths
          { name = 'cmdline' },
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
formatting = {
  fields = {'menu', 'abbr', 'kind'},
  format = function(entry, item)
    local menu_icon = {
      nvim_lsp = 'λ',
      luasnip = '⋗',
      buffer = 'Ω',
      path = '🖫',
    }

    item.menu = menu_icon[entry.source.name]
    return item
  end,
},
      })
    end,
  },
  --
  -- TODO refactor when Tree-sitter is stable and merged to nvim core
  -- https://github.com/nvim-treesitter/nvim-treesitter/issues/4767
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "go",
          "html",
          "css",
          "php",
          "python",
          "javascript",
          "typescript",
          "vimdoc",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },



  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  -- }}}

  -- {{{ Git
  {
    "https://github.com/tpope/vim-fugitive",
    cmd = "Git",
  },

  {
    "https://github.com/echasnovski/mini.diff",
    event = "VeryLazy",
    config = function()
      require("mini.diff").setup({})
    end,
  },
  -- }}}

  -- {{{ Motions
  {
    "https://github.com/folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup({
        modes = {
          search = {
            enabled = true,
          },
          char = {
            enabled = false,
          },
        },
        highlight = {
          groups = {
            label = "Question",
          },
        },
      })
    end,
  },

  {
    "https://github.com/echasnovski/mini.surround",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({})
    end,
  },
  -- }}}

  -- {{{ Miscellaneous
  {
    "https://github.com/farmergreg/vim-lastplace",
    event = "BufReadPost",
  },

  {
    "https://github.com/tpope/vim-sleuth",
    event = "VeryLazy",
    config = function()
      vim.cmd("silent Sleuth")
    end,
  },

  {
    "https://github.com/numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "https://github.com/echasnovski/mini.bufremove",
    lazy = true,
  },
  -- }}}

  -- {{{ Keymaps
  {
    "https://github.com/folke/which-key.nvim",
    event = "VeryLazy",
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
    },
    keys = require("keymaps"),
  },

  {
    "https://github.com/vimwiki/vimwiki",
    event = "BufEnter *.md",
    keys = { "<leader>ww", "<leader>wt" },

    lazy = false,

    init = function()
      print("Setting up vimwiki!")
      vim.g.vimwiki_folding = ""
      vim.g.vimwiki_list = {
        {
          path = "~/Documents/Notes/vimwiki/notes/",
          syntax = "markdown",
          ext = ".md",
        },

      }
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".mdown"] = "markdown",
      }
    end,

  },

  {

    "https://github.com/mbbill/undotree",
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",     -- For colorized css
    config = function()
      require("colorizer").setup()
    end,
  },

  require('colorscheme')

})

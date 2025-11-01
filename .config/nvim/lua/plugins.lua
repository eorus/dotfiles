return {
  -- FZF
  { "junegunn/fzf", build = function() vim.fn["fzf#install"]() end },
  { "junegunn/fzf.vim" },

  -- Oil

{
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    })
  end
},


  -- Colorscheme
{ "cocopon/iceberg.vim",
  lazy = false,  -- load immediately
  priority = 1000, -- load first
  config = function()
    vim.cmd("colorscheme iceberg")
  end
},

  -- Lualine
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "iceberg",
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { 'filename', path = 2,} },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- LSP + completion
  { "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
      require("lsp")
      require("completion")

    end
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" },
},

  -- Vimwiki
  { "vimwiki/vimwiki",
    event = "BufEnter *.md",
    keys = { "<leader>ww", "<leader>wt" },
    lazy = false,
    init = function()
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
vim.keymap.set("n", "<leader>we", function()
  vim.cmd("!wiki2html && xdg-open ~/Documents/Notes/vimwiki/html/index.html")
end, { desc = "Export Vimwiki Markdown to HTML" })
  end
  },

  -- Undotree
  { "mbbill/undotree", event = "VeryLazy" },

  {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      "*",            -- Highlight all files
      css = { rgb_fn = true; },  -- Enable `rgb()` in CSS
      html = { names = false; }, -- Disable named colors in HTML
    })
  end
},

{ "tbabej/taskwiki" },

}

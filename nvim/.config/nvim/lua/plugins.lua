local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
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
		},
	},

    {
        "https://github.com/neovim/nvim-lspconfig",
        event = "VeryLazy",
      	config = function()
			-- enable completions via nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- run the `.setup` call for each LSP, together with any LSP
			-- configuration you want to make
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						-- so lua_ls does not complain about `vim` being an undefined global
						diagnostics = { globals = {"vim"} }
					}
				},
			})
			require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				settings = {},
			})
		end,
	},

    	{ -- Completion Engine
		"hrsh7th/nvim-cmp",
		dependencies = "hrsh7th/cmp-nvim-lsp", -- make cmp work with LSPs
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- tell cmp to use LSPs for completion
				}),
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
				}),
			})
		end,
	},

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

})

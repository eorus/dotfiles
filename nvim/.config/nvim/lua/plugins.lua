local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use ("wbthomason/packer.nvim") -- Have packer manage itself

	--nvim-web-devicons
	use("nvim-tree/nvim-web-devicons") -- Add entry here to install the plugin
	--vimwiki
	use("vimwiki/vimwiki") -- Add entry here to install the plugin
	--taskwiki
	use("tools-life/taskwiki") -- Add entry here to install the plugin
	--vimwiki
	use("blindFS/vim-taskwarrior") -- Add entry here to install the plugin
	--undo tree
	use("mbbill/undotree") -- Add entry here to install the plugin
	--vim css colors
	use("ap/vim-css-color") -- Add entry here to install the plugin
	--vim ranger
	use("kevinhwang91/rnvimr") -- Add entry here to install the plugin

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

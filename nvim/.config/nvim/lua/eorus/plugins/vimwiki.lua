return {
  "vimwiki/vimwiki",
  event = "BufEnter *.md",
  lazy = false,
  keys = { "<leader>ww", "<leader>wt" },
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
}

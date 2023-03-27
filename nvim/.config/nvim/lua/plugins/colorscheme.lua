return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },

  {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_italic = false
      vim.g.nord_bold = false
      vim.g.nord_borders = true
    end,
  },
}

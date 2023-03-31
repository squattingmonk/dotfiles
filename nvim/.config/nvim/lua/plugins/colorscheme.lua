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

      local hl = vim.api.nvim_set_hl
      local group = vim.api.nvim_create_augroup("NordFix", { clear = true })
      local colors = require("nord.named_colors")

      vim.api.nvim_create_autocmd("ColorScheme", {
        desc = "Customize colors in Nord colorscheme",
        pattern = "nord",
        group = group,
        callback = function()
          hl(0, "LspCodeLens", { link = "Comment" })
          hl(0, "Special", { fg = colors.teal })
        end,
      })
    end,
  },
}

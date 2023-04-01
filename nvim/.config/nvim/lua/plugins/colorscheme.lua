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
          hl(0, "SpecialComment", { fg = colors.teal })

          hl(0, "NeoTreeGitAdded", { fg = colors.green })
          hl(0, "NeoTreeGitConflict", { fg = colors.orange })
          hl(0, "NeoTreeGitDeleted", { fg = colors.red })
          hl(0, "NeoTreeGitModified", { fg = colors.yellow })
          hl(0, "NeoTreeGitUntracked", { fg = colors.orange })
          hl(0, "NeoTreeFilename", { fg = colors.darkest_white })
          hl(0, "NeoTreeDimText", { fg = colors.gray })
        end,
      })
    end,
  },
}

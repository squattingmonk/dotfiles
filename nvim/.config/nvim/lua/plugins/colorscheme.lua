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

          hl(0, "FoldColumn", { fg = colors.glacier })
          hl(0, "UfoFoldedEllipsis", { link = "FoldColumn" })

          hl(0, "NeoTreeGitAdded", { fg = colors.green })
          hl(0, "NeoTreeGitConflict", { fg = colors.orange })
          hl(0, "NeoTreeGitDeleted", { fg = colors.red })
          hl(0, "NeoTreeGitModified", { fg = colors.yellow })
          hl(0, "NeoTreeGitUntracked", { fg = colors.orange })
          hl(0, "NeoTreeFilename", { fg = colors.darkest_white })
          hl(0, "NeoTreeDimText", { fg = colors.gray })

          local links = {
            ["@lsp.type.namespace"] = "@namespace",
            ["@lsp.type.type"] = "@type",
            ["@lsp.type.class"] = "@type",
            ["@lsp.type.enum"] = "@type",
            ["@lsp.type.interface"] = "@type",
            ["@lsp.type.struct"] = "@structure",
            ["@lsp.type.parameter"] = "@parameter",
            ["@lsp.type.variable"] = "@variable",
            ["@lsp.type.property"] = "@property",
            ["@lsp.type.enumMember"] = "@constant",
            ["@lsp.type.function"] = "@function",
            ["@lsp.type.method"] = "@method",
            ["@lsp.type.macro"] = "@constant",
            ["@lsp.type.decorator"] = "@function",
          }
          for newgroup, oldgroup in pairs(links) do
            hl(0, newgroup, { link = oldgroup, default = true })
          end
        end,
      })
    end,
  },
}

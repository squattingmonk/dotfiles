local M = {}

M.setup = function ()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "nord",
      disabled_filetypes = { "neo-tree" },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
  }
end

return M

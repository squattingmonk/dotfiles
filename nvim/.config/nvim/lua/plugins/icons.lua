local icons_present, icons = pcall(require, "nvim-web-devicons")
if not icons_present then
   return
end

local colors_present, colors = pcall(require, "nordic.palette")
if not colors_present then
  return
end

local M = {}
M.setup = function()
  icons.setup {
    override = {
      [".tags"] = {
        icon = "",
        color = colors.gray,
        name = "Tags",
      },
      cfg = {
        icon = "",
        color = colors.yellow,
        name = "Configuration",
      },
      json = {
        icon = "",
        color = colors.yellow,
        name = "Json",
      },
      lock = {
        icon = "",
        color = colors.red,
        name = "Lock",
      },
      lua = {
        icon = "",
        color = colors.blue,
        name = "Lua",
      },
      md = {
        icon = "",
        color = colors.green,
        name = "Markdown",
      },
      nim = {
        icon = "",
        color = colors.yellow,
        name = "Nim",
      },
      nss = {
        icon = "",
        color = colors.bright_cyan,
        name = "NWScript",
      },
    },

    default = true
  }
end

return M

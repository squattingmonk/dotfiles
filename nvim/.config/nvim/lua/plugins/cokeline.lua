local M = {}

local get_hex = require("cokeline.utils").get_hex
local colors = require("nordic.palette")
local components = {
  space = {
    text = " ",
    truncation = { priority = 1 },
  },

  separator = {
    text = function (buffer)
      return buffer.index ~= 1 and "▏" or ""
    end,
    fg = get_hex("Comment", "fg"),
    truncation = { priority = 1 },
  },

  index = {
    text = function (buffer)
      return buffer.index .. ": "
    end,
    truncation = { priority = 1 },
  },

  devicon = {
    text = function (buffer)
      return buffer.devicon.icon
    end,
    truncation = { priority = 1 },
  },

  filename = {
    text = function (buffer)
      return buffer.filename
    end,
    style = function (buffer)
      return (buffer.is_focused and "bold") or nil
    end,
    truncation = {
      priority = 2,
      direction = "left",
    },
  },

  saved_or_unsaved = {
    text = function (buffer)
      return buffer.is_modified and "*" or ""
    end,
    truncation = { priority = 1 },
  },

  close = {
    text = "",
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

M.setup = function ()
  require("cokeline").setup {
    show_if_buffers_are_at_least = 1,

    rendering = {
      max_buffer_width = 30,
    },

    default_hl = {
      fg = function (buffer)
        return
          buffer.is_focused
            and get_hex("Normal", "fg")
            or get_hex("Comment", "fg")
      end,
      bg = get_hex("ColorColumn", "bg"),
    },

    components = {
      components.space,
      components.separator,
      components.index,
      components.devicon,
      components.filename,
      components.saved_or_unsaved,
      components.space,
      components.close,
    },

    sidebar = {
      filetype = "neo-tree",
      components = {
        {
          text = "  NeoTree",
          fg = colors.yellow,
          bg = get_hex("ColorColumn", "bg"),
          style = "bold",
        }
      }
    }
  }
end

return M

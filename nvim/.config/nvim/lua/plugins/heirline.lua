local M = {}
local icons = require("nvim-web-devicons")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Colors used below. Should be theme-agnostic.
local colors = {
  red = utils.get_highlight("DiagnosticError").fg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("DiagnosticWarn").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag = {
    warn = utils.get_highlight("DiagnosticWarn").fg,
    error = utils.get_highlight("DiagnosticError").fg,
    hint = utils.get_highlight("DiagnosticHint").fg,
    info = utils.get_highlight("DiagnosticInfo").fg,
  },
  git = {
    del = utils.get_highlight("DiffDelete").fg,
    add = utils.get_highlight("DiffAdd").fg,
    change = utils.get_highlight("DiffChange").fg,
  },
}

local Align = { provider = "%=" }
local Space = { provider = " " }

local FileIcon = {
  init = function (self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = icons.get_icon_color(filename, extension, { default = true })
  end,
  provider = function (self)
    return self.icon and (self.icon .. " ")
  end,
  hl = function (self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function (self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  provider = function (self)
    -- Trim the filename relative to the current directory
    local filename = vim.fn.fnamemodify(self.filename, ":.")
    if filename == "" then return "[No Name]" end

    -- Shorten the filename to its initials if the filename takes up more than
    -- 1/4 the available space.
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = utils.get_highlight("Directory").fg }
}

local FileType = {
  provider = function ()
    return vim.bo.filetype
  end,
  hl = { fg = utils.get_highlight("Type").fg, style = "bold" }
}

local FileModified = {
  provider = function ()
    if vim.bo.modified then
      return " [+]"
    end
  end
}

local FileNameBlock = {
  hl = { fg = utils.get_highlight("Directory").fg, force = true }
}


local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%7(%l/%L%):%c %P",
}

local DefaultStatusLine = {
  Space, utils.insert(FileNameBlock, FileIcon, FileName, FileModified), Align,
  Ruler, Space, FileType, Space,
}

local InactiveStatusLine = {
  condition = function ()
    return not conditions.is_active()
  end,

  Space, utils.insert(FileNameBlock, FileIcon, FileName, FileModified), Space, Align,
  FileType, Space,
}

local SpecialStatusLine = {
  condition = function ()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix", },
      filetype = { "^git.*", "neo-tree" },
    })
  end,

  Space, FileType, Space, Align,
}

local StatusLines = {
  hl = function ()
    if conditions.is_active() then
      return {
        fg = utils.get_highlight("StatusLine").fg,
        bg = utils.get_highlight("StatusLine").bg,
      }
    else
      return {
        fg = utils.get_highlight("StatusLineNC").fg,
        bg = utils.get_highlight("StatusLineNC").bg,

      }
    end
  end,
  init = utils.pick_child_on_condition,

  SpecialStatusLine, InactiveStatusLine, DefaultStatusLine,
}

M.setup = function ()
  require("heirline").setup(StatusLines)
end

return M

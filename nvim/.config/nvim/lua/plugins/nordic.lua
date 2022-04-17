local M = {}

M.setup = function ()
  require("nordic").colorscheme {
    underline_option = "undercurl",
    italic = false,
    italic_comments = false,
    minimal_mode = false,
    alternate_backgrounds = false,

    custom_colors = function (c, s, cs)
      -- c: color palette table
      --  see the palette file for available entries
      -- s: styles table
      --  none, bold, underline, italic, undercurl, strikethrough, reverse, inverse, standout, nocombine
      -- cs: user defined/configured styles table
      --  none, underline, italic, comments
      --  bg(name) -> default or alternate background color based on configuration
      return {
        -- Tree-sitter corrections
        { { "TSField", }, c.dark_white, c.none, cs.none },
        { { "TSType", "TSTypeBuiltin", "Type" }, c.blue, c.none, cs.none },
        { { "TSFunction", "TSKeywordFunction", "Function" }, c.bright_cyan, c.none, cs.none },

        -- NeoTree
        { { "NeoTreeDimText", }, c.black, c.none, cs.none },
        { { "NeoTreeGitAdded", }, c.green, c.none, cs.none },
        { { "NeoTreeGitConflict", }, c.orange, c.none, cs.none },
        { { "NeoTreeGitDeleted", }, c.red, c.none, cs.none },
        { { "NeoTreeGitModified" }, c.yellow, c.none, cs.none },
        { { "NeoTreeGitUntracked" }, c.orange, c.none, cs.none },
      }
    end,
  }
end

return M

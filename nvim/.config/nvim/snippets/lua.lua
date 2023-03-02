-- Boilerplate {{{
local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"
-- }}}

--- Creates a snippet {{{
local function cs(trigger, nodes, opts)
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  -- insert snippet into appropriate table
  table.insert(target_table, snippet)
end
-- }}}

-- Snippets go here --

-- [luasnippet] Create LuaSnip snippet {{{
cs(
  "luasnippet",
  fmt(
    [=[
-- {} {{{{{{
cs(
  "{}",
  fmt(
    [[
{}
    ]],
    {{
      {}
    }}
  ){}
) -- }}}}}}
    ]=],
    {
      i(2, "Description"),
      i(1, "trigger"),
      i(3),
      i(4),
      c(5, {
        t(""),
        fmt([[, "{}"]], { i(1, "keymap") }),
        fmt([[, {{ pattern = "{}", {} }}]], { i(1, "*/snippets/*.lua"), i(2, "keymap") }),
      }),
    }
  ),
  { pattern = "*/snippets/*.lua", "jcs" }
) -- }}}

-- [regexsnippet] Create regex LuaSnip snippet {{{
cs(
  "regexsnippet",
  fmt(
  [=[
-- {} {{{{{{
cs(
  {{ trig = "{}", regTrig = true, hidden = true, }},
  fmt(
    [[
{}
    ]],
    {{
      {}
    }}
  )
) -- }}}}}}
  ]=],
  {
    i(1, "Description"),
    i(2, ""),
    i(3, ""),
    i(4, ""),
  }),
  { pattern = "*/snippets/*.lua", "jcr" }
) -- }}}

-- [function] Lua function snippet {{{
cs(
  "function", fmt(
  [[
function {}({})
  {}
end
  ]],
  {
    i(1, ""),
    i(2, ""),
    i(3, ""),
  }),
  "jff"
) -- }}}

-- [localfunction] Lua local function snippet {{{
cs(
  "localfunction", fmt(
  [[
local function {}({})
	{}
end
  ]],
  {
    i(1, ""),
    i(2, ""),
    i(3, ""),
  }),
  "jlf"
) -- }}}

-- [local] Lua local variable snippet {{{
cs(
  "local", fmt(
  [[
local {} = {}
  ]],
  {
    i(1, ""),
    i(2, "")
  }),
  "jlv"
) -- }}}

-- Boilerplate --
return snippets, autosnippets

-- vim:foldenable foldmethod=marker

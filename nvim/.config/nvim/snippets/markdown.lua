-- Boilerplate {{{
local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda

local snippets, autosnippets = {}, {}

local group = vim.api.nvim_create_augroup("Markdown Snippets", { clear = true })
local file_pattern = "*.md"
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
end --}}}

-- Helper functions {{{

-- Run shell command and return trimmed output
local function sh(cmd)
  return vim.fn.trim(vim.fn.system(cmd))
end

-- Get repo name
local function repo()
  return sh([[basename $(git ls-remote --get-url || pwd)]])
end

-- Get last git tag
local function last_tag()
  return sh("git describe --tags --abbrev=0")
end

local function commits()
  return sh(string.format([[git --no-pager log --pretty=format:"### %%B" %s...HEAD]], last_tag()))
end

--}}}


-- Snippets go here --

-- GitHub issue link {{{

cs(
  "issue",
  fmt(
    "[#{}](https://github.com/squattingmonk/{}/issues/{})",
    {
      i(1),
      f(repo),
      rep(1)
    }
  )
) -- }}}

-- GitHub PR link {{
cs(
  "pr",
  fmt(
    "[#{}](https://github.com/squattingmonk/{}/pull/{})",
    {
      i(1),
      f(repo),
      rep(1)
    }
  )
) -- }}

-- Changelog entry {{{
cs(
  "changelog",
  fmt(
    [[
    ## {}: {}
    {}

    ---

    Details: https://github.com/squattingmonk/{}/compare/{}...{}


    ]],
    {
      i(1, "newtag"),
      f(
        function(_)
          return sh([[date +"%B %-d, %Y"]])
        end
      ),
      i(0),
      f(repo),
      f(last_tag),
      rep(1)
    }
  )
) -- }}}

-- Boilerplate --
return snippets, autosnippets

-- -- vim:foldenable foldmethod=marker

local M = {}
local cmp = require "cmp"
local luasnip = require "luasnip"

-- Symbols for autocomplete
local lsp_symbols = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
---checks if the character preceding the cursor is a space character
---@return boolean true if it is a space character, false otherwise
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local fn = {
  completeSuggested = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true -- As shown on ghost_text
  },
  completeSelected = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false -- No complete if not explicitly selected
  },
  nextItem = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    elseif not check_backspace() then
      cmp.complete()
    else
      fallback()
    end
  end,
  prevItem = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
    else
      fallback()
    end
  end,
  unobstrusive = function(fallback)
    if cmp.visible() then cmp.mapping.abort() end
    fallback()
  end
}

M.setup = function()
  cmp.setup {

    completion = {
      -- If autocomplete is on, it opens in nim files even when there's nothing
      -- to complete.
      autocomplete = false,
      completeopt = "menu,menuone,noselect,preview",
    },

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),

      -- Pop up completion menu if not already showing
      ["<C-Space>"] = cmp.mapping.complete(),

      -- Close completion menu.
      ["<C-e>"] = cmp.mapping.abort(),

      -- Accept currently selected item. Selects the first item if one has not
      -- been selected.
      ["<C-y>"] = fn.completeSuggested,

      -- Accept currently selected item. Will not auto-select an item unless
      -- select == true.
      ["<CR>"] = fn.completeSelected,

      -- Selects the next/previous item in the completion menu if it is showing.
      -- Otherwise, shows the completion menu.
      ["<C-j>"] = fn.nextItem,
      ["<C-k>"] = fn.prevItem,
      ["<Tab>"] = fn.nextItem,
      ["<S-Tab>"] = fn.prevItem,
    }),


    sources = {
      { name = "path" },
      { name = "nvim_lsp", max_item_count = 7, },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer", keyword_length = 3 },
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s", lsp_symbols[vim_item.kind])
        vim_item.menu = ({
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lua = "[Lua]",
          nvim_lsp = "[LSP]",
        })[entry.source.name]
        return vim_item
      end,
    },

    experimental = {
      ghost_text = true,
    },
  }
end

return M

local M = {}
local cmp = require "cmp"
local luasnip = require "luasnip"
local neogen = require "neogen"

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
  nextItem = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif not check_backspace() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),
  prevItem = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
      fallback()
    end
  end, { "i", "s" }),
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
      ["<Tab>"] = fn.nextItem,
      ["<S-Tab>"] = fn.prevItem,

      -- Jump to the next/previous snippet node if available
      ["<C-j>"] = cmp.mapping(function(fallback)
        if neogen.jumpable() then
          neogen.jump_next()
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if neogen.jumpable(true) then
          neogen.jump_prev()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end),
    }),


    sources = {
      { name = "path" },
      -- { name = "nvim_lsp_signature_help" },
      { name = "nvim_lsp", max_item_count = 7, },
      -- { name = "tags", max_item_count = 7, },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer", max_item_count = 5, },
    },

    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = string.format("%s %s", lsp_symbols[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lua = "[Lua]",
          nvim_lsp = "[LSP]",
          -- tags = "[Tag]",
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

local M = {}

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

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.setup = function()
  local cmp = require "cmp"

  cmp.setup {

    completion = {
      completeopt = "menu,menuone,noinsert,noselect"
    },

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    },

    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

      -- Pop up completion menu if not already showing
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

      -- Close completion menu.
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },

      -- Accept currently selected item. Selects the first item if one has not
      -- been selected.
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }, { "i", "c" }
      ),

      -- Accept currently selected item. Will not auto-select an item unless
      -- select == true.
      ["<CR>"] = cmp.mapping.confirm { select = false },

      -- Tab completion!
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    sources = {
      { name = "path" },
      { name = "nvim_lsp" },
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

    documentation = {
      border = "rounded",
    },

    experimental = {
      ghost_text = true,
      native_menu = false,
    },

  }
end

return M

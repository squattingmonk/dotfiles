return {
  {
    "Saghen/blink.cmp",
    opts = function(_, opts)
      -- Merge custom sources with the existing ones from LazyVim
      -- Requires the LazyVim blink.cmp extra
      opts.snippets = {
        preset = "luasnip",
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      }
      opts.completion = {
        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },
      }
      opts.keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      }
    end,
  },
}

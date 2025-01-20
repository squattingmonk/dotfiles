return {
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        -- Don't select by default, auto insert on selection
        list = { selection = { preselect = false, auto_insert = true } },
      },
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
    },
  },
}

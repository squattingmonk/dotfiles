local ls = require("luasnip")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
-- require("luasnip.loaders.from_snipmate").lazy_load()

ls.config.set_config {
  history = true, -- Allows jumping back to last snippet
  updateevents = "TextChanged,TextChangedI", -- Update changes as you type
  enable_autosnippets = true,
}

vim.keymap.set({"i", "s"}, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set({"i", "s"}, "<C-h>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

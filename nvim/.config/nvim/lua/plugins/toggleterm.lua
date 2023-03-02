local toggleterm = require("toggleterm")
local colors = require("nordic.palette")

toggleterm.setup({
  open_mapping = [[<C-\>]],
  direction = "vertical",
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  hide_numbers = true,
  start_in_insert = true,
  shade_terminals = false,
  highlights = {
    Normal = {
      guibg = colors.dark_black,
    },
    FloatBorder = {
      guifg = colors.black,
    },
  },
  float_opts = {
    border = "curved",
    -- winblend = 10,
  },
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

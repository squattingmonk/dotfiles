return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      shade_terminals = false,
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = { "term://*" },
        callback = function()
          local termopts = { buffer = 0 }
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], termopts)
          vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], termopts)
          vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], termopts)
          vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], termopts)
          vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], termopts)
        end,
      })

      require("toggleterm").setup(opts)
    end,
  },
}

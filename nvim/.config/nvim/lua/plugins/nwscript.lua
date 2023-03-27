return {
  {
    "squattingmonk/vim-nwscript",
    ft = "nwscript",
    config = function()
      vim.cmd([[let g:nwscript#modules#enabled = [] ]])
    end,
  },
}

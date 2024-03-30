return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nimls = {},
      },
    },
  },
  {
    "alaviss/nim.nvim",
    enabled = false,
    ft = "nim",
  },
}

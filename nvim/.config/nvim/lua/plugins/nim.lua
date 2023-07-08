return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nim_langserver = {},
      },
    },
  },
  {
    "alaviss/nim.nvim",
    enabled = false,
    ft = "nim",
  },
}

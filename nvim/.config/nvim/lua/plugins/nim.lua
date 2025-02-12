return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        nim_langserver = {},
        -- nimls = {},
      },
    },
  },
  {
    "alaviss/nim.nvim",
    enabled = false,
    ft = "nim",
  },
}

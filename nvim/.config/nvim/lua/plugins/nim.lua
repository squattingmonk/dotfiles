return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nim_langserver = {
          inlayHints = false,
        },
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

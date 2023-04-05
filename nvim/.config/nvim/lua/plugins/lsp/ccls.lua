return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ccls = {
          mason = false,
          cmd = { "ccls" },
          filetypes = {
            "c",
            "cpp",
          },
          init_options = {
            compilationDatabaseDirectory = "build",
          },
        },
      },
    },
  },
}

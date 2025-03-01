return {
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,

    config = function()
      vim.opt.guifont = "JetBrainsMono Nerd Font Mono"
      vim.g.firenvim_config = {
        localSettings = {
          [".*"] = {
            cmdline = "neovim",
            takeover = "never",
          },
        },
      }
    end,
  },
}

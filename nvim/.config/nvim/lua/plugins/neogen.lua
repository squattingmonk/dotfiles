return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        languages = {
          nwscript = require("plugins.neogen.nwscript"),
        },
      })
    end,
  },
}

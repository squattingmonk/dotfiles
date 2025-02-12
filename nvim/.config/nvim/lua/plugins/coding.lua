return {
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          css = { names = false, mode = "virtualtext" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.align",
    config = function()
      require("mini.align").setup()
    end,
  },
}

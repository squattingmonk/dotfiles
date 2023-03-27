return {
  {
    -- Customizes the statuscolumn. Requires neovim >= 0.9.
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          { text = { "%s" }, click = "v:lua:ScSa" },
          { text = { builtin.lnumfunc }, click = "v:lua.ScSa" },
          {
            text = { " ", builtin.foldfunc, " " },
            condition = { builtin.not_empty, true, builtin.not_empty },
            click = "v:lua:ScFa",
          },
        },
      })
    end,
  },
}

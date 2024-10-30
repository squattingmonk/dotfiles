return {
  {
    "L3MON4D3/LuaSnip",
    -- Handle jumping between nodes below.
    keys = function()
      return {}
    end,
    config = function(_, opts)
      local path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/snippets"
      require("luasnip.loaders.from_lua").lazy_load({ paths = path })
      require("luasnip").setup(opts)
    end,
    opts = {
      enable_autosnippets = true,
    },
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            exclude = { "all" },
          })
        end,
      },
    },
  },
}

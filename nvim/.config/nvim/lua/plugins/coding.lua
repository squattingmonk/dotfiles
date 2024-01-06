return {
  {
    "L3MON4D3/LuaSnip",
    -- Handle jumping between nodes below.
    keys = function()
      return {}
    end,
    config = function()
      local path = os.getenv("XDG_CONFIG_HOME") .. "/nvim/snippets"
      require("luasnip.loaders.from_lua").lazy_load({ paths = path })
    end,
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<leader>nf", ":Neogen<cr>", desc = "Generate annotation" },
    },
    config = function()
      require("neogen").setup({
        languages = {
          nwscript = require("plugins.neogen.nwscript"),
        },
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local neogen = require("neogen")

      local fn = {
        -- Accept the currently suggested completion item, replacing the current
        -- word
        completeSuggested = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true, -- As shown on ghost_text
        }),

        -- Accept the currently selected completion item, replacing the current
        -- word.
        completeSelected = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false, -- No complete if not explicitly selected
        }),

        -- Move cursor to next item in the completion menu. If completion menu
        -- is not showing, we jump to the next snippet node *only* if we are
        -- inside a snippet. This stops us from jumping back to an unexpected
        -- place.
        nextItem = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif neogen.jumpable() then
            neogen.jump_next()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Move cursor to previous item in the completion menu. If completion
        -- menu is not showing, we jump to the next snippet node *only* if we
        -- are inside a snippet. This stops us from jumping back to an
        -- unexpected place.
        prevItem = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif neogen.jumpable(-1) then
            neogen.jump_prev()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Closes the completion menu if it is showing, then executes the
        -- keypress.
        unobstrusive = function(fallback)
          if cmp.visible() then
            cmp.mapping.abort()
          end
          fallback()
        end,
      }

      opts.completion = {
        completeopt = "menu,menuone,preview",
      }

      opts.mapping = cmp.mapping.preset.insert({
        -- Scroll through docs in preview window.
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Pop up completion menu if not already showing
        ["<C-Space>"] = cmp.mapping.complete(),

        -- Close completion menu.
        ["<Esc>"] = cmp.mapping.abort(),

        -- Accept currently selected item. Will not auto-select an item.
        ["<CR>"] = fn.completeSelected,

        -- Select next/previous item.
        ["<Tab>"] = fn.nextItem,
        ["<S-Tab>"] = fn.prevItem,
      })
    end,
  },

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
}

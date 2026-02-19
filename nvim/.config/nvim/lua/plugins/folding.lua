return {
  {
    -- Customizes the statuscolumn. Requires neovim >= 0.9.
    "luukvbaal/statuscol.nvim",
    opts = function(_, opts)
      local builtin = require("statuscol.builtin")
      return vim.tbl_extend("force", opts, {
        segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc }, click = "v:lua.ScSa" },
          {
            text = { " ", builtin.foldfunc, " " },
            condition = { builtin.not_empty, true, builtin.not_empty },
            click = "v:lua.ScFa",
          },
        },
      })
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    event = "BufRead",
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zC",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "K",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek at folded lines",
      },
    },
    opts = function(_, opts)
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.opt.fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "/",
        eob = " ",
      }

      local ftmap = {
        vim = "indent",
        lua = { "lsp", "indent" },
        nwscript = { "treesitter", "indent" },
      }

      return vim.tbl_extend("force", opts, {
        provider_selector = function(_, filetype, _)
          return ftmap[filetype] or { "treesitter", "indent" }
        end,
        close_fold_kinds_for_ft = { default = { "imports" } },
      })
    end,
  },

  -- Add line folding capability
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicResgistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
      },
    },
  },
}

-- Boostrap packer install {{{2
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
execute("packadd packer.nvim")

-- Reload plugins when saving this file {{{2
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync"
})

-- Have packer use a popup window {{{2
require("packer").init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  }
}

-- Install plugins {{{1
return require("packer").startup(function(use)
  -- Let packer manage itself {{{2
  use {
    "wbthomason/packer.nvim",
    event = "VimEnter",
    opt = true,
  }

  -- Required by others {{{2
  use { "nvim-lua/plenary.nvim", module = "plenary" }
  use { "kyazdani42/nvim-web-devicons" }

  -- LSP {{{2
  use {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    requires = { "hrsh7th/cmp-nvim-lsp" },
    config = [[require("lsp")]],
  }

  -- Telescope {{{2
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = [[require("plugins.telescope")]],
  }

  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  }

  -- Treesitter {{{2
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[require("plugins.treesitter")]],
  }

  use { "nvim-treesitter/playground" }

  -- Completion {{{2
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    requires = {
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    },
    config = [[require("plugins.completion").setup()]],
  }

  use { "jiangmiao/auto-pairs" }

  -- Snippets {{{2
  use {
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    config = [[require("plugins.luasnip")]]
  }

  -- Comments
  use {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function ()
      require("Comment").setup()
    end
  }


  -- UI {{{2
  use {
    "shaunsingh/nord.nvim",
    config = function()
      vim.g.nord_borders = true
      require("nord").set()
      vim.cmd [[
        :highlight! link TSConstant Constant
        :highlight! link TSVariable Variable
        :highlight! link TSPunctBracket Delimiter
      ]]
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function ()
      require("plugins.gitsigns")
    end
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    -- disable = true,
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    setup = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function ()
      require("neo-tree").setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
          }
        }
      }
      -- vim.api.nvim_set_keymap("n", "<leader>e", ":NeoTreeShowToggle<cr>", { silent = true, noremap = true })
    end
  }

  -- Nim {{{2
  use { "alaviss/nim.nvim" }

  -- NWScript {{{2
  use { "squattingmonk/vim-nwscript" }

  -- 2}}}
end)

-- vim:foldenable foldmethod=marker foldlevel=1

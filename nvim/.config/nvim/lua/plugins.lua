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
  use {
    "nvim-lua/plenary.nvim",
    module = "plenary",
    config = function ()
      require("plenary.filetype").add_file("nwscript")
    end,
  }

  use {
    "kyazdani42/nvim-web-devicons",
    config = [[require("plugins.icons").setup()]]
}

  -- LSP {{{2
  use {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    requires = { "hrsh7th/cmp-nvim-lsp" },
    config = [[require("lsp")]],
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end
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

  use {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        languages = {
          nwscript = require("plugins.neogen.nwscript"),
        },
      }
    end,
    requires = "nvim-treesitter/nvim-treesitter",
  }

  -- Completion {{{2
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      -- { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
    },
    config = [[require("plugins.completion").setup()]],
  }

  use {
    "quangnguyen30192/cmp-nvim-tags",
    requires = "nvim-cmp",
    ft = { "nwscript", },
  }

  use { "jiangmiao/auto-pairs" }

  use {
    "ray-x/lsp_signature.nvim",
    config = function()
      require "lsp_signature".setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
        toggle_key = "<C-k>",
        hint_enable = false,
        padding = " ",
        floating_window_above_cur_line = false,
      })
    end,
  }

  -- Snippets {{{2
  use {
    "L3MON4D3/LuaSnip",
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
    "andersevenrud/nordic.nvim",
    config = function ()
      require("plugins.nordic").setup()
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
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    setup = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function ()
      require("plugins.neotree").setup()
    end
  }

  use {
    "noib3/nvim-cokeline",
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      if not vim.g.started_by_firenvim then
        require("plugins.cokeline").setup()
      end
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function ()
      if not vim.g.started_by_firenvim then
        require("plugins.lualine").setup()
      end
    end,
  }

  use {
    "rebelot/heirline.nvim",
    disable = true,
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      require("plugins.heirline").setup()
    end
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function ()
      require("indent_blankline").setup {
        char = "▎",
        show_current_context = true,
      }
    end
  }

  use {
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("plugins.toggleterm")
    end
  }
  -- Nim {{{2
  use { "alaviss/nim.nvim" }

  -- NWScript {{{2
  use { "squattingmonk/vim-nwscript" }

  -- Editing {{{2
  use { "tpope/vim-fugitive" }
  use { "tpope/vim-surround" }
  use { "tpope/vim-repeat" }
  use { "junegunn/vim-easy-align" }

  use {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup()
    end,
  }

  use {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end
  }

  use "stevearc/dressing.nvim"
  use {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  }
  -- 2}}}
end)

-- vim:foldenable foldmethod=marker foldlevel=1

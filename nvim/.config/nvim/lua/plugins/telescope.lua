return {
  {
    "nvim-telescope/telescope.nvim",
    event = "BufReadPre",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    opts = {
      defaults = {
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "bottom",
        },
        path_display = { "smart" },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
}

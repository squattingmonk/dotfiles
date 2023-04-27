return {
  {
    "nvim-telescope/telescope.nvim",
    event = "BufReadPre",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
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
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        telescope = {
          layout_config = {
            width = function(_, columns, _)
              return math.min(columns, 80)
            end,
            height = function(_, _, lines)
              return math.min(lines, 20)
            end,
          },
        },
      },
    },
  },
}

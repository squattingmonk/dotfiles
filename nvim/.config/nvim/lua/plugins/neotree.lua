local M = {}

M.setup = function ()
  require("neo-tree").setup {
    close_if_last_window = true,
    default_component_configs = {
      name = {
        use_git_status_colors = true,
      },
      git_status = {
        symbols = {
          -- Change type
          added = "+",
          deleted = "-",
          modified = "",
          renamed = "",
          -- Status type
          untracked = "?",
          ignored   = "",
          unstaged  = "",
          staged    = "",
          conflict  = "!",
        },
      },

    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = true,
        hide_gitignored = true,
      }
    },
  }

end

return M

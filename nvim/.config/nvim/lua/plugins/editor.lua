return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "+",
            deleted = "-",
            modified = "",
            renamed = "󱦰",
            -- Status type
            untracked = "?",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "!",
          },
        },
      },
    },
  },
}

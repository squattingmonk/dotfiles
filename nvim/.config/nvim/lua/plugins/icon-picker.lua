return {
  {
    "ziontee113/icon-picker.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>ei", "<cmd>IconPickerInsert emoji<cr>", mode = "i", desc = "Insert emoji", },
      { "<leader>ey", "<cmd>IconPickerYank emoji<cr>", desc = "Yank emoji", },
      { "<leader>ii", "<cmd>IconPickerInsert nerd_font_v3<cr>", mode = "i", desc = "Insert icon", },
      { "<leader>iy", "<cmd>IconPickerYank nerd_font_v3<cr>", desc = "Yank icon", },
    },
    cmd = { "IconPickerYank", "IconPickerInsert", "IconPickerNormal" },
    opts = {
      disable_legacy_commands = true,
    },
  },
}

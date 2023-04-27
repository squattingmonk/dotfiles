return {
  {
    "Civitasv/cmake-tools.nvim",
    dependency = "nvim-lua/plenary.nvim",
    ft = { "cpp", "cmake" },
    opts = {
      cmake_build_directory = "build",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      opts.sections.lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        -- stylua: ignore
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }, },
        -- stylua: ignore
        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" }, },
        {
          function()
            return "CMake:"
          end,
          icon = "",
          separator = "",
          padding = { left = 1, right = 0 },
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
          end,
          on_click = function(clicks, button)
            if button == "l" and clicks == 1 then
              vim.cmd("CMakeGenerate")
            end
          end,
        },
        {
          function()
            local preset = require("cmake-tools").get_configure_preset()
            return "[" .. (preset and preset or "") .. "]"
          end,
          separator = "",
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
              and require("cmake-tools").has_cmake_preset()
          end,
          on_click = function(clicks, button)
            if button == "l" and clicks == 1 then
              vim.cmd("CMakeSelectConfigurePreset")
            end
          end,
        },
        {
          function()
            local type = require("cmake-tools").get_build_type()
            return "[" .. (type and type or "") .. "]"
          end,
          separator = "",
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
              and not require("cmake-tools").has_cmake_preset()
          end,
          on_click = function(clicks, button)
            if button == "l" and clicks == 1 then
              vim.cmd("CMakeSelectBuildType")
            end
          end,
        },
        {
          function()
            return "Build"
          end,
          icon = "",
          separator = "",
          padding = { left = 1, right = 0 },
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
          end,
          on_click = function(clicks, button)
            if clicks == 1 and button == "l" then
              vim.cmd("CMakeBuild")
            end
          end,
        },
        {
          function()
            local preset = require("cmake-tools").get_build_preset()
            return "[" .. (preset and preset or "") .. "]"
          end,
          separator = "",
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
              and require("cmake-tools").has_cmake_preset()
          end,
          on_click = function(clicks, button)
            if button == "l" and clicks == 1 then
              vim.cmd("CMakeSelectBuildPreset")
            end
          end,
        },
        {
          function()
            local type = require("cmake-tools").get_build_target()
            return "[" .. (type and type or "") .. "]"
          end,
          cond = function()
            return package.loaded["cmake-tools"]
              and require("cmake-tools").is_cmake_project()
            -- and not require("cmake-tools").has_cmake_preset()
          end,
          on_click = function(clicks, button)
            if clicks == 1 and button == "l" then
              vim.cmd("CMakeSelectBuildTarget")
            end
          end,
        },
        {
          "navic",
          cond = function()
            return package.loaded["nvim-navic"]
              and require("nvim-navic").is_available()
          end,
          color_correction = "dynamic",
        },
      }
    end,
  },
}

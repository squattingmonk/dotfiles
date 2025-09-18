return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        additional_vim_regex_highlighting = true,
      },
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "fish",
        "gitignore",
        "go",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "nim",
        "nwscript",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          ---@diagnostic disable missing-fields
          require("nvim-treesitter.parsers").nwscript = {
            install_info = {
              url = "https://github.com/squattingmonk/tree-sitter-nwscript",
              branch = "master",
            },
            filestype = "nwscript",
            tier = 2,
          }
        end,
      })
    end,
  },
}

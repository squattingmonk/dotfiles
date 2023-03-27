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
        "help",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "nwscript",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "typescript",
        "vim",
        "yaml",
      },
    },
    config = function(_, opts)
      -- Create NWScript grammar
      local parser_config =
        require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.nwscript = {
        install_info = {
          url = "https://github.com/tinygiant98/tree-sitter-nwscript",
          files = { "src/parser.c" },
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filestype = "nwscript",
      }

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

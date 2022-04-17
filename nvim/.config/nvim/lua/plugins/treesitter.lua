require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- Can be "all", "maintained", or a list of languages
  sync_install = false, -- Install languages synchronously
  ignore_install = { "" }, -- Parsers to ignore installing
  highlight = {
    enable = true, -- enable highlighting
    disable = { "" }, -- Languages to disable highlighting for
    additional_vim_regex_highlighting = false, -- Also runs vim's syntax
  },
  indent = {
    enable = true, -- Enable treesitter-based indentation
    disable = { "yaml", "lua" }, -- Languages to disable indentation for
  },
  playground = {
    enable = true,
    disable = {},
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.nwscript = {
  install_info = {
    url = "https://github.com/tinygiant98/tree-sitter-nwscript",
    files = { "src/parser.c" },
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filestype = "nwscript",
}

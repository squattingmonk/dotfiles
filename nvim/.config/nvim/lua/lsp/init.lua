local lsp = require("lspconfig")
local utils = require("lsp.utils")
local capabilities = utils.capabilities()

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure native diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  float = { source = "always" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

---------------------------------------------------------------------------------
-- Individual server configurations go here
---------------------------------------------------------------------------------


-- Lua
lsp.sumneko_lua.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    utils.disable_formatting(client)
    utils.mappings(bufnr)
  end,
  settings = {
    Lua = {
      completion = {
        enable = true,
        --showWord = "Disable"
      },
      runtime = {
        version = "LuaJIT",
        path = utils.get_luajit_path(),
      },
      diagnostics = {
        globals = { "vim", },
      },
      workspace = {
        library = utils.get_nvim_rtp_path(),
      },
      telemetry = {
        enable = false,
      }
    }
  }
})

-- Nim
lsp.nimls.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    utils.disable_formatting(client)
    utils.mappings(bufnr)
  end,
  settings = {}
})

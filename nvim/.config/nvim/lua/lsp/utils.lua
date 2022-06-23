local M = {}

--- Format-on-save for LSPs that implement formatting.
--- @param client table
function M.format_on_save(client)
  if client.resolved_capabilities.document_formatting then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end
end

--- LSP server capabilities with nvim-cmp
function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").update_capabilities(capabilities)
end

--- Disables formatting for a server
--- @param client table
function M.disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

--- LSP keymappings
--- @param bufnr number
function M.mappings(bufnr)
  --- Map a key to an action for the given buffer
  --- @param mode string
  --- @param key string
  --- @param action string
  local bmap = function(mode, key, action)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, action, opts)
  end

  bmap("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
  bmap("n", "gh", ":lua vim.lsp.buf.hover()<cr>")
  bmap("n", "gr", ":Telescope lsp_references<cr>")
  bmap("n", "K", ":lua vim.lsp.buf.signature_help()<cr>")
  bmap("n", "<leader>r", ":lua vim.lsp.buf.rename()<cr>")
end

--- Make luajit runtime files discoverable to the server.
function M.get_luajit_path()
  local luajit_path = vim.split(package.path, ";")
  table.insert(luajit_path, "lua/?.lua")
  table.insert(luajit_path, "lua/?/init.lua")
  return luajit_path
end

--- Make NeoVim runtime files discoverable by the server
function M.get_nvim_rtp_path()
  return { os.getenv("VIMRUNTIME") }
end

return M

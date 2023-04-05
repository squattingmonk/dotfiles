-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Disable autoformat for c/cpp files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Set options for FireNvim
vim.api.nvim_create_autocmd("UIEnter", {
  command = [[
    if exists('g:started_by_firenvim')
      set guifont=Fira\ Code\ Medium:h10
      set laststatus = 0
      set wrap
      set linebreak
    endif
  ]],
})

-- Load ftplugin files
local ftmodule = "ftplugin.%s"
local function loadftmodule(ft, action)
  local modname = ftmodule:format(ft)
  local _, res = pcall(require, modname)
  if type(res) == "table" then
    if type(res[action]) == "function" then
      res[action]()
    end
  elseif
    type(res) == "string"
    and not res:match("Module '" .. modname .. "' not found")
    and not res:match("	no file")
  then
    print(res)
  end
end

vim.api.nvim_create_autocmd(
  { "FileType", "BufEnter", "BufWinEnter", "Colorscheme" },
  {
    pattern = { "*" },
    callback = function()
      loadftmodule(vim.bo.filetype, "ftplugin")
    end,
  }
)

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    loadftmodule(vim.bo.filetype, "newfile")
  end,
})

vim.api.nvim_create_autocmd(
  { "FileType", "BufEnter", "VimEnter", "BufWinEnter", "Colorscheme" },
  {
    pattern = { "*" },
    callback = function()
      loadftmodule(vim.bo.filetype, "syntax")
    end,
  }
)

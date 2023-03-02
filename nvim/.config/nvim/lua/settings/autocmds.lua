vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "UIEnter" }, {
  command = [[
    if exists('g:started_by_firenvim')
      set guifont=Fira\ Code\ Medium:h10
      set laststatus=0
      set wrap
      set linebreak
    endif
  ]]

})

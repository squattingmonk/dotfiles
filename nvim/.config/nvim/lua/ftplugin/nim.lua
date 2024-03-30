local ft = {}

function ft.ftplugin()
  vim.bo.commentstring = "# %s"
  vim.bo.formatoptions = "jncroql"
end

return ft

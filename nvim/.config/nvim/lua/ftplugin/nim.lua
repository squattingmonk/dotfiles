local ft = {}

function ft.ftplugin()
  vim.bo.comments = ":##,:#,s1:#[,e:]#,fb:-"
  vim.bo.commentstring = "# %s"
  vim.bo.formatoptions = "jncroql"
end

return ft

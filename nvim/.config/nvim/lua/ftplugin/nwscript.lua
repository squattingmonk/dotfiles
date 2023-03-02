local ft = {}

function ft.ftplugin()
  vim.bo.expandtab = true
  vim.bo.shiftwidth = 4
  vim.bo.softtabstop = 4
  vim.bo.tabstop = 4
end

function ft.syntax()
  vim.cmd[[
    set syntax=nwscript.doxygen
    hi! link doxygenStartL Comment
    hi! link doxygenParam Special
    hi! link doxygenParamName Special
    hi! link doxygenSpecialOneLineDesc Comment
    hi! link doxygenSpecialTypeOneLineDesc Special
    hi! link doxygenBOther Special
    hi! link doxygenBriefWord Special
    hi! link doxygenBrief Comment
    hi! TSComment gui=NONE
  ]]
end

return ft

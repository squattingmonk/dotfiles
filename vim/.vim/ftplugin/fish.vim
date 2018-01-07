" Set up :make to use fish for syntax checking
compiler fish

" Have long lines wrap insude comments
setlocal textwidth=79

" Enable folding of block structures in fish
setlocal foldmethod=expr

" Unfold everything by default
au BufWinEnter * normal zR

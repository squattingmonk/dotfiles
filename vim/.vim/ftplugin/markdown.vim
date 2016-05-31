" Turn on spell-checking
setlocal spell

"-- pandoc Markdown+LaTeX -------------------------------------------

noremap <buffer> <Leader>b :! pandoc -t beamer % -o %<.pdf<CR><CR>
noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
noremap <buffer> <Leader>v :! zathura %<.pdf 2>&1 >/dev/null &<CR><CR>


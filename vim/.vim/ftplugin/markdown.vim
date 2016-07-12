" Turn on spell-checking
setlocal spell

"-- pandoc Markdown+LaTeX -------------------------------------------

nnoremap <Leader>c a$\ce{}$<Esc>hi
inoremap <Leader>c $\ce{}$<Esc>hi

noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
noremap <buffer> <Leader>v :! zathura %<.pdf 2>&1 >/dev/null &<CR><CR>


"-- vim-surround extensions for bold and italicize ------------------

let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

nmap <Leader>i ysiwi
nmap <Leader>b ysiwb

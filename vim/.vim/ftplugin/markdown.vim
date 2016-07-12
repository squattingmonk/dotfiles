" Turn on spell-checking
setlocal spell

"-- pandoc Markdown+LaTeX -------------------------------------------

noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
noremap <buffer> <Leader>v :! zathura %<.pdf 2>&1 >/dev/null &<CR><CR>


"-- vim-surround extensions for bold and italicize ------------------

let b:surround_{char2nr('i')} = "*\r*"
let b:surround_{char2nr('b')} = "**\r**"

nmap <Leader>i ysiwi
nmap <Leader>b ysiwb

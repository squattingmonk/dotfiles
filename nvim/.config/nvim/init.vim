" begin plugins
" ------------------------------------------------------------------------------
" Run our plugin manager
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'SirVer/ultisnips'
Plug 'squattingmonk/vim-nwscript'
Plug 'sheerun/vim-polyglot'

call plug#end()

" vim-pandoc
let g:pandoc#syntax#conceal#blacklist = ['atx', 'list']
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#folding#level = 1
let g:pandoc#hypertext#create_if_no_alternates_exist = 1
let g:pandoc#formatting#mode = 'haA'

" UltiSnips
let g:UltiSnipsSnippetDirectories = ['~/.local/share/nvim/UltiSnips', 'UltiSnips']

" vim-nwscript
let g:nwscript#snippets#url = 'https://github.com/squattingmonk/'
let g:nwscript#snippets#author = 'Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>'

" end plugins
" ------------------------------------------------------------------------------

" Enable mouse support
set mouse=a

" Turn line numbers on
set nu

" Turn on relative numbering
set rnu

" Turn on syntax highlighting
syntax on

" Turn on line limit hint
set colorcolumn=80

" Set spelling options
set spelllang=en
set spellfile=$HOME/Sync/vim/spell/en.utf-8.add

" Set color scheme
" color miro8
color bleh
set background=dark

" Make sure the statusline is always on
set laststatus=2

" Default indentation: 4 spaces
set ts=4 sts=4 sw=4 expandtab

" Remap j and k to move up a row instead of a line
" (useful for line wraps)
nnoremap j gj
nnoremap k gk

" Remap <Esc> to jj and kk in insert mode
inoremap jj <Esc>
inoremap kk <Esc>

" Remap up and down keys to move lines up and down
nnoremap <up> ddkP
nnoremap <down> ddp

" Add lines above and below in normal mode
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" Allow copying and pasting to/from the system clipboard
set clipboard=unnamedplus

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection and indentation
    filetype plugin indent on

    " Syntax of these languages is fussy over tabs vs spaces
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

    " Customizations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType crystal setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif

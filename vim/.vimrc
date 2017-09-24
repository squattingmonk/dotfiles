" begin plugins
" ------------------------------------------------------------------------------
" Run our plugin manager
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'baskerville/vim-sxhkdrc'
Plug 'dag/vim-fish'
Plug 'AGhost-7/vim-nwscript'

call plug#end()

" EasyAlign Plugin
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Airline plugin
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'

" end plugins
" ------------------------------------------------------------------------------

" be iMproved
set nocompatible

" Enable mouse support
set mouse=a

" Turn line numbers on
set nu

" Turn on syntax highlighting
syntax on

" Set spelling options
set spelllang=en
set spellfile=$HOME/Dropbox/vim/spell/en.utf-8.add

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

" Allow saving of files as sudo when I forget to start vim using sudo
cmap W w !sudo tee % > /dev/null

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Enable file type detection
    filetype on
    filetype plugin on

    " Syntax of these languages is fussy over tabs vs spaces
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

    " Customizations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
endif

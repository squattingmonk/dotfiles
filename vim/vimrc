" Begin Vundle (vim plugin manager) config
set nocompatible        " be iMproved, required
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Airline statusline plugin
Plugin 'bling/vim-airline'

" Color schemes
" Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()           " required
filetype plugin indent on   " required
" to ignore indent changes instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :Plugin install   - installs plugins; append '!' to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append '!' to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append '!' to auto-approve
"
" See :h vundle for more details or wiki for FAQ

" End Vundle config -----

" Use powerline fonts for airline plugin
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1

" Turn line numbers on
set nu

" Turn on syntax highlighting
syntax on

" Set color scheme
color miro8

" Default indentation: 4 spaces
set ts=4 sts=4 sw=4 expandtab

" Remap j and k to move up a row instead of a line
" (useful for line wraps)
nnoremap j gj
nnoremap k gk

" Remap <Esc> to jj in insert mode
inoremap jj <Esc>

" Only do this part when compiled with support for autocommands
if has("autocmd")
	" Enable file type detection
	filetype on

	" Syntax of these languages is fussy over tabs vs spaces
	autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

	" Customizations based on house-style (arbitrary)
	autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
	autocmd FileType css setlocal ts=4 sts=4 sw=4 expandtab
endif

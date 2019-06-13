" begin plugins
" ------------------------------------------------------------------------------
" Run our plugin manager
call plug#begin('~/.local/share/nvim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'SirVer/ultisnips'
Plug 'squattingmonk/vim-nwscript'
Plug 'alaviss/nim.nvim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/asyncomplete-tags.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'

call plug#end()

" vim-pandoc
let g:pandoc#syntax#conceal#blacklist = ['atx', 'list']
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#folding#level = 1
let g:pandoc#hypertext#create_if_no_alternates_exist = 1
let g:pandoc#formatting#mode = 'haA'

" UltiSnips
let g:UltiSnipsSnippetDirectories = ['~/.local/share/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsExpandTrigger="<C-e>"

" nim
nmap gd <Plug>NimGoToDefBuf
nmap gS <Plug>NimGoToDefSplit
nmap gV <Plug>NimGoToDefVSplit

" vim-nwscript
let g:nwscript#snippets#url = 'https://github.com/squattingmonk/'
let g:nwscript#snippets#author = 'Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>'

" asyncomplete
let g:asyncomplete_auto_completeopt = 0
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <C-y>   pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" asyncomplete-buffer
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

" asyncomplete-omni
call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
    \ 'name': 'omni',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['c', 'cpp', 'html'],
    \ 'completor': function('asyncomplete#sources#omni#completor')
    \  }))

" asyncomplete + nim
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })

" asyncomplete + UltiSnips
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

" asyncomplete + tags
call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'whitelist': ['c', 'nwscript'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))
" }}}

" Status line {{{
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

let g:lightline.separator = {
	\   'left': '', 'right': ''
	\}
let g:lightline.subseparator = {
	\   'left': '', 'right': ''
	\}

" Hide extra mode information
set noshowmode
" }}}

" end plugins
" ------------------------------------------------------------------------------

" Enable mouse support
set mouse=a

" Turn line numbers on
set number

" Turn on relative numbering
set relativenumber

" Turn on syntax highlighting
syntax on

" Turn on line limit hint
set colorcolumn=80

" Highlight the current line
set cursorline

" Turn off word wrap
set nowrap

" Set completion popup options
set completeopt=menu,menuone,preview,noselect,noinsert

" Set position of new splits
set splitbelow
set splitright

" Set spelling options
set spelllang=en
set spellfile=$HOME/Sync/vim/spell/en.utf-8.add

" Set color scheme
colorscheme nord
set background=dark

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

" Default indentation: 4 spaces
set ts=4 sts=4 sw=4 expandtab

" Syntax of these languages is fussy over tabs vs spaces
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

" Customizations based on house-style (arbitrary)
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType nim setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType crystal setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
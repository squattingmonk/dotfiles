" vim:foldmethod=marker:foldlevel=1

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" Appearance {{{
    " Theme
    Plug 'arcticicestudio/nord-vim'

    " Status line {{{
    Plug 'itchyny/lightline.vim'
        let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'separator': { 'left': '', 'right': '' },
            \ 'subseparator': { 'left': '', 'right': '' }
            \ }
 
        " Hide extra mode information
        set noshowmode
    " }}}
" }}}

" Filetypes {{{
    " Pandoc {{{
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
        let g:pandoc#syntax#conceal#blacklist = ['atx', 'list']
        let g:pandoc#syntax#conceal#urls = 1
        let g:pandoc#folding#level = 1
        let g:pandoc#hypertext#create_if_no_alternates_exist = 1
        let g:pandoc#formatting#mode = 'haA'
    " }}}

    " nim {{{
    Plug 'alaviss/nim.nvim'
        nmap gd <Plug>NimGoToDefBuf
        nmap gS <Plug>NimGoToDefSplit
        nmap gV <Plug>NimGoToDefVSplit
    " }}}

    " NWScript {{{
    Plug 'squattingmonk/vim-nwscript'
        let g:nwscript#snippets#url = 'https://github.com/squattingmonk/'
        let g:nwscript#snippets#author = 'Michael A. Sinclair (Squatting Monk) <squattingmonk@gmail.com>'
    " }}}

    " Catch-all
    Plug 'sheerun/vim-polyglot'
" }}}

" UltiSnips {{{
Plug 'sirver/ultisnips'
    " Make tab-select from pop-up menu compatible
    inoremap <expr> <CR> pumvisible() ?
        \   "\<C-y><C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" :
        \   "\<CR>"
    let g:UltiSnipsExpandTrigger="<nop>"
    let g:UltiSnipsJumpForwardTrigger="<Tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" Default snippets
Plug 'honza/vim-snippets'

" }}}

" Autocomplete {{{
Plug 'shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    let g:deoplete#enable_at_startup = 1
    set completeopt=menuone,noinsert,noselect,preview

    " Hide completion messages
    set shortmess+=c

    " Tab completion
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Select with Enter
    "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

    " Close preview window when selection is done
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    
    " Disable the truncate feature.
    autocmd VimEnter * call deoplete#custom#source('_', 'max_abbr_width', 0)
    autocmd VimEnter * call deoplete#custom#source('_', 'max_menu_width', 0)

    " Add tag completion source
    Plug 'deoplete-plugins/deoplete-tag'

    " Display function signature on autocomplete
    Plug 'shougo/echodoc.vim'
        let g:echodoc#enable_at_startup = 1

" }}}

" Autopairs {{{
Plug 'jiangmiao/auto-pairs'
    let g:AutoPairsMapBS = 0
" }}}

" Convenience {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" }}}

call plug#end()
" }}}


" Enable mouse support
set mouse=a

" Turn line numbers on
set number

" Turn on relative numbering
set relativenumber

" Set color scheme
colorscheme nord
set background=dark
set termguicolors

" Turn on syntax highlighting
syntax on

" Turn on line limit hint
set colorcolumn=80

" Highlight the current line
set cursorline

" Turn off word wrap
set nowrap

" Set position of new splits
set splitbelow
set splitright

" Set spelling options
set spelllang=en
set spellfile=$HOME/Sync/vim/spell/en.utf-8.add

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

" Automatically reload vimrc when it's saved
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested so $MYVIMRC
augroup END

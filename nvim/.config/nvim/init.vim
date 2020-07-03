" vim:foldmethod=marker:foldlevel=9

" Plugins {{{
call plug#begin($XDG_DATA_HOME.'/nvim/plugged')

" Convenience {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" }}}

" Session Management {{{
Plug 'tpope/vim-obsession'

let g:session_dir = '~/.local/share/nvim/sessions'
command! Sessions call fzf#run(fzf#wrap({'source': 'ls', 'dir': g:session_dir, 'sink': 'source'}))

exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/'
exec 'nnoremap <Leader>sr :so ' . g:session_dir . '/'
nnoremap <Leader>sp :Obsession<CR>

" Plug 'dhruvasagar/vim-prosession'
" let g:prosession_dir = g:session_dir . '/'
" }}}

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

        " Always show the tabline
        set showtabline=2

        " Show vim-obsession status in statusline
        function! LightlineObsession()
            if exists(':Obsession') && exists('v:this_session')
                let l:parts = split(v:this_session, '/')
                let l:filename = l:parts[-1]
                return '%{ObsessionStatus()} ' . l:filename
            endif
            return ''
        endfunction

        " Show current working directory in tab name
        function! LightlineTabname(n) abort
            return fnamemodify(getcwd(tabpagewinnr(a:n), a:n), ':t')
        endfunction

        let g:lightline.active = {
		    \ 'left': [ [ 'mode', 'paste' ],
		    \           [ 'readonly', 'filename', 'modified' ] ],
		    \ 'right': [ [ 'lineinfo' ],
		    \            [ 'percent' ],
            \ [ 'fileformat', 'fileencoding', 'filetype' ] ] }
        let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ [ 'close' ],
            \            [ 'obsession' ] ] }

        let g:lightline.component_expand = {
            \ 'obsession': 'LightlineObsession' }

        let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'tabname', 'modified' ],
            \ 'inactive': [ 'tabnum', 'tabname', 'modified' ] }

        let g:lightline.tab_component_function = {
            \ 'tabname': 'LightlineTabname' }

        " Make tmux statusline match vim
        Plug 'edkolev/tmuxline.vim'
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
        augroup nim
            autocmd!
            autocmd FileType nim nmap gd <Plug>NimGoToDefBuf
            autocmd FileType nim nmap gS <Plug>NimGoToDefSplit
            autocmd FileType nim nmap gV <Plug>NimGoToDefVSplit
            autocmd FileType nim set foldmethod=manual

            " Remove trailing whitepace on save
            autocmd BufWritePre <buffer> %s/\s\+$//e
        augroup END
    " }}}

    " NWScript {{{
    Plug 'squattingmonk/vim-nwscript'
        augroup nwscript
            autocmd!
            autocmd FileType nwscript set foldlevel=9
        augroup END
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
    let g:UltiSnipsJumpForwardTrigger="<C-j>"
    let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    let g:UltiSnipsEditSplit="context"

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

" Don't mark URL-like things as spelling errors
autocmd BufEnter * syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

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

nnoremap <Leader>q :qa<CR>

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

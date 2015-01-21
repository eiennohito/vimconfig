 " Note: Skip initialization for vim-tiny or vim-small.
 if !1 | finish | endif

 set nocompatible
 filetype on
 filetype off

 let s:dotvim = fnamemodify(globpath(&rtp, 'vimified.dir'), ':p:h')

 let mapleader = ","
 let maplocalleader = "\\"

 set foldlevelstart=0
 set foldmethod=syntax

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " _. Basic Neobundle configuration {{{

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" }}}

" _. Bundles {{{

 NeoBundle 'altercation/vim-colors-solarized.git'

 " Git integration {{{ "
 NeoBundle 'tpope/vim-fugitive'
    nmap <leader>gs :Gstatus<CR>
    nmap <leader>gc :Gcommit -v<CR>
 " }}} Git integration "

 NeoBundle 'Valloric/YouCompleteMe'

 NeoBundle 'git@github.com:GEverding/vim-hocon.git'

 " Status line {{{ "
 set laststatus=2
 let g:airline#extensions#tabline#enabled = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'

 NeoBundle 'git@github.com:bling/vim-airline.git'

 " }}} Status line "

 " Snippets {{{
 NeoBundle 'SirVer/ultisnips'
 "
 NeoBundle 'git@github.com:eiennohito/vim-snippets.git'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

 "}}}

 " _. LaTeX {{{

 let g:latex_build_dir = './Output'
 let g:latex_latexmk_options = '-lualatex'
 let g:latex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
 function! SyncTexForward()
   call latex#view#view('-b '
     \ . g:latex#data[b:latex.id].out()
     \ . ' ' . line(".") . ' ' . expand('%:p'))
 endfunction
 NeoBundle 'lervag/vim-latex'
" }}}

 call neobundle#end()

" }}}

" Required:
 filetype plugin indent on

" _ Vim {{{
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}

" Fold description {{{ "
syntax on
set backspace=indent,eol,start

set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set relativenumber

set expandtab
set shiftwidth=2
set softtabstop=2
" }}} Fold description "

 nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END
" }}}

" Quick editing {{{

nnoremap <leader>ev <C-w>s<C-w>j:e $MYVIMRC<cr>
exec 'nnoremap <leader>es <C-w>s<C-w>j:e '.s:dotvim.'/snippets/<cr>'
nnoremap <leader>eg <C-w>s<C-w>j:e ~/.gitconfig<cr>
nnoremap <leader>ez <C-w>s<C-w>j:e ~/.zshrc<cr>
nnoremap <leader>et <C-w>s<C-w>j:e ~/.tmux.conf<cr>

" --------------------

set ofu=syntaxcomplete#Complete
let g:rubycomplete_buffer_loading = 0
let g:rubycomplete_classes_in_global = 1

" showmarks
let g:showmarks_enable = 1
hi! link ShowMarksHLl LineNr
hi! link ShowMarksHLu LineNr
hi! link ShowMarksHLo LineNr
hi! link ShowMarksHLm LineNr

" }}}

" _. Text Folding {{{
"exec ':so '.s:dotvim.'/functions/my_fold_text.vim'
" }}}

nmap <silent> <leader>hh :set invhlsearch<CR>
nmap <silent> <leader>ll :set invlist<CR>
nmap <silent> <leader>nn :set invnumber<CR>
nmap <silent> <leader>pp :set invpaste<CR>
nmap <silent> <leader>ii :set invrelativenumber<CR>

" Don't redraw while executing macros
set nolazyredraw

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:␣
    au InsertLeave * :set listchars+=trail:␣
augroup END

" Remove trailing whitespaces when saving
" Wanna know more? http://vim.wikia.com/wiki/Remove_unwanted_spaces
" If you want to remove trailing spaces when you want, so not automatically,
" see
" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Display_or_remove_unwanted_whitespace_with_a_script.
autocmd BufWritePre * :%s/\s\+$//e

" }}}

autocmd! BufWritePost vimrc source $MYVIMRC
 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

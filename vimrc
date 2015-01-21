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

 NeoBundle 'bling/vim-airline'

 NeoBundle 'tpope/vim-fugitive'

 NeoBundle 'Valloric/YouCompleteMe'

 NeoBundle 'git@github.com:GEverding/vim-hocon.git'
 
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

 syntax on
 set backspace=indent,eol,start

 set background=dark
 let g:solarized_termcolors=256
 colorscheme solarized

 set relativenumber

 set expandtab
 set shiftwidth=2
 set softtabstop=2

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
exec ':so '.s:dotvim.'/functions/my_fold_text.vim'
" }}}
"
autocmd! BufWritePost vimrc source $MYVIMRC
 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

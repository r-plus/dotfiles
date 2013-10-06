" colorscheme setting for Win32
colorscheme pablo

" override textwidth=78
autocmd FileType text setlocal textwidth=0

" hide icon menu.
set guioptions-=T
" visual select to copy.
set guioptions+=a

" font.
if has ('win32')
    set guifont=MS_Gothic:h10:cSHIFTJIS
endif

" width
set columns=120
" height
set lines=40

" fix jp-menu
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

" gvim win32
if has('gui_win32')
    "source $VIMRUNTIME/mswin.vim
    " Copy-Paste-Cut shortcut key enable and yank to clipboard for Windows
    set clipboard+=unnamed
    " Minimize shortcut
    nnoremap <M-n> :simalt ~n<CR>
    " Paste Clipboard mapping
    nnoremap <M-v> "*P
    inoremap <M-v> <ESC>"*pa
    cnoremap <M-v> <C-r>+
    nnoremap <RightMouse> "*p
    inoremap <RightMouse> <C-r><C-o>*
endif

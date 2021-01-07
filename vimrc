if &compatible
  set nocompatible
endif

filetype plugin indent off
" dein.vim {{{
let s:dein_cache_dir = '~/.cache/dein'
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(s:dein_cache_dir)
  let s:toml = '~/dotfiles/dein.toml'
  let s:lazy_toml = '~/dotfiles/dein_lazy.toml'
  call dein#begin(s:dein_cache_dir)
  call dein#load_toml(s:toml)
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
" }}}

" Installation check.
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on

" -----------------------------------------------------------------------

" display
set number
set ruler
set showcmd
set title
set wildmenu
set wildmode=list:longest,full
set cmdheight=2
set ambiwidth=double
" vim-powerline recommended
set t_Co=256
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set wrapscan

" tab-space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" backup file
set nobackup
"set noswapfile
set directory=~/.vim/swap
set viewdir=~/.vim/view
set undodir=~/.vim/undo
" for preserve i-node
set backupcopy=yes

" colorshceme
if !has('gui_running')
  colorscheme desert
endif

" foldmethod
set foldmethod=marker

" decimal increment
setlocal nf=
" setlocal nf=octal,hex

" programming syntax + indent
syntax on
set cindent
set autoindent

" set modeline
set modelines=2
set modeline

" Don't save options.
set viewoptions-=options

" backspace behavior
set backspace=indent,eol,start

scriptencoding utf-8

augroup MyAutoCommands
  autocmd!

  " highlight http://vim-users.jp/2009/07/hack40/
  autocmd VimEnter,Colorscheme,BufRead * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter,BufRead * match IdeographicSpace /　/

  " auto set paste, nopaste for C-v from clipboard
  "autocmd InsertEnter * set paste
  autocmd InsertLeave * set nopaste

  " Save fold settings. Copy from http://vim-users.jp/2009/10/hack84/
  autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
  autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif

  " automatically reload vimrc
  autocmd BufWritePost vimrc nested source $MYVIMRC

  " markdown
  autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown

  " theos
  autocmd BufNewFile,BufRead *.h,*.m,*.mm,*.xm,*.x,*.xi,*.xmi set filetype=objcpp

  " dont hide double-quote on json file
  autocmd FileType json setl conceallevel=0

  " yaml
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup end

" mappings {{{
" keymap for theos framework
nnoremap <Space>m :update<CR> :!make; [ $? -eq 0 ] && (make package; make install)<CR>
nnoremap ,v 0f)l"vye$xo{<CR>DLog(@"<Esc>"vpa");<CR>%orig;<CR>}<Esc>
nnoremap ,r 0f)l"vye$xo{<CR>id tmp = %orig;<CR>DLog(@"<Esc>"vpa %@", tmp);<CR>return tmp;<CR>}<Esc>

" keymap for window mover
nnoremap <TAB> <C-w>w<CR>

" for US keylayout.
nnoremap <silent> ; :

" keymap for window resize
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>

" keymap for tab move
nnoremap <C-TAB> gt
nnoremap <C-S-TAB> gT

" lines wrap downward/upward as default
nnoremap j gj
nnoremap k gk

" tab open vimrc
nnoremap <F5> :tabe $MYVIMRC<CR>

" toggle highlight search
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" align for textile table macro
xnoremap <silent> \| :Alignta \|<CR>

" keymap for insert current file name
imap <C-F> <C-R>=expand("%")<CR>

" escape safety
imap <C-@> <C-[>
imap <C-]> <C-[>

" snippet
inoreabbrev <expr> dl repeat('/', 80 - col('.'))
inoreabbrev <expr> logc 'id tmp = %orig;<CR>NSLog(@"return = %@", tmp);<CR>NSLog(@"return class = %@", NSStringFromClass([tmp class]));'
inoreabbrev <expr> boolc 'BOOL tmp = %orig;<CR>NSLog(@"return = %@", tmp ? @"YES" : @"NO");<CR>return tmp;'
inoreabbrev <expr> subjcc 'SubjC_set_maximum_depth(0);<CR>SubjC_start();<CR>%orig;<CR>SubjC_end();'
inoreabbrev <expr> fou '#import <Foundation/Foundation.h><CR>'
inoreabbrev <expr> tanalyze 'CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();<CR>CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();<CR>NSLog(@"time = %f", end - start);'
" }}}


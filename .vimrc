" NeoBundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
NeoBundle 'git://github.com/vim-scripts/YankRing.vim.git'
NeoBundle 'git://github.com/r-plus/EnhCommentify.vim.git'

filetype plugin indent on

" -----------------------------------------------------------------------

" display
set number
set ruler

" search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" tab-space
set ts=2
set sw=2
set sts=2
set expandtab

" backup file
set nobackup

" colorshceme
colorscheme desert

" foldmethod
"set foldmethod=indent

" decimal increment
setlocal nf=
" setlocal nf=octal,hex

" programming syntax + indent
syntax on
set cindent
set autoindent

" set modeline
set modeline

" vim-ref
nmap ,ra :<C-u>Ref alc<Space>
nnoremap ,ro :<C-u>Ref alc<Space><C-r><C-w><CR>
nnoremap <silent> <Space>K :<C-u>call ref#jump('normal', 'alc')<CR>
vnoremap <silent> <Space>K :<C-u>call ref#jump('visual', 'alc')<CR>
let g:ref_alc_start_linenumber = 43
" vim-ref for Windows
if has('gui_win32')
  let $PATH = $PATH . ';C:\Program Files (x86)\Lynx for Win32'
  let g:ref_alc_encoding = 'cp932'
  let g:ref_alc_start_linenumber = 45
endif

" auto set paste, nopaste for C-v from clipboard
autocmd InsertEnter * set paste
autocmd InsertLeave * set nopaste

" Copy-Paste-Cut shortcut key enable for Windows
if has('gui_win32')
  source $VIMRUNTIME/mswin.vim
endif

" theos
autocmd BufNewFile,BufRead *.h,*.m,*.mm,*.xm,*.x set filetype=objcpp
autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                        \ endif

"" quickrun for theos tweak
"let g:quickrun_config = {}
"let g:quickrun_config['objcpp'] = {'command': 'make'}
"augroup TheosTweak
"  autocmd!
"  autocmd BufWinEnter,BufNewFile *.xm set filetype=objcpp
"augroup END

" keymap for theos framework
nnoremap <Space>m :update<CR> :!make; [ $? -eq 0 ] && (make package; make install)<CR>
nnoremap ,v $xo{<CR>%log;<CR>%orig;<CR>}<Esc>
nnoremap ,r $xo{<CR>%log;<CR>return %orig;<CR>}<Esc>

" keymap for window resize
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>

" comment line creater
inoreabbrev <expr> dl repeat('/', 80 - col('.'))

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

" PEP8 indent
autocmd FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" error-fix yankring
let g:yankring_manual_clipboard_check = 0

" -----------------------------------------------------------------------
" neocomplcache from README

	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_smart_case = 1
	let g:neocomplcache_enable_camel_case_completion = 1
	let g:neocomplcache_enable_underbar_completion = 1
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
	
	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : '',
	    \ 'vimshell' : $HOME.'/.vimshell_hist',
	    \ 'scheme' : $HOME.'/.gosh_completions'
	        \ }
	
	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
	    let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
	
	" Plugin key-mappings.
	imap <C-k>     <Plug>(neocomplcache_snippets_expand)
	smap <C-k>     <Plug>(neocomplcache_snippets_expand)
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()
	
	" SuperTab like snippets behavior.
	"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
	
	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	
	" For cursor moving in insert mode(Not recommended)
	inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	
	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1
	
	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
	"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
	
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	
	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
	  let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
	let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
	
	" For snippet_complete marker.
	if has('conceal')
	  set conceallevel=2 concealcursor=i
	endif

 

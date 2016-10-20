" NeoBundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
let g:neobundle#default_options._ = { 'verbose' : 1, 'focus' : 1 }

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleLazy 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/unite.vim', {
      \   'depends' : ["Shougo/neomru.vim"],
      \   'autoload' : {
      \       'commands' : ["Unite"]
      \   }
      \}
NeoBundleLazy 'Shougo/vimfiler', {
      \   'depends' : ["Shougo/unite.vim"],
      \   'autoload' : {
      \       'commands' : ["VimFilerTab", "VimFiler", "VimFilerExplorer"]
      \   }
      \}
NeoBundleLazy 'thinca/vim-ref', {
      \   'autoload' : {
      \       'commands' : ["Ref"]
      \   }
      \}
NeoBundleLazy 'h1mesuke/vim-alignta', {
      \   'autoload' : {
      \       'commands' : ["Align", "Alignta"]
      \   }
      \}
NeoBundleLazy 'Shougo/vimshell', {
      \   'depends' : ["Shougo/vimproc"],
      \   'autoload' : {
      \       'commands' : ["VimShell"]
      \   }
      \}
NeoBundleLazy 'thinca/vim-qfreplace', {
      \   'autoload' : {
      \       'filetypes' : ['unite', 'quickfix']
      \   }
      \}
NeoBundleLazy 'thinca/vim-quickrun', {
      \   'autoload' : {
      \       'mappings' : ["<Leader>r"]
      \   }
      \}
NeoBundleLazy 'Shougo/vimproc', {
      \   'build' : {
      \       'windows' : 'tools\\update-dll-mingw',
      \       'cygwin' : 'make -f make_cygwin.mak',
      \       'mac' : 'make -f make_mac.mak',
      \       'linux' : 'make',
      \       'unix' : 'gmake',
      \   }
      \}
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
"NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bling/vim-airline'
"NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'r-plus/EnhCommentify.vim'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'osyo-manga/vim-anzu'
"NeoBundle 'kana/vim-smartinput'
NeoBundleLazy 'osyo-manga/vim-over', {
      \   'autoload' : {
      \       'commands' : ["OverCommandLine"]
      \   }
      \}
NeoBundleLazy 'deris/vim-rengbang', {
      \   'autoload' : {
      \       'commands' : ["RengBang"]
      \   }
      \}
if has('mac')
  NeoBundle 'elzr/vim-json'
  NeoBundle 'toyamarinyon/vim-swift'
  NeoBundle 'davidhalter/jedi-vim'
  NeoBundle 'mhinz/vim-signify'
  NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive'}
  NeoBundle 'rhysd/migemo-search.vim'
  NeoBundleLazy 'tyru/open-browser.vim', {
        \   'autoload' : {
        \       'mappings' : ["<Leader>r"]
        \   }
        \}
endif

call neobundle#end()
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
augroup end

" mappings {{{
" keymap for theos framework
nnoremap <Space>m :update<CR> :!make; [ $? -eq 0 ] && (make package; make install)<CR>
nnoremap ,v $xo{<CR>%log;<CR>%orig;<CR>}<Esc>
nnoremap ,r $xo{<CR>%log;<CR>return %orig;<CR>}<Esc>

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

" -----------------------------------------------------------------------
"  Plugins
" -----------------------------------------------------------------------

" vim-signify {{{
let g:signify_vcs_list = ['git']
let g:signify_line_highlight = 1
nnoremap <Leader>gt :<C-u>SignifyToggle<CR>
" }}}

" vim-anzu {{{
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" }}}

" vim-over
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//cg<Left><Left><Left>

" vim-ref {{{
nnoremap ,ra :<C-u>Ref alc<Space>
nnoremap ,ro :<C-u>Ref alc<Space><C-r><C-w><CR>
nnoremap <silent> <Space>K :<C-u>call ref#jump('normal', 'alc')<CR>
vnoremap <silent> <Space>K :<C-u>call ref#jump('visual', 'alc')<CR>
if neobundle#tap('vim-ref')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:ref_alc_start_linenumber = 43
    " vim-ref for Windows
    if has('gui_win32')
      if exists(isdirectory('C:Program Files (x86)\Lynx for Win32'))
        let $PATH = $PATH . ';C:\Program Files (x86)\Lynx for Win32'
      else
        let $PATH = $PATH . ';C:\Program Files\Lynx for Win32'
      endif
      let g:ref_alc_encoding = 'cp932'
      let g:ref_alc_start_linenumber = 45
    endif
  endfunction
  call neobundle#untap()
endif
" }}}

" migemo-search {{{
if neobundle#tap('migemo-search.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    if executable('cmigemo')
      cnoremap <expr><CR> migemosearch#replace_search_word()."\<CR>"
    endif
  endfunction
  call neobundle#untap()
endif
" }}}

" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['objcpp'] = {
      \     'command': 'clang',
      \     'exec': ['%c %s -o %s:p:r -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
      \     'tempfile': '{tempname()}.mm',
      \ }
let g:quickrun_config['markdown'] = {
      \ 'outputter': 'browser',
      \ 'command': 'pandoc',
      \ 'exec': ['%c -s -f markdown -t html -o %s:p:r.html %s', 'open %s:p:r.html', 'sleep 1', 'rm %s:p:r.html'],
      \ 'tempfile': '{tempname()}.md'
      \ }
" }}}

" blogger settings saved to pit. {{{
"let g:blogger_blogid = ''
"let g:blogger_email = ''
"let g:blogger_pass = ''
let g:blogger_ruby_path = '/usr/local/bin/ruby'
"let g:blogger_ruby_path = join(split(system('which ruby'), '')[0:-2], "")
" }}}

" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
" }}}

" error-fix yankring
let g:yankring_manual_clipboard_check = 0

" unite.vim vimproc.vim VimFiler {{{
nnoremap vv :<C-u>VimFilerTab<CR>
nnoremap fm :<C-u>Unite file_mru -buffer-name=mru -no-quit<CR>
nnoremap fb :<C-u>Unite bookmark -buffer-name=bookmark<CR>
nnoremap fg :<C-u>Unite grep -buffer-name=grep<CR>
nnoremap fc :<C-u>Unite grep:% -buffer-name=grep -no-quit -auto-preview<CR>
nnoremap fr :<C-u>UniteResume<CR>
if neobundle#tap('unite.vim')
  function! neobundle#tapped.hooks.on_source(bundle)
    let g:unite_force_overwrite_statusline = 0
    call vimfiler#custom#profile('default', 'context', {
    \   'safe' : 0,
    \   'auto_cd' : 1,
    \   'edit_action' : 'tabopen',
    \ })
    autocmd FileType vimfiler call unite#custom_default_action('directory', 'cd')
    autocmd FileType unite call unite#custom_default_action('file', 'tabopen')
    "let g:unite_enable_start_insert = 1
    if executable('ag')
      " Use ag in unite grep source.
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
      let g:unite_source_grep_recursive_opt = ''
    elseif executable('pt')
      " Use pt in unite grep source.
      " https://github.com/monochromegane/the_platinum_searcher
      let g:unite_source_grep_command = 'pt'
      let g:unite_source_grep_default_opts = '--nogroup --nocolor'
      let g:unite_source_grep_recursive_opt = ''
      let g:unite_source_grep_encoding = 'utf-8'
    endif
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()"{{{
      " Overwrite settings.
      nnoremap <silent><buffer><expr> r     unite#do_action('replace')
      nnoremap <silent><buffer><expr> gr     unite#do_action('grep')

      nmap <buffer> <ESC>      <Plug>(unite_exit)
      imap <buffer> jj      <Plug>(unite_insert_leave)
      "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

      imap <buffer><expr> j unite#smart_map('j', '')
      imap <buffer> <TAB>   <Plug>(unite_select_next_line)
      imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
      imap <buffer> '     <Plug>(unite_quick_match_default_action)
      nmap <buffer> '     <Plug>(unite_quick_match_default_action)
      imap <buffer><expr> x
            \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
      nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
      nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
      imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
      imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
      nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
      nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
    endfunction"}}}
  endfunction
  call neobundle#untap()
endif
" }}}

" vim-smartinput {{{
if neobundle#tap('vim-smartinput')
  function! neobundle#tapped.hooks.on_source(bundle)
    call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)',
          \ '<Enter>',
          \ '<Enter>')
  endfunction
  call neobundle#untap()
endif
" }}}

" neocomplete from README {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"imap <expr> <CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
augroup NeoCompleteGroup
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
" neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

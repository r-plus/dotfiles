" NeoBundle
set nocompatible
filetype plugin indent off

if has('vim_starting')
    let g:neobundle#types#git#default_protocol = has('gui_win32') ? 'https' : 'git'
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundleLazy 'Shougo/unite.vim', {
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
NeoBundleLazy 'tyru/open-browser.vim', {
\   'autoload' : {
\       'mappings' : ["<Leader>r"]
\   }
\}
NeoBundleLazy 'fkfk/rbpit.vim', {
\   'autoload' : {
\       'filetypes' : ["markdown"]
\   }
\}
NeoBundleLazy 'kana/vim-metarw', {
\   'autoload' : {
\       'filetypes' : ["markdown"]
\   }
\}
NeoBundleLazy 'ujihisa/blogger.vim', {
\   'autoload' : {
\       'filetypes' : ["markdown"]
\   }
\}
NeoBundleLazy 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'r-plus/EnhCommentify.vim'
NeoBundle 'osyo-manga/vim-anzu'

filetype plugin indent on

" -----------------------------------------------------------------------

" display
set number
set ruler
set showcmd
set title
set wildmenu
set wildmode=list:longest,full
" vim-powerline recommended
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
"let g:Powerline_symbols = 'fancy'

" search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

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
" for preserve i-node
set backupcopy=yes

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
set modelines=2
set modeline

" auto set paste, nopaste for C-v from clipboard
"autocmd InsertEnter * set paste
autocmd InsertLeave * set nopaste

" theos
autocmd BufNewFile,BufRead *.h,*.m,*.mm,*.xm,*.x set filetype=objcpp
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

" keymap for theos framework
nnoremap <Space>m :update<CR> :!make; [ $? -eq 0 ] && (make package; make install)<CR>
nnoremap ,v $xo{<CR>%log;<CR>%orig;<CR>}<Esc>
nnoremap ,r $xo{<CR>%log;<CR>return %orig;<CR>}<Esc>

" keymap for window resize
nnoremap <silent> <S-Up>    :5wincmd -<CR>
nnoremap <silent> <S-Down>  :5wincmd +<CR>
nnoremap <silent> <S-Left>  :5wincmd <<CR>
nnoremap <silent> <S-Right> :5wincmd ><CR>

" keymap for tab move
nnoremap <C-TAB> gt
nnoremap <C-S-TAB> gT

" keymap for insert current file name
imap <C-F> <C-R>=expand("%")<CR>

" escape safety
imap <C-@> <C-[>

" snippet
inoreabbrev <expr> dl repeat('/', 80 - col('.'))
inoreabbrev <expr> logc 'id tmp = %orig;<CR>NSLog(@"return = %@", tmp);<CR>NSLog(@"return class = %@", NSStringFromClass([tmp class]));'
inoreabbrev <expr> boolc 'BOOL tmp = %orig;<CR>NSLog(@"return = %@", tmp ? @"YES" : @"NO");<CR>return tmp;'
inoreabbrev <expr> subjcc 'SubjC_set_maximum_depth(0);<CR>SubjC_start();<CR>%orig;<CR>SubjC_end();'

" Save fold settings. Copy from http://vim-users.jp/2009/10/hack84/
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options

" PEP8 indent
autocmd FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" automatically reload .vimrc
autocmd BufWritePost .vimrc source $MYVIMRC

" -----------------------------------------------------------------------
"  Plugins
" -----------------------------------------------------------------------

" vim-anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" vim-ref
nnoremap ,ra :<C-u>Ref alc<Space>
nnoremap ,ro :<C-u>Ref alc<Space><C-r><C-w><CR>
nnoremap <silent> <Space>K :<C-u>call ref#jump('normal', 'alc')<CR>
vnoremap <silent> <Space>K :<C-u>call ref#jump('visual', 'alc')<CR>
let bundle = neobundle#get('vim-ref')
function! bundle.hooks.on_source(bundle)
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
unlet bundle

"" quickrun for theos tweak
let g:quickrun_config = {}
"augroup TheosTweak
"  autocmd!
"  autocmd BufWinEnter,BufNewFile *.xm set filetype=objcpp
"augroup END

" markdown
autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown
let g:quickrun_config['markdown'] = {
            \ 'outputter': 'browser',
            \ 'command': 'pandoc',
            \ 'exec': ['%c -s -f markdown -t html -o %s:p:r.html %s', 'open %s:p:r.html', 'sleep 1', 'rm %s:p:r.html'],
            \ 'tempfile': '{tempname()}.md'
            \ }
" blogger settings saved to pit.
"let g:blogger_blogid = ''
"let g:blogger_email = ''
"let g:blogger_pass = ''
let g:blogger_ruby_path = '/usr/local/bin/ruby'
"let g:blogger_ruby_path = join(split(system('which ruby'), '')[0:-2], "")

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

" error-fix yankring
let g:yankring_manual_clipboard_check = 0

" unite.vim vimproc.vim VimFiler
nnoremap vv :<C-u>VimFilerTab<CR>
nnoremap ff :<C-u>Unite buffer -buffer-name=buf -no-quit<CR>
nnoremap fm :<C-u>Unite file_mru -buffer-name=mru -no-quit<CR>
nnoremap fb :<C-u>Unite bookmark -buffer-name=bookmark<CR>
nnoremap fl :<C-u>Unite line -buffer-name=line -start-insert -no-quit<CR>
nnoremap fg :<C-u>Unite grep -buffer-name=grep -no-quit -auto-preview<CR>
nnoremap fr :<C-u>UniteResume<CR>
let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
    let g:vimfiler_edit_action = 'tabopen'
    autocmd FileType vimfiler call unite#custom_default_action('directory', 'cd')
    autocmd FileType unite call unite#custom_default_action('file', 'tabopen')
    "let g:unite_enable_start_insert = 1
    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('ack-grep')
        " Use ack in unite grep source.
        let g:unite_source_grep_command = 'ack-grep'
        let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
        let g:unite_source_grep_recursive_opt = ''
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
unlet bundle

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

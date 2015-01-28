scriptencoding utf-8
set nocompatible

let file_name = expand("%")
if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  if file_name == ""
    call feedkeys("\<space>n")
  endif
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'git://github.com/groenewege/vim-less.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neomru.vim.git'
NeoBundle 'git://github.com/Shougo/unite-outline'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimproc', { 'build': { 'windows': 'make -f make_mingw32.mak', 'cygwin': 'make -f make_cygwin.mak', 'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak', } }
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/thinca/vim-qfreplace.git'
NeoBundle 'git://github.com/airblade/vim-gitgutter.git'
NeoBundle 'git://github.com/hrsh7th/vim-better-css-indent.git'
NeoBundle 'git://github.com/hrsh7th/vim-versions.git'
NeoBundle 'git://github.com/mhinz/vim-startify.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/w0ng/vim-hybrid.git'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'git://github.com/t9md/vim-quickhl.git'
NeoBundle 'git://github.com/Shougo/neosnippet.git'
NeoBundle 'git://github.com/jason0x43/vim-js-indent.git'

syntax on
filetype plugin on
filetype indent on

" SSH クライアントの設定によってはマウスが使える（putty だと最初からいける）
set mouse=n
set nocompatible
set hlsearch
set number
set backspace=2
set smartcase
set nowrap
set shiftwidth=2
set ic
set hidden
set noswapfile
set nobackup
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set virtualedit=all
set ignorecase
set t_Co=256
set includeexpr=substitute(v:fname,'\(\.\|\\/\)','/','')
set suffixesadd=.php,.js,.rb,.java,.json,.md,.as
set path+=./;/
set splitright
set showtabline=2
set pumheight=30
set incsearch
set cindent


let mapleader = "\<Space>"
nmap <LEADER><LEADER>m <Plug>(quickhl-cword-toggle)
nmap <LEADER>m <Plug>(quickhl-manual-this)
vmap <LEADER>m <Plug>(quickhl-manual-this)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <space>, :<C-u>source $MYVIMRC<cr>
nnoremap <space>n :VimFilerBufferDir -simple -buffer-name=vimfiler -auto-cd -split -no-quit -winwidth=35 -toggle -direction=topleft<CR>
nnoremap <space>. :<C-u>edit $MYVIMRC<cr>
nnoremap q :q<CR>
nnoremap H 15h
nnoremap J 8j
nnoremap K 8k
nnoremap L 15l
nnoremap <silent> ,gg :<C-u>GitGutterToggle<cr>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<cr>
nnoremap <silent> ,uy :<C-u>Unite history/yank<cr>
nnoremap <silent> ,ub :<C-u>Unite buffer<cr>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<cr>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<cr>
nnoremap <silent> ,uo :<C-u>Unite -vertical -winwidth=40 outline<cr>
nnoremap <silent> <space><cr> :<C-u>UniteVersions status:!<cr>
inoremap <C-j> <esc>
nnoremap cir ciw<C-r>0<ESC>:<C-u>let@/=@1<cr>:noh<cr>
nnoremap <silent> ,uc :<C-u>Unite colorscheme -auto-preview<CR>

nnoremap <expr><silent><LEADER><ESC> printf(":\<C-u>%s\<CR>:\<C-u>%s\<CR>:\<C-u>%s\<CR>:\<C-u>%s\<CR>",
      \ 'QuickhlManualReset',
      \ 'QuickhlCwordDisable',
      \ 'nohlsearch',
      \ 'redraw!')

autocmd! InsertLeave * call g:my_insertleave_setting()
function! g:my_insertleave_setting()
  set nopaste
endfunction
set pastetoggle=<F9>

nnoremap : q:
xnoremap : q:

autocmd! CmdwinEnter * call g:my_cmdwinenter_settings()
function! g:my_cmdwinenter_settings()
  nnoremap <buffer><ESC> :<C-u>q<CR>
  imap <expr><TAB> g:my_cursor_move_or_snippet_expand_command()
  startinsert!
endfunction

""""""""
set tabline=%!g:my_tabline()

function! g:my_tabline()
  let s:titles = map(range(1, tabpagenr('$')), 'g:my_tabtitle(v:val)')
  let s:tabpages = join(s:titles, '').  '%#TabLineFill#%T'
  let s:info = ''
  let s:info .= '['
  let s:info .= g:my_unite_project_dir == '' ? 'project_dir not detect' : pathshorten(g:my_unite_project_dir)
  let s:info .= ']'
  return s:tabpages . '%=' . s:info
endfunction

function! g:my_tabtitle(tabnr)
  let s:bufnrs = tabpagebuflist(a:tabnr)
  let s:highlight = a:tabnr is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
  let s:curbufnr = s:bufnrs[tabpagewinnr(a:tabnr) - 1]
  let s:max_length = 30

  let s:fname = a:tabnr . ': ' . fnamemodify(bufname(s:curbufnr), ':t')
  let s:title = ' ' . s:fname . repeat(' ', s:max_length)
  let s:title = strpart(s:title, 0, s:max_length)
  if strlen(s:fname) > s:max_length
    let s:title = strpart(s:title, 0, s:max_length - 4) . '... '
  endif
  return '%' . a:tabnr . 'T' . s:highlight . s:title . '%T%#TabLineFill#'
endfunction
" pairs mapping.
inoremap <expr><CR> g:my_pair_enter()
inoremap <expr><BS> g:my_pair_delete()
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
let g:my_pairs = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'", '<': '>', '>': '<' }
function! g:my_pair_enter()
  if g:my_pair_is_between()
    return "\<CR>\<UP>\<END>\<CR>"
  endif
  return "\<CR>"
endfunction
function! g:my_pair_delete()
  if g:my_pair_is_between()
    return "\<RIGHT>\<BS>\<BS>"
  endif
  return "\<BS>"
endfunction
function! g:my_pair_is_between()
  if exists("g:my_pairs[getline('.')[col('.') - 2]]")
    if getline('.')[col('.') - 1] == g:my_pairs[getline('.')[col('.') - 2]]
      return 1
    endif
  endif
  return 0
endfunction

" move cursor.
imap <expr><TAB> g:my_cursor_move_or_snippet_expand_command()
function! g:my_cursor_move_or_snippet_expand_command()
  if neosnippet#expandable() || neosnippet#jumpable()
    return "\<PLUG>(neosnippet_expand_or_jump)"
  endif
  if getline('.')[0:col('.')-2] =~# '^\(\t\|\s\)*$'
    return "\<TAB>"
  endif
  return "\<RIGHT>"
endfunction

" search cursor_word.
nnoremap <expr>gf<CR> g:my_cursor_word_search_command('open')
nnoremap <expr>gfv g:my_cursor_word_search_command('vsplit')
nnoremap <expr>gfs g:my_cursor_word_search_command('split')
function! g:my_cursor_word_search_command(action)
  let iskeyword = &iskeyword
  setlocal iskeyword +=.-/
  let word = strlen(expand('<cword>')) ? tolower(expand('<cword>')) : ''
  let word = substitute(word, '\.', '/', 'g')
  let word = substitute(word, '\/\+', '\/', 'g')
  let word = substitute(word, '^\/\|\/$', '', 'g')
  let word = substitute(word, '^.*\/', '', 'g')
  execute 'setlocal iskeyword=' . iskeyword
  return printf(":\<C-u>Unite -buffer-name=file_rec/async -immediately -default-action=%s -input=%s file_rec/async:%s\<CR>",
        \ a:action,
        \ word,
        \ (g:my_unite_project_dir != "" ? g:my_unite_project_dir : "!"))
endfunction

"function! g:my_cursor_word_search_command(action)
"  let word = strlen(expand('<cWORD>')) ? tolower(expand('<cWORD>')) : ''
"  let word = substitute(word, '\.', '/', 'g')
"  let word = substitute(word, '^\/\=.\{-}\/', '', 'g')
"  let word = substitute(word, '[^[:alnum:]\/_]', '', 'g')
"  let word = substitute(word, '\/\+', '\/', 'g')
"  echomsg word
"  return printf(":\<C-u>Unite -buffer-name=file_rec/async -input=%s -immediately -default-action=%s file_rec/async:%s\<CR>",
"        \ word,
"        \ a:action,
"        \ (g:my_unite_project_dir != "" ? g:my_unite_project_dir : "!"))
"endfunction

" file_rec
nnoremap <expr><C-p> g:my_project_file_command()
function! g:my_project_file_command()
  return printf(":\<C-u>Unite -buffer-name=buffer_tab-file_rec/async -silent buffer_tab file_rec/async:%s\<CR>",
        \ (g:my_unite_project_dir != "" ? g:my_unite_project_dir : "!"))
endfunction

if neobundle#is_installed('unite.vim')
  let g:my_unite_project_dir = ""
  let g:unite_split_rule = 'botright'

  let s:action = { 'is_selectable' : 1 }
  function! s:action.func(candidates)
    let g:my_unite_project_dir = substitute(a:candidates[0].action__path, '\/$', '', 'g')
    echomsg "changed current project dir: " . g:my_unite_project_dir
    let winnr = bufwinnr(bufnr('%'))
    for bufnr in range(1, bufnr('$'))
      if stridx(fnamemodify(bufname(bufnr), ':p'), fnamemodify(g:my_unite_project_dir, ':p')) == -1
        continue
      endif

      let bufwinnr = bufwinnr(bufnr)

      " remove.
      if bufwinnr == -1 && bufexists(bufnr)
        try
          execute 'bdelete ' . bufnr
        catch
        endtry

        " hidden.
      else
        execute bufwinnr . 'wincmd w'
        setlocal bufhidden=delete nobuflisted
      endif
    endfor
    execute winnr . 'wincmd w'
  endfunction
  call unite#custom_action('file_vimfiler_base', 'my_project_cd', s:action)

  autocmd! Filetype unite call g:my_unite_setting()
  function! g:my_unite_setting()
    nmap <buffer><ESC>       <PLUG>(unite_exit)
    nmap <buffer>:q          <PLUG>(unite_exit)
    nmap <buffer><LEADER>q   <PLUG>(unite_exit)
    nnoremap <buffer><expr>s unite#do_action('split')
    nnoremap <buffer><expr>v unite#do_action('vsplit')
    call unite#custom_source('file_rec/async,file_rec/git,file_rec,grep', 'ignore_pattern', join([
          \ '\(.*\/$\)',
          \ '\.git\/',
          \ '\.svn\/',
          \ '\/\(image\|img\)\/',
          \ '\.sass-cache',
          \ '\.css',
          \ 'locale',
          \ 'q9',
          \ 'Q9',
          \ 'Q9player',
          \ 'tplc',
          \ 'babel',
          \ 'node_modules'
          \], '\|'))

  endfunction
endif

if neobundle#is_installed('vimfiler')
  let g:vimfiler_safe_mode_by_default = 0

  autocmd! Filetype vimfiler call g:my_vimfiler_setting()
  function! g:my_vimfiler_setting()
    nnoremap <buffer>b :Unite -buffer-name=bookmark -default-action=cd -no-start-insert bookmark<CR>
    nmap     <buffer><CR> <plug>(vimfiler_edit_file)
    nnoremap <buffer><F5> :<C-u>call vimfiler#mappings#do_current_dir_action('my_project_cd')<CR>
    nmap     <buffer><C-l> <C-w>l
  endfunction
endif

if neobundle#is_installed('neocomplcache')
  let g:neocomplcache_enable_at_startup = 1
endif

if neobundle#is_installed('vimshell')
  let g:vimshell_popup_command = 'topleft sp | resize 10 | set winfixheight'
  let g:vimshell_split_command = 'tabnew'
endif

colorscheme hybrid


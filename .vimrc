scriptencoding utf-8
set nocompatible

let file_name = expand("%")
if has('vim_starting')
  filetype plugin off
  filetype indent off
  execute 'set runtimepath+=' . expand('~/.vim/bundle/neobundle.vim')
  if file_name == ""
    autocmd VimEnter * NERDTreeToggle ./
  endif
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleLocal expand('~/.vim/bundle.local')
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neomru.vim.git'
NeoBundle 'git://github.com/Shougo/unite-outline'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc', { 'build': { 'windows': 'make -f make_mingw32.mak', 'cygwin': 'make -f make_cygwin.mak', 'mac': 'make -f make_mac.mak', 'unix': 'make -f make_unix.mak', } }
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/airblade/vim-gitgutter.git'
NeoBundle 'git://github.com/hrsh7th/vim-better-css-indent.git'
NeoBundle 'git://github.com/hrsh7th/vim-versions.git'
NeoBundle 'git://github.com/jskywalk/nerdtree_search.git', { 'build': { 'unix': 'cp ./nerdtree_search.vim ../nerdtree/nerdtree_plugin' } }
NeoBundle 'git://github.com/scrooloose/nerdtree.git'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'git://github.com/w0ng/vim-hybrid.git'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'altercation/solarized'
NeoBundle 'vim-scripts/newspaper.vim'
NeoBundle 'nerdtree_change_cwd'

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
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set virtualedit=all
set t_Co=256

nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l
nnoremap <space>, :<C-u>source $MYVIMRC<cr>
nnoremap <space>n :NERDTreeToggle<cr>
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
nnoremap <C-p> :<C-u>UniteWithCurrentDir -input= file_rec/async<cr>
inoremap <C-j> <esc>
nnoremap cir ciw<C-r>0<ESC>:<C-u>let@/=@1<cr>:noh<cr>
nnoremap <silent> ,uc :<C-u>Unite colorscheme -auto-preview<CR>

if neobundle#is_installed('unite.vim')
  let g:unite_split_rule = 'botright'
  autocmd! Filetype unite call g:my_unite_setting()
  function! g:my_unite_setting()
    nnoremap <buffer><expr>s unite#do_action('split')
    nnoremap <buffer><expr>v unite#do_action('vsplit')
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

set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'
set number
set tabstop=4 shiftwidth=4 expandtab

call plug#begin('~/.config/nvim/plugged')

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" ncm2
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'

" Color scheme
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'

Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'kennethzfeng/vim-raml'
" Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'alfredodeza/pytest.vim'
Plug 'fatih/vim-go'
Plug 'cespare/vim-toml'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'w0rp/ale'

" JS/TS/Vue
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template'

" Python
Plug 'zchee/deoplete-jedi'
Plug 'tell-k/vim-autopep8'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


" FZF / Ctrlp for file navigation
if executable('fzf')
  " OSX vs Linux loading (depending on where fzf is)
  let s:uname = system("echo -n \"$(uname)\"")
  if !v:shell_error && s:uname == "Darwin"
    Plug '/usr/local/opt/fzf'
  else
    Plug 'junegunn/fzf', {'dir': '~/.local/src/fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

" Rust Plugins
if executable('rustc')
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  " Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/echodoc.vim'

Plug 'ryanoasis/vim-devicons'
" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on
" colorscheme jellybeans
colorscheme base16-gruvbox-dark-medium
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
syntax on


let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#rust_source_path='/home/peer/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'

" Mappings
let mapleader = ","
nmap <leader>c :nohl<CR>
nmap j gj
nmap k gk
nmap <leader>p "+p
nmap <leader>y "+y
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

set backspace=indent,eol,start
set history=1000
set ruler
set showcmd
set autoindent
set showmatch
set nowrap
" Set .temp dir
set backupdir=~/.tmp
set directory=~/.tmp
set autoread
set wmh=0
set viminfo+=!
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2 " Status line always visible
set relativenumber
set gdefault
set autoindent
set bg=light
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...
set tabstop=4


set tags=./tags;

highlight StatusLine ctermfg=blue ctermbg=yellow


" Remove trailing whitespace on save for py files.
au BufWritePre *.py :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

map <Leader>b :silent !{make display} <cr>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" By default, vim thinks .md is Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" C/C++ Header guard
function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Syntastic configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " show tab number not number of split panes
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme='jellybeans'

let g:rustfmt_autosave = 1
let g:rustfmt_command = 'rustup run stable rustfmt'

" ALE maps
map <Leader>e :ALEDetail<cr>
map <Leader>l :ALELint<cr>
" ALE config
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_executable = 'rls'
let g:ale_rust_rls_toolchain = 'nightly'
let g:ale_rust_rustc_options = '-Z no-codegen'
let g:ale_linters = {
      \'rust': ['rls'],
      \'markdown': ['proselint', 'redpen', 'vale'],
      \'text': ['proselint', 'vale'],
      \}
let g:ale_fixers = {'rust': ['remove_trailing_lines', 'rustfmt', 'trim_whitespaces']}
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_devel = 1 " Use rust debug build
let g:LanguageClient_serverCommands = {
    \ 'rust': ['/home/peer/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }
let g:LanguageClient_autoStart = 1

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" autocmd BufWritePre *.py 0,$!yapf

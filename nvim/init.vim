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
Plug 'rhysd/vim-clang-format'
Plug 'kennethzfeng/vim-raml'
Plug 'tpope/vim-unimpaired'
Plug 'alfredodeza/pytest.vim'
Plug 'fatih/vim-go'
Plug 'hexdigest/gounit-vim'
Plug 'cespare/vim-toml'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'

" JS/TS/Vue
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Quramy/vim-js-pretty-template'

" Python
Plug 'tell-k/vim-autopep8'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'


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
endif
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/echodoc.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'
" Add plugins to &runtimepath
call plug#end()

" lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [
  \       'lineinfo',
  \     ],
  \     [
  \       'dicon',
  \       'fileencoding'
  \     ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'blame': 'LightlineGitBlame',
  \   'dicon': 'LightlineWebDevIcons',
  \   'fugitive': 'LightlineFugitive',
  \ },
  \ 'subseparator': { 'left': '|', 'right': '|' }
\ }

function! LightlineModified()
  return &ft ==# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
        \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft ==# 'unite' ? unite#get_status_string() :
        \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
        \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
        \ (fname !=# '' ? fname : '[No Name]') .
        \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction


function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
      let mark = ''  " edit here for cool mark
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineWebDevIcons() abort
  return &buftype ==# 'terminal' || &filetype =~# 'denite\|tagbar' ? '' :
        \ winwidth(0) > 120 ? (strlen(&filetype) ? (exists('*WebDevIconsGetFileTypeSymbol') ?  WebDevIconsGetFileTypeSymbol() : &filetype) : 'no ft') : ''
endfunction

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

nnoremap <c-space> :Rg<cr>
noremap <leader>s :Rg<cr><c-w>

filetype plugin indent on
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

let g:tex_flavor = 'latex'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#rust_source_path='/home/peer/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'

" Mappings
let mapleader = ","
nmap <leader>c :nohl<CR>
nmap j gj
nmap k gk
nmap <leader>p "+p
nmap <leader>y "+y

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

let g:go_highlight_functions = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1


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

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

inoremap <silent><expr> <c-.> coc#refresh()

nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> <leader>l <Plug>(coc-diagnostic-info)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" allow to scroll in the preview
set mouse=a

" mappings
nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l       :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p       :<C-u>CocFzfListResume<CR>

" Required for operations modifying multiple buffers like rename.
set hidden

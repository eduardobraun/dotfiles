call plug#begin('~/.config/nvim/plugged')

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Color scheme
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'bling/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'rhysd/vim-clang-format'
Plug 'kchmck/vim-coffee-script'
Plug 'kennethzfeng/vim-raml'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'alfredodeza/pytest.vim'

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on
colorscheme jellybeans
syntax on

let g:python_host_prog = '/usr/bin/python2'
let g:loaded_python3_provider = 1

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

" YouCompleteMe configuration
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_server_keep_logfiles = 1

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" EasyTags configuration
:let g:easytags_dynamic_files = 1
:let g:easytags_events = ['BufWritePost']
:let g:easytags_autorecurse = 1
:let g:easytags_include_members = 1

" Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


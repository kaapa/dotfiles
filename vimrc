call pathogen#infect()

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
nmap <leader>d :bd<CR>
nmap <leader>D :bufdo bd<CR>

set background=dark
colorscheme solarized

filetype plugin indent on
let mapleader = ","

set nocompatible

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" indent
set ai " autoindent
set si " smart indent
set smarttab
set autoindent

set formatoptions-=o "dont continue comments when pushing o/O

"hide buffers when not displayed
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Swap and backup files
set noswapfile
set nobackup
set nowb

set statusline=%F%m%r%h%w[%L]%y[%p%%][%04v][%{fugitive#statusline()}]
"              | | | | |  |   |  |      |
"              | | | | |  |   |  |      |
"              | | | | |  |   |  |      |
"              | | | | |  |   |  |      |
"              | | | | |  |   |  |      +-- current column
"              | | | | |  |   |  +-- current % into file
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the rbuffer

" Autodelte trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '\.DS_Store']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" Neocomplcache configuration
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 5
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 

" Syntastic configuration
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_warnings=1

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

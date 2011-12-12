call pathogen#infect()          " initialize plugins in ~/.vim/bundle
call pathogen#helptags()        " build plugins' helptags

let mapleader = ","

nnoremap <C-h> <C-w>h           " move to window left of current window
nnoremap <C-j> <C-w>j           " move to window below current window
nnoremap <C-k> <C-w>k           " move to window above current window
nnoremap <C-l> <C-w>l           " move to window right of current window
nnoremap <Tab> :bn<CR>          " next buffer
nnoremap <S-Tab> :bp<CR>        " previous buffer
vnoremap <Tab> >                " increase indentation in visual mode
vnoremap <S-Tab> <              " decrease indentation in visual mode
nmap <leader>d :bd<CR>          " delete current buffer
nmap <leader>D :bufdo bd<CR>    " delete all buffers
imap jj <ESC>                   " escape

set background=dark
colorscheme solarized

set nocompatible
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set number                      " show line numbers

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set formatoptions-=o "dont continue comments when pushing o/O

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Disable swap and backup files
set noswapfile
set nobackup
set nowb

set statusline=%F\ %y\ %{fugitive#statusline()}\ %m%r%h%w%=[%p%%][%L][%02v]

autocmd BufWritePre * :%s/\s\+$//e      " remove trailing whitespace on save

" Taglist configuration
let tlist_php_settings = 'php;c:class;d:constant;f:function'
let Tlist_GainFocus_On_ToggleOpen = 1   " focus taglist window when openend
let Tlist_Close_On_Select = 1           " close taglist window when a tag is selected
let Tlist_Show_One_File = 1             " don't show tags from other buffers
let Tlist_Exit_OnlyWindow = 1           " exit when taglist is last window
let Tlist_Enable_Fold_Column = 0        " hide foldings
map <Leader>t :TlistToggle<CR>          " toggle taglist window
map <Leader>g <C-]>                     " goto definition under cursor

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '\.DS_Store']
let NERDTreeMinimalUI = 1               " hide bookmarks and help text
let NERDTreeDirArrows = 1               " show arrows instead of + characters for directory folding
let NERDTreeQuitOnOpen = 1              " hide NERDTree when a file is opened
map <Leader>n :NERDTreeToggle<CR>       " toggle NERDTree

" Neocomplcache configuration
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 5
let g:neocomplcache_snippets_dir = '~/.vim/snippets/'
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

" Syntastic configuration
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_warnings=1

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

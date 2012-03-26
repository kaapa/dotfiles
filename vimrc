let mapleader = ","

" Initialize vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Configure bundles to use
Bundle 'altercation/vim-colors-solarized'
Bundle 'jimenezrick/vimerl'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'

Bundle 'mileszs/ack.vim'
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"

Bundle 'scrooloose/nerdcommenter'

Bundle 'scrooloose/nerdtree'
  let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', '\.DS_Store']
  let NERDTreeMinimalUI = 1               " hide bookmarks and help text
  let NERDTreeDirArrows = 1               " show arrows instead of + characters for directory folding
  let NERDTreeQuitOnOpen = 1              " hide NERDTree when a file is opened
  map <Leader>n :NERDTreeToggle<CR>       " toggle NERDTree

Bundle 'scrooloose/syntastic'
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_jump=1
  let g:syntastic_auto_loc_list=1
  let g:syntastic_quiet_warnings=1

Bundle 'Shougo/neocomplcache'
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_min_syntax_length = 5
  let g:neocomplcache_snippets_dir = '~/.vim/snippets/'
  inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/IndexedSearch'

Bundle 'vim-scripts/taglist.vim'
  let tlist_php_settings = 'php;c:class;d:constant;f:function'
  let Tlist_GainFocus_On_ToggleOpen = 1   " focus taglist window when openend
  let Tlist_Close_On_Select = 1           " close taglist window when a tag is selected
  let Tlist_Show_One_File = 1             " don't show tags from other buffers
  let Tlist_Exit_OnlyWindow = 1           " exit when taglist is last window
  let Tlist_Enable_Fold_Column = 0        " hide foldings
  map <Leader>t :TlistToggle<CR>          " toggle taglist window

filetype plugin indent on       " required by vundle

function! g:ToggleNuMode()
  if(&rnu == 1)
    set nu
  else
    set rnu
  endif
endfunc

nnoremap <Leader>r :call g:ToggleNuMode()<cr>

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

au FileType php nnoremap K :! open "http://fi2.php.net/<cword>"<CR><CR>   " Show documentation for word under cursor
au FileType php nnoremap <Leader>gc :Ack --type=php "class <cword>"<CR>   " Goto class definition for word under cursor

set background=dark
colorscheme solarized

syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set number                      " show line numbers
set hidden                      " don't unload buffer when abandoned
                                " - preserves undo stack through :w
                                " - allows to hide a modified buffer

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

set formatoptions-=o            " don't continue comments when pushing o/O

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

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

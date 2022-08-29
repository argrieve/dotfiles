"================
" Vundle/Plugins
"================
" Vundle Install:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Launch vim and run :PluginInstall
"
" Begin Vundle
set nocompatible                  " Use Vim rather than vi settings (required)
filetype off                      " Temporarily turn off file types (required)
set rtp+=~/.vim/bundle/Vundle.vim " Add Vundle to runtime path (required)
call vundle#begin()               " Initialize Vundle (required)
Plugin 'VundleVim/Vundle.vim'     " Let Vundle manage itself (required)

" Themes/Appearance
Plugin 'altercation/vim-colors-solarized' " Set terminal palette to solarized
Plugin 'vim-airline/vim-airline'          " Fancy status bar:
Plugin 'vim-airline/vim-airline-themes'   " Requires Powerline fonts (see below)

" Git Integration
"Plugin 'tpope/vim-fugitive'
"Plugin 'airblade/vim-gitgutter' " c+[ and c+] to move between chunks

" Syntax/Auto Completion
"Plugin 'scrooloose/syntastic'   " Syntax checking
"Plugin 'ervandew/supertab'      " Tab completion
"Plugin 'rip-rip/clang_complete' " C/C++ completion, requires python2+clang (see below)
"Plugin 'sirver/ultisnips'       " Snippets engine
"Plugin 'honza/vim-snippets'     " Collection of snippets

" File/Directory Enhancements
"Plugin 'majutsushi/tagbar'      " Requires ctags (see below)
Plugin 'ctrlpvim/ctrlp.vim'     " Fuzzy file searching
"Plugin 'scrooloose/nerdtree'    " Project tree sidebar

" Misc Functionality
"Plugin 'vim-scripts/a.vim'            " Switch between .h/.cpp files
"Plugin 'scrooloose/nerdcommenter'     " Auto commenting
"Plugin 'terryma/vim-multiple-cursors' " Select multiple words, nice for refactoring

call vundle#end()                 " Vundle cleanup (required)
filetype plugin indent on         " Re-enable file types (required)
" End Vundle

"============
" Appearance
"============
syntax enable                    " Turn on syntax highlighting
set background=dark              " Use dark solarized theme
if !has('gui_running')           " Different settings needed in vim terminal mode
  let g:solarized_termcolors=256 " Tell Solarized to degrade to 256 color mode
  se t_Co=256
endif
colorscheme solarized
if has('gui_running')
  "set guioptions-=m   "remove menu bar
  set guioptions-=T   "remove toolbar
  set guioptions-=r   "remove right-hand scroll bar
  set guioptions-=L   "remove left-hand scroll bar
  set guioptions-=e   "use console vim style tabs
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
endif

"==================
" Sanity/Defensive 
"==================
set encoding=utf-8              " Standard encoding
set backspace=indent,eol,start  " Allow backspace in insert mode
set autoread                    " Reload files changed outside of vim
set hidden                      " Buffers can exist in the background
set history=1000                " Store lots of command history (it's not 1990)

"=========
" General
"=========
set number        " Enable line numbers on the left side
set ruler         " Enable ruler in bottom right corner
set visualbell    " Turn off beeping
set noerrorbells  " Turn off beeping
set splitright    " Opens vertical split right of current window
set splitbelow    " Opens horizontal split below current window

"=======
" Mouse
"=======
set mouse=n         " Enable mouse in normal mode (for resizing splits)
"set mouse=a         " Enable full mouse support
set ttymouse=xterm2 " Set to name of terminal for mouse code support
"set ttyfast         " Send more characters for redraws (disable on slow machines)

"========
" Search
"========
set incsearch     " Find the next match as we type the search 
set hlsearch      " Highlight all search pattern matches
set ignorecase    " Ignore case when searching

"=============
" Indentation
"=============
set expandtab     " Pressing the Tab key will insert spaces
set tabstop=3     " Number of spaces a Tab character in a file counts for
set softtabstop=3 " Number of spaces to insert when Tab key is pressed
set shiftwidth=3  " Size of an 'indent' - used by > and < commands
set autoindent    " Copy indent from current line when starting a new line
set smartindent   " Intelligently indent new lines based on { and } characters

"=========
" Folding
"=========
set nofoldenable      " Don't fold by default
set foldmethod=syntax " Fold based on syntax or indent
set foldnestmax=3     " Set the max nesting of folds for 'syntax' and 'indent'

"================
" Tab Completion
"================
set wildmode=longest,list      " bash style tab completion
"set wildmode=longest:list,full " bash style + open wildmenu on second tab
"set wildmenu                   " ctrl+n and ctrl+p to scroll through options
set wildignore=*.o,*.obj,*~    " Files to ignore when tab completing

"=================
" Custom Commands
"=================
" Reload.vimrc, <leader> = '\' by default
map <leader>r :source ~/.vimrc<CR>

" Clear search register, stops Vim highlighting when sourcing .vimrc
let @/=''

" ; is now :, saves a keystroke for commands
nnoremap ; :

" Auto insertion of brackets
inoremap {<CR> {<CR>}<C-o>O

" jk exits to normal mode, handy for clang_complete
inoremap jk <Esc>

" Movement between splits - uses ctrl+j/k/l/h
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Movement between tabs - uses shift+j/k/l/h
"nnoremap <S-J> :tabclose<CR>
"nnoremap <S-K> :tabnew 
"nnoremap <S-L> :tabnext<CR>
"nnoremap <S-H> :tabprevious<CR>

" Movement between buffers - uses shift+j/k/l/h
nnoremap <S-J> :bp <BAR> bd #<CR>
nnoremap <S-K> :e
nnoremap <S-L> :bnext<CR>
nnoremap <S-H> :bprevious<CR>

" Faster file writing/closing
"nnoremap <leader>w :w<CR>
"nnoremap <leader>q :q<CR>
"nnoremap <leader>a :q!<CR>
"nnoremap <leader>wq :wq<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>q :q!<CR>

" Open Quickfix window automatically after running :make
augroup OpenQuickfixWindowAfterMake
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
augroup END

"======================
" Plugin Configuration
"======================

" Airline Settings
"------------------
" Powerline fonts install:
"   git clone https://github.com/powerline/fonts
"   cd fonts && ./install.sh
"   Change terminal font to use powerline (e.g. Ubuntu Mono Powerline)
set laststatus=2                " Always show status line
let g:airline_powerline_fonts=1 " User Powerline fonts (looks nice)
"let g:airline_symbols_ascii=1
let g:airline_theme='solarized' " Matches with vim-colors-solarized
let g:airline#extensions#tabline#enable=1      " Show all open buffers
let g:airline#extensions#tabline#fnamemod=':t' " Show just the filename

" Syntastic Settings
"--------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list=1 " Stick sytax errors in location list
let g:syntastic_auto_loc_list=1            " Open/close error window automatically
let g:syntastic_check_on_open=1            " Syntax check file when opened
let g:syntastic_check_on_wq=0              " Do not syntax check on :wq
" Set compiler to use for specific file types:
let g:syntastic_c_checkers=['gcc']
let g:syntastic_c_compiler='gcc'
let g:syntastic_c_compiler_options=''
let g:syntastic_cpp_checkers=['gcc']
let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++11'
let g:syntastic_cpp_check_header=1 " check C/C++ header files too

" SuperTab Settings
"-------------------
let g:SuperTabDefaultCompletionType='context' " Use context aware completion

" Clang_Complete Settings
"-------------------------
" Ubuntu 16.04 install:
"   sudo apt-get purge vim-*
"   sudo apt-get install vim-nox-py2 libclang-dev
let g:clang_library_path='/usr/lib/llvm-3.8/lib' " Path to libclang.so (required)
set pumheight=10                     " Limit popup menu height
set completeopt=menu,menuone,longest " Disable preview scratch window
set conceallevel=2                   " Hide special characters when inserting function parameters
set concealcursor=vin                " Modes to conceal/hide special characters
"let g:clang_complete_auto=0    " Disable auto popup
"let g:clang_complete_copen=1   " Show clang errors in the quickfix window
let g:clang_snippets=1         " Inserts function parameters at completion
let g:clang_conceal_snippets=1 " Hide special characters surrounding function parameters
let g:clang_snippets_engine='clang_complete'
let g:clang_user_options='-std=c++11'

" UltiSnips Settings
"--------------------
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" Tagbar Settings
"-----------------
" Requires ctags: 
"   sudo apt-get install exuberant-ctags
" \t to open/close Tagbar
noremap <leader>t :TagbarToggle<CR>
" Auto open Tagbar with supported file types
"autocmd VimEnter * nested :call tagbar#autoopen(1)
" Open Tagbar in new tabs
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" NERDTree Settings
"-------------------
noremap <leader>e :NERDTreeToggle<CR>
" Open NERDTree automatically when Vim starts up
"autocmd vimenter * NERDTree
" Close Vim if NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDCommenter Settings
"------------------------
"let g:NERDSpaceDelims=1       " Place a space after comment delimiter
"let g:NERDCommentEmptyLines=1 " Comment out empty lines
let g:NERDDefaultAlign='left'  " Align slashes along left side
let g:NERDAltDelims_h=1        " Enable '//' for single-line comments
let g:NERDAltDelims_c=1        " Enable '//' for single-line comments
let g:NERDAltDelims_cpp=1      " Enable '//' for single-line comments
" Toggle comments with //
nmap // <leader>c<space>
vmap // <leader>cs

" Multiple Cursor Settings
"--------------------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

set nocompatible                       " Not compatible with Vi, needed for Vundle
filetype off                           " Must be off when starting Vundle
syntax on                              " Turn syntax highlighting on
set shell=/bin/sh                      " Set default shell

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'             " Package manager
Plugin 'Yggdroot/indentLine'           " Shows vertical indent lines
Plugin 'tpope/vim-fugitive'            " Git integration in the vim statusline
Plugin 'tpope/vim-markdown'            " Markdown highlighting for vim
Plugin 'scrooloose/nerdtree'           " Nerdtree sidebar
Plugin 'scrooloose/nerdcommenter'      " Easier commenting of code
Plugin 'scrooloose/syntastic'          " Syntax help in the sidebar and statusline
Plugin 'mileszs/ack.vim'               " Ack functionality in vim
Plugin 'zhaocai/GoldenView.Vim'        " Window manager
Plugin 'mikewest/vimroom'              " Distraction free writing


call vundle#end()
filetype plugin indent on              " Turn filetype on again

"""""""""""""""""""""""""""
" Key mappings
"""""""""""""""""""""""""""
nnoremap <C-n> :NERDTreeToggle<CR>
inoremap jj <Esc>                      
nnoremap ; :
nmap <silent> ,/ :nohlsearch<CR>
nnoremap <leader>a :Ack                
"nnoremap <leader>mb :call Processdoc()<CR>
nnoremap <C-b> :call Processdoc()<CR>
map <F5> <ESC>:! pdflatex %<CR>

" Easy window navigation
map <C-h> <C-w>h                       " Move to window left
map <C-j> <C-w>j                       " Move to window below
map <C-k> <C-w>k                       " Move to window above
map <C-l> <C-w>l                       " Move to window right

nnoremap <Leader>vr :VimroomToggle<CR> " Toggle distraction free writing mode

"""""""""""""""""""""""""""
" Leader settings
"""""""""""""""""""""""""""
let mapleader = ","
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>       " Strip all trailing whitespace from file

"""""""""""""""""""""""""""
" Editor settings
"""""""""""""""""""""""""""
set autochdir                          " Sets working directory to current file location
set wildmenu                           " Command line completion
set suffixes=.c,.java,.tex,.py,.txt,.in,.out,.h,.vim,.pl,.hs,.rb,.cpp,.cs   " Pay attention to these file types
set wildignore=.log,*.aux,*.log,*.o,*.class                                 " Ignore these file types
set ruler                              " Shows column, row, and % document left
set noshowmode
set laststatus=2                       " Make the statusline always visible
set nowrap                             " Editor doesn't wrap lines
set textwidth=0
set backspace=indent,eol,start         " Make backspace behave as it should
set hidden                             " A buffer becomes hidden when it is abandoned
set smartcase
set showcmd
set foldenable
set foldmethod=marker
set autoindent                         " Auto indent lines accordingly
set copyindent
set shiftround
set showmatch
set noerrorbells visualbell t_vb=      " Disable visual bells and audio bells when hit EOF
set cursorline                         " Highlight the line the cursor is on
set encoding=utf-8                     " UTF8 encoding
set number                             " Show line numbers
set scrolloff=7                        " Leave 7 lines of buffer when scrolling up or down
set hlsearch                           " Highlight search results
set guifont=Inconsolata\ for\ Powerline:h13       " Font
set smartindent                        " Indent smartly...
set tabstop=4                          " Set how many spaces the tab key produces
set shiftwidth=4                       " Indenting a line with >> or << will indent and un-indent by 4
set softtabstop=4                      " Pressing tab in insert mode will use 4 spaces
set undolevels=1000                    " More undos
set expandtab
set incsearch                          " Highlight searches as you type them
set t_Co=256                           " Set terminal colors to 256
set noswapfile                         " Disable the creation of a swap file (.swp) when editing in vim
set colorcolumn=81                     " Colors the 81st column as width guide
set pastetoggle=<F2>                   " Paste into vim with F2 and keep indentations correct
"set relativenumber                     " Displays how far each line is away from the current one
"set undofile                           " Creates a .un~ file that saves undo changes
set gdefault                           " Globally substitutes as default

"""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""
set background=dark
colorscheme jellybeans


"""""""""""""""""""""""""""
" Vim Airline
"""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols = get(g:, 'airline_symbols', {})
let g:airline_theme = 'powerlineish'
let g:airline_symbols.space = "\ua0"

"""""""""""""""""""""""""""
" LaTeX settings
"""""""""""""""""""""""""""
let g:tex_flavor='latex'
autocmd Filetype tex setlocal makeprg=pdflatex\ --shell-escape\ '%'   " Dunno if this works

"""""""""""""""""""""""""""
" Markdown settings
"""""""""""""""""""""""""""
autocmd FileType markdown setlocal makeprg=pandoc\ --shell-escape\ '-o % %<.pdf'
"""""""""""""""""""""""""""
" GVIM settings
"""""""""""""""""""""""""""
if has("gui_running")
    set lines=999 columns=999
    let g:airline_theme = 'understated'
    set background=light
    colorscheme solarized
else
    " settings for Terminal
    let g:airline_left_sep          = '⮀'
    let g:airline_left_alt_sep      = '⮁'
    let g:airline_right_sep         = '⮂'
    let g:airline_right_alt_sep     = '⮃'
    let g:airline_branch_prefix     = '⭠'
    let g:airline_readonly_symbol   = '⭤'
    let g:airline_linecolumn_prefix = '⭡'
endif


""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""
function Processdoc()      " Doesn't work yet........
    echom "processing..."
    execute "pandoc -o %.pdf %"
    echom "done!"
endfunction

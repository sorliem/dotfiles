"""""""""""""""""""""""""""""""""""""""
" VIM-PLUG
"""""""""""""""""""""""""""""""""""""""
set path+=**

let g:plug_url_format='git@github.com:%s.git'
" let g:polyglot_disabled = ['elixir']

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
  let $FZF_DEFAULT_COMMAND="rg --files --hidden --color=ansi"

Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'jremmen/vim-ripgrep'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'

Plug 'scrooloose/nerdtree'
  let NERDTreeShowHidden=1
  let g:NERDTreeHijackNetrw=0

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'jpalardy/vim-slime', { 'branch': 'main' }
  if exists('$TMUX')
      let g:slime_target = "tmux"
      let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": "3"}
      let g:slime_dont_ask_default = 1
  endif

Plug 'vimwiki/vimwiki'
" Plug 'mhinz/vim-startify'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'dyng/ctrlsf.vim'
Plug 'cespare/vim-toml'
Plug 'udalov/kotlin-vim'
Plug 'szw/vim-maximizer'
Plug 'NLKNguyen/papercolor-theme'
Plug 'flazz/vim-colorschemes'
Plug 'tjdevries/colorbuddy.vim'

" Tim Pope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'


Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/git-worktree.nvim'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" LSP stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
" Plug 'simrat39/symbols-outline.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'j-hui/fidget.nvim'

" Snippets
Plug 'L3MON4D3/LuaSnip'
  let g:snippets = "luasnip"
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" BASIC CONFIGURATION
"""""""""""""""""""""""""""""""""""""""
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
set nowrap
set smartcase
set nobackup
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↵
set relativenumber
set ruler
set hidden               " hide the buffer if not saved instead of unloading it
set laststatus=2         " always show the status bar
set incsearch            " highlight while I search
set hlsearch             " highlight search results
set ignorecase
set undolevels=500       " a lot of undos
set noswapfile           " no .swp file
" set t_Co=256             " 256 terminal colors
set showcmd              " show command in status bar
set wildmenu             " graphical menu for tab completion
set showmatch
set ttimeoutlen=50
set nofoldenable         " dont fold code blocks
set splitright
set splitbelow
set mouse=a              " use mouse to adjust vim splits
set synmaxcol=210        " dont do syntax highlighting after this column
set spelllang=en_us      " set spelling language
set scrolloff=0
set cursorline
set cursorcolumn
set colorcolumn=80
set runtimepath^=~/.vim runtimepath+=~/.vim/after
set completeopt=menu,menuone,noselect
set guicursor=i:block
set backupdir=~/.vim/backups

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

highlight ColorColumn ctermbg=0 guibg=darkgrey
highlight CursorLine ctermbg=Black


let g:gruvbox_invert_selection='0'

" set background=light
" colorscheme PaperColor

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox

" let g:gruvbox_contrast_light="hard"
" set background=light
" colorscheme gruvbox

" let g:solarized_termcolors=256
" set background=dark
" colorscheme solarized

" let g:solarized_termcolors=256
" set background=light
" colorscheme solarized
"
" let g:rustfmt_autosave = 1

highlight Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""

" set mapleader to comma
let mapleader = ","

" swap colon and semicolon
nnoremap ; :
nnoremap : ;

" make Y behave like other captial letters
nnoremap Y y$

" keeping it centered when jumping around, joining lines
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ'z

" better undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" jumplist muations. Add to jumplist when jumping more than 5 lines
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" better indentation, keeps block highlighted
vnoremap < <gv
vnoremap > >gv

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever (per the primagen)
" in visual mode, paste what is in the default register
" without overwriting the default register with what was
" just erased
vnoremap <leader>p "_dP

" reload init.vim
nnoremap <leader>rv :so $MYVIMRC<CR>

" delete buffer
nnoremap <leader>d :bd<CR>

" fzf starting at home dir
nnoremap <silent> <leader>F :FZF ~<cr>

" rg in current dir
nnoremap <leader>f :R<CR>
" nnoremap <leader>f :lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>

" toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>

" paste from clipboard
nnoremap <leader>P "+p<CR>

" copy to clipboard
vnoremap <leader>c "+y<CR>

" reload all buffers from disk
nnoremap <leader>br :bufdo e!<CR>

" load worktree list
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>

" Fugitive status
nnoremap <silent> <Leader>gs :Git<CR>

" Fugitive blame
nnoremap <silent> <Leader>gb :Git blame<CR>

" Fugitive diff master
nnoremap <silent> <Leader>gd :Git diff master..HEAD<CR>:only<CR>

nnoremap <Leader>gl1 :read !git log -n 1<CR>?commit<CR>d3j

" toggle NERDTree
" nnoremap <Leader>nt :NERDTreeToggle<Enter>
nnoremap <Leader>nt :Hexplore!<Enter>
nnoremap <Leader>e :Hexplore!<Enter>


" find current file in tree
" nnoremap <silent> <Leader>nf :NERDTreeFind<CR>
" command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n
nnoremap <Leader>nf :let @/=expand("%:t") <Bar> execute 'Hexplore!' expand("%:h") <Bar> normal n<CR>

" save and exec file
nnoremap <Leader>x :call miles#save_and_exec()<CR>

" update daily/staging
nnoremap <Leader>cd :call miles#update_daily()<CR>

" update production
nnoremap <Leader>cp :call miles#update_production()<CR>

" run test file
nnoremap <Leader>rt :call RunElixirTest()<CR>

" run all tests
nnoremap <Leader>tt :call RunAllTests()<CR>

" run formatting
nnoremap <Leader>rf :call miles#run_formatter()<CR>

" get rid of highlighting
nnoremap <leader>hh :noh<CR>

" search over lines in buffer
nnoremap // :BLines<CR>
" nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

" search for word under cursor with, sublime text 2 style
nmap     <C-F>f <Plug>CtrlSFPrompt

" search for word under cursor with, sublime text 2 style
nmap     <C-F>w <Plug>CtrlSFCwordPath<CR>

" toggle the CtrlSF search results window
nnoremap <C-F>t :CtrlSFToggle<CR>

nnoremap <leader>gt :GoTest<CR>

" vim-bujo mappings
nmap <C-S> <Plug>BujoAddnormal
imap <C-S> <Plug>BujoAddinsert

nmap <C-Q> <Plug>BujoChecknormal
imap <C-Q> <Plug>BujoCheckinsert

"""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
"""""""""""""""""""""""""""""""""""""""
if executable('rg')
	let g:rg_derive_root='true'
endif

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" vim & tmux navigation
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

if exists('$TMUX')
    function! RunElixirTest()
        let cmd = "tmux send-keys -t xgps:xgps-2.3 'dtest " . expand('%:') . "' C-m"
        echo "Running test " . expand('%:')
        call system(cmd)
    endfunction

    function! RunAllTests()
        let cmd = "tmux send-keys -t xgps:xgps-2.3 'dtest' C-m"
        echo "Running all tests"
        call system(cmd)
    endfunction
endif

if has("persistent_undo")
    " set undodir=$HOME."/.undodir"
    let &undodir=$HOME."/.undodir"
    set undofile
endif

if executable('rg')
   command! -bang -nargs=* R
     \ call fzf#vim#grep(
     \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
     \   fzf#vim#with_preview(), <bang>0)
endif


" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

"""""""""""""""""""""""""""""""""""""""
" LUA
"""""""""""""""""""""""""""""""""""""""

" load lua files
lua require("miles")

"""""""""""""""""""""""""""""""""""""""
" VARIABLES
"""""""""""""""""""""""""""""""""""""""

let g:startify_lists = [
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:startify_change_to_dir = 0

"""""""""""""""""""""""""""""""""""""""
" AUTOCMD
"""""""""""""""""""""""""""""""""""""""

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" only have cursorline set on active window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

augroup miles_highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=250}
augroup END

augroup miles_elixir
    autocmd!
    autocmd BufNewFile,BufRead *.ex,*.exs set syntax=elixir
    autocmd BufNewFile,BufRead *.eex set syntax=eelixir
augroup END

augroup miles_git
  autocmd!
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
augroup END

augroup miles_markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal spell
augroup END

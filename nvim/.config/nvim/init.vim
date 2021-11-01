"""""""""""""""""""""""""""""""""""""""
" VIM-PLUG
"""""""""""""""""""""""""""""""""""""""
let g:plug_url_format='git@github.com:%s.git'

call plug#begin()

" junegunn
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

  let $FZF_DEFAULT_COMMAND="rg --files --hidden --color=ansi"

Plug 'junegunn/vim-peekaboo'
Plug 'elixir-editors/vim-elixir'
Plug 'stsewd/fzf-checkout.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'gruvbox-community/gruvbox'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
  " to truncate all path sections but the last one, e.g. a branch
  " 'foo/bar/baz' becomes 'f/b/baz', use
  let g:airline#extensions#branch#format = 2

Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'editorconfig/editorconfig-vim'
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'jpalardy/vim-slime', { 'branch': 'main' }
  if exists('$TMUX')
      let g:slime_target = "tmux"
      let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": "3"}
      let g:slime_dont_ask_default = 1
  endif

Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 500

Plug 'dyng/ctrlsf.vim'
Plug 'cespare/vim-toml'
Plug 'udalov/kotlin-vim'
Plug 'szw/vim-maximizer'
Plug 'NLKNguyen/papercolor-theme'
Plug 'flazz/vim-colorschemes'

" Tim Pope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

  " Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make', 'branch': 'main' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

filetype plugin indent on

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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set relativenumber
set ruler
set hidden               " hide the buffer if not saved instead of unloading it
set laststatus=2         " always show the status bar
set incsearch            " highlight while I search
set hlsearch             " highlight search results
set ignorecase
set undolevels=500       " a lot of undos
set noswapfile           " no .swp file
set t_Co=256             " 256 terminal colors
set showcmd              " show command in status bar
set wildmenu             " graphical menu for tab completion
set showmatch
set ttyfast
set ttimeoutlen=50
"set paste                " paste properly
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

highlight ColorColumn ctermbg=0 guibg=darkgrey
highlight CursorLine ctermbg=Black

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

" colorscheme PaperColor
" set background=light

colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'soft'

" colorscheme gruvbox
" set background=light
" let g:gruvbox_contrast_light="hard"


" syntax enable
" set background=dark
" colorscheme solarized
" let g:solarized_termcolors=256

" make gruvbox light look correct
if (has("termguicolors"))
  set termguicolors
endif
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

" use tabs to move through buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

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

" greatest remap ever (per the primagen)
" in visual mode, paste what is in the default register
" without overwriting the default register with what was
" just erased
vnoremap <leader>p "_dP

" shortcut to edit init.vim
nnoremap <leader>ev :edit $MYVIMRC<CR>

" reload init.vim
nnoremap <leader>rv :so $MYVIMRC<CR>

" shortcut to edit .alacritty.yml
nnoremap <leader>ea :edit ~/.config/alacritty/alacritty.yml<CR>

" delete buffer
nnoremap <leader>d :bd<CR>

" fzf starting at home dir
nnoremap <silent> <leader>F :FZF ~<cr>

" rg in current dir
nnoremap <leader>f :R<CR>

" toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>

" paste from clipboard
nnoremap <leader>P "+p<CR>

" copy to clipboard
vnoremap <leader>c "+y<CR>

" reload all buffers from disk
nnoremap <leader>br :bufdo e!<CR>

" search for strings in all buffers
nnoremap <leader>l :Lines<CR>

" " search for strings in all current buffer
" nnoremap <leader>bl :BLines<CR>

" Fugitive status
nnoremap <silent> <Leader>gs :Git<CR>

" Fugitive blame
nnoremap <silent> <Leader>gb :Git blame<CR>

" toggle NERDTree
nnoremap <Leader>nt :NERDTreeToggle<Enter>

" find current file in tree
nnoremap <silent> <Leader>nf :NERDTreeFind<CR>

" get rid of highlighting
nnoremap <leader>hh :noh<CR>

" search for word under cursor with, sublime text 2 style
nmap     <C-F>f <Plug>CtrlSFPrompt

" search for word under cursor with, sublime text 2 style
nmap     <C-F>w <Plug>CtrlSFCwordPath<CR>

" toggle the CtrlSF search results window
nnoremap <C-F>t :CtrlSFToggle<CR>

"""""""""""""""""""""""""""""""""""""""
" SNIPPETS
"""""""""""""""""""""""""""""""""""""""
nnoremap \ins :-1read $HOME/.vim/.snippets/io-inspect.snippet<CR>V=^4ei
inoremap \ins <esc><CR>:-1read $HOME/.vim/.snippets/io-inspect.snippet<CR>V=^4ei

" print IO.puts("")
nnoremap \iop :-1read $HOME/.vim/.snippets/io-puts.snippet<CR>^f"a

" module definition
nnoremap \mod :-1read $HOME/.vim/.snippets/defmodule.snippet<CR>^whi

" function definition
nnoremap \def :-1read $HOME/.vim/.snippets/def.snippet<CR>^whi

" generic GenServer module
nnoremap \genserver :-1read $HOME/.vim/.snippets/genserver.snippet<CR>^whi

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

if has("persistent_undo")
    " set undodir=$HOME."/.undodir"
    let &undodir=$HOME."/.undodir"
    set undofile
endif

" ripgrep
if executable('rg')
   command! -bang -nargs=* R
     \ call fzf#vim#grep(
     \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
     \   fzf#vim#with_preview(), <bang>0)
endif


" Files + devicons
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="ansi-dark" --style=numbers,changes,header,grid --color always {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

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
" VARIABLES
"""""""""""""""""""""""""""""""""""""""

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" load lua files
lua require("miles")


function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

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

" only have cursorline set on active window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

autocmd BufWritePre * :call TrimWhitespace()

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 30)
augroup END

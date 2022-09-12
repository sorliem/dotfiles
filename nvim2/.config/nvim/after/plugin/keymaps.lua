local Remap = require("miles.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- swap colon and semicolon
nnoremap(";", ":")
nnoremap(":", ";")

-- make Y behave like other captial letters
nnoremap("Y", "y$")

-- keeping it centered when jumping around, joining lines
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ'z")

-- better undo break points
inoremap(",", ",<c-g>u")
inoremap(".", ".<c-g>u")
inoremap("!", "!<c-g>u")
inoremap("?", "?<c-g>u")

-- jumplist muations. Add to jumplist when jumping more than 5 lines
-- not sure if this <expr> is in right place
nnoremap("<expr> k", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'")
nnoremap("<expr> j", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'")

-- better indentation, keeps block highlighted
vnoremap("<", "<gv")
vnoremap(">", ">gv")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- do search and replace using the word under cursor
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")

-- greatest remap ever (per the primagen)
-- in visual mode, paste what is in the default register
-- without overwriting the default register with what was
-- just erased
vnoremap("<leader>p", "\"_dP")
xnoremap("<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

-- reload init.vim
nnoremap("<leader>rv", ":so $MYVIMRC<CR>")

-- delete buffer
nnoremap("<leader>d", ":bd<CR>")

-- fzf starting at home dir
nnoremap("<leader>F", ":FZF ~<CR>")

-- rg in current dir
nnoremap("<leader>ps", ":R<CR>")
-- nnoremap <leader>f :lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>

-- toggle undotree
nnoremap("<leader>u", ":UndotreeToggle<CR>")

-- paste from clipboard
nnoremap("<leader>P", "\"+p<CR>")

-- copy to clipboard
vnoremap("<leader>c", "\"+y<CR>")

-- reload all buffers from disk
nnoremap("<leader>br", ":bufdo e!<CR>")

-- git worktrees
nnoremap("<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
nnoremap("<leader>gaw", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")

-- Fugitive status
nnoremap("<Leader>gs", ":Git<CR>", {noremap = true, silent = true})

-- Fugitive blame
nnoremap("<Leader>gb", ":Git blame<CR>", {noremap = true, silent = true})

-- Fugitive diff master
nnoremap("<Leader>gd", ":Git diff master..HEAD<CR>:only<CR>", {noremap = true, silent = true})

-- Grab last commit messge
nnoremap("<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j")

-- Grab current line as _permanent_ github link
nnoremap("<leader>ghl", ":0GBrowse!<CR>")

-- Grab current selection as _permanent_ github link
vnoremap("<leader>ghl", ":GBrowse!<CR>")

-- toggle netrw
nnoremap("<Leader>nt", ":Hexplore!<Enter>")
nnoremap("<Leader>pv", ":Hexplore!<Enter>")
nnoremap("<Leader>e", ":Hexplore!<Enter>")

-- find current file in tree
-- nnoremap <silent> <Leader>nf :NERDTreeFind<CR>
-- command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n
nnoremap("<Leader>nf", ":let @/=expand(\"%:\t\") <Bar> execute 'Hexplore!' expand(\"%:h\") <Bar> normal n<CR>")

-- save and exec file
nnoremap("<Leader>x", ":call SaveAndExec()<CR>")

-- run test file
nnoremap("<Leader>rt", ":call RunElixirTest()<CR>")

-- run all tests
nnoremap("<Leader>tt", ":call RunAllTests()<CR>")

-- run formatting
nnoremap("<Leader>rf", ":call RunFormatter()<CR>")

-- get rid of highlighting
nnoremap("<leader>hh", ":noh<CR>")

-- search over lines in buffer
nnoremap("//", ":BLines<CR>")
-- nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

-- search for word under cursor with, sublime text 2 style
nmap("<C-F>f", "<Plug>CtrlSFPrompt")

-- search for word under cursor with, sublime text 2 style
nmap("<C-F>w", "<Plug>CtrlSFCwordPath<CR>")

-- toggle the CtrlSF search results window
nnoremap("<C-F>t", ":CtrlSFToggle<CR>")

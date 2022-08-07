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

-- greatest remap ever (per the primagen)
-- in visual mode, paste what is in the default register
-- without overwriting the default register with what was
-- just erased
vnoremap("<leader>p", "\"_dP")

-- reload init.vim
nnoremap("<leader>rv", ":so $MYVIMRC<CR>")

-- delete buffer
nnoremap("<leader>d", ":bd<CR>")

-- fzf starting at home dir
nnoremap("<silent>", "<leader>F :FZF ~<cr>")

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

-- load worktree list
nnoremap("<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")

-- Fugitive status
nnoremap("<silent>", "<Leader>gs :Git<CR>")

-- Fugitive blame
nnoremap("<silent>", "<Leader>gb :Git blame<CR>")

-- Fugitive diff master
nnoremap("<silent>", "<Leader>gd :Git diff master..HEAD<CR>:only<CR>")

-- Grab last commit messge
nnoremap("<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j")

-- Grab current line as _permanent_ github link
nnoremap("<leader>ghl", ":0GBrowse!<CR>")

-- Grab current selection as _permanent_ github link
vnoremap("<leader>ghl", ":GBrowse!<CR>")

-- toggle NERDTree
-- nnoremap <Leader>nt :NERDTreeToggle<Enter>
nnoremap("<Leader>nt", ":Hexplore!<Enter>")
nnoremap("<Leader>e", ":Hexplore!<Enter>")


-- find current file in tree
-- nnoremap <silent> <Leader>nf :NERDTreeFind<CR>
-- command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n
nnoremap("<Leader>nf", ":let @/=expand(\"%:\t\") <Bar> execute 'Hexplore!' expand(\"%:h\") <Bar> normal n<CR>")

-- save and exec file
nnoremap("<Leader>x", ":call miles#save_and_exec()<CR>")

-- update daily/staging
nnoremap("<Leader>cd", ":call miles#update_daily()<CR>")

-- update production
nnoremap("<Leader>cp", ":call miles#update_production()<CR>")

-- run test file
nnoremap("<Leader>rt", ":call RunElixirTest()<CR>")

-- run all tests
nnoremap("<Leader>tt", ":call RunAllTests()<CR>")

-- run formatting
nnoremap("<Leader>rf", ":call miles#run_formatter()<CR>")

-- get rid of highlighting
nnoremap("<leader>hh", ":noh<CR>")

-- search over lines in buffer
nnoremap("//", ":BLines<CR>")
-- nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

-- search for word under cursor with, sublime text 2 style
nmap("", "   <C-F>f <Plug>CtrlSFPrompt")

-- search for word under cursor with, sublime text 2 style
nmap("", "   <C-F>w <Plug>CtrlSFCwordPath<CR>")

-- toggle the CtrlSF search results window
nnoremap("<C-F>t", ":CtrlSFToggle<CR>")

nnoremap("<leader>gt", ":GoTest<CR>")

-- vim-bujo mappings
nmap("<C-S>", "<Plug>BujoAddnormal")
imap("<C-S>", "<Plug>BujoAddinsert")

nmap("<C-Q>", "<Plug>BujoChecknormal")
imap("<C-Q>", "<Plug>BujoCheckinsert")

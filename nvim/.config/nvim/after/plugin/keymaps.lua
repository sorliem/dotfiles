-- swap colon and semicolon
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")

-- make Y behave like other captial letters
vim.keymap.set("n", "Y", "y$")

-- keeping it centered when jumping around, joining lines
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ'z")

-- better undo break points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- jumplist muations. Add to jumplist when jumping more than 5 lines
-- not sure if this <expr> is in right place
vim.keymap.set("n", "<expr> k", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'k'")
vim.keymap.set("n", "<expr> j", "(v:count > 5 ? \"m'\" . v:count : \"\") . 'j'")

-- better indentation, keeps block highlighted
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- higlight your pasted region
vim.keymap.set("n", "gV", "`[v`]")

-- keep center of screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep center of screen when iterating through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keep center of screen when iterating through quickfix
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

-- do search and replace using the word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")

-- greatest remap ever (per the primagen)
-- in visual mode, paste what is in the default register
-- without overwriting the default register with what was
-- just erased
vim.keymap.set("v", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>p", "\"_dP")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- reload init.vim
vim.keymap.set("n", "<leader>rv", ":so $MYVIMRC<CR>")

-- delete buffer
vim.keymap.set("n", "<leader>d", ":bd<CR>")

-- fzf starting at home dir
vim.keymap.set("n", "<leader>F", ":FZF ~<CR>")

-- rg in current dir
vim.keymap.set("n", "<leader>ps", ":R<CR>")
-- nnoremap <leader>f :lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>

-- toggle undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- paste from clipboard
vim.keymap.set("n", "<leader>P", "\"+p<CR>")

-- copy to clipboard
vim.keymap.set("v", "<leader>c", "\"+y<CR>")

-- reload all buffers from disk
vim.keymap.set("n", "<leader>br", ":bufdo e!<CR>")

-- git worktrees
vim.keymap.set("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
vim.keymap.set("n", "<leader>gaw", ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")

-- Fugitive status
vim.keymap.set("n", "<Leader>gs", ":Git<CR>", {noremap = true, silent = true})

-- Fugitive blame
vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", {noremap = true, silent = true})

-- Fugitive diff master
vim.keymap.set("n", "<Leader>gd", ":Git diff master..HEAD<CR>:only<CR>", {noremap = true, silent = true})

-- Grab last commit messge
vim.keymap.set("n", "<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j")

-- Grab current line as _permanent_ github link
vim.keymap.set("n", "<leader>ghl", ":0GBrowse!<CR>")

-- Grab current selection as _permanent_ github link
vim.keymap.set("v", "<leader>ghl", ":GBrowse!<CR>")

-- toggle netrw
vim.keymap.set("n", "<Leader>nt", ":Hexplore!<Enter>")
vim.keymap.set("n", "<Leader>pv", ":Hexplore!<Enter>")
vim.keymap.set("n", "<Leader>e", ":Hexplore!<Enter>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- find current file in tree
-- nnoremap <silent> <Leader>nf :NERDTreeFind<CR>
-- command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n
vim.keymap.set("n", "<Leader>nf", ":let @/=expand(\"%:\t\") <Bar> execute 'Hexplore!' expand(\"%:h\") <Bar> normal n<CR>")
vim.keymap.set("n", "-", ":let @/=expand(\"%:\t\") <Bar> execute 'Hexplore!' expand(\"%:h\") <Bar> normal n<CR>")

-- save and exec file
vim.keymap.set("n", "<Leader>x", ":call SaveAndExec()<CR>")

-- run test file
vim.keymap.set("n", "<Leader>rt", ":call RunElixirTest()<CR>")

-- run all tests
vim.keymap.set("n", "<Leader>tt", ":call RunAllTests()<CR>")

-- run formatting
vim.keymap.set("n", "<Leader>rf", ":call RunFormatter()<CR>")

vim.keymap.set("n", '<Leader>qr', ':lua require("miles.telescope").reload()<CR>', { noremap = true })

vim.keymap.set("n", "<leader>rs", "<cmd>lua require('miles.snippets').reload_snippets()<CR>")

-- set keybinds for both INSERT and VISUAL.
vim.keymap.set("i", "<C-n>", "<Plug>luasnip-next-choice")
vim.keymap.set("s", "<C-n>", "<Plug>luasnip-next-choice")
vim.keymap.set("i", "<C-p>", "<Plug>luasnip-prev-choice")
vim.keymap.set("s", "<C-p>", "<Plug>luasnip-prev-choice")

-- get rid of highlighting
vim.keymap.set("n", "<leader>hh", ":noh<CR>")

-- search over lines in buffer
vim.keymap.set("n", "//", ":BLines<CR>")
-- nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

-- search for word under cursor with, sublime text 2 style
vim.keymap.set("n", "<C-F>f", "<Plug>CtrlSFPrompt")

-- search for word under cursor with, sublime text 2 style
vim.keymap.set("n", "<C-F>w", "<Plug>CtrlSFCwordPath<CR>")

vim.keymap.set("n", "<leader>fw", ":lua require('telescope.builtin').grep_string{}<CR>")

-- toggle the CtrlSF search results window
vim.keymap.set("n", "<C-F>t", ":CtrlSFToggle<CR>")

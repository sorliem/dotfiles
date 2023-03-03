local map = function(mode, keys, func, desc)
	vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end

-- swap colon and semicolon
map("n", ";", ":")
map("n", ":", ";")

-- make Y behave like other captial letters
map("n", "Y", "y$", "Yank to end of line")

-- better undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- jumplist muations. Add to jumplist when jumping more than 5 lines
-- not sure if this <expr> is in right place
map("n", "<expr> k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'')
map("n", "<expr> j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'')

-- better indentation, keeps block highlighted
map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- higlight your pasted region
map("n", "gV", "`[v`]")

-- keep center of screen when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- keep center of screen when iterating through search results
map("n", "n", "nzzzv", "Next result and center the screen")
map("n", "N", "Nzzzv", "Prev result and center the screen")

-- keeping it centered when jumping around, joining lines
map("n", "J", "mzJ'z", "Join line and keep screen centered")

-- keep center of screen when iterating through quickfix
map("n", "<C-j>", "<cmd>cnext<CR>zz", "Next quickfix item and center screen")
map("n", "<C-k>", "<cmd>cprev<CR>zz", "Prev quickfix item and center screen")

-- do search and replace using the word under cursor
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search/replace for word under cursor")

-- nnoremap("<C-d>", "<C-d>zz")
-- nnoremap("<C-u>", "<C-u>zz")

-- greatest remap ever (per the primagen)
-- in visual mode, paste what is in the default register
-- without overwriting the default register with what was
-- just erased
map("v", "<leader>p", '"_dP', "Delete to void buffer and paste over without overwriting clipboard")
map("x", "<leader>p", '"_dP', "Delete to void buffer and paste over without overwriting clipboard")

-- next greatest remap ever : asbjornHaland
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')

-- reload init.lua
map("n", "<leader>rv", ":so $MYVIMRC<CR>", "[R]eload [V]imrc (init.lua)")

-- delete buffer
map("n", "<leader>d", ":bdelete<CR>", "[D]elete buffer")

-- fzf starting at home dir
map("n", "<leader>F", ":FZF ~<CR>")

-- rg in current dir
map("n", "<leader>ps", ":R<CR>", "[P]roject [S]earch with `rg`")
-- nnoremap <leader>f :lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>

-- toggle undotree
map("n", "<leader>u", ":UndotreeToggle<CR>")

-- paste from clipboard
map("n", "<leader>P", '"+p<CR>', "[P]aste from clipboard")

-- copy to clipboard
map("v", "<leader>c", '"+y<CR>', "[C]opy to system clipboard")

-- reload all buffers from disk
map("n", "<leader>br", ":bufdo e!<CR>", "[B]uffer [R]eload")

-- git worktrees
map("n", "<leader>gw", ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", "[G]it [W]orktrees")
map(
	"n",
	"<leader>gaw",
	":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	"[G]it [A]dd [W]orktree"
)

-- Fugitive status
map("n", "<Leader>gs", ":Git<CR>", "[G]it [S]tatus")

-- Fugitive blame
map("n", "<Leader>gb", ":Git blame<CR>", "[G]it [B]lame")

-- Fugitive diff master
map("n", "<Leader>gd", ":Git diff master..HEAD<CR>:only<CR>", "[G]it [D]iff master..HEAD")

-- Grab last commit messge
map("n", "<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j", "Read prev (1-back) [G]it [L]og commit message")

-- Grab current line as _permanent_ github link
map("n", "<leader>ghl", ":0GBrowse!<CR>", "[G]it[H]ub line yank")

-- Grab current selection as _permanent_ github link
map("v", "<leader>ghl", ":GBrowse!<CR>", "[G]it[H]ub line yank")

map("n", "<leader>km", function()
	require("telescope.builtin").keymaps({ show_plug = false })
end, "[K]ey [M]aps")

-- toggle netrw
map("n", "<Leader>pv", ":Hexplore!<Enter>", "[P]roject [V]view (netrw)")
map("n", "<Leader>e", ":Hexplore!<Enter>", "[E]xplore (netrw)")

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- find current file in tree
-- nnoremap <silent> <Leader>nf :NERDTreeFind<CR>
-- command! ExploreFind let @/=expand("%:t") | execute 'Explore' expand("%:h") | normal n
map(
	"n",
	"<Leader>nf",
	':let @/=expand("%:\t") <Bar> execute \'Hexplore!\' expand("%:h") <Bar> normal n<CR>',
	"[N]erd [F]ind (in netrw)"
)
map(
	"n",
	"-",
	':let @/=expand("%:\t") <Bar> execute \'Hexplore!\' expand("%:h") <Bar> normal n<CR>',
	"Open netrw and find current file"
)

-- save and exec file
map("n", "<Leader>x", ":call SaveAndExec()<CR>", "Save and e[x]ec")

-- run test file
map("n", "<Leader>rt", ":call RunElixirTest()<CR>")

-- run all tests
map("n", "<Leader>tt", ":call RunAllTests()<CR>")

-- run formatting
map("n", "<Leader>rf", ":call RunFormatter()<CR>", "[R]un [F]ormatter")

-- set keybinds for both INSERT and VISUAL.
map("i", "<C-n>", "<Plug>luasnip-next-choice")
map("s", "<C-n>", "<Plug>luasnip-next-choice")
map("i", "<C-p>", "<Plug>luasnip-prev-choice")
map("s", "<C-p>", "<Plug>luasnip-prev-choice")

-- get rid of highlighting
map("n", "<leader>hh", ":noh<CR>")

-- search over lines in buffer
map("n", "//", ":BLines<CR>")
-- nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

-- search for word under cursor with, sublime text 2 style
map("n", "<C-F>f", "<Plug>CtrlSFPrompt")

-- search for word under cursor with, sublime text 2 style
map("n", "<C-F>w", "<Plug>CtrlSFCwordPath<CR>")

map("n", "<leader>fw", ":lua require('telescope.builtin').grep_string{}<CR>", "[F]ind [W]ord (telescope)")

-- toggle the CtrlSF search results window
map("n", "<C-F>t", ":CtrlSFToggle<CR>")

map("n", "<Space>ar", function()
	vim.cmd("AutoRun")
end, "[A]uto [R]un")

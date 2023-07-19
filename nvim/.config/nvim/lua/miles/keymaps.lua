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

map("n", "<CR>", "ciw")

-- for some reason on mac alt file doesn't work
map("n", "<C-6>", "<C-^>")

map("v", "y", "ygv<ESC>", "ygv<ESC> - yank but don't move cursor back to start of selection")

-- jumplist muations. Add to jumplist when jumping more than 5 lines
-- not sure if this <expr> is in right place
map("n", "<expr> k", '(v:count > 5 ? "m\'" . v:count : "") . \'k\'')
map("n", "<expr> j", '(v:count > 5 ? "m\'" . v:count : "") . \'j\'')

-- better indentation, keeps block highlighted
map("v", "<", "<gv", "Indent left once")
map("v", ">", ">gv", "Indent right once")

map("v", "J", ":m '>+1<CR>gv=gv", "Move highlighted region down one line w/ auto-indent")
map("v", "K", ":m '<-2<CR>gv=gv", "Move highlighted region up one line w/ auto-indent")

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

-- get rid of highlighting
map("n", "<leader>hh", ":noh<CR>")

-- do search and replace using the word under cursor
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search/replace for word under cursor")
map("n", "<leader>rn", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search/replace for word under cursor")

-- greatest remap ever (per the primagen)
-- in visual mode, paste what is in the default register
-- without overwriting the default register with what was
-- just erased
map("v", "<leader>p", '"_dP', "Delete to void buffer and paste over without overwriting clipboard")
map("x", "<leader>p", '"_dP', "Delete to void buffer and paste over without overwriting clipboard")

-- delete to void register
map("n", "<leader>d", '"_d', "[D]elete to void register")
map("v", "<leader>d", '"_d', "[D]elete to void register")

-- copy to clipboard
map("v", "<leader>c", '"+y<CR>', "[C]opy to system clipboard")

-- paste from clipboard
map("n", "<leader>P", '"+p<CR>', "[P]aste from clipboard")

-- reload init.lua
map("n", "<leader>rv", ":so $MYVIMRC<CR>", "[R]eload [V]imrc (init.lua)")

-- delete buffer
map("n", "<leader>bd", ":bdelete<CR>", "[B]uffer [D]elete")

-- reload all buffers from disk
map("n", "<leader>br", ":bufdo e!<CR>", "[B]uffer [R]eload")

-- Grab last commit messge
map("n", "<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j", "Read prev (1-back) [G]it [L]og commit message")

map("n", "<Leader>pv", ":Hexplore!<Enter>", "[P]roject [V]view (netrw)")

-- map(
-- 	"n",
-- 	"-",
-- 	':let @/=expand("%:\t") <Bar> execute \'Hexplore!\' expand("%:h") <Bar> normal n<CR>',
-- 	"Open netrw and find current file"
-- )

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Launch tmux-sessionizer")

-- save and exec file
map("n", "<Leader>x", ":call SaveAndExec()<CR>", "Save and e[x]ec")

-- run test file
map("n", "<Leader>rt", ":call RunElixirTest()<CR>")

-- run all tests
-- map("n", "<Leader>tt", ":call RunAllTests()<CR>")

-- run formatting
map("n", "<Leader>rf", ":call RunFormatter()<CR>", "[R]un [F]ormatter")

map("n", "<Space>ar", ":AutoRun<CR>", "[A]uto [R]un a file on a specific pattern and output to buffer")

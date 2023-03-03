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

-- get rid of highlighting
map("n", "<leader>hh", ":noh<CR>")

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

-- paste from clipboard
map("n", "<leader>P", '"+p<CR>', "[P]aste from clipboard")

-- copy to clipboard
map("v", "<leader>c", '"+y<CR>', "[C]opy to system clipboard")

-- reload all buffers from disk
map("n", "<leader>br", ":bufdo e!<CR>", "[B]uffer [R]eload")

-- Grab last commit messge
map("n", "<leader>gl1", ":read !git log -n 1<CR>?commit<CR>d3j", "Read prev (1-back) [G]it [L]og commit message")

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

map("n", "<Space>ar", ":AutoRun<CR>", "[A]uto [R]un")

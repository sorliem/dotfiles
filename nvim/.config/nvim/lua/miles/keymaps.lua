local map = function(mode, keys, func, desc)
	vim.keymap.set(mode, keys, func, { desc = desc, noremap = true, silent = true })
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search on <Esc> in normal mode")

-- swap colon and semicolon
map("n", ";", ":")
map("n", ":", ";")

-- better undo break points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", "!", "!<c-g>u")
map("i", "?", "?<c-g>u")

-- map("n", "<CR>", "ciw")

vim.keymap.set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.o.buftype == "nofile" then
		-- not perfect, but in the command window (`q:`) hitting Enter should input <CR> to run the command
		-- don't have a better way of detecting when in a command window
		return vim.keycode("<CR>")
	else
		return vim.keycode("ciw")
	end
end, { expr = true, desc = "Clear highlighting if showing then replace word under cursor" })

-- vim.keymap.set("t", "<Esc>", function()
-- 	vim.keycode("<C-\\><C-n>")
-- end, { expr = true, desc = "ecape a terminal window" })
vim.cmd([[ tnoremap <Esc> <C-\><C-n> ]])

-- C-a goes beginning of line in command line mode
vim.cmd([[ cnoremap <C-A> <Home> ]])
map("n", "<leader>tm", "<cmd>vert term<CR>", "Open neovim terminal in a vertical split")

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

-- Navigate merge conflict markers
map("n", "]n", [[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'W')<cr>]], "Navate to next conflict marker")
map(
	"n",
	"[n",
	[[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bW')<cr>]],
	"Navate to previous conflict marker"
)

-- keeping it centered when jumping around, joining lines
map("n", "J", "mzJ'z", "Join line and keep screen centered")

-- keep center of screen when iterating through quickfix
map("n", "<C-j>", "<cmd>cnext<CR>zz", "Next quickfix item and center screen")
map("n", "<C-k>", "<cmd>cprev<CR>zz", "Prev quickfix item and center screen")

-- get rid of highlighting
map("n", "<leader>hh", "<cmd>noh<CR>")

-- do search and replace using the word under cursor
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Search/replace for word under cursor")

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
map("n", "<leader>rv", "<cmd>so $MYVIMRC<CR>", "[R]eload [V]imrc (init.lua)")

-- delete buffer
map("n", "<leader>bd", "<cmd>bdelete<CR>", "[B]uffer [D]elete")

-- reload all buffers from disk
map("n", "<leader>br", "<cmd>bufdo e!<CR>", "[B]uffer [R]eload")

-- Grab last commit messge
map("n", "<leader>gl1", "<cmd>read !git log -n 1<CR>?commit<CR>d3j", "Read prev (1-back) [G]it [L]og commit message")

map("n", "<Leader>pv", "<cmd>Hexplore!<Enter>", "[P]roject [V]view (netrw)")

map("n", "<Leader>ts", "<cmd>%s/\\s\\+$//e<CR>", "[T]rim trailing [S]paces")

-- map(
-- 	"n",
-- 	"-",
-- 	':let @/=expand("%:\t") <Bar> execute \'Hexplore!\' expand("%:h") <Bar> normal n<CR>',
-- 	"Open netrw and find current file"
-- )

map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Launch tmux-sessionizer")

-- save and exec file
-- map("n", "<Leader>x", ":call SaveAndExec()<CR>", "Save and e[x]ec")

-- run test file
-- map("n", "<Leader>rt", ":call RunElixirTest()<CR>")
map("n", "<Leader>rst", function()
	local file_plus_linenum = vim.fn.expand("%:") .. ":" .. vim.api.nvim_win_get_cursor(0)[1]
	local cmd = "tmux send-keys -t {left} 'dtest " .. file_plus_linenum .. "' C-m"
	print("👈👈👈 Running ONE test: " .. file_plus_linenum)

	vim.call("system", cmd)
end, "[R]un [S]ingle [T]est - only Elixir")

map("n", "<Leader>rt", function()
	local file = vim.fn.expand("%:")
	print("👈👈👈 Running all tests: " .. file)
	local cmd = "tmux send-keys -t {left} 'dtest " .. file .. "' C-m"

	vim.call("system", cmd)
end, "[R]un all [T]ests - only Elixir")

map("n", "<leader>td", function()
	local baseurl = "https://registry.terraform.io/?q=%s"
	local word = vim.fn.expand("<cword>")
	local url = string.format(baseurl, word)
	vim.ui.open(url)
end, "[T]erraform [D]efinition")

-- map("n", "<leader>gho", function()
-- 	local url = vim.fn.system([[git remote get-url origin | sed -e 's|git@\(.*\):|https://\1/|' -e 's|\.git$||']])
-- 	local url2 = url:gsub("\n$", "")
-- 	vim.ui.open(url2)
-- end, "[G]it[h]ub [O]pen repo website")

vim.keymap.set("n", "dd", function()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		-- delete to black hole register if deleting a blank line --comment
		return '"_dd'
	else
		return "dd"
	end
end, { expr = true, desc = "Smart dd" })

-- COMMENTED OUT - part of default neovim
-- map("x", ".", "<cmd>norm .<CR>", "Repeat last action on visually selected line")
-- map("x", "@", "<cmd>norm @q<CR>", "Repeat @q macro on visually selected lines")

-- run formatting
-- map("n", "<Leader>rf", ":call RunFormatter()<CR>", "[R]un [F]ormatter")

map("n", "<Space>ar", "<cmd>AutoRun<CR>", "[A]uto [R]un a file on a specific pattern and output to buffer")

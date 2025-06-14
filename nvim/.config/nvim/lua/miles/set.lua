local HOME = os.getenv("HOME")

vim.cmd([[set path+=**]])
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.backup = false

vim.opt.list = true
vim.opt.listchars = {
	tab = "→·",
	lead = "·",
	space = "·",
	trail = "·",
	eol = "↵",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
}

vim.opt.ruler = true
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.undolevels = 500
vim.opt.swapfile = false
-- vim.opt.t_Co = 256             -- 256 terminal colors
vim.opt.termguicolors = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,list:full" -- for : stuff
vim.opt.showmatch = true
vim.opt.ttimeoutlen = 50
vim.opt.foldenable = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse = "a"
-- vim.opt.synmaxcol = 210
vim.opt.spelllang = "en_us"
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3
vim.opt.cmdheight = 1
vim.opt.cmdwinheight = 10
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
-- vim.opt.colorcolumn = '80'
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.guicursor = "i:block"
vim.opt.updatetime = 50
vim.opt.backupdir = HOME .. "/.vim/backups"
vim.opt.conceallevel = 0

-- vim.opt.guicursor = {
-- 	"n-v-c:block",
-- 	"i-ci-ve:ver25",
-- 	"r-cr:hor20",
-- 	"o:hor50",
-- 	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
-- 	"sm:block-blinkwait175-blinkoff150-blinkon175",
-- }

vim.cmd([[
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]])

vim.g.editorconfig = true

vim.g.netrw_browse_split = 2
vim.g.netrw_banner = 0 -- disable annoying banner
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_altv = 1 -- open splits to the right

vim.g.mapleader = " "
vim.g.maplocalleader = " "

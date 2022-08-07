local HOME = os.getenv("HOME")

vim.cmd [[set path+=**]]
vim.opt.errorbells = false
vim.opt.tabstop=4
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.wrap = true
vim.opt.smartcase = true
vim.opt.backup = false
vim.opt.list = true
vim.opt.listchars = "tab:»\\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↵"
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.hidden = true
vim.opt.laststatus = 2
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.undolevels = 500
vim.opt.swapfile = false
-- vim.opt.t_Co = 256             -- 256 terminal colors
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.showmatch = true
vim.opt.ttimeoutlen=50
vim.opt.foldenable = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.mouse=a
vim.opt.synmaxcol=210
vim.opt.spelllang="en_us"
vim.opt.scrolloff=0
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "80"
vim.opt.runtimepath:append(HOME .. "/.vim")
vim.opt.runtimepath:append(HOME .. "/.vim/after")
vim.opt.completeopt="menu,menuone,noselect"
vim.opt.guicursor="i:block"
vim.opt.backupdir= HOME .."/.vim/backups"

vim.g.mapleader = " "

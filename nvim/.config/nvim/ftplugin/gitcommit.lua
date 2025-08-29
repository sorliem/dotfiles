-- No line numbers
-- vim.opt_local.relativenumber = false
-- vim.opt_local.number = false
-- vim.opt_local.signcolumn = "no"

vim.opt_local.textwidth = 72
-- vim.opt_local.colorcolumn = { 73, 51 }
vim.opt_local.colorcolumn = "73,51"

-- Autoformatting
-- Enable formatting everywhere, not just comments
-- vim.opt_local.formatoptions:append("ca")

vim.opt_local.spell = true
-- vim.opt_local.iskeyword:remove("-")

-- Plugin settings

vim.b.EditorConfig_disable = 1

-- Mappings

-- Navigate between changed files
vim.keymap.set("n", "{", "?^@@<cr>", { silent = true, buffer = true })
vim.keymap.set("n", "}", "/^@@<cr>", { silent = true, buffer = true })

local Remap = require("miles.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
vim.keymap.set('n', '<leader>he', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', {silent = true})
-- nnoremap("<leader>he", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
nnoremap("<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", {silent = true})
nnoremap("<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", {silent = true})
nnoremap("<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", {silent = true})
nnoremap("<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", {silent = true})
nnoremap("<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>", {silent = true})

nnoremap("<M-j>", ":lua require('harpoon.ui').nav_file(1)<CR>", {silent = true})
nnoremap("<M-k>", ":lua require('harpoon.ui').nav_file(2)<CR>", {silent = true})
nnoremap("<M-l>", ":lua require('harpoon.ui').nav_file(3)<CR>", {silent = true})
nnoremap("<M-;>", ":lua require('harpoon.ui').nav_file(4)<CR>", {silent = true})
nnoremap("<M-'>", ":lua require('harpoon.ui').nav_file(5)<CR>", {silent = true})

-- vim.g.harpoon_log_level = 'debug'

-- if not string.find(vim.loop.cwd(), "atlantis") then
--     require("harpoon").setup({
--         global_settings = {
--             mark_branch = true
--         }
--     })
-- end

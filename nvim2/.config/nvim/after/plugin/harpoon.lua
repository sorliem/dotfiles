local Remap = require("miles.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
nnoremap("<leader>he", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
nnoremap("<leader>hy", ":lua require('harpoon.cmd-ui').toggle_quick_menu()<CR>")
nnoremap("<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
nnoremap("<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
nnoremap("<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
nnoremap("<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
nnoremap("<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")

nnoremap("<M-j>", ":lua require('harpoon.ui').nav_file(1)<CR>")
nnoremap("<M-k>", ":lua require('harpoon.ui').nav_file(2)<CR>")
nnoremap("<M-l>", ":lua require('harpoon.ui').nav_file(3)<CR>")
nnoremap("<M-;>", ":lua require('harpoon.ui').nav_file(4)<CR>")
nnoremap("<M-'>", ":lua require('harpoon.ui').nav_file(5)<CR>")

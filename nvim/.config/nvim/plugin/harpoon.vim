lua print("hello from plugin/harpoon.vim")
lua require("miles")

nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>he :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>hy :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>

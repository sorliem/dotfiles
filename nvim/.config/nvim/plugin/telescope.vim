lua require("miles")

nnoremap <C-P> :lua require('miles.telescope').project_files()<CR>
" nnoremap <leader>o :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>vrc :lua require('miles.telescope').search_dotfiles()<CR>
nnoremap <leader><leader> :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ht :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_branches()<CR>
nnoremap <leader>gm :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>gf :lua require('telescope.builtin').git_status()<CR>

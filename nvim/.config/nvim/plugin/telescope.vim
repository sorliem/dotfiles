lua require("miles")

" nnoremap <C-P> :lua require("telescope.builtin").git_files()<CR>
nnoremap <C-P> :lua require('miles.telescope').project_files()<CR>
nnoremap <C-S> :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>vrc :lua require('miles.telescope').search_dotfiles()<CR>
nnoremap <leader><leader> :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_branches()<CR>

" doesn't work
" nnoremap // :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>


vim.cmd [[
if executable('rg')
   command! -bang -nargs=* R
     \ call fzf#vim#grep(
     \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
     \   fzf#vim#with_preview(), <bang>0)
endif
]]

vim.cmd[[
"autocmd BufWritePre * :call TrimWhitespace()

" only have cursorline set on active window
" autocmd WinLeave * set nocursorline
" autocmd WinEnter * set cursorline

" augroup miles_highlight_yank
"     autocmd!
"     autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=250}
" augroup END

" augroup miles_elixir
"     autocmd!
"     autocmd BufNewFile,BufRead *.ex,*.exs set syntax=elixir
"     autocmd BufNewFile,BufRead *.eex set syntax=eelixir
" augroup END

" augroup miles_git
"   autocmd!
"   autocmd FileType gitcommit setlocal wrap
"   autocmd FileType gitcommit setlocal spell
" augroup END

" augroup miles_markdown
"   autocmd!
"   autocmd FileType markdown setlocal wrap
"   autocmd FileType markdown setlocal spell
" augroup END
]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
MilesDevGroup = augroup('Miles', {})
YankGroup = augroup('YankGroup', {})
WhiteSpaceGroup = augroup('WhiteSpaceGroup', {})

autocmd('BufWritePre', {
    group = WhiteSpaceGroup,
    pattern = '*',
    command = '%s/\\s\\+$//e'
})

autocmd('WinLeave', {
    pattern = '*',
    command = 'set nocursorline'
})

autocmd('WinEnter', {
    pattern = '*',
    command = 'set cursorline'
})

autocmd('TextYankPost', {
    group = YankGroup,
    pattern = '*',
    callback = function()
      vim.highlight.on_yank{higroup="IncSearch", timeout=250}
    end
})

autocmd({'BufNewFile','BufRead'}, {
    group = MilesDevGroup,
    pattern = {'*.ex', '.exs'},
    command = 'set syntax=elixir'
})

autocmd({'BufNewFile','BufRead'}, {
    group = MilesDevGroup,
    pattern = '*.eex',
    command = 'set syntax=eelixir'
})

autocmd('FileType', {
    group = MilesDevGroup,
    pattern = {'gitcommit', 'markdown'},
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.wrap = true
    end
})

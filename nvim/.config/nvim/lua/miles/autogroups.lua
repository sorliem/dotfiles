local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
MilesDevGroup = augroup('Miles', {})
YankGroup = augroup('YankGroup', {})
WhiteSpaceGroup = augroup('WhiteSpaceGroup', {})
PackerGroup = augroup('PackerGroup', {})

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

autocmd('FileType', {
    group = MilesDevGroup,
    pattern = {'vimwiki'},
    callback = function()
      vim.opt_local.spell = true
      vim.opt.listchars:remove('eol')
    end
})

autocmd('BufWritePost', {
    group = PackerGroup,
    pattern = 'packer.lua',
    command = 'source <afile> | PackerCompile'
})

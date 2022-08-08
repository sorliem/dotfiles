vim.cmd [[
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]]

vim.cmd [[highlight ColorColumn ctermbg=0 guibg=darkgrey]]
vim.cmd [[highlight CursorLine ctermbg=Black]]
vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]


vim.g.gruvbox_invert_selection='0'

-- vim.cmd [[set background=light]]
-- vim.cmd [[colorscheme PaperColor]]

-- vim.g.gruvbox_italic = 1
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.cmd [[set background=dark]]
-- vim.cmd [[colorscheme gruvbox]]

-- vim.g.gruvbox_contrast_light = 'hard'
-- vim.cmd [[set background=light]]
-- vim.cmd [[colorscheme gruvbox]]

-- vim.g.solarized_termcolors = 256
-- vim.cmd [[set background=dark]]
-- vim.cmd [[colorscheme solarized]]

-- vim.g.solarized_termcolors = 256
-- vim.cmd [[set background=light]]
-- vim.cmd [[colorscheme solarized]]
--
vim.g.tokyonight_italic_functions = 1
vim.g.tokyonight_italic_comments = 1
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = true
vim.cmd [[colorscheme tokyonight]]

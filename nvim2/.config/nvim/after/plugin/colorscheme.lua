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

-- set background=light
-- colorscheme PaperColor

-- let g:gruvbox_italic=1
-- let g:gruvbox_contrast_dark='hard'
-- set background=dark
-- colorscheme gruvbox

-- let g:gruvbox_contrast_light=--hard--
-- set background=light
-- colorscheme gruvbox

-- let g:solarized_termcolors=256
-- set background=dark
-- colorscheme solarized

-- let g:solarized_termcolors=256
-- set background=light
-- colorscheme solarized
--
vim.g.tokyonight_italic_functions = 1
vim.g.tokyonight_italic_comments = 1
vim.g.tokyonight_style = 'night'
vim.g.tokyonight_transparent = true
vim.cmd [[colorscheme tokyonight]]

-- let g:rustfmt_autosave = 1

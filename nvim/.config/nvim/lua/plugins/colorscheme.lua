return {
	{
		{
			'ellisonleao/gruvbox.nvim',
			config = function()
				-- vim.cmd [[highlight ColorColumn ctermbg=0 guibg=darkgrey]]
				-- vim.cmd [[highlight CursorLine ctermbg=Black]]
				-- vim.cmd [[highlight ColorColumn ctermbg=0 guibg=darkgrey]]
				-- vim.cmd [[highlight CursorLine ctermbg=0 guibg=#262626]]

				require("gruvbox").setup({
					undercurl = true,
					underline = true,
					bold = true,
					italic = true,
					strikethrough = true,
					invert_selection = false,
					invert_signs = false,
					invert_tabline = false,
					invert_intend_guides = false,
					inverse = true, -- invert background for search, diffs, statuslines and errors
					contrast = "hard", -- can be "hard", "soft" or empty string
					palette_overrides = {},
					overrides = {},
					dim_inactive = false,
					transparent_mode = false,
				})

				vim.g.gruvbox_invert_selection='0'
				vim.g.gruvbox_italic = 1
				vim.g.gruvbox_contrast_dark = 'hard'
				vim.cmd [[set background=dark]]
				vim.cmd [[colorscheme gruvbox]]
				-- vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
				-- vim.cmd [[highlight ColorColumn ctermbg=0 guibg=darkgrey]]
				-- vim.cmd [[highlight CursorLine ctermbg=0 guibg=#262626]]
				-- vim.cmd [[highlight CursorLine ctermbg=0 guibg=#555555]]
			end
		},
		{
			'fenetikm/falcon',
			lazy = true,
			config = function()
				-- vim.g.falcon_background = false
				-- vim.g.falcon_inactive = true
				-- vim.cmd [[colorscheme falcon]]
			end
		},
		{
			'NLKNguyen/papercolor-theme',
			lazy = true,
			config = function()
				-- vim.cmd [[set background=light]]
				-- vim.cmd [[colorscheme PaperColor]]
			end
		},
		{
			'ishan9299/nvim-solarized-lua',
			lazy = true,
			config = function()
				-- vim.g.solarized_termcolors = 256
				-- vim.cmd [[set background=dark]]
				-- vim.cmd [[colorscheme solarized]]

				-- vim.g.solarized_termcolors = 256
				-- vim.cmd [[set background=light]]
				-- vim.cmd [[colorscheme solarized]]
			end
		},
		{
			'folke/tokyonight.nvim',
			lazy = true,
			config = function()
				-- vim.opt.background = 'dark'
				-- vim.g.tokyonight_italic_functions = 1
				-- vim.g.tokyonight_italic_comments = 1
				-- vim.g.tokyonight_style = 'night'
				-- vim.g.tokyonight_transparent = true
				-- vim.cmd [[colorscheme tokyonight]]
			end
		}
	}
}

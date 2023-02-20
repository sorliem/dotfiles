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
			end
		},
		{'fenetikm/falcon', lazy = true},
		{'NLKNguyen/papercolor-theme', lazy = true},
		{'ishan9299/nvim-solarized-lua', lazy = true},
		{'folke/tokyonight.nvim', lazy = true},
	}
}

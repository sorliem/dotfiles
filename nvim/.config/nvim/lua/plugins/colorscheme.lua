return {
	{
		{
			"ellisonleao/gruvbox.nvim",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				require("gruvbox").setup({
					undercurl = true,
					underline = false,
					bold = true,
					italic = {
						strings = false,
						operators = false,
						comments = true,
					},
					strikethrough = true,
					invert_selection = false,
					invert_signs = true,
					invert_tabline = false,
					invert_intend_guides = false,
					inverse = true, -- invert background for search, diffs, statuslines and errors
					contrast = "hard", -- can be "hard", "soft" or empty string
					palette_overrides = {
						dark0_hard = "#1d2021",
						dark0 = "#1d2021",
					},
					overrides = {
						Comment = { fg = "#8f8f8f", italic = true },
					},
					dim_inactive = false,
					transparent_mode = false,
				})

				vim.cmd([[set background=dark]])
				vim.cmd([[colorscheme gruvbox]])

				-- vim.cmd([[ hi Search guibg=peru guifg=wheat ]])
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				require("catppuccin").setup({
					-- latte, frappe, macchiato, mocha
					flavour = "frappe",
					transparent_mode = false,
				})
				vim.cmd([[set background=light]])
				vim.cmd("colorscheme catppuccin")
				-- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
			end,
		},
		{
			"rebelot/kanagawa.nvim",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				require("kanagawa").setup({
					theme = "wavelotus",
				})
				vim.cmd("colorscheme kanagawa")
			end,
		},
		{
			"EdenEast/nightfox.nvim",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				-- vim.cmd("colorscheme nightfox")
				vim.cmd([[set background=dark]])
				vim.cmd("colorscheme nightfox")
			end,
		},
		{
			"projekt0n/github-nvim-theme",
			priority = 1000,
			lazy = false,
			cond = true,
			config = function()
				require("github-theme").setup({
					options = {
						transparent = false,
					},
				})

				vim.cmd.colorscheme("github_dark")
			end,
		},
		{
			"fenetikm/falcon",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				vim.g.falcon_background = true
				vim.g.falcon_inactive = false
				vim.cmd([[colorscheme falcon]])
			end,
		},
		{
			"folke/tokyonight.nvim",
			priority = 1000,
			lazy = false,
			cond = false,
			config = function()
				vim.opt.background = "dark"
				-- vim.g.tokyonight_italic_functions = 1
				-- vim.g.tokyonight_italic_comments = 1
				-- vim.g.tokyonight_style = "moon"
				-- vim.g.tokyonight_transparent = true
				require("tokyonight").setup({
					-- styles: moon, night, storm, day
					style = "moon",
					lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
					sidebars = { "qf", "fugitive" },
					on_colors = function(colors)
						colors.hint = colors.orange
						colors.error = "#ff0000"
					end,
				})
				vim.cmd([[colorscheme tokyonight]])
			end,
		},
	},
	{
		"rose-pine/neovim",
		priority = 1000,
		lazy = false,
		name = "rose-pine",
		cond = false,
		config = function()
			require("rose-pine").setup({
				variant = "moon", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = true,
					transparency = false,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				highlight_groups = {
					Comment = { fg = "muted" },
					VertSplit = { fg = "muted", bg = "muted" },
				},
			})

			vim.cmd("colorscheme rose-pine")
			-- vim.cmd("colorscheme rose-pine-main")
			-- vim.cmd("colorscheme rose-pine-moon")
			-- vim.cmd("colorscheme rose-pine-dawn")
		end,
	},
	{
		"maxmx03/fluoromachine.nvim",
		priority = 1000,
		lazy = false,
		cond = false,
		config = function()
			local fm = require("fluoromachine")

			-- themes: fluoromachine, retrowave, delta
			fm.setup({
				glow = false,
				theme = "delta",
			})

			vim.cmd.colorscheme("fluoromachine")
		end,
	},
}

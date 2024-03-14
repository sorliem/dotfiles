return {
	{
		{
			"ellisonleao/gruvbox.nvim",
			priority = 1000,
			cond = false,
			config = function()
				require("gruvbox").setup({
					undercurl = true,
					underline = true,
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
			"briones-gabriel/darcula-solid.nvim",
			dependencies = { "rktjmp/lush.nvim" },
			cond = false,
			config = function()
				vim.cmd("colorscheme darcula-solid")
				vim.cmd("set termguicolors")
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			cond = false,
			config = function()
				require("catppuccin").setup({
					-- latte, frappe, macchiato, mocha
					flavour = "frappe",
					transparent_mode = false,
				})
				vim.cmd([[set background=dark]])
				vim.cmd("colorscheme catppuccin")
				-- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
			end,
		},
		{
			"EdenEast/nightfox.nvim",
			cond = false,
			config = function()
				-- vim.cmd("colorscheme nightfox")
				vim.cmd([[set background=light]])
				vim.cmd("colorscheme dayfox")
			end,
		},
		{
			"yeddaif/neovim-purple",
			cond = false,
			config = function()
				vim.cmd([[colorscheme neovim_purple]])
			end,
		},
		{
			"projekt0n/github-nvim-theme",
			cond = true,
			config = function()
				require("github-theme").setup({})

				vim.cmd.colorscheme("github_dark")
			end,
		},
		{
			"drewtempelmeyer/palenight.vim",
			cond = false,
			config = function()
				vim.cmd([[
				if (has("nvim"))
					"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
					let $NVIM_TUI_ENABLE_TRUE_COLOR=1
				endif
				]])

				vim.cmd([[set background=dark]])
				vim.cmd([[colorscheme palenight]])
			end,
		},
		{
			"fenetikm/falcon",
			cond = false,
			config = function()
				vim.g.falcon_background = true
				vim.g.falcon_inactive = false
				vim.cmd([[colorscheme falcon]])
			end,
		},
		{
			"NLKNguyen/papercolor-theme",
			cond = false,
			config = function()
				vim.cmd([[set background=dark]])
				vim.cmd([[colorscheme PaperColor]])
			end,
		},
		{
			"ishan9299/nvim-solarized-lua",
			cond = false,
			config = function()
				vim.g.solarized_termcolors = 256
				vim.cmd([[set background=dark]])
				vim.cmd([[colorscheme solarized]])

				-- vim.g.solarized_termcolors = 256
				-- vim.cmd [[set background=light]]
				-- vim.cmd [[colorscheme solarized]]
			end,
		},
		{
			"folke/tokyonight.nvim",
			cond = false,
			config = function()
				vim.opt.background = "dark"
				-- vim.g.tokyonight_italic_functions = 1
				-- vim.g.tokyonight_italic_comments = 1
				-- vim.g.tokyonight_style = "moon"
				-- vim.g.tokyonight_transparent = true
				require("tokyonight").setup({
					style = "night",
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
		"maxmx03/fluoromachine.nvim",
		cond = false,
		config = function()
			local fm = require("fluoromachine")

			-- themes: fluoromachine, retrowave, delta
			fm.setup({
				glow = true,
				theme = "fluoromachine",
			})

			vim.cmd.colorscheme("fluoromachine")
		end,
	},
}

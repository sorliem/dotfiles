return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = 'gruvbox',
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {},
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "searchcount" },
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							path = 1,
							symbols = {
								modified = "[+]",      -- Text to show when the file is modified.
								readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]",     -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = {
						"diff",
						"branch",
						{ "diagnostics", sources = { "nvim_diagnostic" } },
					},
					lualine_y = { "filetype" },
					lualine_z = {
						-- function()
						-- 	return "DB:" .. vim.g.db_name
						-- end,
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							"filename",
							file_status = true, -- Displays file status (readonly status, modified status)
							path = 1,
							symbols = {
								modified = "[+]",      -- Text to show when the file is modified.
								readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]",     -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = { "filetype" },
					lualine_y = {
						"branch",
						"diff",
						{ "diagnostics", sources = { "nvim_diagnostic" } },
					},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			})
		end,
	},
}

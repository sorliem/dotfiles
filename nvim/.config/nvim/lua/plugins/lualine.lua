return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		event = "VeryLazy",
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
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = {
						"diff",
						"branch",
						-- function()
						-- local res = vim.fn.system("gh pr list --json=id")
						-- local Job = require("plenary.job")
						-- Job:new({
						-- 	command = "gh",
						-- 	args = { "pr", "list", "--json=id" },
						-- 	cwd = "/tmp",
						-- 	env = {},
						-- 	on_exit = function(j, return_val)
						-- 		print(return_val)
						--
						-- 		print(j:result())
						-- 	end,
						-- }):sync() -- or start()

						-- local res = "[]\n"
						-- if res == "[]\n" then
						-- 	return "No PRs ✅"
						-- else
						-- 	return "PRs open ❌"
						-- end
						-- end,
						-- { "diagnostics", sources = { "nvim_diagnostic" } },
					},
					lualine_y = { "filetype", "fileformat" },
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
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
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

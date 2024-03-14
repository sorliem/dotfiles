return {
	{
		"stevearc/oil.nvim",
		opts = {},
		cond = true,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				default_file_explorer = false,
			})

			vim.keymap.set("n", "-", function()
				vim.cmd("Oil")
			end, { desc = "Open parent directory" })
		end,
	},
}

return {
	{
		"stevearc/oil.nvim",
		cond = true,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					-- ["<C-p>"] = false, -- disable preview
				},
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

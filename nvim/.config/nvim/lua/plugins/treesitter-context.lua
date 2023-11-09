return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("treesitter-context").setup({
				min_window_height = 50,
				max_lines = 3,
			})
		end,
	},
}

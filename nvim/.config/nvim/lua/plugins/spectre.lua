return {
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{ "<leader>rg" },
		},
		config = function()
			vim.keymap.set("n", "<leader>rg", function()
				require("spectre").open_visual({ select_word = true })
			end, { desc = "Search current word with [R]ip[G]rep (Spectre)" })
		end,
	},
}

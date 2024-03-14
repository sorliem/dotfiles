return {
	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>dfh",
				":DiffviewFileHistory<CR>",
				{ desc = "[D]iffview [F]ile [H]istory (diffview.nvim)" }
			)

			vim.keymap.set(
				"n",
				"<leader>dfc",
				":DiffviewClose<CR>",
				{ desc = "[D]iffview [F]ile [C]lose (diffview.nvim)" }
			)
		end,
	},
}

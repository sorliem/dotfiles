return {
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>dfh",
				":DiffviewFileHistory %<CR>",
				{ desc = "[D]iffview [F]ile [H]istory of current file (diffview.nvim)" }
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

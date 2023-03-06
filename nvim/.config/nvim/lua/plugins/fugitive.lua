return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<Leader>gs" },
		},
		config = function()
			-- Fugitive status
			vim.keymap.set("n", "<Leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })

			-- Fugitive blame
			vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })

			-- Fugitive diff master
			vim.keymap.set(
				"n",
				"<Leader>gd",
				":Git diff master..HEAD<CR>:only<CR>",
				{ desc = "[G]it [D]iff master..HEAD" }
			)
		end,
	},
}

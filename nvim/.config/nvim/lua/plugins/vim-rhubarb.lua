return {
	{
		"tpope/vim-rhubarb",
		config = function()
			-- Grab current line as _permanent_ github link
			vim.keymap.set("n", "<leader>ghl", ":0GBrowse!<CR>", { desc = "[G]it[H]ub line yank" })

			-- Grab current selection as _permanent_ github link
			vim.keymap.set("v", "<leader>ghl", ":GBrowse!<CR>", { desc = "[G]it[H]ub line yank" })
		end,
	},
}

return {
	{
		"dyng/ctrlsf.vim",
		config = function()
			-- search for word under cursor with, sublime text 2 style
			vim.keymap.set("n", "<C-F>f", "<Plug>CtrlSFPrompt")

			-- search for word under cursor with, sublime text 2 style
			vim.keymap.set("n", "<C-F>w", "<Plug>CtrlSFCwordPath<CR>")

			-- toggle the CtrlSF search results window
			vim.keymap.set("n", "<C-F>t", ":CtrlSFToggle<CR>")
		end,
	},
}

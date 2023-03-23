return {
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = ":call fzf#install()",
			},
		},
		config = function()
			vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden"
			vim.g.fzf_layout = {
				up = "~90%",
				window = {
					width = 0.8,
					height = 0.8,
					yoffset = 0.5,
					xoffset = 0.5,
					highlight = "Todo",
					border = "sharp",
				},
			}

			-- search over lines in buffer
			vim.keymap.set("n", "//", ":BLines<CR>", { desc = "Fuzzy search over buffer lines" })

			-- rg in current dir
			-- vim.keymap.set("n", "<leader>ps", ":R<CR>", { desc = "[P]roject [S]earch with `rg`" })

			-- fzf starting at home dir
			vim.keymap.set("n", "<leader>F", ":FZF ~<CR>")
		end,
	},
}

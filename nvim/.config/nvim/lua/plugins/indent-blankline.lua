return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("tab:→·")
			vim.opt.listchars:append("lead:·")
			vim.opt.listchars:append("space:·")
			vim.opt.listchars:append("trail:·")
			vim.opt.listchars:append("eol:↵")
			vim.opt.listchars:append("extends:›")
			vim.opt.listchars:append("precedes:‹")

			require("indent_blankline").setup({
				show_end_of_line = true,
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = false,
			})
		end,
	},
}

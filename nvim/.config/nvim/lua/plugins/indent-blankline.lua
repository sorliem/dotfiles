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

			require("ibl").setup({
				enabled = false,
			})
		end,
	},
}

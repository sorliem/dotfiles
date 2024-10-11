return {
	{
		"jakobkhansen/journal.nvim",
		event = "VeryLazy",
		config = function()
			require("journal").setup({
				root = "~/.journal",
			})
		end,
	},
}

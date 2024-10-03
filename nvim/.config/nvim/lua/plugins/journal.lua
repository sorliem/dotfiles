return {
	{
		"jakobkhansen/journal.nvim",
		cond = true,
		event = "VeryLazy",
		commit = "56ad4cdc4cdd2e05d4cd4f27ae26317e84387ff6", -- to avoid 0.10 breaking changes
		config = function()
			require("journal").setup({
				root = "~/.journal",
			})
		end,
	},
}

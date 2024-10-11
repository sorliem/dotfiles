return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		event = "VeryLazy",
		dependencies = {
			{
				"junegunn/fzf.vim",
				{
					"junegunn/fzf",
					build = ":call fzf#install()",
				},
			},
		},
		config = function()
			require("bqf").setup({
				preview = {
					auto_preview = false,
				},
			})
		end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		config = function()
			require("qf_helper").setup()
		end,
	},
}

return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		event = "VeryLazy",
		config = function() end,
	},
	{
		"stevearc/qf_helper.nvim",
		event = "VeryLazy",
		config = function()
			require("qf_helper").setup()
		end,
	},
}

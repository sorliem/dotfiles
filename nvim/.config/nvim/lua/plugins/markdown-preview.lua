return {
	{
		"iamcco/markdown-preview.nvim",
		cond = false, -- disable it
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}

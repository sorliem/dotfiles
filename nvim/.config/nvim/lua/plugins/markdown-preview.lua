return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			MarkdownGroup = vim.api.nvim_create_augroup("MarkdownGroup", {})
			vim.g.mkdp_filetypes = { "markdown" }

			vim.api.nvim_create_autocmd("BufRead", {
				group = MarkdownGroup,
				pattern = { "*.md" },
				command = "MarkdownPreview",
			})
		end,
		ft = { "markdown" },
	},
}

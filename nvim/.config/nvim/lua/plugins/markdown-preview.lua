return {
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		init = function()
			-- MarkdownGroup = vim.api.nvim_create_augroup("MarkdownGroup", {})
			-- vim.api.nvim_create_autocmd("BufRead", {
			-- 	group = MarkdownGroup,
			-- 	pattern = { "*.md" },
			-- 	command = "MarkdownPreview",
			-- })
		end,
	},
}

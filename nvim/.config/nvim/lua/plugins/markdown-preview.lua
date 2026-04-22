return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		event = "VeryLazy",
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		config = function()
			vim.keymap.set("n", "<leader>mdp", function()
				vim.cmd("MarkdownPreviewToggle")
			end, { desc = "Toggle markdown preview" })
		end,
		ft = { "markdown" },
	},
	{
		"richardbizik/nvim-toc",
		cond = false,
		config = function()
			require("nvim-toc").setup({})
		end,
	},
}

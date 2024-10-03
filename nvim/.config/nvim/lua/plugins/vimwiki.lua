return {
	{
		"vimwiki/vimwiki",
		event = "VeryLazy",
		keys = {
			{ "<leader>ww" },
		},
		setup = function()
			vim.cmd([[
				let g:vimwiki_list = [{'path': '~/.vimwiki/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}]
				let g:vimwiki_conceallevel = 0
			]])

			-- vim.g.vimwiki_list = [{path = "~/.vimwiki/vimwiki/", syntax = "markdown", ext = "md"}]
		end,
	},
}

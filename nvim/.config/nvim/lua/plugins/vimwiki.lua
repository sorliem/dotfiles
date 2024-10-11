return {
	{
		"vimwiki/vimwiki",
		keys = {
			{ "<leader>ww" },
		},
		setup = function()
			vim.cmd([[
				let g:vimwiki_list = [{'path': '~/.vimwiki/vimwiki/', 'syntax': 'markdown'}]
				let g:vimwiki_conceallevel = 0

				let g:vimwiki_ext2syntax = {'.md': 'markdown',
																				\ '.mkd': 'markdown',
																				\ '.wiki': 'media'}
			]])

			-- vim.g.vimwiki_list = [{path = "~/.vimwiki/vimwiki/", syntax = "markdown", ext = "md"}]
		end,
	},
}

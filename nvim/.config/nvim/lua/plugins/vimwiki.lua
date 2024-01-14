return {
	{
		"vimwiki/vimwiki",
		keys = {
			{ "<leader>ww" },
		},
		setup = function()
			vim.cmd([[ let g:vimwiki_list = [{'path': '~/.vimwiki/vimwiki/', 'syntax': 'markdown', 'ext': 'md'}] ]])
			-- vim.g.vimwiki_list = [{path = "~/.vimwiki/vimwiki/", syntax = "markdown", ext = "md"}]
		end,
	},
}

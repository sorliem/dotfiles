return {
	{
		"junegunn/fzf",
		build = ":call fzf#install()",
	},
	{
		"junegunn/fzf.vim",
		init = function()
			vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden"
			vim.g.fzf_layout = {
				up = "~90%",
				window = {
					width = 0.8,
					height = 0.8,
					yoffset = 0.5,
					xoffset = 0.5,
					highlight = "Todo",
					border = "sharp",
				},
			}
		end,
	},
}

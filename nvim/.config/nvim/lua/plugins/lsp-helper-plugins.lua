return {
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				progress = {
					display = {
						progress_icon = "dots",
					},
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	"folke/lsp-colors.nvim",
}

-- see other files in this dir for plugin setups with larger configs
return {
	"christoomey/vim-tmux-navigator",
	"folke/lsp-colors.nvim",

	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "cespare/vim-toml", ft = "toml" },
	{ "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } },
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "jparise/vim-graphql", ft = "graphql", cond = false },

	{ "chr4/nginx.vim", ft = "template" },
	{ "lepture/vim-jinja", ft = "template" },
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"numToStr/Comment.nvim",
		event = { "BufRead" },
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"nvim-lua/popup.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
	},
	{
		"haya14busa/vim-asterisk",
		config = function()
			vim.cmd([[
				map *  <Plug>(asterisk-z*)
				map #  <Plug>(asterisk-z#)
				map g* <Plug>(asterisk-gz*)
				map g# <Plug>(asterisk-gz#)
				let g:asterisk#keeppos = 1
			]])
		end,
	},
}

-- see other files in this dir for plugin setups with larger configs
return {
	"christoomey/vim-tmux-navigator",
	"folke/lsp-colors.nvim",

	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "cespare/vim-toml", ft = "toml" },
	{ "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } },
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "jparise/vim-graphql", ft = "graphql" },

	-- Tim Pope
	"tpope/vim-sleuth",
	{ "tpope/vim-surround", event = { "BufRead" } },
	{ "tpope/vim-repeat", event = { "BufRead" } },
	{ "tpope/vim-commentary", cond = false },
	{ "tpope/vim-unimpaired" },

	{ "chr4/nginx.vim", ft = "template" },
	{ "lepture/vim-jinja", ft = "template" },
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	"sindrets/diffview.nvim",
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
}

-- see other files in this dir for plugin setups with larger configs
return {
	"christoomey/vim-tmux-navigator",
	"editorconfig/editorconfig-vim",
	"folke/lsp-colors.nvim",
	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "cespare/vim-toml", ft = "toml" },
	{ "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } },
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "jparise/vim-graphql", ft = "graphql" },

	-- Tim Pope
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	{ "tpope/vim-commentary", cond = false },
	"tpope/vim-unimpaired",

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	"sindrets/diffview.nvim",
	{
		"numToStr/Comment.nvim",
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
}

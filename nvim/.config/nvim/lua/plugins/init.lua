-- see other files in this dir for plugin setups with larger configs
return {
	"mbbill/undotree",
	"christoomey/vim-tmux-navigator",
	"editorconfig/editorconfig-vim",
	"vimwiki/vimwiki",
	"dyng/ctrlsf.vim",
	"folke/lsp-colors.nvim",
	"MunifTanjim/nui.nvim",
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},
	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "dstein64/vim-startuptime", cmd = "StartupTime" },
	{ "cespare/vim-toml", ft = "toml" },
	{ "elixir-editors/vim-elixir", ft = { "elixir", "eelixir" } },
	{ "udalov/kotlin-vim", ft = "kotlin" },
	{ "jparise/vim-graphql", ft = "graphql" },

	-- Tim Pope
	"tpope/vim-fugitive",
	"tpope/vim-sleuth",
	"tpope/vim-rhubarb",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"tpope/vim-commentary",
	"tpope/vim-unimpaired",

	"ThePrimeagen/vim-be-good",

	{
		"nvim-lua/popup.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}

-- see other files in this dir for plugin setups with larger configs
return {
	{
		"mbbill/undotree",
		config = function()
			-- toggle undotree
			vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")
		end,
	},
	"christoomey/vim-tmux-navigator",
	"editorconfig/editorconfig-vim",
	"vimwiki/vimwiki",
	{
		"dyng/ctrlsf.vim",
		config = function()
			-- search for word under cursor with, sublime text 2 style
			vim.keymap.set("n", "<C-F>f", "<Plug>CtrlSFPrompt")

			-- search for word under cursor with, sublime text 2 style
			vim.keymap.set("n", "<C-F>w", "<Plug>CtrlSFCwordPath<CR>")

			-- toggle the CtrlSF search results window
			vim.keymap.set("n", "<C-F>t", ":CtrlSFToggle<CR>")
		end,
	},
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
	{
		"tpope/vim-fugitive",
		config = function()
			-- Fugitive status
			vim.keymap.set("n", "<Leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })

			-- Fugitive blame
			vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })

			-- Fugitive diff master
			vim.keymap.set(
				"n",
				"<Leader>gd",
				":Git diff master..HEAD<CR>:only<CR>",
				{ desc = "[G]it [D]iff master..HEAD" }
			)
		end,
	},
	"tpope/vim-sleuth",
	{
		"tpope/vim-rhubarb",
		config = function()
			-- Grab current line as _permanent_ github link
			vim.keymap.set("n", "<leader>ghl", ":0GBrowse!<CR>", { desc = "[G]it[H]ub line yank" })

			-- Grab current selection as _permanent_ github link
			vim.keymap.set("v", "<leader>ghl", ":GBrowse!<CR>", { desc = "[G]it[H]ub line yank" })
		end,
	},
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

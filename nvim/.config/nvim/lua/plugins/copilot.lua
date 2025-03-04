return {
	{
		"github/copilot.vim",
		cond = false,
	},
	{
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
				{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			},
			build = "make tiktoken", -- Only on MacOS or Linux
			config = function( --[[opts]])
				require("CopilotChat").setup({ model = "claude-3.7-sonnet" })

				vim.keymap.set("n", "<space>pi", function()
					require("CopilotChat").toggle()
				end, { desc = "Co[pi]lot Chat" })
			end,
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		cond = false,
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		cond = false,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}

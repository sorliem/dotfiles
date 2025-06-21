return {
	{
		{
			"CopilotC-Nvim/CopilotChat.nvim",
			dependencies = {
				{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
				{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
			},
			build = "make tiktoken", -- Only on MacOS or Linux
			config = function( --[[opts]])
				require("CopilotChat").setup({
					-- model = "claude-opus-4",
					-- model = "gemini-2.5-pro",
					model = "claude-sonnet-4",
					context = {},
					sticky = {
						"#files",
						-- "#files:`**/*`",
						-- "#git",
						"#buffers",
						"#filenames",
						"#system:`git status --porcelain`",
					},

					question_header = "👤 User ", -- Header to use for user questions
					answer_header = "🤖 Copilot ", -- Header to use for AI answers
					error_header = "❗Error ", -- Header to use for errors
					mappings = {
						reset = {
							normal = "", -- disable chat clearing
							insert = "",
						},
					},
				})

				vim.keymap.set("n", "<space>cco", function()
					require("CopilotChat").toggle()
				end, { desc = "[C]opilot [C]hat" })

				vim.keymap.set("n", "<space>ccp", function()
					vim.cmd.CopilotChatPrompts()
				end, { desc = "[C]opilot [C]hat [P]rompts" })
			end,
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		cond = true,
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		cond = true,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}

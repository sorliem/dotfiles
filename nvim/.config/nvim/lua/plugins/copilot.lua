return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		event = "VeryLazy",
		cond = false,
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				event = "VeryLazy",
				config = function()
					require("copilot").setup({})
				end,
			},
			{
				"zbirenbaum/copilot-cmp",
				event = "VeryLazy",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function( --[[opts]])
			require("CopilotChat").setup({
				system_prompt = "{BASE_INSTRUCTIONS}",
				show_help = true,
				model = "claude-opus-4",
				-- model = "gemini-2.5-pro",
				-- model = "claude-sonnet-4",
				-- model = "gpt-5",
				context = {},
				sticky = {
					"#files",
					-- "#files:`**/*`",
					-- "#git",
					"#buffers",
					"#filenames",
					"#system:`git status --porcelain`",
					"#system:`git log --oneline -10`", -- Recent commits
					"#system:`pwd`", -- Current directory
				},

				prompts = {
					Yarrr = {
						prompt = "Explain how it works in pirate speak",
						system_prompt = "You are fascinated by pirates, so please respond in pirate speak.",
					},
					NiceInstructions = {
						system_prompt = "You are a nice coding tutor, so please respond in a friendly and helpful manner. {BASE_INSTRUCTIONS}",
					},
					MyCustomPrompt = {
						prompt = "Explain how it works.",
						system_prompt = "You are very good at explaining stuff",
						mapping = "<leader>ccmc",
						description = "My custom prompt description",
					},
				},
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

			-- Custom input for CopilotChat
			vim.keymap.set("n", "<leader>cci", function()
				local input = vim.fn.input("Ask Copilot: ")
				if input ~= "" then
					vim.cmd("CopilotChat " .. input)
				end
			end, { desc = "CopilotChat - Ask input" })
		end,
	},
}

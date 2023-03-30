return {
	{
		"tpope/vim-rhubarb",
		dependencies = {
			"tpope/vim-fugitive",
		},
		config = function()
			local function on_master_branch()
				local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")

				return branch == "master" or branch == "main"
			end
			-- Grab current line as _permanent_ github link
			vim.keymap.set("n", "<leader>ghl", function()
				if not on_master_branch() then
					local answer = vim.fn.input({ prompt = "Not on master/main, continue? (y/n): " })
					if answer == "y" then
						vim.cmd("0GBrowse!")
					else
						print("not copying github line")
					end
				else
					vim.cmd("0GBrowse!")
				end
			end, { desc = "[G]it[H]ub line yank" })

			-- Grab current selection as _permanent_ github link
			vim.keymap.set("v", "<leader>ghl", ":GBrowse!<CR>", { desc = "[G]it[H]ub line yank" })
		end,
	},
}

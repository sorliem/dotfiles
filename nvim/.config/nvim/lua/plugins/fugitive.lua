return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<Leader>gs" },
			{ "<Leader>bl" },
			{ "<Leader>gd" },
		},
		config = function()
			-- Fugitive status
			vim.keymap.set("n", "<Leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

			-- Fugitive blame
			vim.keymap.set("n", "<Leader>bl", ":Git blame<CR>", { desc = "Git [B][l]ame" })

			-- Fugitive diff master
			vim.keymap.set(
				"n",
				"<Leader>gd",
				":Git diff master..HEAD<CR>:only<CR>",
				{ desc = "[G]it [D]iff master..HEAD" }
			)

			local Miles_Fugitive = vim.api.nvim_create_augroup("Miles_Fugitive", {})

			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = Miles_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.filetype ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "<leader>pu", function()
						vim.cmd.Git("push")
					end, {
						buffer = bufnr,
						remap = false,
						desc = "[G]it [P]ush via fugitive (only active in fugitive buffer)",
					})
				end,
			})

			vim.keymap.set("n", "<Leader>gy", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "<Leader>go", "<cmd>diffget //3<CR>")
		end,
	},
}

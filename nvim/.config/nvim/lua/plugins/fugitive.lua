return {
	{
		"tpope/vim-fugitive",
		keys = {
			{ "<Leader>gs" },
			{ "<Leader>gb" },
			{ "<Leader>gd" },
		},
		config = function()
			-- Fugitive status
			vim.keymap.set("n", "<Leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

			-- Fugitive blame
			vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })

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

					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git("push")
					end, opts)
				end,
			})

			vim.keymap.set("n", "<Leader>gy", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "<Leader>go", "<cmd>diffget //3<CR>")
		end,
	},
}

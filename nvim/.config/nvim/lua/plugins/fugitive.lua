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

			-- vim.keymap.set("n", "<Leader>gp", ":Git pull<CR>", { desc = "[G]it [P]ull" })

			-- Fugitive diff master
			vim.keymap.set(
				"n",
				"<Leader>gd",
				":Git diff master..HEAD<CR>:only<CR>",
				{ desc = "[G]it [D]iff master..HEAD" }
			)

			vim.keymap.set("n", "<leader>gho", function()
				vim.cmd("GBrowse")
			end, { desc = "[G]it[h]ub [O]pen repo website" })

			local Miles_Fugitive = vim.api.nvim_create_augroup("Miles_Fugitive", {})

			vim.api.nvim_create_autocmd("BufWinEnter", {
				group = Miles_Fugitive,
				pattern = "*",
				callback = function()
					if vim.bo.filetype ~= "fugitive" then
						return
					end

					local bufnr = vim.api.nvim_get_current_buf()

					vim.keymap.set("n", "<leader>pu", function()
						vim.cmd.Git("push")
						-- Run command that opens url using the dir + branch name like below
						-- https://github.com/onXmaps/atlantis-trailcams/pull/new/miles/SRE-5365-cert-walkback-ds
					end, {
						buffer = bufnr,
						remap = false,
						desc = "[G]it [P]ush via fugitive (only active in fugitive buffer)",
					})
				end,
			})

			vim.keymap.set("n", "<Leader>gy", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "<Leader>go", "<cmd>diffget //3<CR>")

			vim.cmd([[ cabbrev Gco Git checkout ]])
		end,
	},
}

return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_formatter = "     <author>, <author_time:%Y-%m-%d> - <summary>",
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 0,
					ignore_whitespace = false,
				},
				on_attach = function( --[[bufnr]])
					local gs = package.loaded.gitsigns

					-- Navigation
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					-- nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
					-- nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
					-- vnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
					-- vnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
					-- nnoremap('<leader>hS', gs.stage_buffer)
					-- nnoremap('<leader>hu', gs.undo_stage_hunk)
					-- nnoremap('<leader>hR', gs.reset_buffer)
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
					vim.keymap.set("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame)
					vim.keymap.set("n", "<leader>hd", gs.diffthis)
					vim.keymap.set("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					-- nnoremap('<leader>td', gs.toggle_deleted)

					-- Text object
					-- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
				end,
			})
		end,
	},
}

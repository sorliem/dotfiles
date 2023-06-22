return {
	{
		"ThePrimeagen/harpoon",
		config = function()
			vim.keymap.set("n", "<leader>ha", function()
				require("harpoon.mark").add_file()
			end, { desc = "[H]arpoon [A]dd file" })

			vim.keymap.set("n", "<leader>he", function()
				require("harpoon.ui").toggle_quick_menu()
			end, { desc = "[H]arpoon [E]dit list" })

			vim.keymap.set("n", "<M-j>", ":lua require('harpoon.ui').nav_file(1)<CR>", { desc = "Harpoon file 1" })
			vim.keymap.set("n", "<M-k>", ":lua require('harpoon.ui').nav_file(2)<CR>", { desc = "Harpoon file 2" })
			vim.keymap.set("n", "<M-l>", ":lua require('harpoon.ui').nav_file(3)<CR>", { desc = "Harpoon file 3" })
			vim.keymap.set("n", "<M-;>", ":lua require('harpoon.ui').nav_file(4)<CR>", { desc = "Harpoon file 4" })
			vim.keymap.set("n", "<M-'>", ":lua require('harpoon.ui').nav_file(5)<CR>", { desc = "Harpoon file 5" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "harpoon",
				callback = function()
					vim.cmd("setlocal cursorline")
				end,
			})
		end,
	},
}

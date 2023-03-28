return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()

			vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "[N]vimTree [T]oggle" })
			vim.keymap.set("n", "<leader>nf", function()
				require("nvim-tree.api").tree.find_file({ open = true })
			end, { desc = "[N]vimTree [F]ind File" })
		end,
	},
}
